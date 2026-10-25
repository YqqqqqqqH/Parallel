#!/usr/bin/env python3
"""从 WSL 调用 Windows 上的 Vivado 2018.3（xvlog / xelab / xsim）做批处理仿真。

Vivado 读不了 \\\\wsl.localhost\\ 路径，cmd.exe 的当前目录也必须在 Windows 盘上，
所以每次运行都把源码复制到 E:\\vivado_proj\\lab2_alu\\batch\\<name>\\ 再编译仿真，
完整日志拷回 lab2/results/sim/<name>.log。

用法：
  python3 scripts/xsim.py <name> <设计文件>            # 官方激励 + tb_monitor
  python3 scripts/xsim.py <name> <设计文件> --plus      # 增强激励 alu_tb_plus
  python3 scripts/xsim.py <name> <设计文件> --stop-on-fail
"""
import argparse
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

LAB = Path(__file__).resolve().parent.parent
VIVADO_BIN = r"E:\Xilinx_Vivado_SDK_2018.3_1207_2324\Vivado\2018.3\bin"
WORK_ROOT = Path("/mnt/e/vivado_proj/lab2_alu/batch")
LOG_DIR = LAB / "results" / "sim"


def _tool(name, args, cwd):
    """在 Windows 目录 cwd 下运行一个 Vivado 命令行工具，返回 (返回码, 输出)。"""
    proc = subprocess.run(["cmd.exe", "/c", rf"{VIVADO_BIN}\{name}.bat", *args],
                          cwd=cwd, capture_output=True)
    out = (proc.stdout + proc.stderr).decode("gbk", errors="replace").replace("\r", "")
    return proc.returncode, out


def run(name, design, plus=False, stop_on_fail=False, extra_tb=None):
    """编译并仿真一个设计，返回解析后的结果字典。

    design 是含 module alu 的文件；plus=True 时用增强激励，否则用官方激励 + tb_monitor。
    extra_tb 可替换增强激励文件（默认 sim/alu_tb_plus.v）。
    """
    work = WORK_ROOT / name
    if work.exists():
        shutil.rmtree(work)
    work.mkdir(parents=True)

    shutil.copy(design, work / "alu.v")
    if plus:
        tb_files = [Path(extra_tb) if extra_tb else LAB / "sim" / "alu_tb_plus.v"]
        top = "alu_tb_plus"
        tcl_lines = ["run all", "quit"]
    else:
        tb_files = [LAB / "alu_tb.v", LAB / "sim" / "tb_monitor.v"]
        top = "tb_monitor"
        tcl_lines = (LAB / "scripts" / "sim.tcl").read_text().splitlines()
    for f in tb_files:
        shutil.copy(f, work / f.name)
    (work / "run.tcl").write_text("\n".join(tcl_lines) + "\n")

    log = []
    t0 = time.time()
    steps = [
        ("xvlog", ["alu.v", *[f.name for f in tb_files]]),
        ("xelab", ["-debug", "typical", "-s", "snap", top]),
        ("xsim", ["snap", "-tclbatch", "run.tcl",
                  *(["-testplusarg", "stop_on_fail"] if stop_on_fail else [])]),
    ]
    for tool, args in steps:
        rc, out = _tool(tool, args, work)
        log.append(f"===== {tool} {' '.join(args)} (rc={rc})\n{out}")
        if rc != 0:
            _save_log(name, log)
            raise RuntimeError(f"{tool} 失败（rc={rc}），见 results/sim/{name}.log")
    elapsed = time.time() - t0
    _save_log(name, log)

    sim_out = log[-1]
    res = {"name": name, "seconds": round(elapsed, 1), "output": sim_out}
    m = re.search(r"MONITOR_END time=(\d+) ns first_fail=(-?\d+) fail_ns=(-?\d+) bad_since=(-?\d+)",
                  sim_out)
    if m:
        end, ff, fns, bs = map(int, m.groups())
        res.update(end=end, first_fail=ff,
                   fail_ns=fns + (end - bs if bs >= 0 else 0))
    m = re.search(r"MONITOR first_fail=\S+ (.*)", sim_out)
    if m:
        res["first_vector"] = m.group(1).strip()
    m = re.search(r"\$finish called at time : (\d+) ns", sim_out)
    if m:
        res["finish"] = int(m.group(1))
    return res


def _save_log(name, log):
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    (LOG_DIR / f"{name}.log").write_text("\n".join(log))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("name")
    ap.add_argument("design")
    ap.add_argument("--plus", action="store_true", help="使用增强激励 sim/alu_tb_plus.v")
    ap.add_argument("--stop-on-fail", action="store_true")
    a = ap.parse_args()
    res = run(a.name, a.design, plus=a.plus, stop_on_fail=a.stop_on_fail)
    for k, v in res.items():
        if k != "output":
            print(f"{k}: {v}")
    if a.plus:
        print("\n".join(l for l in res["output"].splitlines() if l.startswith(("PLUS", "MISMATCH"))))
    return 0


if __name__ == "__main__":
    sys.exit(main())
