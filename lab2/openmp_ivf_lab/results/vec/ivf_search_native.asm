
results/vec/ivf_search_native.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <ivf::better(ivf::Neighbor const&, ivf::Neighbor const&)>:
       0:	endbr64
       4:	vmovsd (%rdi),%xmm1
       8:	vmovsd (%rsi),%xmm0
       c:	mov    $0x1,%eax
      11:	vcomisd %xmm1,%xmm0
      15:	ja     32 <ivf::better(ivf::Neighbor const&, ivf::Neighbor const&)+0x32>
      17:	vucomisd %xmm0,%xmm1
      1b:	jp     30 <ivf::better(ivf::Neighbor const&, ivf::Neighbor const&)+0x30>
      1d:	jne    30 <ivf::better(ivf::Neighbor const&, ivf::Neighbor const&)+0x30>
      1f:	mov    0x8(%rsi),%eax
      22:	cmp    %eax,0x8(%rdi)
      25:	setl   %al
      28:	ret
      29:	nopl   0x0(%rax)
      30:	xor    %eax,%eax
      32:	ret
      33:	data16 cs nopw 0x0(%rax,%rax,1)
      3e:	xchg   %ax,%ax

0000000000000040 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)>:
      40:	endbr64
      44:	test   %rdx,%rdx
      47:	je     80 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)+0x40>
      49:	vxorps %xmm3,%xmm3,%xmm3
      4d:	xor    %eax,%eax
      4f:	vxorpd %xmm2,%xmm2,%xmm2
      53:	nopl   0x0(%rax,%rax,1)
      58:	vcvtss2sd (%rdi,%rax,4),%xmm3,%xmm0
      5d:	vcvtss2sd (%rsi,%rax,4),%xmm3,%xmm1
      62:	vsubsd %xmm1,%xmm0,%xmm0
      66:	add    $0x1,%rax
      6a:	cmp    %rax,%rdx
      6d:	vmulsd %xmm0,%xmm0,%xmm0
      71:	vaddsd %xmm0,%xmm2,%xmm2
      75:	jne    58 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)+0x18>
      77:	vmovsd %xmm2,%xmm2,%xmm0
      7b:	ret
      7c:	nopl   0x0(%rax)
      80:	vxorpd %xmm2,%xmm2,%xmm2
      84:	vmovsd %xmm2,%xmm2,%xmm0
      88:	ret
      89:	nopl   0x0(%rax)

0000000000000090 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)>:
      90:	endbr64
      94:	test   %rdx,%rdx
      97:	push   %r15
      99:	vxorps %xmm1,%xmm1,%xmm1
      9d:	mov    %rdx,%r15
      a0:	push   %r14
      a2:	push   %r13
      a4:	mov    %rcx,%r13
      a7:	push   %r12
      a9:	push   %rbp
      aa:	push   %rbx
      ab:	je     2b1 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x221>
      b1:	lea    0x0(,%r13,4),%r11
      b9:	mov    %rdi,%rbp
      bc:	xor    %r12d,%r12d
      bf:	xor    %edx,%edx
      c1:	mov    %r11,%rax
      c4:	mov    0x10(%rsi),%rcx
      c8:	mov    0x8(%rsi),%r14
      cc:	mov    %r11,-0x18(%rsp)
      d1:	sar    $0x2,%rax
      d5:	mov    %r11,%rbx
      d8:	xor    %r8d,%r8d
      db:	mov    %rax,-0x8(%rsp)
      e0:	mov    %r11,%rax
      e3:	lea    (%rcx,%r11,1),%r9
      e7:	sar    $0x4,%rbx
      eb:	and    $0xfffffffffffffff0,%rax
      ef:	shl    $0x2,%r14
      f3:	add    %rax,%rcx
      f6:	mov    %r13,%rax
      f9:	shl    $0x4,%rax
      fd:	mov    %rax,-0x10(%rsp)
     102:	nopw   0x0(%rax,%rax,1)
     108:	mov    -0x18(%rsp),%rax
     10d:	mov    %r9,%r11
     110:	sub    %rax,%r11
     113:	test   %r13,%r13
     116:	je     1a6 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x116>
     11c:	mov    0x0(%rbp),%r10
     120:	mov    -0x10(%rsp),%rsi
     125:	mov    %r12,%rax
     128:	mov    %rdx,-0x20(%rsp)
     12d:	shl    $0x4,%rax
     131:	lea    (%r10,%rax,1),%rdi
     135:	add    %rsi,%r10
     138:	add    %rax,%r10
     13b:	nopl   0x0(%rax,%rax,1)
     140:	mov    0x8(%rdi),%edx
     143:	cmp    $0xffffffff,%edx
     146:	je     198 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x108>
     148:	test   %rbx,%rbx
     14b:	jle    267 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1d7>
     151:	mov    %r11,%rax
     154:	jmp    188 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf8>
     156:	cs nopw 0x0(%rax,%rax,1)
     160:	cmp    0x4(%rax),%edx
     163:	je     1f0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x160>
     169:	cmp    0x8(%rax),%edx
     16c:	je     200 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x170>
     172:	cmp    0xc(%rax),%edx
     175:	je     210 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x180>
     17b:	add    $0x10,%rax
     17f:	cmp    %rcx,%rax
     182:	je     220 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x190>
     188:	cmp    (%rax),%edx
     18a:	jne    160 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xd0>
     18c:	cmp    %r9,%rax
     18f:	setne  %al
     192:	movzbl %al,%eax
     195:	add    %rax,%r8
     198:	add    $0x10,%rdi
     19c:	cmp    %r10,%rdi
     19f:	jne    140 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xb0>
     1a1:	mov    -0x20(%rsp),%rdx
     1a6:	add    $0x1,%rdx
     1aa:	add    %r14,%r9
     1ad:	add    %r13,%r12
     1b0:	add    %r14,%rcx
     1b3:	cmp    %rdx,%r15
     1b6:	jne    108 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x78>
     1bc:	test   %r8,%r8
     1bf:	js     296 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x206>
     1c5:	vcvtsi2sd %r8,%xmm1,%xmm0
     1ca:	imul   %r13,%r15
     1ce:	test   %r15,%r15
     1d1:	js     271 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1e1>
     1d7:	vcvtsi2sd %r15,%xmm1,%xmm1
     1dc:	pop    %rbx
     1dd:	pop    %rbp
     1de:	pop    %r12
     1e0:	pop    %r13
     1e2:	pop    %r14
     1e4:	pop    %r15
     1e6:	vdivsd %xmm1,%xmm0,%xmm0
     1ea:	ret
     1eb:	nopl   0x0(%rax,%rax,1)
     1f0:	add    $0x4,%rax
     1f4:	jmp    18c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xfc>
     1f6:	cs nopw 0x0(%rax,%rax,1)
     200:	add    $0x8,%rax
     204:	jmp    18c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xfc>
     206:	cs nopw 0x0(%rax,%rax,1)
     210:	add    $0xc,%rax
     214:	jmp    18c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xfc>
     219:	nopl   0x0(%rax)
     220:	mov    %r9,%rsi
     223:	sub    %rax,%rsi
     226:	sar    $0x2,%rsi
     22a:	cmp    $0x2,%rsi
     22e:	je     259 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1c9>
     230:	cmp    $0x3,%rsi
     234:	je     24d <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1bd>
     236:	cmp    $0x1,%rsi
     23a:	jne    198 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x108>
     240:	cmp    (%rax),%edx
     242:	jne    198 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x108>
     248:	jmp    18c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xfc>
     24d:	cmp    (%rax),%edx
     24f:	je     18c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xfc>
     255:	add    $0x4,%rax
     259:	cmp    (%rax),%edx
     25b:	je     18c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xfc>
     261:	add    $0x4,%rax
     265:	jmp    240 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1b0>
     267:	mov    -0x8(%rsp),%rsi
     26c:	mov    %r11,%rax
     26f:	jmp    22a <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x19a>
     271:	mov    %r15,%rax
     274:	and    $0x1,%r15d
     278:	pop    %rbx
     279:	pop    %rbp
     27a:	shr    $1,%rax
     27d:	pop    %r12
     27f:	pop    %r13
     281:	or     %r15,%rax
     284:	pop    %r14
     286:	pop    %r15
     288:	vcvtsi2sd %rax,%xmm1,%xmm1
     28d:	vaddsd %xmm1,%xmm1,%xmm1
     291:	vdivsd %xmm1,%xmm0,%xmm0
     295:	ret
     296:	mov    %r8,%rax
     299:	and    $0x1,%r8d
     29d:	shr    $1,%rax
     2a0:	or     %r8,%rax
     2a3:	vcvtsi2sd %rax,%xmm1,%xmm0
     2a8:	vaddsd %xmm0,%xmm0,%xmm0
     2ac:	jmp    1ca <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x13a>
     2b1:	vxorpd %xmm0,%xmm0,%xmm0
     2b5:	jmp    1ca <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x13a>
     2ba:	nopw   0x0(%rax,%rax,1)

00000000000002c0 <ivf::TopK::TopK(unsigned long)>:
     2c0:	endbr64
     2c4:	push   %r12
     2c6:	mov    %rsi,%rax
     2c9:	vpxor  %xmm0,%xmm0,%xmm0
     2cd:	push   %rbp
     2ce:	push   %rbx
     2cf:	mov    %rdi,%rbx
     2d2:	sub    $0x10,%rsp
     2d6:	shr    $0x3b,%rax
     2da:	mov    %rsi,(%rdi)
     2dd:	movq   $0x0,0x18(%rdi)
     2e5:	vmovdqu %xmm0,0x8(%rdi)
     2ea:	jne    37e <ivf::TopK::TopK(unsigned long)+0xbe>
     2f0:	test   %rsi,%rsi
     2f3:	jne    300 <ivf::TopK::TopK(unsigned long)+0x40>
     2f5:	add    $0x10,%rsp
     2f9:	pop    %rbx
     2fa:	pop    %rbp
     2fb:	pop    %r12
     2fd:	ret
     2fe:	xchg   %ax,%ax
     300:	shl    $0x4,%rsi
     304:	mov    %rsi,%rdi
     307:	mov    %rsi,%rbp
     30a:	call   30f <ivf::TopK::TopK(unsigned long)+0x4f>
     30f:	mov    0x10(%rbx),%rsi
     313:	mov    0x8(%rbx),%rdi
     317:	vmovq  %rax,%xmm2
     31c:	mov    %rax,%r12
     31f:	vpunpcklqdq %xmm2,%xmm2,%xmm0
     323:	cmp    %rdi,%rsi
     326:	je     34e <ivf::TopK::TopK(unsigned long)+0x8e>
     328:	sub    %rdi,%rsi
     32b:	mov    %rax,%rdx
     32e:	mov    %rdi,%rcx
     331:	add    %rax,%rsi
     334:	nopl   0x0(%rax)
     338:	vmovdqu (%rcx),%xmm1
     33c:	add    $0x10,%rdx
     340:	add    $0x10,%rcx
     344:	vmovdqu %xmm1,-0x10(%rdx)
     349:	cmp    %rdx,%rsi
     34c:	jne    338 <ivf::TopK::TopK(unsigned long)+0x78>
     34e:	test   %rdi,%rdi
     351:	je     369 <ivf::TopK::TopK(unsigned long)+0xa9>
     353:	mov    0x18(%rbx),%rsi
     357:	vmovdqa %xmm0,(%rsp)
     35c:	sub    %rdi,%rsi
     35f:	call   364 <ivf::TopK::TopK(unsigned long)+0xa4>
     364:	vmovdqa (%rsp),%xmm0
     369:	add    %rbp,%r12
     36c:	vmovdqu %xmm0,0x8(%rbx)
     371:	mov    %r12,0x18(%rbx)
     375:	add    $0x10,%rsp
     379:	pop    %rbx
     37a:	pop    %rbp
     37b:	pop    %r12
     37d:	ret
     37e:	lea    0x0(%rip),%rdi        # 385 <ivf::TopK::TopK(unsigned long)+0xc5>
     385:	call   38a <ivf::TopK::TopK(unsigned long)+0xca>
     38a:	endbr64
     38e:	mov    %rax,%rbp
     391:	jmp    396 <ivf::TopK::TopK(unsigned long)+0xd6>
     396:	cs nopw 0x0(%rax,%rax,1)

00000000000003a0 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)>:
     3a0:	endbr64
     3a4:	push   %r15
     3a6:	push   %r14
     3a8:	push   %r13
     3aa:	push   %r12
     3ac:	push   %rbp
     3ad:	push   %rbx
     3ae:	sub    $0x138,%rsp
     3b5:	mov    (%rdi),%rbx
     3b8:	mov    (%rsi),%rbp
     3bb:	mov    %fs:0x28,%rax
     3c4:	mov    %rax,0x128(%rsp)
     3cc:	xor    %eax,%eax
     3ce:	mov    0x8(%rdi),%rax
     3d2:	mov    0x8(%rsi),%rcx
     3d6:	sub    %rbx,%rax
     3d9:	sub    %rbp,%rcx
     3dc:	mov    %rax,%rdx
     3df:	sar    $0x4,%rdx
     3e3:	cmp    %rcx,%rax
     3e6:	jne    3ec <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x4c>
     3ec:	xor    %r12d,%r12d
     3ef:	test   %rax,%rax
     3f2:	je     4a8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x108>
     3f8:	vmovq  0x0(%rip),%xmm1        # 400 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x60>
     400:	vmovsd 0x0(%rip),%xmm5        # 408 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x68>
     408:	xor    %ecx,%ecx
     40a:	vmovsd 0x0(%rip),%xmm6        # 412 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x72>
     412:	vmovsd 0x0(%rip),%xmm4        # 41a <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x7a>
     41a:	jmp    471 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xd1>
     41c:	nopl   0x0(%rax)
     420:	vandpd %xmm1,%xmm0,%xmm2
     424:	vucomisd %xmm2,%xmm5
     428:	jb     42e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x8e>
     42e:	vmovsd 0x0(%rbp),%xmm3
     433:	vandpd %xmm1,%xmm3,%xmm2
     437:	vsubsd %xmm3,%xmm0,%xmm0
     43b:	vfmadd132sd %xmm6,%xmm6,%xmm2
     440:	vandpd %xmm1,%xmm0,%xmm0
     444:	vcomisd %xmm0,%xmm2
     448:	jb     44e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xae>
     44e:	cmp    0x8(%rbx),%eax
     451:	jne    457 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xb7>
     457:	nopw   0x0(%rax,%rax,1)
     460:	add    $0x1,%r12
     464:	add    $0x10,%rbp
     468:	add    $0x10,%rbx
     46c:	cmp    %rdx,%r12
     46f:	jae    4a8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x108>
     471:	mov    0x8(%rbp),%eax
     474:	vmovsd (%rbx),%xmm0
     478:	cmp    $0xffffffff,%eax
     47b:	jne    420 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x80>
     47d:	cmpl   $0xffffffff,0x8(%rbx)
     481:	jne    487 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xe7>
     487:	vucomisd 0x0(%rip),%xmm0        # 48f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xef>
     48f:	setnp  %al
     492:	vucomisd %xmm4,%xmm0
     496:	cmovne %ecx,%eax
     499:	test   %al,%al
     49b:	jne    460 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xc0>
     49d:	jmp    4a2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x102>
     4a2:	nopw   0x0(%rax,%rax,1)
     4a8:	mov    0x128(%rsp),%rax
     4b0:	sub    %fs:0x28,%rax
     4b9:	jne    4cd <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x12d>
     4bb:	add    $0x138,%rsp
     4c2:	pop    %rbx
     4c3:	pop    %rbp
     4c4:	pop    %r12
     4c6:	pop    %r13
     4c8:	pop    %r14
     4ca:	pop    %r15
     4cc:	ret
     4cd:	call   4d2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x132>
     4d2:	data16 cs nopw 0x0(%rax,%rax,1)
     4dd:	nopl   (%rax)

00000000000004e0 <ivf::TopK::add(ivf::Neighbor)>:
     4e0:	endbr64
     4e4:	push   %rbx
     4e5:	mov    %rdi,%rbx
     4e8:	sub    $0x40,%rsp
     4ec:	mov    0x8(%rdi),%r9
     4f0:	mov    %rsi,0x18(%rsp)
     4f5:	mov    0x10(%rdi),%rsi
     4f9:	vmovq  %xmm0,0x10(%rsp)
     4ff:	mov    %fs:0x28,%rax
     508:	mov    %rax,0x38(%rsp)
     50d:	xor    %eax,%eax
     50f:	mov    %rsi,%rax
     512:	sub    %r9,%rax
     515:	mov    %rax,%rdx
     518:	sar    $0x4,%rdx
     51c:	cmp    (%rdi),%rdx
     51f:	jb     6b0 <ivf::TopK::add(ivf::Neighbor)+0x1d0>
     525:	vmovsd 0x10(%rsp),%xmm1
     52b:	vmovsd (%r9),%xmm0
     530:	vcomisd %xmm1,%xmm0
     534:	jbe    598 <ivf::TopK::add(ivf::Neighbor)+0xb8>
     536:	cmp    $0x10,%rax
     53a:	jg     5b0 <ivf::TopK::add(ivf::Neighbor)+0xd0>
     53c:	mov    0x10(%rsp),%rax
     541:	sub    $0x1,%rdx
     545:	vmovsd %xmm1,0x20(%rsp)
     54b:	mov    %rax,-0x10(%rsi)
     54f:	mov    0x18(%rsp),%eax
     553:	mov    %eax,-0x8(%rsi)
     556:	mov    %eax,0x28(%rsp)
     55a:	shl    $0x4,%rdx
     55e:	lea    (%r9,%rdx,1),%rax
     562:	nopw   0x0(%rax,%rax,1)
     568:	mov    0x20(%rsp),%rdx
     56d:	mov    %rdx,(%rax)
     570:	mov    0x28(%rsp),%edx
     574:	mov    %edx,0x8(%rax)
     577:	mov    0x38(%rsp),%rax
     57c:	sub    %fs:0x28,%rax
     585:	jne    7a5 <ivf::TopK::add(ivf::Neighbor)+0x2c5>
     58b:	add    $0x40,%rsp
     58f:	pop    %rbx
     590:	ret
     591:	nopl   0x0(%rax)
     598:	vucomisd %xmm0,%xmm1
     59c:	jp     577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     59e:	jne    577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     5a0:	mov    0x8(%r9),%ecx
     5a4:	cmp    %ecx,0x18(%rsp)
     5a8:	jge    577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     5aa:	jmp    536 <ivf::TopK::add(ivf::Neighbor)+0x56>
     5ac:	nopl   0x0(%rax)
     5b0:	mov    (%r9),%rax
     5b3:	vmovq  -0x10(%rsi),%xmm0
     5b8:	lea    -0x10(%rsi),%rdx
     5bc:	mov    %r9,%rdi
     5bf:	mov    -0x8(%rsi),%rcx
     5c3:	sub    %r9,%rdx
     5c6:	lea    0x0(%rip),%r8        # 5cd <ivf::TopK::add(ivf::Neighbor)+0xed>
     5cd:	vmovsd %xmm1,0x8(%rsp)
     5d3:	mov    %rax,-0x10(%rsi)
     5d7:	mov    0x8(%r9),%eax
     5db:	sar    $0x4,%rdx
     5df:	mov    %eax,-0x8(%rsi)
     5e2:	xor    %esi,%esi
     5e4:	call   5e9 <ivf::TopK::add(ivf::Neighbor)+0x109>
     5e9:	mov    0x10(%rbx),%rdx
     5ed:	mov    0x8(%rbx),%r9
     5f1:	mov    0x10(%rsp),%rcx
     5f6:	vmovsd 0x8(%rsp),%xmm1
     5fc:	mov    %rdx,%rax
     5ff:	mov    %rcx,-0x10(%rdx)
     603:	sub    %r9,%rax
     606:	mov    0x18(%rsp),%ecx
     60a:	sar    $0x4,%rax
     60e:	mov    %ecx,-0x8(%rdx)
     611:	lea    -0x1(%rax),%rdx
     615:	sub    $0x2,%rax
     619:	mov    %rax,%r8
     61c:	mov    %ecx,0x28(%rsp)
     620:	shr    $0x3f,%r8
     624:	vmovsd %xmm1,0x20(%rsp)
     62a:	add    %rax,%r8
     62d:	sar    $1,%r8
     630:	test   %rdx,%rdx
     633:	jle    55a <ivf::TopK::add(ivf::Neighbor)+0x7a>
     639:	lea    0x20(%rsp),%rcx
     63e:	jmp    668 <ivf::TopK::add(ivf::Neighbor)+0x188>
     640:	mov    (%rdi),%rdx
     643:	mov    %rdx,(%rax)
     646:	mov    0x8(%rdi),%edx
     649:	mov    %edx,0x8(%rax)
     64c:	lea    -0x1(%r8),%rdx
     650:	mov    %rdx,%rax
     653:	shr    $0x3f,%rax
     657:	add    %rdx,%rax
     65a:	mov    %r8,%rdx
     65d:	sar    $1,%rax
     660:	test   %r8,%r8
     663:	je     690 <ivf::TopK::add(ivf::Neighbor)+0x1b0>
     665:	mov    %rax,%r8
     668:	mov    %r8,%rdi
     66b:	mov    %rcx,%rsi
     66e:	shl    $0x4,%rdx
     672:	shl    $0x4,%rdi
     676:	add    %r9,%rdi
     679:	call   67e <ivf::TopK::add(ivf::Neighbor)+0x19e>
     67e:	mov    %eax,%esi
     680:	lea    (%r9,%rdx,1),%rax
     684:	test   %sil,%sil
     687:	jne    640 <ivf::TopK::add(ivf::Neighbor)+0x160>
     689:	jmp    568 <ivf::TopK::add(ivf::Neighbor)+0x88>
     68e:	xchg   %ax,%ax
     690:	mov    0x20(%rsp),%rdx
     695:	mov    %rdi,%rax
     698:	mov    %rdx,(%rax)
     69b:	mov    0x28(%rsp),%edx
     69f:	mov    %edx,0x8(%rax)
     6a2:	jmp    577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     6a7:	nopw   0x0(%rax,%rax,1)
     6b0:	cmp    0x18(%rdi),%rsi
     6b4:	je     780 <ivf::TopK::add(ivf::Neighbor)+0x2a0>
     6ba:	vmovdqa 0x10(%rsp),%xmm2
     6c0:	add    $0x10,%rsi
     6c4:	vmovdqu %xmm2,-0x10(%rsi)
     6c9:	mov    %rsi,0x10(%rdi)
     6cd:	mov    %rsi,%rdx
     6d0:	mov    -0x8(%rsi),%ecx
     6d3:	vmovsd -0x10(%rsi),%xmm0
     6d8:	sub    %r9,%rdx
     6db:	mov    %rdx,%rax
     6de:	mov    %ecx,0x28(%rsp)
     6e2:	sar    $0x4,%rax
     6e6:	vmovsd %xmm0,0x20(%rsp)
     6ec:	lea    -0x1(%rax),%r10
     6f0:	sub    $0x2,%rax
     6f4:	mov    %rax,%r8
     6f7:	shr    $0x3f,%r8
     6fb:	add    %rax,%r8
     6fe:	sar    $1,%r8
     701:	test   %r10,%r10
     704:	jle    79b <ivf::TopK::add(ivf::Neighbor)+0x2bb>
     70a:	lea    0x20(%rsp),%rcx
     70f:	jmp    744 <ivf::TopK::add(ivf::Neighbor)+0x264>
     711:	nopl   0x0(%rax)
     718:	mov    (%rdi),%rdx
     71b:	mov    %r8,%r10
     71e:	mov    %rdx,(%rax)
     721:	mov    0x8(%rdi),%edx
     724:	mov    %edx,0x8(%rax)
     727:	lea    -0x1(%r8),%rdx
     72b:	mov    %rdx,%rax
     72e:	shr    $0x3f,%rax
     732:	add    %rdx,%rax
     735:	sar    $1,%rax
     738:	test   %r8,%r8
     73b:	je     690 <ivf::TopK::add(ivf::Neighbor)+0x1b0>
     741:	mov    %rax,%r8
     744:	mov    %r8,%rax
     747:	mov    %rcx,%rsi
     74a:	shl    $0x4,%rax
     74e:	lea    (%r9,%rax,1),%rdi
     752:	call   757 <ivf::TopK::add(ivf::Neighbor)+0x277>
     757:	mov    %eax,%edx
     759:	mov    %r10,%rax
     75c:	shl    $0x4,%rax
     760:	add    %r9,%rax
     763:	test   %dl,%dl
     765:	jne    718 <ivf::TopK::add(ivf::Neighbor)+0x238>
     767:	mov    0x20(%rsp),%rdx
     76c:	mov    %rdx,(%rax)
     76f:	mov    0x28(%rsp),%edx
     773:	mov    %edx,0x8(%rax)
     776:	jmp    577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     77b:	nopl   0x0(%rax,%rax,1)
     780:	lea    0x10(%rsp),%rdx
     785:	lea    0x8(%rdi),%rdi
     789:	call   78e <ivf::TopK::add(ivf::Neighbor)+0x2ae>
     78e:	mov    0x8(%rbx),%r9
     792:	mov    0x10(%rbx),%rsi
     796:	jmp    6cd <ivf::TopK::add(ivf::Neighbor)+0x1ed>
     79b:	lea    -0x10(%r9,%rdx,1),%rax
     7a0:	jmp    568 <ivf::TopK::add(ivf::Neighbor)+0x88>
     7a5:	call   7aa <ivf::TopK::add(ivf::Neighbor)+0x2ca>
     7aa:	nopw   0x0(%rax,%rax,1)

00000000000007b0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)>:
     7b0:	endbr64
     7b4:	push   %rbp
     7b5:	mov    %rsp,%rbp
     7b8:	push   %r15
     7ba:	push   %r14
     7bc:	push   %r13
     7be:	push   %r12
     7c0:	push   %rbx
     7c1:	and    $0xffffffffffffffe0,%rsp
     7c5:	sub    $0x60,%rsp
     7c9:	mov    %rdi,0x28(%rsp)
     7ce:	mov    %fs:0x28,%rax
     7d7:	mov    %rax,0x58(%rsp)
     7dc:	mov    0x10(%rsi),%rax
     7e0:	mov    %rax,0x30(%rsp)
     7e5:	shr    $0x3b,%rax
     7e9:	jne    c76 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4c6>
     7ef:	cmpq   $0x0,0x30(%rsp)
     7f5:	mov    %rcx,%r14
     7f8:	je     b84 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3d4>
     7fe:	shlq   $0x4,0x30(%rsp)
     804:	mov    0x30(%rsp),%r13
     809:	mov    %rsi,%r15
     80c:	mov    %rdx,%r12
     80f:	mov    %r13,%rdi
     812:	call   817 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x67>
     817:	vmovsd 0x0(%rip),%xmm0        # 81f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x6f>
     81f:	add    %rax,%r13
     822:	mov    %rax,0x40(%rsp)
     827:	mov    %rax,%rbx
     82a:	mov    %r13,0x50(%rsp)
     82f:	nop
     830:	movl   $0xffffffff,0x8(%rax)
     837:	add    $0x10,%rax
     83b:	vmovsd %xmm0,-0x10(%rax)
     840:	cmp    %r13,%rax
     843:	jne    830 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x80>
     845:	mov    0x10(%r15),%rdi
     849:	mov    %r13,0x48(%rsp)
     84e:	test   %rdi,%rdi
     851:	je     8b9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x109>
     853:	mov    0x8(%r15),%rcx
     857:	mov    0x60(%r15),%rdx
     85b:	vxorps %xmm3,%xmm3,%xmm3
     85f:	mov    %rbx,%rsi
     862:	xor    %r9d,%r9d
     865:	lea    0x0(,%rcx,4),%r8
     86d:	nopl   (%rax)
     870:	test   %rcx,%rcx
     873:	vxorpd %xmm2,%xmm2,%xmm2
     877:	je     8a0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xf0>
     879:	xor    %eax,%eax
     87b:	nopl   0x0(%rax,%rax,1)
     880:	vcvtss2sd (%r12,%rax,4),%xmm3,%xmm0
     886:	vcvtss2sd (%rdx,%rax,4),%xmm3,%xmm1
     88b:	vsubsd %xmm1,%xmm0,%xmm0
     88f:	add    $0x1,%rax
     893:	cmp    %rax,%rcx
     896:	vmulsd %xmm0,%xmm0,%xmm0
     89a:	vaddsd %xmm0,%xmm2,%xmm2
     89e:	jne    880 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xd0>
     8a0:	mov    %r9d,0x8(%rsi)
     8a4:	add    $0x1,%r9
     8a8:	add    $0x10,%rsi
     8ac:	add    %r8,%rdx
     8af:	vmovsd %xmm2,-0x10(%rsi)
     8b4:	cmp    %rdi,%r9
     8b7:	jne    870 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xc0>
     8b9:	mov    %r14,%rax
     8bc:	lea    0x0(%rip),%r15        # 8c3 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x113>
     8c3:	shl    $0x4,%rax
     8c7:	lea    (%rbx,%rax,1),%rdi
     8cb:	cmp    $0x10,%rax
     8cf:	mov    %rax,0x18(%rsp)
     8d4:	mov    %rdi,0x20(%rsp)
     8d9:	jg     bc6 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x416>
     8df:	cmp    %r13,0x20(%rsp)
     8e4:	jae    9ae <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1fe>
     8ea:	mov    0x18(%rsp),%rax
     8ef:	mov    0x20(%rsp),%r12
     8f4:	sar    $0x4,%rax
     8f8:	mov    %rax,0x38(%rsp)
     8fd:	nopl   (%rax)
     900:	vmovsd (%r12),%xmm1
     906:	vmovsd (%rbx),%xmm0
     90a:	vcomisd %xmm1,%xmm0
     90e:	ja     922 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x172>
     910:	vucomisd %xmm0,%xmm1
     914:	jp     94e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x19e>
     916:	jne    94e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x19e>
     918:	mov    0x8(%rbx),%eax
     91b:	cmp    %eax,0x8(%r12)
     920:	jge    94e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x19e>
     922:	mov    (%rbx),%rax
     925:	vmovq  (%r12),%xmm0
     92b:	mov    %r15,%r8
     92e:	xor    %esi,%esi
     930:	mov    0x8(%r12),%rcx
     935:	mov    0x38(%rsp),%rdx
     93a:	mov    %rbx,%rdi
     93d:	mov    %rax,(%r12)
     941:	mov    0x8(%rbx),%eax
     944:	mov    %eax,0x8(%r12)
     949:	call   94e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x19e>
     94e:	add    $0x10,%r12
     952:	cmp    %r13,%r12
     955:	jb     900 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x150>
     957:	cmpq   $0x10,0x18(%rsp)
     95d:	jle    9ae <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1fe>
     95f:	mov    0x20(%rsp),%r12
     964:	lea    0x0(%rip),%r15        # 96b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1bb>
     96b:	sub    $0x10,%r12
     96f:	nop
     970:	mov    (%rbx),%rax
     973:	vmovq  (%r12),%xmm0
     979:	mov    %r12,%r13
     97c:	mov    %r15,%r8
     97f:	mov    0x8(%r12),%rcx
     984:	sub    %rbx,%r13
     987:	xor    %esi,%esi
     989:	mov    %rbx,%rdi
     98c:	mov    %rax,(%r12)
     990:	mov    0x8(%rbx),%eax
     993:	mov    %r13,%rdx
     996:	sar    $0x4,%rdx
     99a:	mov    %eax,0x8(%r12)
     99f:	call   9a4 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1f4>
     9a4:	sub    $0x10,%r12
     9a8:	cmp    $0x10,%r13
     9ac:	jg     970 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1c0>
     9ae:	mov    %r14,%rax
     9b1:	shr    $0x3d,%rax
     9b5:	jne    c5a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4aa>
     9bb:	mov    0x28(%rsp),%r15
     9c0:	vpxor  %xmm0,%xmm0,%xmm0
     9c4:	test   %r14,%r14
     9c7:	movq   $0x0,0x10(%r15)
     9cf:	vmovdqu %xmm0,(%r15)
     9d4:	je     c25 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x475>
     9da:	lea    0x0(,%r14,4),%r12
     9e2:	mov    %r12,%rdi
     9e5:	call   9ea <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x23a>
     9ea:	mov    %rax,%r13
     9ed:	cmp    $0x1,%r14
     9f1:	mov    %r15,%rax
     9f4:	mov    %r13,(%r15)
     9f7:	lea    0x0(%r13,%r12,1),%r15
     9fc:	lea    0x4(%r13),%rdi
     a00:	mov    %r15,0x10(%rax)
     a04:	movl   $0x0,0x0(%r13)
     a0c:	je     c32 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x482>
     a12:	cmp    %rdi,%r15
     a15:	je     a23 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x273>
     a17:	lea    -0x4(%r12),%rdx
     a1c:	xor    %esi,%esi
     a1e:	call   a23 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x273>
     a23:	mov    0x28(%rsp),%rax
     a28:	lea    -0x1(%r14),%rcx
     a2c:	cmp    $0x7,%rcx
     a30:	mov    %r15,0x8(%rax)
     a34:	jbe    c47 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x497>
     a3a:	mov    %rcx,%rsi
     a3d:	vmovdqa 0x0(%rip),%ymm3        # a45 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x295>
     a45:	mov    %r13,%rdx
     a48:	lea    0x8(%rbx),%rax
     a4c:	shr    $0x3,%rsi
     a50:	vmovdqa 0x0(%rip),%ymm2        # a58 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2a8>
     a58:	shl    $0x5,%rsi
     a5c:	add    %r13,%rsi
     a5f:	nop
     a60:	vxorps %xmm1,%xmm1,%xmm1
     a64:	vpermd 0x20(%rax),%ymm2,%ymm1
     a6a:	vxorps %xmm0,%xmm0,%xmm0
     a6e:	vpermd (%rax),%ymm3,%ymm0
     a73:	add    $0x20,%rdx
     a77:	sub    $0xffffffffffffff80,%rax
     a7b:	vxorps %xmm4,%xmm4,%xmm4
     a7f:	vpermd -0x20(%rax),%ymm2,%ymm4
     a85:	vpblendd $0xf0,%ymm1,%ymm0,%ymm0
     a8b:	vxorps %xmm1,%xmm1,%xmm1
     a8f:	vpermd -0x40(%rax),%ymm3,%ymm1
     a95:	vpermd %ymm0,%ymm3,%ymm0
     a9a:	vpblendd $0xf0,%ymm4,%ymm1,%ymm1
     aa0:	vpermd %ymm1,%ymm2,%ymm1
     aa5:	vpblendd $0xf0,%ymm1,%ymm0,%ymm0
     aab:	vmovdqu %ymm0,-0x20(%rdx)
     ab0:	cmp    %rsi,%rdx
     ab3:	jne    a60 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2b0>
     ab5:	mov    %rcx,%rax
     ab8:	and    $0xfffffffffffffff8,%rax
     abc:	vzeroupper
     abf:	sub    %rax,%rcx
     ac2:	cmp    $0x3,%rcx
     ac6:	jbe    afc <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x34c>
     ac8:	mov    %rax,%rdx
     acb:	and    $0xfffffffffffffffc,%rcx
     acf:	shl    $0x4,%rdx
     ad3:	lea    0x8(%rbx,%rdx,1),%rdx
     ad8:	vmovdqu (%rdx),%xmm5
     adc:	vmovdqu 0x20(%rdx),%xmm6
     ae1:	vshufps $0x88,0x10(%rdx),%xmm5,%xmm0
     ae7:	vshufps $0x88,0x30(%rdx),%xmm6,%xmm1
     aed:	vshufps $0x88,%xmm1,%xmm0,%xmm0
     af2:	vmovdqu %xmm0,0x0(%r13,%rax,4)
     af9:	add    %rcx,%rax
     afc:	mov    %rax,%rdx
     aff:	lea    0x0(,%rax,4),%rcx
     b07:	shl    $0x4,%rdx
     b0b:	mov    0x8(%rbx,%rdx,1),%esi
     b0f:	mov    %esi,0x0(%r13,%rax,4)
     b14:	lea    0x1(%rax),%rsi
     b18:	cmp    %r14,%rsi
     b1b:	jae    b4a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39a>
     b1d:	mov    0x18(%rbx,%rdx,1),%esi
     b21:	mov    %esi,0x4(%r13,%rcx,1)
     b26:	lea    0x2(%rax),%rsi
     b2a:	cmp    %r14,%rsi
     b2d:	jae    b4a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39a>
     b2f:	mov    0x28(%rbx,%rdx,1),%esi
     b33:	add    $0x3,%rax
     b37:	cmp    %r14,%rax
     b3a:	mov    %esi,0x8(%r13,%rcx,1)
     b3f:	jae    b4a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39a>
     b41:	mov    0x38(%rbx,%rdx,1),%eax
     b45:	mov    %eax,0xc(%r13,%rcx,1)
     b4a:	test   %rbx,%rbx
     b4d:	je     b5c <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3ac>
     b4f:	mov    0x30(%rsp),%rsi
     b54:	mov    %rbx,%rdi
     b57:	call   b5c <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3ac>
     b5c:	mov    0x58(%rsp),%rax
     b61:	sub    %fs:0x28,%rax
     b6a:	jne    c55 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4a5>
     b70:	mov    0x28(%rsp),%rax
     b75:	lea    -0x28(%rbp),%rsp
     b79:	pop    %rbx
     b7a:	pop    %r12
     b7c:	pop    %r13
     b7e:	pop    %r14
     b80:	pop    %r15
     b82:	pop    %rbp
     b83:	ret
     b84:	mov    %rcx,%rax
     b87:	lea    0x0(%rip),%r15        # b8e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3de>
     b8e:	movq   $0x0,0x40(%rsp)
     b97:	movq   $0x0,0x50(%rsp)
     ba0:	shl    $0x4,%rax
     ba4:	cmp    $0x10,%rax
     ba8:	mov    %rax,0x20(%rsp)
     bad:	movq   $0x0,0x48(%rsp)
     bb6:	mov    %rax,0x18(%rsp)
     bbb:	jle    c4e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x49e>
     bc1:	xor    %r13d,%r13d
     bc4:	xor    %ebx,%ebx
     bc6:	sar    $0x4,%rax
     bca:	mov    %rax,0x38(%rsp)
     bcf:	sub    $0x2,%rax
     bd3:	mov    %rax,%r12
     bd6:	shr    $0x3f,%r12
     bda:	add    %rax,%r12
     bdd:	sar    $1,%r12
     be0:	jmp    bec <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x43c>
     be2:	nopw   0x0(%rax,%rax,1)
     be8:	sub    $0x1,%r12
     bec:	mov    %r12,%rax
     bef:	mov    0x38(%rsp),%rdx
     bf4:	mov    %r15,%r8
     bf7:	mov    %r12,%rsi
     bfa:	shl    $0x4,%rax
     bfe:	mov    %rbx,%rdi
     c01:	vmovq  (%rbx,%rax,1),%xmm0
     c06:	mov    0x8(%rbx,%rax,1),%rcx
     c0b:	call   c10 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x460>
     c10:	test   %r12,%r12
     c13:	jne    be8 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x438>
     c15:	cmp    %r13,0x20(%rsp)
     c1a:	jb     8ea <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x13a>
     c20:	jmp    95f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1af>
     c25:	movq   $0x0,0x10(%r15)
     c2d:	jmp    b4a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39a>
     c32:	mov    0x28(%rsp),%rax
     c37:	mov    %rdi,0x8(%rax)
     c3b:	mov    0x8(%rbx),%eax
     c3e:	mov    %eax,0x0(%r13)
     c42:	jmp    b4a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39a>
     c47:	xor    %eax,%eax
     c49:	jmp    abf <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x30f>
     c4e:	xor    %ebx,%ebx
     c50:	jmp    9ae <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1fe>
     c55:	call   c5a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4aa>
     c5a:	mov    0x58(%rsp),%rax
     c5f:	sub    %fs:0x28,%rax
     c68:	jne    c55 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4a5>
     c6a:	lea    0x0(%rip),%rdi        # c71 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4c1>
     c71:	call   c76 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4c6>
     c76:	mov    0x58(%rsp),%rax
     c7b:	sub    %fs:0x28,%rax
     c84:	jne    c55 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4a5>
     c86:	lea    0x0(%rip),%rdi        # c8d <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4dd>
     c8d:	call   c92 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4e2>
     c92:	endbr64
     c96:	mov    %rax,%rbx
     c99:	jmp    c9e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4ee>
     c9e:	xchg   %ax,%ax

0000000000000ca0 <ivf::TopK::finish(ivf::Neighbor*)>:
     ca0:	endbr64
     ca4:	push   %r15
     ca6:	push   %r14
     ca8:	push   %r13
     caa:	mov    %rdi,%r13
     cad:	push   %r12
     caf:	push   %rbp
     cb0:	mov    %rsi,%rbp
     cb3:	push   %rbx
     cb4:	sub    $0x8,%rsp
     cb8:	mov    0x10(%rdi),%rbx
     cbc:	mov    0x8(%rdi),%r12
     cc0:	mov    %rbx,%rdx
     cc3:	sub    $0x10,%rbx
     cc7:	sub    %r12,%rdx
     cca:	cmp    $0x10,%rdx
     cce:	jle    d88 <ivf::TopK::finish(ivf::Neighbor*)+0xe8>
     cd4:	lea    0x0(%rip),%r14        # cdb <ivf::TopK::finish(ivf::Neighbor*)+0x3b>
     cdb:	nopl   0x0(%rax,%rax,1)
     ce0:	mov    (%r12),%rax
     ce4:	vmovq  (%rbx),%xmm0
     ce8:	mov    %rbx,%r15
     ceb:	xor    %esi,%esi
     ced:	mov    0x8(%rbx),%rcx
     cf1:	sub    %r12,%r15
     cf4:	mov    %r14,%r8
     cf7:	mov    %r12,%rdi
     cfa:	mov    %rax,(%rbx)
     cfd:	mov    0x8(%r12),%eax
     d02:	mov    %r15,%rdx
     d05:	sub    $0x10,%rbx
     d09:	sar    $0x4,%rdx
     d0d:	mov    %eax,0x18(%rbx)
     d10:	call   d15 <ivf::TopK::finish(ivf::Neighbor*)+0x75>
     d15:	cmp    $0x10,%r15
     d19:	jg     ce0 <ivf::TopK::finish(ivf::Neighbor*)+0x40>
     d1b:	mov    0x8(%r13),%r12
     d1f:	mov    0x10(%r13),%rdx
     d23:	sub    %r12,%rdx
     d26:	cmp    $0x10,%rdx
     d2a:	jle    d88 <ivf::TopK::finish(ivf::Neighbor*)+0xe8>
     d2c:	mov    %r12,%rsi
     d2f:	mov    %rbp,%rdi
     d32:	call   d37 <ivf::TopK::finish(ivf::Neighbor*)+0x97>
     d37:	mov    0x10(%r13),%rdx
     d3b:	sub    0x8(%r13),%rdx
     d3f:	mov    0x0(%r13),%rax
     d43:	add    %rbp,%rdx
     d46:	vmovsd 0x0(%rip),%xmm0        # d4e <ivf::TopK::finish(ivf::Neighbor*)+0xae>
     d4e:	shl    $0x4,%rax
     d52:	add    %rbp,%rax
     d55:	cmp    %rdx,%rax
     d58:	je     d75 <ivf::TopK::finish(ivf::Neighbor*)+0xd5>
     d5a:	nopw   0x0(%rax,%rax,1)
     d60:	movl   $0xffffffff,0x8(%rdx)
     d67:	add    $0x10,%rdx
     d6b:	vmovsd %xmm0,-0x10(%rdx)
     d70:	cmp    %rdx,%rax
     d73:	jne    d60 <ivf::TopK::finish(ivf::Neighbor*)+0xc0>
     d75:	add    $0x8,%rsp
     d79:	pop    %rbx
     d7a:	pop    %rbp
     d7b:	pop    %r12
     d7d:	pop    %r13
     d7f:	pop    %r14
     d81:	pop    %r15
     d83:	ret
     d84:	nopl   0x0(%rax)
     d88:	cmp    $0x10,%rdx
     d8c:	jne    d3f <ivf::TopK::finish(ivf::Neighbor*)+0x9f>
     d8e:	mov    (%r12),%rax
     d92:	mov    %rax,0x0(%rbp)
     d96:	mov    0x8(%r12),%eax
     d9b:	mov    %eax,0x8(%rbp)
     d9e:	jmp    d3f <ivf::TopK::finish(ivf::Neighbor*)+0x9f>

0000000000000da0 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)>:
     da0:	endbr64
     da4:	push   %r15
     da6:	push   %r14
     da8:	push   %r13
     daa:	push   %r12
     dac:	push   %rbp
     dad:	push   %rbx
     dae:	sub    $0x58,%rsp
     db2:	mov    %rdx,0x10(%rsp)
     db7:	mov    %rcx,0x8(%rsp)
     dbc:	mov    %r8,0x18(%rsp)
     dc1:	mov    %fs:0x28,%rax
     dca:	mov    %rax,0x48(%rsp)
     dcf:	xor    %eax,%eax
     dd1:	test   %rdx,%rdx
     dd4:	je     eee <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x14e>
     dda:	lea    0x20(%rsp),%rax
     ddf:	mov    %rdi,%r12
     de2:	mov    %rsi,%r15
     de5:	xor    %r13d,%r13d
     de8:	movabs $0xffffffff00000000,%r14
     df2:	mov    %rax,(%rsp)
     df6:	cs nopw 0x0(%rax,%rax,1)
     e00:	mov    0x8(%rsp),%rax
     e05:	mov    (%rsp),%rdi
     e09:	mov    (%rax),%rsi
     e0c:	call   e11 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x71>
     e11:	cmpq   $0x0,(%r12)
     e16:	je     ea7 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x107>
     e1c:	xor    %ebx,%ebx
     e1e:	xchg   %ax,%ax
     e20:	mov    0x8(%r12),%rcx
     e25:	mov    0x48(%r12),%rsi
     e2a:	mov    %rcx,%rax
     e2d:	mov    %rcx,%rdx
     e30:	imul   %rbx,%rax
     e34:	imul   %r13,%rdx
     e38:	shl    $0x2,%rax
     e3c:	shl    $0x2,%rdx
     e40:	test   %rcx,%rcx
     e43:	je     f10 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x170>
     e49:	add    %rax,%rsi
     e4c:	add    %r15,%rdx
     e4f:	vxorpd %xmm2,%xmm2,%xmm2
     e53:	xor    %eax,%eax
     e55:	nopl   (%rax)
     e58:	vxorpd %xmm3,%xmm3,%xmm3
     e5c:	vcvtss2sd (%rdx,%rax,4),%xmm3,%xmm0
     e61:	vcvtss2sd (%rsi,%rax,4),%xmm3,%xmm1
     e66:	vsubsd %xmm1,%xmm0,%xmm0
     e6a:	add    $0x1,%rax
     e6e:	cmp    %rax,%rcx
     e71:	vmulsd %xmm0,%xmm0,%xmm0
     e75:	vaddsd %xmm0,%xmm2,%xmm2
     e79:	jne    e58 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xb8>
     e7b:	mov    0x30(%r12),%rax
     e80:	and    %r14,%rbp
     e83:	mov    (%rsp),%rdi
     e87:	vmovsd %xmm2,%xmm2,%xmm0
     e8b:	mov    (%rax,%rbx,4),%eax
     e8e:	or     %rax,%rbp
     e91:	mov    %rbp,%rsi
     e94:	call   e99 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xf9>
     e99:	add    $0x1,%rbx
     e9d:	cmp    (%r12),%rbx
     ea1:	jb     e20 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x80>
     ea7:	mov    0x8(%rsp),%rax
     eac:	mov    (%rsp),%rdi
     eb0:	mov    (%rax),%rsi
     eb3:	mov    0x18(%rsp),%rax
     eb8:	imul   %r13,%rsi
     ebc:	shl    $0x4,%rsi
     ec0:	add    %rax,%rsi
     ec3:	call   ec8 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x128>
     ec8:	mov    0x28(%rsp),%rdi
     ecd:	test   %rdi,%rdi
     ed0:	je     f19 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x179>
     ed2:	mov    0x38(%rsp),%rsi
     ed7:	add    $0x1,%r13
     edb:	sub    %rdi,%rsi
     ede:	call   ee3 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x143>
     ee3:	cmp    %r13,0x10(%rsp)
     ee8:	jne    e00 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x60>
     eee:	mov    0x48(%rsp),%rax
     ef3:	sub    %fs:0x28,%rax
     efc:	jne    f2a <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x18a>
     efe:	add    $0x58,%rsp
     f02:	pop    %rbx
     f03:	pop    %rbp
     f04:	pop    %r12
     f06:	pop    %r13
     f08:	pop    %r14
     f0a:	pop    %r15
     f0c:	ret
     f0d:	nopl   (%rax)
     f10:	vxorpd %xmm2,%xmm2,%xmm2
     f14:	jmp    e7b <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xdb>
     f19:	add    $0x1,%r13
     f1d:	cmp    %r13,0x10(%rsp)
     f22:	jne    e00 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x60>
     f28:	jmp    eee <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x14e>
     f2a:	call   f2f <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x18f>
     f2f:	endbr64
     f33:	mov    %rax,%rbx
     f36:	jmp    f3b <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x19b>
     f3b:	nopl   0x0(%rax,%rax,1)

0000000000000f40 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)>:
     f40:	endbr64
     f44:	push   %r15
     f46:	movabs $0xffffffff00000000,%r15
     f50:	push   %r14
     f52:	push   %r13
     f54:	mov    %rdi,%r13
     f57:	push   %r12
     f59:	push   %rbp
     f5a:	push   %rbx
     f5b:	sub    $0xa8,%rsp
     f62:	mov    %rsi,0x38(%rsp)
     f67:	mov    %rdx,0x28(%rsp)
     f6c:	mov    %rcx,0x30(%rsp)
     f71:	mov    %r8,0x40(%rsp)
     f76:	mov    %fs:0x28,%rax
     f7f:	mov    %rax,0x98(%rsp)
     f87:	xor    %eax,%eax
     f89:	lea    0x50(%rsp),%rax
     f8e:	test   %rdx,%rdx
     f91:	movq   $0x0,0x18(%rsp)
     f9a:	mov    %rax,0x48(%rsp)
     f9f:	lea    0x70(%rsp),%rax
     fa4:	mov    %rax,(%rsp)
     fa8:	je     1129 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1e9>
     fae:	mov    0x18(%rsp),%rax
     fb3:	imul   0x8(%r13),%rax
     fb8:	mov    0x38(%rsp),%rsi
     fbd:	mov    0x30(%rsp),%r14
     fc2:	mov    0x48(%rsp),%rdi
     fc7:	lea    (%rsi,%rax,4),%rbx
     fcb:	mov    0x8(%r14),%rcx
     fcf:	mov    %r13,%rsi
     fd2:	mov    %rbx,%rdx
     fd5:	call   fda <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x9a>
     fda:	mov    (%r14),%rsi
     fdd:	mov    (%rsp),%rdi
     fe1:	call   fe6 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xa6>
     fe6:	mov    0x50(%rsp),%rax
     feb:	mov    0x58(%rsp),%rsi
     ff0:	cmp    %rax,%rsi
     ff3:	mov    %rax,0x20(%rsp)
     ff8:	mov    %rsi,0x10(%rsp)
     ffd:	je     10bc <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x17c>
    1003:	mov    %rax,%rsi
    1006:	mov    0x18(%r13),%rax
    100a:	mov    %rsi,0x8(%rsp)
    100f:	nop
    1010:	mov    0x8(%rsp),%rsi
    1015:	mov    (%rsi),%ecx
    1017:	mov    %rcx,%rdx
    101a:	mov    (%rax,%rcx,8),%rbp
    101e:	add    $0x1,%edx
    1021:	cmp    (%rax,%rdx,8),%rbp
    1025:	lea    0x0(,%rdx,8),%r14
    102d:	jae    10a6 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x166>
    102f:	nop
    1030:	mov    0x8(%r13),%rdx
    1034:	mov    0x48(%r13),%rcx
    1038:	mov    %rdx,%rax
    103b:	imul   %rbp,%rax
    103f:	shl    $0x2,%rax
    1043:	test   %rdx,%rdx
    1046:	je     1150 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x210>
    104c:	add    %rax,%rcx
    104f:	vxorpd %xmm2,%xmm2,%xmm2
    1053:	xor    %eax,%eax
    1055:	nopl   (%rax)
    1058:	vxorpd %xmm3,%xmm3,%xmm3
    105c:	vcvtss2sd (%rbx,%rax,4),%xmm3,%xmm0
    1061:	vcvtss2sd (%rcx,%rax,4),%xmm3,%xmm1
    1066:	vsubsd %xmm1,%xmm0,%xmm0
    106a:	add    $0x1,%rax
    106e:	cmp    %rax,%rdx
    1071:	vmulsd %xmm0,%xmm0,%xmm0
    1075:	vaddsd %xmm0,%xmm2,%xmm2
    1079:	jne    1058 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x118>
    107b:	mov    0x30(%r13),%rax
    107f:	and    %r15,%r12
    1082:	mov    (%rsp),%rdi
    1086:	vmovsd %xmm2,%xmm2,%xmm0
    108a:	mov    (%rax,%rbp,4),%eax
    108d:	or     %rax,%r12
    1090:	mov    %r12,%rsi
    1093:	call   1098 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x158>
    1098:	mov    0x18(%r13),%rax
    109c:	add    $0x1,%rbp
    10a0:	cmp    (%rax,%r14,1),%rbp
    10a4:	jb     1030 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xf0>
    10a6:	addq   $0x4,0x8(%rsp)
    10ac:	mov    0x8(%rsp),%rdi
    10b1:	cmp    %rdi,0x10(%rsp)
    10b6:	jne    1010 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xd0>
    10bc:	mov    0x30(%rsp),%rax
    10c1:	mov    0x18(%rsp),%rsi
    10c6:	mov    (%rsp),%rdi
    10ca:	imul   (%rax),%rsi
    10ce:	mov    0x40(%rsp),%rax
    10d3:	shl    $0x4,%rsi
    10d7:	add    %rax,%rsi
    10da:	call   10df <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x19f>
    10df:	mov    0x78(%rsp),%rdi
    10e4:	test   %rdi,%rdi
    10e7:	je     10f9 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1b9>
    10e9:	mov    0x88(%rsp),%rsi
    10f1:	sub    %rdi,%rsi
    10f4:	call   10f9 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1b9>
    10f9:	mov    0x20(%rsp),%rdi
    10fe:	test   %rdi,%rdi
    1101:	je     1159 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x219>
    1103:	mov    0x60(%rsp),%rsi
    1108:	sub    %rdi,%rsi
    110b:	call   1110 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1d0>
    1110:	addq   $0x1,0x18(%rsp)
    1116:	mov    0x28(%rsp),%rsi
    111b:	mov    0x18(%rsp),%rax
    1120:	cmp    %rsi,%rax
    1123:	jne    fae <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x6e>
    1129:	mov    0x98(%rsp),%rax
    1131:	sub    %fs:0x28,%rax
    113a:	jne    1171 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x231>
    113c:	add    $0xa8,%rsp
    1143:	pop    %rbx
    1144:	pop    %rbp
    1145:	pop    %r12
    1147:	pop    %r13
    1149:	pop    %r14
    114b:	pop    %r15
    114d:	ret
    114e:	xchg   %ax,%ax
    1150:	vxorpd %xmm2,%xmm2,%xmm2
    1154:	jmp    107b <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x13b>
    1159:	addq   $0x1,0x18(%rsp)
    115f:	mov    0x18(%rsp),%rax
    1164:	cmp    %rax,0x28(%rsp)
    1169:	jne    fae <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x6e>
    116f:	jmp    1129 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1e9>
    1171:	call   1176 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x236>
    1176:	endbr64
    117a:	mov    %rax,%rbx
    117d:	jmp    1182 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x242>
    1182:	endbr64
    1186:	mov    %rax,%rbx
    1189:	vzeroupper
    118c:	jmp    1191 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x251>

Disassembly of section .text._ZNSt7__cxx119to_stringEi:

0000000000000000 <std::__cxx11::to_string(int)>:
   0:	endbr64
   4:	push   %rbp
   5:	mov    %esi,%ecx
   7:	shr    $0x1f,%ecx
   a:	mov    %rsp,%rbp
   d:	push   %r15
   f:	movzbl %cl,%r15d
  13:	push   %r14
  15:	mov    %rdi,%r14
  18:	push   %r13
  1a:	push   %r12
  1c:	mov    %esi,%r12d
  1f:	push   %rbx
  20:	sub    $0xe8,%rsp
  27:	mov    %fs:0x28,%rax
  30:	mov    %rax,0xd8(%rsp)
  38:	xor    %eax,%eax
  3a:	neg    %r12d
  3d:	cmovs  %esi,%r12d
  41:	mov    %ecx,%esi
  43:	cmp    $0x9,%r12d
  47:	jbe    2c9 <std::__cxx11::to_string(int)+0x2c9>
  4d:	cmp    $0x63,%r12d
  51:	jbe    1bb <std::__cxx11::to_string(int)+0x1bb>
  57:	cmp    $0x3e7,%r12d
  5e:	jbe    2f8 <std::__cxx11::to_string(int)+0x2f8>
  64:	cmp    $0x270f,%r12d
  6b:	jbe    2e8 <std::__cxx11::to_string(int)+0x2e8>
  71:	cmp    $0x1869f,%r12d
  78:	mov    %r12d,%ebx
  7b:	mov    $0x5,%eax
  80:	jbe    295 <std::__cxx11::to_string(int)+0x295>
  86:	cmp    $0xf423f,%r12d
  8d:	jbe    308 <std::__cxx11::to_string(int)+0x308>
  93:	cmp    $0x98967f,%r12d
  9a:	mov    $0x6,%r13d
  a0:	mov    $0x7,%eax
  a5:	jbe    299 <std::__cxx11::to_string(int)+0x299>
  ab:	cmp    $0x5f5e0ff,%r12d
  b2:	jbe    2b0 <std::__cxx11::to_string(int)+0x2b0>
  b8:	cmp    $0x3b9ac9ff,%rbx
  bf:	jbe    290 <std::__cxx11::to_string(int)+0x290>
  c5:	mov    $0x9,%r13d
  cb:	lea    0x10(%r14),%rax
  cf:	lea    0x1(%r13,%rsi,1),%esi
  d4:	mov    %rax,(%r14)
  d7:	mov    $0x2d,%edx
  dc:	mov    %r14,%rdi
  df:	call   e4 <std::__cxx11::to_string(int)+0xe4>
  e4:	mov    (%r14),%rcx
  e7:	vmovdqa 0x0(%rip),%ymm1        # ef <std::__cxx11::to_string(int)+0xef>
  ef:	vmovdqa 0x0(%rip),%ymm2        # f7 <std::__cxx11::to_string(int)+0xf7>
  f7:	vmovdqa 0x0(%rip),%ymm3        # ff <std::__cxx11::to_string(int)+0xff>
  ff:	vmovdqa 0x0(%rip),%ymm4        # 107 <std::__cxx11::to_string(int)+0x107>
 107:	add    %r15,%rcx
 10a:	vmovdqu %ymm1,(%rsp)
 10f:	vmovdqa 0x0(%rip),%ymm5        # 117 <std::__cxx11::to_string(int)+0x117>
 117:	vmovdqa 0x0(%rip),%ymm6        # 11f <std::__cxx11::to_string(int)+0x11f>
 11f:	vmovdqa 0x0(%rip),%xmm0        # 127 <std::__cxx11::to_string(int)+0x127>
 127:	vmovdqu %ymm2,0x20(%rsp)
 12d:	vmovdqu %ymm3,0x40(%rsp)
 133:	vmovdqu %ymm6,0xa0(%rsp)
 13c:	vmovdqu %ymm4,0x60(%rsp)
 142:	vmovdqu %ymm5,0x80(%rsp)
 14b:	vmovdqu %xmm0,0xb9(%rsp)
 154:	jmp    163 <std::__cxx11::to_string(int)+0x163>
 156:	cs nopw 0x0(%rax,%rax,1)
 160:	mov    %r12d,%ebx
 163:	imul   $0x51eb851f,%rbx,%rdx
 16a:	mov    %r12d,%eax
 16d:	shr    $0x25,%rdx
 171:	imul   $0x64,%edx,%esi
 174:	sub    %esi,%eax
 176:	mov    %r12d,%esi
 179:	mov    %edx,%r12d
 17c:	mov    %r13d,%edx
 17f:	add    %eax,%eax
 181:	lea    0x1(%rax),%edi
 184:	movzbl (%rsp,%rax,1),%eax
 188:	movzbl (%rsp,%rdi,1),%edi
 18c:	mov    %dil,(%rcx,%rdx,1)
 190:	lea    -0x1(%r13),%edx
 194:	sub    $0x2,%r13d
 198:	cmp    $0x270f,%esi
 19e:	mov    %al,(%rcx,%rdx,1)
 1a1:	ja     160 <std::__cxx11::to_string(int)+0x160>
 1a3:	cmp    $0x3e7,%esi
 1a9:	ja     240 <std::__cxx11::to_string(int)+0x240>
 1af:	vzeroupper
 1b2:	add    $0x30,%r12d
 1b6:	jmp    257 <std::__cxx11::to_string(int)+0x257>
 1bb:	lea    0x10(%rdi),%rax
 1bf:	add    $0x2,%esi
 1c2:	mov    $0x2d,%edx
 1c7:	mov    %rax,(%rdi)
 1ca:	call   1cf <std::__cxx11::to_string(int)+0x1cf>
 1cf:	vmovdqa 0x0(%rip),%ymm7        # 1d7 <std::__cxx11::to_string(int)+0x1d7>
 1d7:	mov    (%r14),%rcx
 1da:	vmovdqa 0x0(%rip),%xmm0        # 1e2 <std::__cxx11::to_string(int)+0x1e2>
 1e2:	vmovdqu %ymm7,(%rsp)
 1e7:	vmovdqa 0x0(%rip),%ymm7        # 1ef <std::__cxx11::to_string(int)+0x1ef>
 1ef:	add    %r15,%rcx
 1f2:	vmovdqu %ymm7,0x20(%rsp)
 1f8:	vmovdqa 0x0(%rip),%ymm7        # 200 <std::__cxx11::to_string(int)+0x200>
 200:	vmovdqu %ymm7,0x40(%rsp)
 206:	vmovdqa 0x0(%rip),%ymm7        # 20e <std::__cxx11::to_string(int)+0x20e>
 20e:	vmovdqu %ymm7,0x60(%rsp)
 214:	vmovdqa 0x0(%rip),%ymm7        # 21c <std::__cxx11::to_string(int)+0x21c>
 21c:	vmovdqu %ymm7,0x80(%rsp)
 225:	vmovdqa 0x0(%rip),%ymm7        # 22d <std::__cxx11::to_string(int)+0x22d>
 22d:	vmovdqu %ymm7,0xa0(%rsp)
 236:	vmovdqu %xmm0,0xb9(%rsp)
 23f:	nop
 240:	add    %r12d,%r12d
 243:	lea    0x1(%r12),%eax
 248:	movzbl (%rsp,%r12,1),%r12d
 24d:	movzbl (%rsp,%rax,1),%eax
 251:	mov    %al,0x1(%rcx)
 254:	vzeroupper
 257:	mov    %r12b,(%rcx)
 25a:	mov    0xd8(%rsp),%rax
 262:	sub    %fs:0x28,%rax
 26b:	jne    313 <std::__cxx11::to_string(int)+0x313>
 271:	add    $0xe8,%rsp
 278:	mov    %r14,%rax
 27b:	pop    %rbx
 27c:	pop    %r12
 27e:	pop    %r13
 280:	pop    %r14
 282:	pop    %r15
 284:	pop    %rbp
 285:	ret
 286:	cs nopw 0x0(%rax,%rax,1)
 290:	mov    $0x9,%eax
 295:	lea    -0x1(%rax),%r13d
 299:	lea    0x10(%r14),%rdx
 29d:	add    %eax,%esi
 29f:	mov    %rdx,(%r14)
 2a2:	jmp    d7 <std::__cxx11::to_string(int)+0xd7>
 2a7:	nopw   0x0(%rax,%rax,1)
 2b0:	mov    $0x8,%eax
 2b5:	lea    0x10(%r14),%rdx
 2b9:	mov    $0x7,%r13d
 2bf:	mov    %rdx,(%r14)
 2c2:	add    %eax,%esi
 2c4:	jmp    d7 <std::__cxx11::to_string(int)+0xd7>
 2c9:	lea    0x10(%rdi),%rax
 2cd:	add    $0x1,%esi
 2d0:	mov    $0x2d,%edx
 2d5:	mov    %rax,(%rdi)
 2d8:	call   2dd <std::__cxx11::to_string(int)+0x2dd>
 2dd:	mov    (%r14),%rcx
 2e0:	add    %r15,%rcx
 2e3:	jmp    1b2 <std::__cxx11::to_string(int)+0x1b2>
 2e8:	mov    $0x3,%r13d
 2ee:	mov    $0x4,%eax
 2f3:	mov    %r12d,%ebx
 2f6:	jmp    299 <std::__cxx11::to_string(int)+0x299>
 2f8:	mov    $0x2,%r13d
 2fe:	mov    $0x3,%eax
 303:	mov    %r12d,%ebx
 306:	jmp    299 <std::__cxx11::to_string(int)+0x299>
 308:	mov    $0x5,%r13d
 30e:	jmp    cb <std::__cxx11::to_string(int)+0xcb>
 313:	call   318 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x8>

Disassembly of section .text._ZNSt7__cxx119to_stringEm:

0000000000000000 <std::__cxx11::to_string(unsigned long)>:
   0:	endbr64
   4:	push   %rbp
   5:	mov    %rsp,%rbp
   8:	push   %r12
   a:	mov    %rdi,%r12
   d:	push   %rbx
   e:	mov    %rsi,%rbx
  11:	sub    $0xe0,%rsp
  18:	mov    %fs:0x28,%rax
  21:	mov    %rax,0xd8(%rsp)
  29:	xor    %eax,%eax
  2b:	cmp    $0x9,%rsi
  2f:	jbe    2a8 <std::__cxx11::to_string(unsigned long)+0x2a8>
  35:	cmp    $0x63,%rsi
  39:	jbe    1b7 <std::__cxx11::to_string(unsigned long)+0x1b7>
  3f:	cmp    $0x3e7,%rsi
  46:	jbe    2c4 <std::__cxx11::to_string(unsigned long)+0x2c4>
  4c:	cmp    $0x270f,%rsi
  53:	jbe    2ce <std::__cxx11::to_string(unsigned long)+0x2ce>
  59:	movabs $0x346dc5d63886594b,%rdi
  63:	mov    %rsi,%rdx
  66:	mov    $0x1,%esi
  6b:	jmp    97 <std::__cxx11::to_string(unsigned long)+0x97>
  6d:	nopl   (%rax)
  70:	cmp    $0xf423f,%rcx
  77:	jbe    280 <std::__cxx11::to_string(unsigned long)+0x280>
  7d:	cmp    $0x98967f,%rcx
  84:	jbe    298 <std::__cxx11::to_string(unsigned long)+0x298>
  8a:	cmp    $0x5f5e0ff,%rcx
  91:	jbe    2a0 <std::__cxx11::to_string(unsigned long)+0x2a0>
  97:	mov    %rdx,%rax
  9a:	mov    %rdx,%rcx
  9d:	mul    %rdi
  a0:	mov    %esi,%eax
  a2:	add    $0x4,%esi
  a5:	shr    $0xb,%rdx
  a9:	cmp    $0x1869f,%rcx
  b0:	ja     70 <std::__cxx11::to_string(unsigned long)+0x70>
  b2:	lea    0x10(%r12),%rax
  b7:	mov    %rax,(%r12)
  bb:	mov    %r12,%rdi
  be:	xor    %edx,%edx
  c0:	call   c5 <std::__cxx11::to_string(unsigned long)+0xc5>
  c5:	mov    0x8(%r12),%eax
  ca:	vmovdqa 0x0(%rip),%ymm1        # d2 <std::__cxx11::to_string(unsigned long)+0xd2>
  d2:	movabs $0x28f5c28f5c28f5c3,%rdi
  dc:	vmovdqa 0x0(%rip),%ymm2        # e4 <std::__cxx11::to_string(unsigned long)+0xe4>
  e4:	vmovdqa 0x0(%rip),%ymm3        # ec <std::__cxx11::to_string(unsigned long)+0xec>
  ec:	vmovdqa 0x0(%rip),%ymm4        # f4 <std::__cxx11::to_string(unsigned long)+0xf4>
  f4:	mov    (%r12),%rsi
  f8:	lea    -0x1(%rax),%ecx
  fb:	vmovdqu %ymm1,(%rsp)
 100:	vmovdqa 0x0(%rip),%ymm5        # 108 <std::__cxx11::to_string(unsigned long)+0x108>
 108:	vmovdqa 0x0(%rip),%ymm6        # 110 <std::__cxx11::to_string(unsigned long)+0x110>
 110:	vmovdqu %ymm2,0x20(%rsp)
 116:	vmovdqa 0x0(%rip),%xmm0        # 11e <std::__cxx11::to_string(unsigned long)+0x11e>
 11e:	vmovdqu %ymm3,0x40(%rsp)
 124:	vmovdqu %ymm6,0xa0(%rsp)
 12d:	vmovdqu %ymm4,0x60(%rsp)
 133:	vmovdqu %ymm5,0x80(%rsp)
 13c:	vmovdqu %xmm0,0xb9(%rsp)
 145:	nopl   (%rax)
 148:	mov    %rbx,%rdx
 14b:	shr    $0x2,%rdx
 14f:	mov    %rdx,%rax
 152:	mul    %rdi
 155:	mov    %rbx,%rax
 158:	mov    %rdx,%r8
 15b:	and    $0xfffffffffffffffc,%rdx
 15f:	shr    $0x2,%r8
 163:	add    %r8,%rdx
 166:	lea    (%rdx,%rdx,4),%rdx
 16a:	shl    $0x2,%rdx
 16e:	sub    %rdx,%rax
 171:	mov    %rbx,%rdx
 174:	mov    %r8,%rbx
 177:	mov    %ecx,%r8d
 17a:	add    %rax,%rax
 17d:	movzbl 0x1(%rsp,%rax,1),%r9d
 183:	movzbl (%rsp,%rax,1),%eax
 187:	mov    %r9b,(%rsi,%r8,1)
 18b:	lea    -0x1(%rcx),%r8d
 18f:	sub    $0x2,%ecx
 192:	cmp    $0x270f,%rdx
 199:	mov    %al,(%rsi,%r8,1)
 19d:	ja     148 <std::__cxx11::to_string(unsigned long)+0x148>
 19f:	cmp    $0x3e7,%rdx
 1a6:	ja     240 <std::__cxx11::to_string(unsigned long)+0x240>
 1ac:	vzeroupper
 1af:	add    $0x30,%ebx
 1b2:	jmp    252 <std::__cxx11::to_string(unsigned long)+0x252>
 1b7:	lea    0x10(%rdi),%rax
 1bb:	mov    $0x2,%esi
 1c0:	xor    %edx,%edx
 1c2:	mov    %rax,(%rdi)
 1c5:	call   1ca <std::__cxx11::to_string(unsigned long)+0x1ca>
 1ca:	vmovdqa 0x0(%rip),%ymm7        # 1d2 <std::__cxx11::to_string(unsigned long)+0x1d2>
 1d2:	mov    (%r12),%rsi
 1d6:	vmovdqa 0x0(%rip),%xmm0        # 1de <std::__cxx11::to_string(unsigned long)+0x1de>
 1de:	vmovdqu %ymm7,(%rsp)
 1e3:	vmovdqa 0x0(%rip),%ymm7        # 1eb <std::__cxx11::to_string(unsigned long)+0x1eb>
 1eb:	vmovdqu %ymm7,0x20(%rsp)
 1f1:	vmovdqa 0x0(%rip),%ymm7        # 1f9 <std::__cxx11::to_string(unsigned long)+0x1f9>
 1f9:	vmovdqu %ymm7,0x40(%rsp)
 1ff:	vmovdqa 0x0(%rip),%ymm7        # 207 <std::__cxx11::to_string(unsigned long)+0x207>
 207:	vmovdqu %ymm7,0x60(%rsp)
 20d:	vmovdqa 0x0(%rip),%ymm7        # 215 <std::__cxx11::to_string(unsigned long)+0x215>
 215:	vmovdqu %ymm7,0x80(%rsp)
 21e:	vmovdqa 0x0(%rip),%ymm7        # 226 <std::__cxx11::to_string(unsigned long)+0x226>
 226:	vmovdqu %ymm7,0xa0(%rsp)
 22f:	vmovdqu %xmm0,0xb9(%rsp)
 238:	nopl   0x0(%rax,%rax,1)
 240:	add    %rbx,%rbx
 243:	movzbl 0x1(%rsp,%rbx,1),%eax
 248:	movzbl (%rsp,%rbx,1),%ebx
 24c:	mov    %al,0x1(%rsi)
 24f:	vzeroupper
 252:	mov    %bl,(%rsi)
 254:	mov    0xd8(%rsp),%rax
 25c:	sub    %fs:0x28,%rax
 265:	jne    2d8 <std::__cxx11::to_string(unsigned long)+0x2d8>
 267:	add    $0xe0,%rsp
 26e:	mov    %r12,%rax
 271:	pop    %rbx
 272:	pop    %r12
 274:	pop    %rbp
 275:	ret
 276:	cs nopw 0x0(%rax,%rax,1)
 280:	lea    0x10(%r12),%rdx
 285:	lea    0x5(%rax),%esi
 288:	mov    %rdx,(%r12)
 28c:	jmp    bb <std::__cxx11::to_string(unsigned long)+0xbb>
 291:	nopl   0x0(%rax)
 298:	lea    0x6(%rax),%esi
 29b:	jmp    b2 <std::__cxx11::to_string(unsigned long)+0xb2>
 2a0:	lea    0x7(%rax),%esi
 2a3:	jmp    b2 <std::__cxx11::to_string(unsigned long)+0xb2>
 2a8:	lea    0x10(%rdi),%rax
 2ac:	mov    $0x1,%esi
 2b1:	xor    %edx,%edx
 2b3:	mov    %rax,(%rdi)
 2b6:	call   2bb <std::__cxx11::to_string(unsigned long)+0x2bb>
 2bb:	mov    (%r12),%rsi
 2bf:	jmp    1af <std::__cxx11::to_string(unsigned long)+0x1af>
 2c4:	mov    $0x3,%esi
 2c9:	jmp    b2 <std::__cxx11::to_string(unsigned long)+0xb2>
 2ce:	mov    $0x4,%esi
 2d3:	jmp    b2 <std::__cxx11::to_string(unsigned long)+0xb2>
 2d8:	call   2dd <ivf::TopK::TopK(unsigned long)+0x1d>

Disassembly of section .text._ZNSt6vectorIN3ivf8NeighborESaIS1_EED2Ev:

0000000000000000 <std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::~vector()>:
   0:	endbr64
   4:	mov    (%rdi),%rax
   7:	test   %rax,%rax
   a:	je     20 <std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::~vector()+0x20>
   c:	mov    0x10(%rdi),%rsi
  10:	mov    %rax,%rdi
  13:	sub    %rax,%rsi
  16:	jmp    1b <std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::~vector()+0x1b>
  1b:	nopl   0x0(%rax,%rax,1)
  20:	ret

Disassembly of section .text.unlikely:

0000000000000000 <ivf::TopK::TopK(unsigned long) [clone .cold]>:
   0:	lea    0x8(%rbx),%rdi
   4:	vzeroupper
   7:	call   c <ivf::TopK::TopK(unsigned long) [clone .cold]+0xc>
   c:	mov    %rbp,%rdi
   f:	call   14 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]>

0000000000000014 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]>:
  14:	mov    $0x10,%edi
  19:	call   1e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xa>
  1e:	lea    0x0(%rip),%rsi        # 25 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x11>
  25:	mov    %rax,%rdi
  28:	mov    %rax,%rbx
  2b:	call   30 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1c>
  30:	mov    0x128(%rsp),%rax
  38:	sub    %fs:0x28,%rax
  41:	jne    1b1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x19d>
  47:	mov    0x0(%rip),%rdx        # 4e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3a>
  4e:	lea    0x0(%rip),%rsi        # 55 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x41>
  55:	mov    %rbx,%rdi
  58:	call   5d <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x49>
  5d:	mov    $0x10,%edi
  62:	call   67 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x53>
  67:	mov    0x8(%rbx),%esi
  6a:	lea    0xe0(%rsp),%rdi
  72:	lea    0x20(%rsp),%rbx
  77:	mov    %rax,(%rsp)
  7b:	mov    %rdi,0x10(%rsp)
  80:	call   85 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x71>
  85:	mov    0x8(%rbp),%esi
  88:	lea    0x80(%rsp),%rdi
  90:	mov    %rdi,0x8(%rsp)
  95:	call   9a <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x86>
  9a:	mov    %r12,%rsi
  9d:	mov    %rbx,%rdi
  a0:	call   a5 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x91>
  a5:	lea    0x0(%rip),%rdx        # ac <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x98>
  ac:	xor    %esi,%esi
  ae:	mov    %rbx,%rdi
  b1:	call   b6 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xa2>
  b6:	lea    0x40(%rsp),%rbp
  bb:	mov    %rax,%rsi
  be:	mov    %rbp,%rdi
  c1:	call   c6 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xb2>
  c6:	lea    0x0(%rip),%rsi        # cd <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xb9>
  cd:	mov    %rbp,%rdi
  d0:	call   d5 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xc1>
  d5:	lea    0x60(%rsp),%r12
  da:	mov    %rax,%rsi
  dd:	lea    0xa0(%rsp),%r13
  e5:	mov    %r12,%rdi
  e8:	call   ed <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xd9>
  ed:	mov    0x8(%rsp),%rdx
  f2:	mov    %r12,%rsi
  f5:	mov    %r13,%rdi
  f8:	call   fd <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xe9>
  fd:	lea    0x0(%rip),%rsi        # 104 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xf0>
 104:	mov    %r13,%rdi
 107:	call   10c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xf8>
 10c:	lea    0xc0(%rsp),%r14
 114:	mov    %rax,%rsi
 117:	lea    0x100(%rsp),%r15
 11f:	mov    %r14,%rdi
 122:	call   127 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x113>
 127:	mov    0x10(%rsp),%rdx
 12c:	mov    %r14,%rsi
 12f:	mov    %r15,%rdi
 132:	call   137 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x123>
 137:	mov    (%rsp),%rdi
 13b:	mov    %r15,%rsi
 13e:	call   143 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x12f>
 143:	mov    %r15,%rdi
 146:	call   14b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x137>
 14b:	mov    %r14,%rdi
 14e:	call   153 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x13f>
 153:	mov    %r13,%rdi
 156:	call   15b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x147>
 15b:	mov    %r12,%rdi
 15e:	call   163 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x14f>
 163:	mov    %rbp,%rdi
 166:	call   16b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x157>
 16b:	mov    %rbx,%rdi
 16e:	call   173 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x15f>
 173:	mov    0x8(%rsp),%rdi
 178:	call   17d <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x169>
 17d:	mov    0x10(%rsp),%rdi
 182:	call   187 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x173>
 187:	mov    0x128(%rsp),%rax
 18f:	sub    %fs:0x28,%rax
 198:	jne    1b6 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a2>
 19a:	mov    0x0(%rip),%rdx        # 1a1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x18d>
 1a1:	mov    (%rsp),%rdi
 1a5:	lea    0x0(%rip),%rsi        # 1ac <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x198>
 1ac:	call   1b1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x19d>
 1b1:	call   1b6 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a2>
 1b6:	call   1bb <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a7>
 1bb:	endbr64
 1bf:	mov    %rax,0x18(%rsp)
 1c4:	mov    %r15,%rdi
 1c7:	vzeroupper
 1ca:	call   1cf <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1bb>
 1cf:	mov    0x18(%rsp),%r15
 1d4:	jmp    1e0 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1cc>
 1d6:	endbr64
 1da:	mov    %rax,%r15
 1dd:	vzeroupper
 1e0:	mov    %r14,%rdi
 1e3:	call   1e8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d4>
 1e8:	mov    %r13,%rdi
 1eb:	mov    %r15,%r13
 1ee:	call   1f3 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1df>
 1f3:	jmp    249 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x235>
 1f5:	endbr64
 1f9:	mov    %rax,%rbp
 1fc:	vzeroupper
 1ff:	mov    %rbx,%rdi
 202:	call   207 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1f3>
 207:	mov    0x8(%rsp),%rdi
 20c:	call   211 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1fd>
 211:	mov    0x10(%rsp),%rdi
 216:	call   21b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x207>
 21b:	mov    (%rsp),%rdi
 21f:	call   224 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x210>
 224:	mov    0x128(%rsp),%rax
 22c:	sub    %fs:0x28,%rax
 235:	jne    2b2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x29e>
 237:	mov    %rbp,%rdi
 23a:	call   23f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x22b>
 23f:	endbr64
 243:	mov    %rax,%r13
 246:	vzeroupper
 249:	mov    %r12,%rdi
 24c:	call   251 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x23d>
 251:	mov    %rbp,%rdi
 254:	mov    %r13,%rbp
 257:	call   25c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x248>
 25c:	jmp    1ff <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1eb>
 25e:	endbr64
 262:	mov    %rax,%rbp
 265:	vzeroupper
 268:	jmp    207 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1f3>
 26a:	endbr64
 26e:	mov    %rbx,%rdi
 271:	mov    %rax,%rbp
 274:	vzeroupper
 277:	call   27c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x268>
 27c:	mov    0x128(%rsp),%rax
 284:	sub    %fs:0x28,%rax
 28d:	jne    2b7 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2a3>
 28f:	mov    %rbp,%rdi
 292:	call   297 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x283>
 297:	endbr64
 29b:	mov    %rax,%r15
 29e:	vzeroupper
 2a1:	jmp    1e8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d4>
 2a6:	endbr64
 2aa:	mov    %rax,%r13
 2ad:	vzeroupper
 2b0:	jmp    251 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x23d>
 2b2:	call   2b7 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2a3>
 2b7:	call   2bc <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]>

00000000000002bc <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]>:
 2bc:	lea    0x40(%rsp),%rdi
 2c1:	vzeroupper
 2c4:	call   2c9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0xd>
 2c9:	mov    0x58(%rsp),%rax
 2ce:	sub    %fs:0x28,%rax
 2d7:	jne    2e1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x25>
 2d9:	mov    %rbx,%rdi
 2dc:	call   2e1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x25>
 2e1:	call   2e6 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>

00000000000002e6 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>:
 2e6:	lea    0x28(%rsp),%rdi
 2eb:	vzeroupper
 2ee:	call   2f3 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0xd>
 2f3:	mov    0x48(%rsp),%rax
 2f8:	sub    %fs:0x28,%rax
 301:	jne    30b <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x25>
 303:	mov    %rbx,%rdi
 306:	call   30b <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x25>
 30b:	call   310 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>

0000000000000310 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>:
 310:	lea    0x78(%rsp),%rdi
 315:	vzeroupper
 318:	call   31d <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0xd>
 31d:	mov    0x50(%rsp),%rdi
 322:	mov    0x60(%rsp),%rsi
 327:	sub    %rdi,%rsi
 32a:	test   %rdi,%rdi
 32d:	je     334 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x24>
 32f:	call   334 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x24>
 334:	mov    0x98(%rsp),%rax
 33c:	sub    %fs:0x28,%rax
 345:	jne    34f <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x3f>
 347:	mov    %rbx,%rdi
 34a:	call   34f <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x3f>
 34f:	call   354 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x44>

Disassembly of section .text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S9_:

0000000000000000 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)>:
   0:	endbr64
   4:	push   %rbx
   5:	mov    %rsi,%r10
   8:	mov    (%rsi),%rcx
   b:	mov    %rdi,%rbx
   e:	mov    0x8(%rsi),%r8
  12:	mov    %rdx,%rdi
  15:	lea    0x10(%r10),%r9
  19:	mov    0x8(%rdx),%rdx
  1d:	cmp    %r9,%rcx
  20:	mov    (%rdi),%rsi
  23:	lea    (%rdx,%r8,1),%rax
  27:	je     130 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x130>
  2d:	cmp    %rax,0x10(%r10)
  31:	jae    49 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x49>
  33:	lea    0x10(%rdi),%r9
  37:	cmp    %r9,%rsi
  3a:	je     120 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x120>
  40:	mov    0x10(%rdi),%r9
  44:	cmp    %rax,%r9
  47:	jae    a8 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0xa8>
  49:	movabs $0x3fffffffffffffff,%rax
  53:	sub    %r8,%rax
  56:	cmp    %rdx,%rax
  59:	jb     1fd <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x1fd>
  5f:	mov    %r10,%rdi
  62:	call   67 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x67>
  67:	lea    0x10(%rbx),%rcx
  6b:	mov    %rcx,(%rbx)
  6e:	mov    (%rax),%rdx
  71:	lea    0x10(%rax),%rsi
  75:	cmp    %rsi,%rdx
  78:	je     150 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x150>
  7e:	mov    %rdx,(%rbx)
  81:	mov    0x10(%rax),%rdx
  85:	mov    %rdx,0x10(%rbx)
  89:	mov    0x8(%rax),%rdx
  8d:	mov    %rdx,0x8(%rbx)
  91:	mov    %rsi,(%rax)
  94:	movq   $0x0,0x8(%rax)
  9c:	movb   $0x0,0x10(%rax)
  a0:	mov    %rbx,%rax
  a3:	pop    %rbx
  a4:	ret
  a5:	nopl   (%rax)
  a8:	xor    %edx,%edx
  aa:	xor    %esi,%esi
  ac:	call   b1 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0xb1>
  b1:	lea    0x10(%rbx),%rcx
  b5:	mov    %rcx,(%rbx)
  b8:	mov    (%rax),%rdx
  bb:	lea    0x10(%rax),%rsi
  bf:	cmp    %rsi,%rdx
  c2:	jne    7e <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x7e>
  c4:	mov    0x8(%rax),%rdx
  c8:	lea    0x1(%rdx),%rdi
  cc:	cmp    $0x8,%edi
  cf:	jb     1b0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x1b0>
  d5:	mov    0x10(%rax),%rdx
  d9:	mov    %rsi,%r10
  dc:	mov    %rdx,0x10(%rbx)
  e0:	mov    %edi,%edx
  e2:	mov    -0x8(%rsi,%rdx,1),%r8
  e7:	mov    %r8,-0x8(%rcx,%rdx,1)
  ec:	lea    0x18(%rbx),%r8
  f0:	and    $0xfffffffffffffff8,%r8
  f4:	sub    %r8,%rcx
  f7:	add    %ecx,%edi
  f9:	sub    %rcx,%r10
  fc:	and    $0xfffffff8,%edi
  ff:	cmp    $0x8,%edi
 102:	jb     89 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x89>
 104:	and    $0xfffffff8,%edi
 107:	xor    %edx,%edx
 109:	mov    %edx,%ecx
 10b:	add    $0x8,%edx
 10e:	mov    (%r10,%rcx,1),%r9
 112:	cmp    %edi,%edx
 114:	mov    %r9,(%r8,%rcx,1)
 118:	jb     109 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x109>
 11a:	jmp    89 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x89>
 11f:	nop
 120:	mov    $0xf,%r9d
 126:	jmp    44 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x44>
 12b:	nopl   0x0(%rax,%rax,1)
 130:	cmp    $0xf,%rax
 134:	jbe    49 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x49>
 13a:	lea    0x10(%rdi),%r9
 13e:	cmp    %r9,%rsi
 141:	jne    40 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x40>
 147:	jmp    49 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x49>
 14c:	nopl   0x0(%rax)
 150:	mov    0x8(%rax),%rdx
 154:	lea    0x1(%rdx),%rdi
 158:	cmp    $0x8,%edi
 15b:	jb     1b0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x1b0>
 15d:	mov    0x10(%rax),%rdx
 161:	mov    %rsi,%r10
 164:	mov    %rdx,0x10(%rbx)
 168:	mov    %edi,%edx
 16a:	mov    -0x8(%rsi,%rdx,1),%r8
 16f:	mov    %r8,-0x8(%rcx,%rdx,1)
 174:	lea    0x18(%rbx),%r8
 178:	and    $0xfffffffffffffff8,%r8
 17c:	sub    %r8,%rcx
 17f:	add    %ecx,%edi
 181:	sub    %rcx,%r10
 184:	and    $0xfffffff8,%edi
 187:	cmp    $0x8,%edi
 18a:	jb     89 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x89>
 190:	and    $0xfffffff8,%edi
 193:	xor    %edx,%edx
 195:	mov    %edx,%ecx
 197:	add    $0x8,%edx
 19a:	mov    (%r10,%rcx,1),%r9
 19e:	cmp    %edi,%edx
 1a0:	mov    %r9,(%r8,%rcx,1)
 1a4:	jb     195 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x195>
 1a6:	jmp    89 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x89>
 1ab:	nopl   0x0(%rax,%rax,1)
 1b0:	test   $0x4,%dil
 1b4:	jne    1e4 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x1e4>
 1b6:	test   %edi,%edi
 1b8:	je     8d <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x8d>
 1be:	movzbl 0x10(%rax),%edx
 1c2:	test   $0x2,%dil
 1c6:	mov    %dl,0x10(%rbx)
 1c9:	je     89 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x89>
 1cf:	mov    %edi,%edi
 1d1:	movzwl -0x2(%rsi,%rdi,1),%edx
 1d6:	mov    %dx,-0x2(%rcx,%rdi,1)
 1db:	mov    0x8(%rax),%rdx
 1df:	jmp    8d <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x8d>
 1e4:	mov    0x10(%rax),%edx
 1e7:	mov    %edi,%edi
 1e9:	mov    %edx,0x10(%rbx)
 1ec:	mov    -0x4(%rsi,%rdi,1),%edx
 1f0:	mov    %edx,-0x4(%rcx,%rdi,1)
 1f4:	mov    0x8(%rax),%rdx
 1f8:	jmp    8d <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x8d>
 1fd:	lea    0x0(%rip),%rdi        # 204 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x204>
 204:	call   209 <.LC23+0x129>

Disassembly of section .text._ZNSt6vectorIN3ivf8NeighborESaIS1_EE17_M_realloc_insertIJRKS1_EEEvN9__gnu_cxx17__normal_iteratorIPS1_S3_EEDpOT_:

0000000000000000 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)>:
   0:	endbr64
   4:	push   %r15
   6:	mov    %rdx,%rcx
   9:	movabs $0x7ffffffffffffff,%rdx
  13:	push   %r14
  15:	push   %r13
  17:	push   %r12
  19:	push   %rbp
  1a:	push   %rbx
  1b:	sub    $0x28,%rsp
  1f:	mov    0x8(%rdi),%r14
  23:	mov    (%rdi),%rbp
  26:	mov    %r14,%rax
  29:	sub    %rbp,%rax
  2c:	sar    $0x4,%rax
  30:	cmp    %rdx,%rax
  33:	je     192 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x192>
  39:	mov    %rsi,%rdx
  3c:	mov    %rdi,%r13
  3f:	mov    %rsi,%r12
  42:	sub    %rbp,%rdx
  45:	cmp    %r14,%rbp
  48:	je     158 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x158>
  4e:	lea    (%rax,%rax,1),%rsi
  52:	cmp    %rax,%rsi
  55:	jb     110 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x110>
  5b:	test   %rsi,%rsi
  5e:	jne    178 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x178>
  64:	vmovdqu (%rcx),%xmm4
  68:	xor    %ebx,%ebx
  6a:	xor    %r15d,%r15d
  6d:	cmp    %rbp,%r12
  70:	mov    $0x10,%ecx
  75:	vmovdqu %xmm4,(%rdx)
  79:	je     af <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xaf>
  7b:	mov    %r12,%rcx
  7e:	mov    %r15,%rax
  81:	mov    %rbp,%rdx
  84:	sub    %rbp,%rcx
  87:	add    %r15,%rcx
  8a:	nopw   0x0(%rax,%rax,1)
  90:	vmovdqu (%rdx),%xmm1
  94:	add    $0x10,%rax
  98:	add    $0x10,%rdx
  9c:	vmovdqu %xmm1,-0x10(%rax)
  a1:	cmp    %rax,%rcx
  a4:	jne    90 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x90>
  a6:	add    $0x10,%rcx
  aa:	cmp    %r14,%r12
  ad:	je     c6 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xc6>
  af:	sub    %r12,%r14
  b2:	mov    %rcx,%rdi
  b5:	mov    %r12,%rsi
  b8:	mov    %r14,%rdx
  bb:	call   c0 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xc0>
  c0:	mov    %rax,%rcx
  c3:	add    %r14,%rcx
  c6:	vmovq  %r15,%xmm2
  cb:	test   %rbp,%rbp
  ce:	vpinsrq $0x1,%rcx,%xmm2,%xmm0
  d4:	je     ef <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xef>
  d6:	mov    0x10(%r13),%rsi
  da:	mov    %rbp,%rdi
  dd:	vmovdqa %xmm0,(%rsp)
  e2:	sub    %rbp,%rsi
  e5:	call   ea <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xea>
  ea:	vmovdqa (%rsp),%xmm0
  ef:	mov    %rbx,0x10(%r13)
  f3:	vmovdqu %xmm0,0x0(%r13)
  f9:	add    $0x28,%rsp
  fd:	pop    %rbx
  fe:	pop    %rbp
  ff:	pop    %r12
 101:	pop    %r13
 103:	pop    %r14
 105:	pop    %r15
 107:	ret
 108:	nopl   0x0(%rax,%rax,1)
 110:	movabs $0x7ffffffffffffff0,%rbx
 11a:	mov    %rbx,%rdi
 11d:	mov    %rcx,0x18(%rsp)
 122:	mov    %rdx,(%rsp)
 126:	call   12b <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x12b>
 12b:	mov    0x18(%rsp),%rcx
 130:	mov    (%rsp),%rdx
 134:	add    %rax,%rbx
 137:	cmp    %rbp,%r12
 13a:	mov    %rax,%r15
 13d:	vmovdqu (%rcx),%xmm3
 141:	lea    0x10(%rax),%rcx
 145:	vmovdqu %xmm3,(%rax,%rdx,1)
 14a:	jne    7b <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x7b>
 150:	jmp    aa <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xaa>
 155:	nopl   (%rax)
 158:	add    $0x1,%rax
 15c:	jb     110 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x110>
 15e:	movabs $0x7ffffffffffffff,%rsi
 168:	cmp    %rsi,%rax
 16b:	mov    %rsi,%rbx
 16e:	cmovbe %rax,%rbx
 172:	shl    $0x4,%rbx
 176:	jmp    11a <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x11a>
 178:	movabs $0x7ffffffffffffff,%rax
 182:	cmp    %rax,%rsi
 185:	cmova  %rax,%rsi
 189:	mov    %rsi,%rbx
 18c:	shl    $0x4,%rbx
 190:	jmp    11a <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x11a>
 192:	lea    0x0(%rip),%rdi        # 199 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x199>
 199:	call   19e <.LC23+0xbe>

Disassembly of section .text._ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPN3ivf8NeighborESt6vectorIS3_SaIS3_EEEElS3_NS0_5__ops15_Iter_comp_iterIPFbRKS3_SC_EEEEvT_T0_SH_T1_T2_:

0000000000000000 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)>:
   0:	endbr64
   4:	push   %r15
   6:	push   %r14
   8:	push   %r13
   a:	push   %r12
   c:	push   %rbp
   d:	mov    %rdi,%rbp
  10:	mov    %rdx,%rdi
  13:	push   %rbx
  14:	and    $0x1,%edi
  17:	mov    %r8,%rbx
  1a:	sub    $0x68,%rsp
  1e:	mov    %rsi,0x10(%rsp)
  23:	mov    %rdx,0x38(%rsp)
  28:	mov    %rcx,0x28(%rsp)
  2d:	vmovsd %xmm0,0x30(%rsp)
  33:	mov    %fs:0x28,%rax
  3c:	mov    %rax,0x58(%rsp)
  41:	xor    %eax,%eax
  43:	lea    -0x1(%rdx),%rax
  47:	mov    %rdi,0x20(%rsp)
  4c:	mov    %rax,%r12
  4f:	shr    $0x3f,%r12
  53:	add    %rax,%r12
  56:	mov    %r12,%rax
  59:	sar    $1,%rax
  5c:	cmp    %rax,%rsi
  5f:	mov    %rax,0x18(%rsp)
  64:	jge    1c0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1c0>
  6a:	mov    %rsi,%r8
  6d:	jmp    97 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x97>
  6f:	nop
  70:	mov    0x0(%r13),%rax
  74:	shl    $0x4,%r8
  78:	add    %rbp,%r8
  7b:	cmp    %r14,0x18(%rsp)
  80:	mov    %rax,(%r8)
  83:	mov    0x8(%r13),%eax
  87:	mov    %eax,0x8(%r8)
  8b:	jle    230 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x230>
  91:	mov    %r14,%r12
  94:	mov    %r12,%r8
  97:	lea    0x1(%r8),%rcx
  9b:	mov    %r8,0x8(%rsp)
  a0:	lea    (%rcx,%rcx,1),%r14
  a4:	shl    $0x5,%rcx
  a8:	lea    -0x1(%r14),%r12
  ac:	lea    0x0(%rbp,%rcx,1),%r13
  b1:	mov    %r12,%rdx
  b4:	mov    %r13,%rdi
  b7:	shl    $0x4,%rdx
  bb:	lea    0x0(%rbp,%rdx,1),%r15
  c0:	mov    %r15,%rsi
  c3:	call   *%rbx
  c5:	mov    0x8(%rsp),%r8
  ca:	test   %al,%al
  cc:	je     70 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x70>
  ce:	mov    (%r15),%rax
  d1:	shl    $0x4,%r8
  d5:	add    %rbp,%r8
  d8:	mov    %rax,(%r8)
  db:	mov    0x8(%r15),%eax
  df:	mov    %eax,0x8(%r8)
  e3:	mov    0x18(%rsp),%rax
  e8:	cmp    %rax,%r12
  eb:	jl     94 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x94>
  ed:	cmpq   $0x0,0x20(%rsp)
  f3:	je     1e0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1e0>
  f9:	mov    0x30(%rsp),%rax
  fe:	mov    %rax,0x40(%rsp)
 103:	mov    0x28(%rsp),%rax
 108:	mov    %rax,0x48(%rsp)
 10d:	lea    -0x1(%r12),%rax
 112:	mov    %rax,%r14
 115:	shr    $0x3f,%r14
 119:	add    %rax,%r14
 11c:	mov    0x10(%rsp),%rax
 121:	sar    $1,%r14
 124:	cmp    %rax,%r12
 127:	jle    18d <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x18d>
 129:	lea    0x40(%rsp),%rax
 12e:	mov    %rax,0x8(%rsp)
 133:	jmp    169 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x169>
 135:	nopl   (%rax)
 138:	mov    0x0(%r13),%rax
 13c:	lea    -0x1(%r14),%rdx
 140:	mov    %r14,%r12
 143:	mov    %rax,(%r15)
 146:	mov    0x8(%r13),%eax
 14a:	mov    %eax,0x8(%r15)
 14e:	mov    %rdx,%rax
 151:	shr    $0x3f,%rax
 155:	add    %rdx,%rax
 158:	sar    $1,%rax
 15b:	cmp    %r14,0x10(%rsp)
 160:	jge    228 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x228>
 166:	mov    %rax,%r14
 169:	mov    %r14,%r13
 16c:	mov    0x8(%rsp),%rsi
 171:	shl    $0x4,%r13
 175:	add    %rbp,%r13
 178:	mov    %r13,%rdi
 17b:	call   *%rbx
 17d:	mov    %r12,%rdx
 180:	shl    $0x4,%rdx
 184:	test   %al,%al
 186:	lea    0x0(%rbp,%rdx,1),%r15
 18b:	jne    138 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x138>
 18d:	mov    0x40(%rsp),%rax
 192:	mov    %rax,(%r15)
 195:	mov    0x48(%rsp),%eax
 199:	mov    %eax,0x8(%r15)
 19d:	mov    0x58(%rsp),%rax
 1a2:	sub    %fs:0x28,%rax
 1ab:	jne    25d <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x25d>
 1b1:	add    $0x68,%rsp
 1b5:	pop    %rbx
 1b6:	pop    %rbp
 1b7:	pop    %r12
 1b9:	pop    %r13
 1bb:	pop    %r14
 1bd:	pop    %r15
 1bf:	ret
 1c0:	mov    %rsi,%rdx
 1c3:	shl    $0x4,%rdx
 1c7:	cmpq   $0x0,0x20(%rsp)
 1cd:	lea    0x0(%rbp,%rdx,1),%r15
 1d2:	jne    244 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x244>
 1d4:	mov    %rsi,%r12
 1d7:	nopw   0x0(%rax,%rax,1)
 1e0:	mov    0x38(%rsp),%r13
 1e5:	sub    $0x2,%r13
 1e9:	mov    %r13,%rax
 1ec:	shr    $0x3f,%rax
 1f0:	add    %r13,%rax
 1f3:	sar    $1,%rax
 1f6:	cmp    %r12,%rax
 1f9:	jne    f9 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xf9>
 1ff:	lea    0x1(%r12,%r12,1),%r12
 204:	mov    %r12,%rax
 207:	shl    $0x4,%rax
 20b:	add    %rbp,%rax
 20e:	mov    (%rax),%rcx
 211:	mov    %rcx,(%r15)
 214:	mov    0x8(%rax),%ecx
 217:	mov    %ecx,0x8(%r15)
 21b:	mov    %rax,%r15
 21e:	jmp    f9 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xf9>
 223:	nopl   0x0(%rax,%rax,1)
 228:	mov    %r13,%r15
 22b:	jmp    18d <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x18d>
 230:	cmpq   $0x0,0x20(%rsp)
 236:	mov    %r13,%r15
 239:	mov    %r14,%r12
 23c:	jne    f9 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xf9>
 242:	jmp    1e0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1e0>
 244:	mov    0x30(%rsp),%rax
 249:	mov    %rax,0x40(%rsp)
 24e:	mov    0x28(%rsp),%rax
 253:	mov    %rax,0x48(%rsp)
 258:	jmp    18d <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x18d>
 25d:	call   262 <.LC23+0x182>
