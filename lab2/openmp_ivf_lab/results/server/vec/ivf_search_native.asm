
results/server/vec/ivf_search_native.o:     file format elf64-x86-64


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
      33:	nop
      34:	data16 cs nopw 0x0(%rax,%rax,1)
      3f:	nop

0000000000000040 <ivf::TopK::TopK(unsigned long)>:
      40:	endbr64 
      44:	push   %r12
      46:	mov    %rsi,%rax
      49:	push   %rbp
      4a:	push   %rbx
      4b:	mov    %rdi,%rbx
      4e:	sub    $0x10,%rsp
      52:	shr    $0x3b,%rax
      56:	mov    %rsi,(%rdi)
      59:	movq   $0x0,0x8(%rdi)
      61:	movq   $0x0,0x10(%rdi)
      69:	movq   $0x0,0x18(%rdi)
      71:	jne    ed <ivf::TopK::TopK(unsigned long)+0xad>
      73:	test   %rsi,%rsi
      76:	je     e4 <ivf::TopK::TopK(unsigned long)+0xa4>
      78:	shl    $0x4,%rsi
      7c:	mov    %rsi,%rdi
      7f:	mov    %rsi,%rbp
      82:	call   87 <ivf::TopK::TopK(unsigned long)+0x47>
      87:	mov    0x10(%rbx),%rsi
      8b:	mov    0x8(%rbx),%rdi
      8f:	mov    %rax,%r12
      92:	vpbroadcastq %rax,%xmm0
      98:	cmp    %rdi,%rsi
      9b:	je     bd <ivf::TopK::TopK(unsigned long)+0x7d>
      9d:	mov    %rax,%rcx
      a0:	mov    %rdi,%rdx
      a3:	nopl   0x0(%rax,%rax,1)
      a8:	vmovdqu (%rdx),%xmm1
      ac:	add    $0x10,%rdx
      b0:	vmovdqu %xmm1,(%rcx)
      b4:	add    $0x10,%rcx
      b8:	cmp    %rdx,%rsi
      bb:	jne    a8 <ivf::TopK::TopK(unsigned long)+0x68>
      bd:	test   %rdi,%rdi
      c0:	je     d8 <ivf::TopK::TopK(unsigned long)+0x98>
      c2:	mov    0x18(%rbx),%rsi
      c6:	vmovdqa %xmm0,(%rsp)
      cb:	sub    %rdi,%rsi
      ce:	call   d3 <ivf::TopK::TopK(unsigned long)+0x93>
      d3:	vmovdqa (%rsp),%xmm0
      d8:	add    %rbp,%r12
      db:	mov    %r12,0x18(%rbx)
      df:	vmovdqu %xmm0,0x8(%rbx)
      e4:	add    $0x10,%rsp
      e8:	pop    %rbx
      e9:	pop    %rbp
      ea:	pop    %r12
      ec:	ret    
      ed:	lea    0x0(%rip),%rdi        # f4 <ivf::TopK::TopK(unsigned long)+0xb4>
      f4:	call   f9 <ivf::TopK::TopK(unsigned long)+0xb9>
      f9:	endbr64 
      fd:	mov    %rax,%rbp
     100:	jmp    105 <ivf::TopK::TopK(unsigned long)+0xc5>
     105:	data16 cs nopw 0x0(%rax,%rax,1)

0000000000000110 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)>:
     110:	endbr64 
     114:	test   %rdx,%rdx
     117:	je     150 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)+0x40>
     119:	vxorps %xmm3,%xmm3,%xmm3
     11d:	xor    %eax,%eax
     11f:	vxorpd %xmm2,%xmm2,%xmm2
     123:	nopl   0x0(%rax,%rax,1)
     128:	vcvtss2sd (%rdi,%rax,4),%xmm3,%xmm0
     12d:	vcvtss2sd (%rsi,%rax,4),%xmm3,%xmm1
     132:	vsubsd %xmm1,%xmm0,%xmm0
     136:	inc    %rax
     139:	vfmadd231sd %xmm0,%xmm0,%xmm2
     13e:	cmp    %rax,%rdx
     141:	jne    128 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)+0x18>
     143:	vmovsd %xmm2,%xmm2,%xmm0
     147:	ret    
     148:	nopl   0x0(%rax,%rax,1)
     150:	vxorpd %xmm2,%xmm2,%xmm2
     154:	vmovsd %xmm2,%xmm2,%xmm0
     158:	ret    
     159:	nopl   0x0(%rax)

0000000000000160 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)>:
     160:	endbr64 
     164:	push   %r15
     166:	vxorps %xmm1,%xmm1,%xmm1
     16a:	push   %r14
     16c:	mov    %rcx,%r14
     16f:	push   %r13
     171:	push   %r12
     173:	push   %rbp
     174:	push   %rbx
     175:	mov    %rdx,-0x20(%rsp)
     17a:	test   %rdx,%rdx
     17d:	je     31c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1bc>
     183:	lea    0x0(,%rcx,4),%rax
     18b:	mov    %rax,%rbx
     18e:	mov    0x10(%rsi),%rcx
     192:	sar    $0x2,%rbx
     196:	lea    (%rcx,%rax,1),%r9
     19a:	mov    %rbx,-0x8(%rsp)
     19f:	mov    %rax,%rbx
     1a2:	and    $0xfffffffffffffff0,%rax
     1a6:	mov    %rax,-0x18(%rsp)
     1ab:	add    %rax,%rcx
     1ae:	mov    %r14,%rax
     1b1:	shl    $0x4,%rax
     1b5:	mov    0x8(%rsi),%r15
     1b9:	mov    %rax,-0x10(%rsp)
     1be:	mov    %rdi,%r12
     1c1:	sar    $0x4,%rbx
     1c5:	shl    $0x2,%r15
     1c9:	xor    %r13d,%r13d
     1cc:	xor    %ebp,%ebp
     1ce:	xor    %r8d,%r8d
     1d1:	nopl   0x0(%rax)
     1d8:	mov    %rcx,%r11
     1db:	sub    -0x18(%rsp),%r11
     1e0:	test   %r14,%r14
     1e3:	je     259 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf9>
     1e5:	mov    (%r12),%rdi
     1e9:	mov    %r13,%rax
     1ec:	shl    $0x4,%rax
     1f0:	lea    (%rdi,%rax,1),%rsi
     1f4:	add    -0x10(%rsp),%rdi
     1f9:	add    %rax,%rdi
     1fc:	nopl   0x0(%rax)
     200:	mov    0x8(%rsi),%edx
     203:	cmp    $0xffffffff,%edx
     206:	je     250 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf0>
     208:	test   %rbx,%rbx
     20b:	jle    312 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1b2>
     211:	mov    %r11,%rax
     214:	jmp    240 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe0>
     216:	cs nopw 0x0(%rax,%rax,1)
     220:	cmp    0x4(%rax),%edx
     223:	je     298 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x138>
     225:	cmp    0x8(%rax),%edx
     228:	je     2a0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x140>
     22a:	cmp    0xc(%rax),%edx
     22d:	je     2b0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x150>
     233:	add    $0x10,%rax
     237:	cmp    %rcx,%rax
     23a:	je     2c0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x160>
     240:	cmp    (%rax),%edx
     242:	jne    220 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xc0>
     244:	cmp    %r9,%rax
     247:	setne  %al
     24a:	movzbl %al,%eax
     24d:	add    %rax,%r8
     250:	add    $0x10,%rsi
     254:	cmp    %rdi,%rsi
     257:	jne    200 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xa0>
     259:	inc    %rbp
     25c:	add    %r15,%r9
     25f:	add    %r14,%r13
     262:	add    %r15,%rcx
     265:	cmp    %rbp,-0x20(%rsp)
     26a:	jne    1d8 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x78>
     270:	vcvtusi2sd %r8,%xmm1,%xmm0
     276:	mov    -0x20(%rsp),%rax
     27b:	pop    %rbx
     27c:	imul   %r14,%rax
     280:	pop    %rbp
     281:	pop    %r12
     283:	vcvtusi2sd %rax,%xmm1,%xmm1
     289:	pop    %r13
     28b:	pop    %r14
     28d:	pop    %r15
     28f:	vdivsd %xmm1,%xmm0,%xmm0
     293:	ret    
     294:	nopl   0x0(%rax)
     298:	add    $0x4,%rax
     29c:	jmp    244 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe4>
     29e:	xchg   %ax,%ax
     2a0:	add    $0x8,%rax
     2a4:	jmp    244 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe4>
     2a6:	cs nopw 0x0(%rax,%rax,1)
     2b0:	add    $0xc,%rax
     2b4:	jmp    244 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe4>
     2b6:	cs nopw 0x0(%rax,%rax,1)
     2c0:	mov    %r9,%r10
     2c3:	sub    %rax,%r10
     2c6:	sar    $0x2,%r10
     2ca:	cmp    $0x2,%r10
     2ce:	je     2f9 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x199>
     2d0:	cmp    $0x3,%r10
     2d4:	je     2ed <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x18d>
     2d6:	cmp    $0x1,%r10
     2da:	jne    250 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf0>
     2e0:	cmp    (%rax),%edx
     2e2:	jne    250 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf0>
     2e8:	jmp    244 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe4>
     2ed:	cmp    (%rax),%edx
     2ef:	je     244 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe4>
     2f5:	add    $0x4,%rax
     2f9:	cmp    (%rax),%edx
     2fb:	je     244 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe4>
     301:	add    $0x4,%rax
     305:	cmp    (%rax),%edx
     307:	jne    250 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf0>
     30d:	jmp    244 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe4>
     312:	mov    -0x8(%rsp),%r10
     317:	mov    %r11,%rax
     31a:	jmp    2ca <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x16a>
     31c:	vxorpd %xmm0,%xmm0,%xmm0
     320:	jmp    276 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x116>
     325:	data16 cs nopw 0x0(%rax,%rax,1)

0000000000000330 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)>:
     330:	endbr64 
     334:	push   %r15
     336:	push   %r14
     338:	push   %r13
     33a:	push   %r12
     33c:	push   %rbp
     33d:	push   %rbx
     33e:	sub    $0x118,%rsp
     345:	mov    %fs:0x28,%rax
     34e:	mov    %rax,0x108(%rsp)
     356:	xor    %eax,%eax
     358:	mov    (%rdi),%rbx
     35b:	mov    0x8(%rdi),%rax
     35f:	mov    (%rsi),%rbp
     362:	mov    0x8(%rsi),%rcx
     366:	sub    %rbx,%rax
     369:	mov    %rax,%rdx
     36c:	sub    %rbp,%rcx
     36f:	sar    $0x4,%rdx
     373:	cmp    %rcx,%rax
     376:	jne    37c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x4c>
     37c:	xor    %r12d,%r12d
     37f:	test   %rdx,%rdx
     382:	je     430 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x100>
     388:	vmovq  0x0(%rip),%xmm1        # 390 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x60>
     390:	vmovsd 0x0(%rip),%xmm4        # 398 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x68>
     398:	vmovsd 0x0(%rip),%xmm5        # 3a0 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x70>
     3a0:	vmovsd 0x0(%rip),%xmm6        # 3a8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x78>
     3a8:	xor    %ecx,%ecx
     3aa:	jmp    3f7 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xc7>
     3ac:	nopl   0x0(%rax)
     3b0:	vandpd %xmm1,%xmm0,%xmm2
     3b4:	vucomisd %xmm2,%xmm4
     3b8:	jb     3be <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x8e>
     3be:	vmovsd 0x0(%rbp),%xmm3
     3c3:	vandpd %xmm1,%xmm3,%xmm2
     3c7:	vfmadd132sd %xmm5,%xmm5,%xmm2
     3cc:	vsubsd %xmm3,%xmm0,%xmm0
     3d0:	vandpd %xmm1,%xmm0,%xmm0
     3d4:	vcomisd %xmm0,%xmm2
     3d8:	jb     3de <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xae>
     3de:	cmp    0x8(%rbx),%eax
     3e1:	jne    3e7 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xb7>
     3e7:	inc    %r12
     3ea:	add    $0x10,%rbp
     3ee:	add    $0x10,%rbx
     3f2:	cmp    %rdx,%r12
     3f5:	je     430 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x100>
     3f7:	mov    0x8(%rbp),%eax
     3fa:	vmovsd (%rbx),%xmm0
     3fe:	cmp    $0xffffffff,%eax
     401:	jne    3b0 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x80>
     403:	cmpl   $0xffffffff,0x8(%rbx)
     407:	jne    40d <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xdd>
     40d:	vucomisd 0x0(%rip),%xmm0        # 415 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xe5>
     415:	setnp  %al
     418:	vucomisd %xmm6,%xmm0
     41c:	cmovne %ecx,%eax
     41f:	test   %al,%al
     421:	jne    3e7 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xb7>
     423:	jmp    428 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xf8>
     428:	nopl   0x0(%rax,%rax,1)
     430:	mov    0x108(%rsp),%rax
     438:	sub    %fs:0x28,%rax
     441:	jne    455 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x125>
     443:	add    $0x118,%rsp
     44a:	pop    %rbx
     44b:	pop    %rbp
     44c:	pop    %r12
     44e:	pop    %r13
     450:	pop    %r14
     452:	pop    %r15
     454:	ret    
     455:	call   45a <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x12a>
     45a:	nopw   0x0(%rax,%rax,1)

0000000000000460 <ivf::TopK::add(ivf::Neighbor)>:
     460:	endbr64 
     464:	push   %rbx
     465:	mov    %rdi,%rbx
     468:	sub    $0x30,%rsp
     46c:	mov    %rsi,0x8(%rsp)
     471:	mov    0x10(%rdi),%rsi
     475:	mov    0x8(%rdi),%r9
     479:	mov    %rsi,%rdx
     47c:	vmovq  %xmm0,(%rsp)
     481:	sub    %r9,%rdx
     484:	mov    %fs:0x28,%rax
     48d:	mov    %rax,0x28(%rsp)
     492:	xor    %eax,%eax
     494:	mov    %rdx,%rax
     497:	sar    $0x4,%rax
     49b:	cmp    %rax,(%rdi)
     49e:	ja     590 <ivf::TopK::add(ivf::Neighbor)+0x130>
     4a4:	vmovsd (%rsp),%xmm1
     4a9:	vmovsd (%r9),%xmm0
     4ae:	vcomisd %xmm1,%xmm0
     4b2:	jbe    578 <ivf::TopK::add(ivf::Neighbor)+0x118>
     4b8:	cmp    $0x10,%rdx
     4bc:	jg     668 <ivf::TopK::add(ivf::Neighbor)+0x208>
     4c2:	vmovdqa (%rsp),%xmm4
     4c7:	lea    -0x1(%rax),%rdx
     4cb:	sub    $0x2,%rax
     4cf:	vmovdqu %xmm4,-0x10(%rsi)
     4d4:	mov    %rax,%r8
     4d7:	mov    -0x8(%rsi),%ecx
     4da:	vmovsd -0x10(%rsi),%xmm0
     4df:	shr    $0x3f,%r8
     4e3:	add    %rax,%r8
     4e6:	mov    %ecx,0x18(%rsp)
     4ea:	vmovsd %xmm0,0x10(%rsp)
     4f0:	sar    %r8
     4f3:	test   %rdx,%rdx
     4f6:	jle    6d1 <ivf::TopK::add(ivf::Neighbor)+0x271>
     4fc:	lea    0x10(%rsp),%rsi
     501:	jmp    530 <ivf::TopK::add(ivf::Neighbor)+0xd0>
     503:	nopl   0x0(%rax,%rax,1)
     508:	vmovdqu (%rcx),%xmm2
     50c:	vmovdqu %xmm2,(%rdx)
     510:	lea    -0x1(%r8),%rdx
     514:	mov    %rdx,%rax
     517:	shr    $0x3f,%rax
     51b:	add    %rdx,%rax
     51e:	sar    %rax
     521:	mov    %r8,%rdx
     524:	test   %r8,%r8
     527:	jle    640 <ivf::TopK::add(ivf::Neighbor)+0x1e0>
     52d:	mov    %rax,%r8
     530:	mov    %r8,%rcx
     533:	shl    $0x4,%rcx
     537:	add    %r9,%rcx
     53a:	mov    %rcx,%rdi
     53d:	shl    $0x4,%rdx
     541:	call   546 <ivf::TopK::add(ivf::Neighbor)+0xe6>
     546:	add    %r9,%rdx
     549:	test   %al,%al
     54b:	jne    508 <ivf::TopK::add(ivf::Neighbor)+0xa8>
     54d:	vmovdqa 0x10(%rsp),%xmm5
     553:	vmovdqu %xmm5,(%rdx)
     557:	mov    0x28(%rsp),%rax
     55c:	sub    %fs:0x28,%rax
     565:	jne    6e7 <ivf::TopK::add(ivf::Neighbor)+0x287>
     56b:	add    $0x30,%rsp
     56f:	pop    %rbx
     570:	ret    
     571:	nopl   0x0(%rax)
     578:	vucomisd %xmm0,%xmm1
     57c:	jp     557 <ivf::TopK::add(ivf::Neighbor)+0xf7>
     57e:	jne    557 <ivf::TopK::add(ivf::Neighbor)+0xf7>
     580:	mov    0x8(%r9),%edi
     584:	cmp    %edi,0x8(%rsp)
     588:	jge    557 <ivf::TopK::add(ivf::Neighbor)+0xf7>
     58a:	jmp    4b8 <ivf::TopK::add(ivf::Neighbor)+0x58>
     58f:	nop
     590:	cmp    0x18(%rdi),%rsi
     594:	je     6b8 <ivf::TopK::add(ivf::Neighbor)+0x258>
     59a:	vmovdqa (%rsp),%xmm7
     59f:	add    $0x10,%rsi
     5a3:	vmovdqu %xmm7,-0x10(%rsi)
     5a8:	mov    %rsi,0x10(%rdi)
     5ac:	mov    %rsi,%rcx
     5af:	sub    %r9,%rcx
     5b2:	mov    %rcx,%rax
     5b5:	sar    $0x4,%rax
     5b9:	lea    -0x1(%rax),%rdx
     5bd:	sub    $0x2,%rax
     5c1:	mov    %rax,%r8
     5c4:	mov    -0x8(%rsi),%edi
     5c7:	vmovsd -0x10(%rsi),%xmm0
     5cc:	shr    $0x3f,%r8
     5d0:	add    %rax,%r8
     5d3:	mov    %edi,0x18(%rsp)
     5d7:	vmovsd %xmm0,0x10(%rsp)
     5dd:	sar    %r8
     5e0:	test   %rdx,%rdx
     5e3:	jle    6dd <ivf::TopK::add(ivf::Neighbor)+0x27d>
     5e9:	lea    0x10(%rsp),%rsi
     5ee:	jmp    614 <ivf::TopK::add(ivf::Neighbor)+0x1b4>
     5f0:	vmovdqu (%rcx),%xmm3
     5f4:	vmovdqu %xmm3,(%rdx)
     5f8:	lea    -0x1(%r8),%rdx
     5fc:	mov    %rdx,%rax
     5ff:	shr    $0x3f,%rax
     603:	add    %rdx,%rax
     606:	sar    %rax
     609:	mov    %r8,%rdx
     60c:	test   %r8,%r8
     60f:	jle    650 <ivf::TopK::add(ivf::Neighbor)+0x1f0>
     611:	mov    %rax,%r8
     614:	mov    %r8,%rcx
     617:	shl    $0x4,%rcx
     61b:	add    %r9,%rcx
     61e:	mov    %rcx,%rdi
     621:	shl    $0x4,%rdx
     625:	call   62a <ivf::TopK::add(ivf::Neighbor)+0x1ca>
     62a:	add    %r9,%rdx
     62d:	test   %al,%al
     62f:	jne    5f0 <ivf::TopK::add(ivf::Neighbor)+0x190>
     631:	vmovdqa 0x10(%rsp),%xmm6
     637:	vmovdqu %xmm6,(%rdx)
     63b:	jmp    557 <ivf::TopK::add(ivf::Neighbor)+0xf7>
     640:	mov    %rcx,%rdx
     643:	jmp    54d <ivf::TopK::add(ivf::Neighbor)+0xed>
     648:	nopl   0x0(%rax,%rax,1)
     650:	vmovdqa 0x10(%rsp),%xmm6
     656:	mov    %rcx,%rdx
     659:	vmovdqu %xmm6,(%rdx)
     65d:	jmp    557 <ivf::TopK::add(ivf::Neighbor)+0xf7>
     662:	nopw   0x0(%rax,%rax,1)
     668:	mov    -0x10(%rsi),%rax
     66c:	vmovdqu (%r9),%xmm7
     671:	lea    -0x10(%rsi),%rdx
     675:	mov    -0x8(%rsi),%rcx
     679:	sub    %r9,%rdx
     67c:	vmovdqu %xmm7,-0x10(%rsi)
     681:	vmovq  %rax,%xmm0
     686:	xor    %esi,%esi
     688:	mov    %r9,%rdi
     68b:	sar    $0x4,%rdx
     68f:	lea    0x0(%rip),%r8        # 696 <ivf::TopK::add(ivf::Neighbor)+0x236>
     696:	call   69b <ivf::TopK::add(ivf::Neighbor)+0x23b>
     69b:	mov    0x10(%rbx),%rsi
     69f:	mov    0x8(%rbx),%r9
     6a3:	mov    %rsi,%rax
     6a6:	sub    %r9,%rax
     6a9:	sar    $0x4,%rax
     6ad:	jmp    4c2 <ivf::TopK::add(ivf::Neighbor)+0x62>
     6b2:	nopw   0x0(%rax,%rax,1)
     6b8:	mov    %rsp,%rdx
     6bb:	lea    0x8(%rdi),%rdi
     6bf:	call   6c4 <ivf::TopK::add(ivf::Neighbor)+0x264>
     6c4:	mov    0x8(%rbx),%r9
     6c8:	mov    0x10(%rbx),%rsi
     6cc:	jmp    5ac <ivf::TopK::add(ivf::Neighbor)+0x14c>
     6d1:	shl    $0x4,%rdx
     6d5:	add    %r9,%rdx
     6d8:	jmp    54d <ivf::TopK::add(ivf::Neighbor)+0xed>
     6dd:	lea    -0x10(%r9,%rcx,1),%rdx
     6e2:	jmp    631 <ivf::TopK::add(ivf::Neighbor)+0x1d1>
     6e7:	call   6ec <ivf::TopK::add(ivf::Neighbor)+0x28c>
     6ec:	nopl   0x0(%rax)

00000000000006f0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)>:
     6f0:	endbr64 
     6f4:	push   %rbp
     6f5:	mov    %rsp,%rbp
     6f8:	push   %r15
     6fa:	push   %r14
     6fc:	push   %r13
     6fe:	mov    %rsi,%r13
     701:	push   %r12
     703:	push   %rbx
     704:	and    $0xffffffffffffffe0,%rsp
     708:	sub    $0x20,%rsp
     70c:	mov    0x10(%rsi),%rax
     710:	mov    %rdi,0x8(%rsp)
     715:	mov    %rax,%rsi
     718:	shr    $0x3b,%rsi
     71c:	mov    %rcx,0x10(%rsp)
     721:	jne    b33 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x443>
     727:	mov    %rax,%r14
     72a:	shl    $0x4,%r14
     72e:	test   %rax,%rax
     731:	je     ae9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3f9>
     737:	mov    %r14,%rdi
     73a:	mov    %rdx,%rbx
     73d:	call   742 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x52>
     742:	vmovsd 0x0(%rip),%xmm0        # 74a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x5a>
     74a:	mov    %rax,%r12
     74d:	add    %rax,%r14
     750:	movl   $0xffffffff,0x8(%rax)
     757:	vmovsd %xmm0,(%rax)
     75b:	add    $0x10,%rax
     75f:	cmp    %rax,%r14
     762:	jne    750 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x60>
     764:	mov    0x10(%r13),%r8
     768:	test   %r8,%r8
     76b:	je     7d1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xe1>
     76d:	mov    0x8(%r13),%rcx
     771:	mov    0x60(%r13),%rdx
     775:	vxorps %xmm3,%xmm3,%xmm3
     779:	mov    %r12,%rdi
     77c:	lea    0x0(,%rcx,4),%r9
     784:	xor    %esi,%esi
     786:	vxorpd %xmm4,%xmm4,%xmm4
     78a:	nopw   0x0(%rax,%rax,1)
     790:	test   %rcx,%rcx
     793:	je     ab8 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3c8>
     799:	xor    %eax,%eax
     79b:	vmovsd %xmm4,%xmm4,%xmm2
     79f:	nop
     7a0:	vcvtss2sd (%rbx,%rax,4),%xmm3,%xmm0
     7a5:	vcvtss2sd (%rdx,%rax,4),%xmm3,%xmm1
     7aa:	vsubsd %xmm1,%xmm0,%xmm0
     7ae:	inc    %rax
     7b1:	vfmadd231sd %xmm0,%xmm0,%xmm2
     7b6:	cmp    %rax,%rcx
     7b9:	jne    7a0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xb0>
     7bb:	mov    %esi,0x8(%rdi)
     7be:	inc    %rsi
     7c1:	vmovsd %xmm2,(%rdi)
     7c5:	add    %r9,%rdx
     7c8:	add    $0x10,%rdi
     7cc:	cmp    %r8,%rsi
     7cf:	jne    790 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xa0>
     7d1:	mov    0x10(%rsp),%rax
     7d6:	lea    0x0(%rip),%rsi        # 7dd <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xed>
     7dd:	shl    $0x4,%rax
     7e1:	mov    %rax,%r15
     7e4:	mov    %rsi,0x18(%rsp)
     7e9:	mov    %rax,(%rsp)
     7ed:	lea    (%r12,%rax,1),%rbx
     7f1:	sar    $0x4,%r15
     7f5:	cmp    $0x10,%rax
     7f9:	jle    ac1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3d1>
     7ff:	lea    -0x2(%r15),%rax
     803:	mov    %rax,%r13
     806:	shr    $0x3f,%r13
     80a:	add    %rax,%r13
     80d:	sar    %r13
     810:	jmp    81b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x12b>
     812:	nopw   0x0(%rax,%rax,1)
     818:	dec    %r13
     81b:	mov    %r13,%rdx
     81e:	shl    $0x4,%rdx
     822:	mov    (%r12,%rdx,1),%rax
     826:	mov    0x8(%r12,%rdx,1),%rcx
     82b:	mov    0x18(%rsp),%r8
     830:	vmovq  %rax,%xmm0
     835:	mov    %r15,%rdx
     838:	mov    %r13,%rsi
     83b:	mov    %r12,%rdi
     83e:	call   843 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x153>
     843:	test   %r13,%r13
     846:	jne    818 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x128>
     848:	cmp    %rbx,%r14
     84b:	jbe    8ab <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1bb>
     84d:	mov    %rbx,%r13
     850:	jmp    861 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x171>
     852:	nopw   0x0(%rax,%rax,1)
     858:	add    $0x10,%r13
     85c:	cmp    %r13,%r14
     85f:	jbe    8a4 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1b4>
     861:	mov    %r12,%rsi
     864:	mov    %r13,%rdi
     867:	call   86c <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x17c>
     86c:	test   %al,%al
     86e:	je     858 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x168>
     870:	mov    0x0(%r13),%rax
     874:	vmovdqu (%r12),%xmm6
     87a:	mov    0x8(%r13),%rcx
     87e:	mov    0x18(%rsp),%r8
     883:	vmovdqu %xmm6,0x0(%r13)
     889:	vmovq  %rax,%xmm0
     88e:	mov    %r15,%rdx
     891:	xor    %esi,%esi
     893:	mov    %r12,%rdi
     896:	call   89b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1ab>
     89b:	add    $0x10,%r13
     89f:	cmp    %r13,%r14
     8a2:	ja     861 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x171>
     8a4:	cmpq   $0x10,(%rsp)
     8a9:	jle    8f2 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x202>
     8ab:	lea    0x0(%rip),%r15        # 8b2 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1c2>
     8b2:	nopw   0x0(%rax,%rax,1)
     8b8:	sub    $0x10,%rbx
     8bc:	mov    %rbx,%r13
     8bf:	mov    (%rbx),%rax
     8c2:	vmovdqu (%r12),%xmm5
     8c8:	sub    %r12,%r13
     8cb:	mov    %r13,%rdx
     8ce:	mov    0x8(%rbx),%rcx
     8d2:	vmovq  %rax,%xmm0
     8d7:	vmovdqu %xmm5,(%rbx)
     8db:	sar    $0x4,%rdx
     8df:	mov    %r15,%r8
     8e2:	xor    %esi,%esi
     8e4:	mov    %r12,%rdi
     8e7:	call   8ec <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1fc>
     8ec:	cmp    $0x10,%r13
     8f0:	jg     8b8 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1c8>
     8f2:	mov    0x10(%rsp),%rax
     8f7:	shr    $0x3d,%rax
     8fb:	jne    b3f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x44f>
     901:	mov    0x8(%rsp),%r15
     906:	mov    0x10(%rsp),%rax
     90b:	movq   $0x0,(%r15)
     912:	movq   $0x0,0x8(%r15)
     91a:	movq   $0x0,0x10(%r15)
     922:	lea    0x0(,%rax,4),%rbx
     92a:	test   %rax,%rax
     92d:	je     ad0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3e0>
     933:	mov    %rbx,%rdi
     936:	call   93b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x24b>
     93b:	mov    %rax,%r13
     93e:	mov    %r13,(%r15)
     941:	mov    %r15,%rax
     944:	cmpq   $0x1,0x10(%rsp)
     94a:	lea    0x0(%r13,%rbx,1),%r15
     94f:	mov    %r15,0x10(%rax)
     953:	movl   $0x0,0x0(%r13)
     95b:	lea    0x4(%r13),%rdi
     95f:	je     b1c <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x42c>
     965:	cmp    %rdi,%r15
     968:	je     975 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x285>
     96a:	lea    -0x4(%rbx),%rdx
     96e:	xor    %esi,%esi
     970:	call   975 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x285>
     975:	mov    0x8(%rsp),%rax
     97a:	mov    %r15,0x8(%rax)
     97e:	mov    0x10(%rsp),%rax
     983:	lea    -0x1(%rax),%rsi
     987:	cmp    $0x7,%rsi
     98b:	jbe    b2c <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x43c>
     991:	mov    %rsi,%rcx
     994:	shr    $0x3,%rcx
     998:	shl    $0x5,%rcx
     99c:	vmovdqa 0x0(%rip),%ymm2        # 9a4 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2b4>
     9a4:	mov    %r13,%rdx
     9a7:	lea    0x8(%r12),%rax
     9ac:	add    %r13,%rcx
     9af:	nop
     9b0:	vmovdqu (%rax),%ymm0
     9b4:	vmovdqu 0x40(%rax),%ymm1
     9b9:	vpermt2d 0x20(%rax),%ymm2,%ymm0
     9c0:	vpermt2d 0x60(%rax),%ymm2,%ymm1
     9c7:	vpermt2d %ymm1,%ymm2,%ymm0
     9cd:	vmovdqu %ymm0,(%rdx)
     9d1:	add    $0x20,%rdx
     9d5:	sub    $0xffffffffffffff80,%rax
     9d9:	cmp    %rdx,%rcx
     9dc:	jne    9b0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2c0>
     9de:	mov    %rsi,%rax
     9e1:	and    $0xfffffffffffffff8,%rax
     9e5:	vzeroupper 
     9e8:	mov    %rax,%rdx
     9eb:	shl    $0x4,%rdx
     9ef:	mov    0x8(%r12,%rdx,1),%esi
     9f4:	mov    0x10(%rsp),%rdi
     9f9:	mov    %esi,0x0(%r13,%rax,4)
     9fe:	lea    0x1(%rax),%rsi
     a02:	lea    0x0(,%rax,4),%rcx
     a0a:	cmp    %rdi,%rsi
     a0d:	jae    a8b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39b>
     a0f:	mov    0x18(%r12,%rdx,1),%esi
     a14:	mov    %esi,0x4(%r13,%rcx,1)
     a19:	lea    0x2(%rax),%rsi
     a1d:	cmp    %rsi,%rdi
     a20:	jbe    a8b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39b>
     a22:	mov    0x28(%r12,%rdx,1),%esi
     a27:	mov    %esi,0x8(%r13,%rcx,1)
     a2c:	lea    0x3(%rax),%rsi
     a30:	cmp    %rsi,%rdi
     a33:	jbe    a8b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39b>
     a35:	mov    0x38(%r12,%rdx,1),%esi
     a3a:	mov    %esi,0xc(%r13,%rcx,1)
     a3f:	lea    0x4(%rax),%rsi
     a43:	cmp    %rsi,%rdi
     a46:	jbe    a8b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39b>
     a48:	mov    0x48(%r12,%rdx,1),%esi
     a4d:	mov    %esi,0x10(%r13,%rcx,1)
     a52:	lea    0x5(%rax),%rsi
     a56:	cmp    %rsi,%rdi
     a59:	jbe    a8b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39b>
     a5b:	mov    0x58(%r12,%rdx,1),%esi
     a60:	mov    %esi,0x14(%r13,%rcx,1)
     a65:	lea    0x6(%rax),%rsi
     a69:	cmp    %rsi,%rdi
     a6c:	jbe    a8b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39b>
     a6e:	mov    0x68(%r12,%rdx,1),%esi
     a73:	add    $0x7,%rax
     a77:	mov    %esi,0x18(%r13,%rcx,1)
     a7c:	cmp    %rax,%rdi
     a7f:	jbe    a8b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39b>
     a81:	mov    0x78(%r12,%rdx,1),%eax
     a86:	mov    %eax,0x1c(%r13,%rcx,1)
     a8b:	test   %r12,%r12
     a8e:	je     a9e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3ae>
     a90:	mov    %r14,%rsi
     a93:	sub    %r12,%rsi
     a96:	mov    %r12,%rdi
     a99:	call   a9e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3ae>
     a9e:	mov    0x8(%rsp),%rax
     aa3:	lea    -0x28(%rbp),%rsp
     aa7:	pop    %rbx
     aa8:	pop    %r12
     aaa:	pop    %r13
     aac:	pop    %r14
     aae:	pop    %r15
     ab0:	pop    %rbp
     ab1:	ret    
     ab2:	nopw   0x0(%rax,%rax,1)
     ab8:	vmovsd %xmm4,%xmm4,%xmm2
     abc:	jmp    7bb <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xcb>
     ac1:	cmp    %rbx,%r14
     ac4:	ja     84d <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x15d>
     aca:	jmp    8f2 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x202>
     acf:	nop
     ad0:	movq   $0x0,(%r15)
     ad7:	movq   $0x0,0x10(%r15)
     adf:	movq   $0x0,0x8(%r15)
     ae7:	jmp    a8b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x39b>
     ae9:	mov    %rcx,%rbx
     aec:	shl    $0x4,%rbx
     af0:	lea    0x0(%rip),%rax        # af7 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x407>
     af7:	mov    %rbx,%r15
     afa:	mov    %rax,0x18(%rsp)
     aff:	mov    %rbx,(%rsp)
     b03:	sar    $0x4,%r15
     b07:	xor    %r12d,%r12d
     b0a:	xor    %r14d,%r14d
     b0d:	cmp    $0x10,%rbx
     b11:	jle    8f2 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x202>
     b17:	jmp    7ff <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x10f>
     b1c:	mov    0x8(%rsp),%rax
     b21:	mov    %rdi,0x8(%rax)
     b25:	xor    %eax,%eax
     b27:	jmp    9e8 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2f8>
     b2c:	xor    %eax,%eax
     b2e:	jmp    9e8 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2f8>
     b33:	lea    0x0(%rip),%rdi        # b3a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x44a>
     b3a:	call   b3f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x44f>
     b3f:	lea    0x0(%rip),%rdi        # b46 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x456>
     b46:	call   b4b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x45b>
     b4b:	endbr64 
     b4f:	mov    %rax,%r13
     b52:	jmp    b57 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x467>
     b57:	endbr64 
     b5b:	mov    %rax,%r13
     b5e:	jmp    b63 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x473>
     b63:	nop
     b64:	data16 cs nopw 0x0(%rax,%rax,1)
     b6f:	nop

0000000000000b70 <ivf::TopK::finish(ivf::Neighbor*)>:
     b70:	endbr64 
     b74:	push   %r15
     b76:	push   %r14
     b78:	push   %r13
     b7a:	mov    %rdi,%r13
     b7d:	push   %r12
     b7f:	push   %rbp
     b80:	mov    %rsi,%rbp
     b83:	push   %rbx
     b84:	sub    $0x8,%rsp
     b88:	mov    0x10(%rdi),%rbx
     b8c:	mov    0x8(%rdi),%r14
     b90:	mov    %rbx,%rdx
     b93:	sub    %r14,%rdx
     b96:	cmp    $0x10,%rdx
     b9a:	jle    bf7 <ivf::TopK::finish(ivf::Neighbor*)+0x87>
     b9c:	lea    0x0(%rip),%r12        # ba3 <ivf::TopK::finish(ivf::Neighbor*)+0x33>
     ba3:	sub    $0x10,%rbx
     ba7:	nopw   0x0(%rax,%rax,1)
     bb0:	mov    %rbx,%r15
     bb3:	mov    (%rbx),%rax
     bb6:	vmovdqu (%r14),%xmm1
     bbb:	sub    %r14,%r15
     bbe:	mov    0x8(%rbx),%rcx
     bc2:	mov    %r15,%rdx
     bc5:	vmovdqu %xmm1,(%rbx)
     bc9:	vmovq  %rax,%xmm0
     bce:	sar    $0x4,%rdx
     bd2:	mov    %r12,%r8
     bd5:	xor    %esi,%esi
     bd7:	mov    %r14,%rdi
     bda:	call   bdf <ivf::TopK::finish(ivf::Neighbor*)+0x6f>
     bdf:	sub    $0x10,%rbx
     be3:	cmp    $0x10,%r15
     be7:	jg     bb0 <ivf::TopK::finish(ivf::Neighbor*)+0x40>
     be9:	mov    0x10(%r13),%rbx
     bed:	mov    0x8(%r13),%r14
     bf1:	mov    %rbx,%rdx
     bf4:	sub    %r14,%rdx
     bf7:	cmp    %r14,%rbx
     bfa:	je     c0f <ivf::TopK::finish(ivf::Neighbor*)+0x9f>
     bfc:	mov    %r14,%rsi
     bff:	mov    %rbp,%rdi
     c02:	call   c07 <ivf::TopK::finish(ivf::Neighbor*)+0x97>
     c07:	mov    0x10(%r13),%rdx
     c0b:	sub    0x8(%r13),%rdx
     c0f:	mov    0x0(%r13),%rcx
     c13:	lea    0x0(%rbp,%rdx,1),%rax
     c18:	shl    $0x4,%rcx
     c1c:	add    %rbp,%rcx
     c1f:	vmovsd 0x0(%rip),%xmm0        # c27 <ivf::TopK::finish(ivf::Neighbor*)+0xb7>
     c27:	cmp    %rax,%rcx
     c2a:	je     c44 <ivf::TopK::finish(ivf::Neighbor*)+0xd4>
     c2c:	nopl   0x0(%rax)
     c30:	movl   $0xffffffff,0x8(%rax)
     c37:	vmovsd %xmm0,(%rax)
     c3b:	add    $0x10,%rax
     c3f:	cmp    %rax,%rcx
     c42:	jne    c30 <ivf::TopK::finish(ivf::Neighbor*)+0xc0>
     c44:	add    $0x8,%rsp
     c48:	pop    %rbx
     c49:	pop    %rbp
     c4a:	pop    %r12
     c4c:	pop    %r13
     c4e:	pop    %r14
     c50:	pop    %r15
     c52:	ret    
     c53:	data16 cs nopw 0x0(%rax,%rax,1)
     c5e:	xchg   %ax,%ax

0000000000000c60 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)>:
     c60:	endbr64 
     c64:	push   %r15
     c66:	movabs $0xffffffff00000000,%r15
     c70:	push   %r14
     c72:	push   %r13
     c74:	xor    %r13d,%r13d
     c77:	push   %r12
     c79:	mov    %rdi,%r12
     c7c:	push   %rbp
     c7d:	push   %rbx
     c7e:	sub    $0x58,%rsp
     c82:	mov    %rsi,(%rsp)
     c86:	mov    %rdx,0x10(%rsp)
     c8b:	mov    %rcx,0x8(%rsp)
     c90:	mov    %r8,0x18(%rsp)
     c95:	lea    0x20(%rsp),%r14
     c9a:	mov    %fs:0x28,%rax
     ca3:	mov    %rax,0x48(%rsp)
     ca8:	xor    %eax,%eax
     caa:	test   %rdx,%rdx
     cad:	je     d9b <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x13b>
     cb3:	nopl   0x0(%rax,%rax,1)
     cb8:	mov    0x8(%rsp),%rax
     cbd:	mov    %r14,%rdi
     cc0:	mov    (%rax),%rsi
     cc3:	xor    %ebx,%ebx
     cc5:	call   cca <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x6a>
     cca:	cmpq   $0x0,(%r12)
     ccf:	je     d59 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xf9>
     cd5:	nopl   (%rax)
     cd8:	mov    0x8(%r12),%rdx
     cdd:	mov    0x48(%r12),%r8
     ce2:	lea    0x0(,%rdx,4),%rax
     cea:	mov    %rax,%rdi
     ced:	imul   %r13,%rax
     cf1:	imul   %rbx,%rdi
     cf5:	vxorpd %xmm2,%xmm2,%xmm2
     cf9:	mov    %rax,%rcx
     cfc:	test   %rdx,%rdx
     cff:	je     d2f <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xcf>
     d01:	mov    (%rsp),%rsi
     d05:	xor    %eax,%eax
     d07:	add    %rcx,%rsi
     d0a:	lea    (%r8,%rdi,1),%rcx
     d0e:	xchg   %ax,%ax
     d10:	vxorpd %xmm3,%xmm3,%xmm3
     d14:	vcvtss2sd (%rsi,%rax,4),%xmm3,%xmm0
     d19:	vcvtss2sd (%rcx,%rax,4),%xmm3,%xmm1
     d1e:	vsubsd %xmm1,%xmm0,%xmm0
     d22:	inc    %rax
     d25:	vfmadd231sd %xmm0,%xmm0,%xmm2
     d2a:	cmp    %rax,%rdx
     d2d:	jne    d10 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xb0>
     d2f:	mov    0x30(%r12),%rax
     d34:	and    %r15,%rbp
     d37:	mov    (%rax,%rbx,4),%eax
     d3a:	vmovsd %xmm2,%xmm2,%xmm0
     d3e:	or     %rax,%rbp
     d41:	mov    %rbp,%rsi
     d44:	mov    %r14,%rdi
     d47:	call   d4c <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xec>
     d4c:	inc    %rbx
     d4f:	cmp    %rbx,(%r12)
     d53:	ja     cd8 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x78>
     d59:	mov    0x8(%rsp),%rax
     d5e:	mov    %r14,%rdi
     d61:	mov    (%rax),%rsi
     d64:	imul   %r13,%rsi
     d68:	shl    $0x4,%rsi
     d6c:	add    0x18(%rsp),%rsi
     d71:	call   d76 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x116>
     d76:	mov    0x28(%rsp),%rdi
     d7b:	test   %rdi,%rdi
     d7e:	je     dba <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x15a>
     d80:	mov    0x38(%rsp),%rsi
     d85:	inc    %r13
     d88:	sub    %rdi,%rsi
     d8b:	call   d90 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x130>
     d90:	cmp    0x10(%rsp),%r13
     d95:	jne    cb8 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x58>
     d9b:	mov    0x48(%rsp),%rax
     da0:	sub    %fs:0x28,%rax
     da9:	jne    dca <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x16a>
     dab:	add    $0x58,%rsp
     daf:	pop    %rbx
     db0:	pop    %rbp
     db1:	pop    %r12
     db3:	pop    %r13
     db5:	pop    %r14
     db7:	pop    %r15
     db9:	ret    
     dba:	inc    %r13
     dbd:	cmp    %r13,0x10(%rsp)
     dc2:	jne    cb8 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x58>
     dc8:	jmp    d9b <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x13b>
     dca:	call   dcf <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x16f>
     dcf:	endbr64 
     dd3:	mov    %rax,%rbp
     dd6:	jmp    ddb <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x17b>
     ddb:	nopl   0x0(%rax,%rax,1)

0000000000000de0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)>:
     de0:	endbr64 
     de4:	push   %r15
     de6:	push   %r14
     de8:	push   %r13
     dea:	mov    %rdi,%r13
     ded:	push   %r12
     def:	push   %rbp
     df0:	push   %rbx
     df1:	sub    $0x98,%rsp
     df8:	mov    %rsi,0x28(%rsp)
     dfd:	mov    %rdx,0x18(%rsp)
     e02:	mov    %rcx,0x20(%rsp)
     e07:	mov    %r8,0x30(%rsp)
     e0c:	lea    0x60(%rsp),%r15
     e11:	mov    %fs:0x28,%rax
     e1a:	mov    %rax,0x88(%rsp)
     e22:	xor    %eax,%eax
     e24:	lea    0x40(%rsp),%rax
     e29:	movq   $0x0,0x10(%rsp)
     e32:	mov    %rax,0x38(%rsp)
     e37:	test   %rdx,%rdx
     e3a:	je     fb0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1d0>
     e40:	mov    0x10(%rsp),%rax
     e45:	mov    0x28(%rsp),%rdi
     e4a:	imul   0x8(%r13),%rax
     e4f:	mov    0x20(%rsp),%r14
     e54:	mov    %r13,%rsi
     e57:	lea    (%rdi,%rax,4),%rbx
     e5b:	mov    0x8(%r14),%rcx
     e5f:	mov    0x38(%rsp),%rdi
     e64:	mov    %rbx,%rdx
     e67:	call   e6c <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x8c>
     e6c:	mov    (%r14),%rsi
     e6f:	mov    %r15,%rdi
     e72:	call   e77 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x97>
     e77:	mov    0x48(%rsp),%rax
     e7c:	mov    0x40(%rsp),%rdx
     e81:	mov    %rax,0x8(%rsp)
     e86:	cmp    %rdx,%rax
     e89:	je     f4e <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x16e>
     e8f:	mov    %rdx,(%rsp)
     e93:	mov    0x18(%r13),%rax
     e97:	nopw   0x0(%rax,%rax,1)
     ea0:	mov    (%rsp),%rdi
     ea4:	mov    (%rdi),%ecx
     ea6:	mov    %rcx,%rdx
     ea9:	mov    (%rax,%rcx,8),%rbp
     ead:	inc    %edx
     eaf:	lea    0x0(,%rdx,8),%r14
     eb7:	cmp    (%rax,%rdx,8),%rbp
     ebb:	jae    f3a <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x15a>
     ebd:	nopl   (%rax)
     ec0:	mov    0x8(%r13),%rdx
     ec4:	mov    0x48(%r13),%rsi
     ec8:	mov    %rdx,%rax
     ecb:	imul   %rbp,%rax
     ecf:	vxorpd %xmm2,%xmm2,%xmm2
     ed3:	lea    0x0(,%rax,4),%rcx
     edb:	test   %rdx,%rdx
     ede:	je     f07 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x127>
     ee0:	xor    %eax,%eax
     ee2:	add    %rsi,%rcx
     ee5:	nopl   (%rax)
     ee8:	vxorpd %xmm3,%xmm3,%xmm3
     eec:	vcvtss2sd (%rbx,%rax,4),%xmm3,%xmm0
     ef1:	vcvtss2sd (%rcx,%rax,4),%xmm3,%xmm1
     ef6:	vsubsd %xmm1,%xmm0,%xmm0
     efa:	inc    %rax
     efd:	vfmadd231sd %xmm0,%xmm0,%xmm2
     f02:	cmp    %rax,%rdx
     f05:	jne    ee8 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x108>
     f07:	mov    0x30(%r13),%rax
     f0b:	movabs $0xffffffff00000000,%rdi
     f15:	mov    (%rax,%rbp,4),%eax
     f18:	and    %rdi,%r12
     f1b:	or     %rax,%r12
     f1e:	vmovsd %xmm2,%xmm2,%xmm0
     f22:	mov    %r12,%rsi
     f25:	mov    %r15,%rdi
     f28:	call   f2d <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x14d>
     f2d:	mov    0x18(%r13),%rax
     f31:	inc    %rbp
     f34:	cmp    %rbp,(%rax,%r14,1)
     f38:	ja     ec0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xe0>
     f3a:	addq   $0x4,(%rsp)
     f3f:	mov    (%rsp),%rsi
     f43:	cmp    %rsi,0x8(%rsp)
     f48:	jne    ea0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xc0>
     f4e:	mov    0x20(%rsp),%rax
     f53:	mov    0x10(%rsp),%rsi
     f58:	mov    %r15,%rdi
     f5b:	imul   (%rax),%rsi
     f5f:	shl    $0x4,%rsi
     f63:	add    0x30(%rsp),%rsi
     f68:	call   f6d <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x18d>
     f6d:	mov    0x68(%rsp),%rdi
     f72:	test   %rdi,%rdi
     f75:	je     f84 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1a4>
     f77:	mov    0x78(%rsp),%rsi
     f7c:	sub    %rdi,%rsi
     f7f:	call   f84 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1a4>
     f84:	mov    0x40(%rsp),%rdi
     f89:	test   %rdi,%rdi
     f8c:	je     fd5 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1f5>
     f8e:	mov    0x50(%rsp),%rsi
     f93:	sub    %rdi,%rsi
     f96:	call   f9b <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1bb>
     f9b:	incq   0x10(%rsp)
     fa0:	mov    0x10(%rsp),%rax
     fa5:	cmp    0x18(%rsp),%rax
     faa:	jne    e40 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x60>
     fb0:	mov    0x88(%rsp),%rax
     fb8:	sub    %fs:0x28,%rax
     fc1:	jne    fec <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x20c>
     fc3:	add    $0x98,%rsp
     fca:	pop    %rbx
     fcb:	pop    %rbp
     fcc:	pop    %r12
     fce:	pop    %r13
     fd0:	pop    %r14
     fd2:	pop    %r15
     fd4:	ret    
     fd5:	incq   0x10(%rsp)
     fda:	mov    0x10(%rsp),%rax
     fdf:	cmp    %rax,0x18(%rsp)
     fe4:	jne    e40 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x60>
     fea:	jmp    fb0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1d0>
     fec:	call   ff1 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x211>
     ff1:	endbr64 
     ff5:	mov    %rax,%rbp
     ff8:	jmp    ffd <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x21d>
     ffd:	endbr64 
    1001:	mov    %rax,%rbp
    1004:	vzeroupper 
    1007:	jmp    100c <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x22c>

Disassembly of section .text._ZNSt7__cxx119to_stringEi:

0000000000000000 <std::__cxx11::to_string(int)>:
   0:	endbr64 
   4:	push   %r14
   6:	mov    %esi,%eax
   8:	sar    $0x1f,%eax
   b:	push   %r13
   d:	mov    %esi,%r14d
  10:	mov    %rdi,%r13
  13:	push   %r12
  15:	shr    $0x1f,%r14d
  19:	push   %rbp
  1a:	mov    %esi,%ebp
  1c:	xor    %eax,%ebp
  1e:	sub    %eax,%ebp
  20:	push   %rbx
  21:	cmp    $0x9,%ebp
  24:	jbe    1ac <std::__cxx11::to_string(int)+0x1ac>
  2a:	cmp    $0x63,%ebp
  2d:	jbe    1ce <std::__cxx11::to_string(int)+0x1ce>
  33:	cmp    $0x3e7,%ebp
  39:	jbe    1ee <std::__cxx11::to_string(int)+0x1ee>
  3f:	mov    %ebp,%ebx
  41:	mov    %rbx,%rdx
  44:	cmp    $0x270f,%ebp
  4a:	jbe    1de <std::__cxx11::to_string(int)+0x1de>
  50:	mov    $0x1,%ecx
  55:	movabs $0x346dc5d63886594b,%rdi
  5f:	jmp    89 <std::__cxx11::to_string(int)+0x89>
  61:	nopl   0x0(%rax)
  68:	cmp    $0x63,%edx
  6b:	jbe    138 <std::__cxx11::to_string(int)+0x138>
  71:	cmp    $0x3e7,%edx
  77:	jbe    190 <std::__cxx11::to_string(int)+0x190>
  7d:	cmp    $0x270f,%edx
  83:	jbe    1a0 <std::__cxx11::to_string(int)+0x1a0>
  89:	mov    %rdx,%rax
  8c:	mov    %rdx,%rsi
  8f:	mul    %rdi
  92:	mov    %ecx,%eax
  94:	add    $0x4,%ecx
  97:	shr    $0xb,%rdx
  9b:	cmp    $0x1869f,%rsi
  a2:	ja     68 <std::__cxx11::to_string(int)+0x68>
  a4:	lea    0x3(%rax),%r12d
  a8:	lea    0x10(%r13),%rax
  ac:	mov    %rax,0x0(%r13)
  b0:	lea    (%r14,%rcx,1),%esi
  b4:	mov    $0x2d,%edx
  b9:	mov    %r13,%rdi
  bc:	call   c1 <std::__cxx11::to_string(int)+0xc1>
  c1:	movzbl %r14b,%ecx
  c5:	add    0x0(%r13),%rcx
  c9:	lea    0x0(%rip),%rsi        # d0 <std::__cxx11::to_string(int)+0xd0>
  d0:	jmp    da <std::__cxx11::to_string(int)+0xda>
  d2:	nopw   0x0(%rax,%rax,1)
  d8:	mov    %ebp,%ebx
  da:	imul   $0x51eb851f,%rbx,%rdx
  e1:	mov    %ebp,%eax
  e3:	shr    $0x25,%rdx
  e7:	imul   $0x64,%edx,%edi
  ea:	sub    %edi,%eax
  ec:	add    %eax,%eax
  ee:	lea    0x1(%rax),%r8d
  f2:	movzbl (%rsi,%r8,1),%r8d
  f7:	movzbl (%rsi,%rax,1),%eax
  fb:	mov    %ebp,%edi
  fd:	mov    %edx,%ebp
  ff:	mov    %r12d,%edx
 102:	mov    %r8b,(%rcx,%rdx,1)
 106:	lea    -0x1(%r12),%edx
 10b:	mov    %al,(%rcx,%rdx,1)
 10e:	sub    $0x2,%r12d
 112:	cmp    $0x270f,%edi
 118:	ja     d8 <std::__cxx11::to_string(int)+0xd8>
 11a:	cmp    $0x3e7,%edi
 120:	ja     171 <std::__cxx11::to_string(int)+0x171>
 122:	add    $0x30,%ebp
 125:	mov    %bpl,(%rcx)
 128:	mov    %r13,%rax
 12b:	pop    %rbx
 12c:	pop    %rbp
 12d:	pop    %r12
 12f:	pop    %r13
 131:	pop    %r14
 133:	ret    
 134:	nopl   0x0(%rax)
 138:	add    $0x5,%eax
 13b:	mov    %ecx,%r12d
 13e:	lea    0x10(%r13),%rdx
 142:	mov    %rdx,0x0(%r13)
 146:	lea    (%r14,%rax,1),%esi
 14a:	mov    $0x2d,%edx
 14f:	mov    %r13,%rdi
 152:	call   157 <std::__cxx11::to_string(int)+0x157>
 157:	movzbl %r14b,%ecx
 15b:	add    0x0(%r13),%rcx
 15f:	mov    %ebp,%ebx
 161:	lea    0x0(%rip),%rsi        # 168 <std::__cxx11::to_string(int)+0x168>
 168:	cmp    $0x63,%ebp
 16b:	ja     c9 <std::__cxx11::to_string(int)+0xc9>
 171:	add    %ebp,%ebp
 173:	lea    0x1(%rbp),%eax
 176:	movzbl (%rsi,%rax,1),%eax
 17a:	movzbl (%rsi,%rbp,1),%ebp
 17e:	mov    %al,0x1(%rcx)
 181:	mov    %bpl,(%rcx)
 184:	mov    %r13,%rax
 187:	pop    %rbx
 188:	pop    %rbp
 189:	pop    %r12
 18b:	pop    %r13
 18d:	pop    %r14
 18f:	ret    
 190:	lea    0x6(%rax),%ecx
 193:	lea    0x5(%rax),%r12d
 197:	jmp    a8 <std::__cxx11::to_string(int)+0xa8>
 19c:	nopl   0x0(%rax)
 1a0:	lea    0x7(%rax),%ecx
 1a3:	lea    0x6(%rax),%r12d
 1a7:	jmp    a8 <std::__cxx11::to_string(int)+0xa8>
 1ac:	lea    0x10(%rdi),%rax
 1b0:	mov    %rax,(%rdi)
 1b3:	lea    0x1(%r14),%esi
 1b7:	mov    $0x2d,%edx
 1bc:	call   1c1 <std::__cxx11::to_string(int)+0x1c1>
 1c1:	movzbl %r14b,%ecx
 1c5:	add    0x0(%r13),%rcx
 1c9:	jmp    122 <std::__cxx11::to_string(int)+0x122>
 1ce:	mov    $0x2,%eax
 1d3:	mov    $0x1,%r12d
 1d9:	jmp    13e <std::__cxx11::to_string(int)+0x13e>
 1de:	mov    $0x3,%r12d
 1e4:	mov    $0x4,%ecx
 1e9:	jmp    a8 <std::__cxx11::to_string(int)+0xa8>
 1ee:	mov    $0x2,%r12d
 1f4:	mov    $0x3,%ecx
 1f9:	mov    %ebp,%ebx
 1fb:	jmp    a8 <std::__cxx11::to_string(int)+0xa8>

Disassembly of section .text._ZNSt7__cxx119to_stringEm:

0000000000000000 <std::__cxx11::to_string(unsigned long)>:
   0:	endbr64 
   4:	push   %r12
   6:	mov    %rdi,%r12
   9:	push   %rbx
   a:	mov    %rsi,%rbx
   d:	sub    $0x8,%rsp
  11:	cmp    $0x9,%rsi
  15:	jbe    19d <std::__cxx11::to_string(unsigned long)+0x19d>
  1b:	cmp    $0x63,%rsi
  1f:	jbe    1b9 <std::__cxx11::to_string(unsigned long)+0x1b9>
  25:	cmp    $0x3e7,%rsi
  2c:	jbe    1cd <std::__cxx11::to_string(unsigned long)+0x1cd>
  32:	cmp    $0x270f,%rsi
  39:	jbe    1c3 <std::__cxx11::to_string(unsigned long)+0x1c3>
  3f:	mov    %rsi,%rdx
  42:	movabs $0x346dc5d63886594b,%rdi
  4c:	mov    $0x1,%esi
  51:	jmp    7f <std::__cxx11::to_string(unsigned long)+0x7f>
  53:	nopl   0x0(%rax,%rax,1)
  58:	cmp    $0xf423f,%rcx
  5f:	jbe    130 <std::__cxx11::to_string(unsigned long)+0x130>
  65:	cmp    $0x98967f,%rcx
  6c:	jbe    170 <std::__cxx11::to_string(unsigned long)+0x170>
  72:	cmp    $0x5f5e0ff,%rcx
  79:	jbe    180 <std::__cxx11::to_string(unsigned long)+0x180>
  7f:	mov    %rdx,%rax
  82:	mov    %rdx,%rcx
  85:	mul    %rdi
  88:	mov    %esi,%eax
  8a:	add    $0x4,%esi
  8d:	shr    $0xb,%rdx
  91:	cmp    $0x1869f,%rcx
  98:	ja     58 <std::__cxx11::to_string(unsigned long)+0x58>
  9a:	lea    0x10(%r12),%rax
  9f:	mov    %rax,(%r12)
  a3:	xor    %edx,%edx
  a5:	mov    %r12,%rdi
  a8:	call   ad <std::__cxx11::to_string(unsigned long)+0xad>
  ad:	mov    0x8(%r12),%eax
  b2:	mov    (%r12),%rsi
  b6:	lea    -0x1(%rax),%ecx
  b9:	lea    0x0(%rip),%rdi        # c0 <std::__cxx11::to_string(unsigned long)+0xc0>
  c0:	movabs $0x28f5c28f5c28f5c3,%r9
  ca:	nopw   0x0(%rax,%rax,1)
  d0:	mov    %rbx,%rdx
  d3:	shr    $0x2,%rdx
  d7:	mov    %rdx,%rax
  da:	mul    %r9
  dd:	mov    %rbx,%rax
  e0:	shr    $0x2,%rdx
  e4:	imul   $0x64,%rdx,%r8
  e8:	sub    %r8,%rax
  eb:	movzbl 0x1(%rdi,%rax,2),%r10d
  f1:	mov    %rbx,%r8
  f4:	movzbl (%rdi,%rax,2),%eax
  f8:	mov    %rdx,%rbx
  fb:	mov    %ecx,%edx
  fd:	mov    %r10b,(%rsi,%rdx,1)
 101:	lea    -0x1(%rcx),%edx
 104:	mov    %al,(%rsi,%rdx,1)
 107:	sub    $0x2,%ecx
 10a:	cmp    $0x270f,%r8
 111:	ja     d0 <std::__cxx11::to_string(unsigned long)+0xd0>
 113:	cmp    $0x3e7,%r8
 11a:	ja     157 <std::__cxx11::to_string(unsigned long)+0x157>
 11c:	add    $0x30,%ebx
 11f:	mov    %bl,(%rsi)
 121:	add    $0x8,%rsp
 125:	mov    %r12,%rax
 128:	pop    %rbx
 129:	pop    %r12
 12b:	ret    
 12c:	nopl   0x0(%rax)
 130:	lea    0x5(%rax),%esi
 133:	lea    0x10(%r12),%rax
 138:	mov    %rax,(%r12)
 13c:	mov    %r12,%rdi
 13f:	xor    %edx,%edx
 141:	call   146 <std::__cxx11::to_string(unsigned long)+0x146>
 146:	mov    (%r12),%rsi
 14a:	lea    0x0(%rip),%rdi        # 151 <std::__cxx11::to_string(unsigned long)+0x151>
 151:	cmp    $0x63,%rbx
 155:	ja     190 <std::__cxx11::to_string(unsigned long)+0x190>
 157:	movzbl 0x1(%rdi,%rbx,2),%eax
 15c:	movzbl (%rdi,%rbx,2),%ebx
 160:	mov    %al,0x1(%rsi)
 163:	mov    %bl,(%rsi)
 165:	add    $0x8,%rsp
 169:	mov    %r12,%rax
 16c:	pop    %rbx
 16d:	pop    %r12
 16f:	ret    
 170:	lea    0x6(%rax),%esi
 173:	jmp    9a <std::__cxx11::to_string(unsigned long)+0x9a>
 178:	nopl   0x0(%rax,%rax,1)
 180:	lea    0x7(%rax),%esi
 183:	jmp    9a <std::__cxx11::to_string(unsigned long)+0x9a>
 188:	nopl   0x0(%rax,%rax,1)
 190:	mov    0x8(%r12),%eax
 195:	lea    -0x1(%rax),%ecx
 198:	jmp    b9 <std::__cxx11::to_string(unsigned long)+0xb9>
 19d:	lea    0x10(%rdi),%rax
 1a1:	mov    %rax,(%rdi)
 1a4:	mov    $0x1,%esi
 1a9:	xor    %edx,%edx
 1ab:	call   1b0 <std::__cxx11::to_string(unsigned long)+0x1b0>
 1b0:	mov    (%r12),%rsi
 1b4:	jmp    11c <std::__cxx11::to_string(unsigned long)+0x11c>
 1b9:	mov    $0x2,%esi
 1be:	jmp    133 <std::__cxx11::to_string(unsigned long)+0x133>
 1c3:	mov    $0x4,%esi
 1c8:	jmp    9a <std::__cxx11::to_string(unsigned long)+0x9a>
 1cd:	mov    $0x3,%esi
 1d2:	jmp    9a <std::__cxx11::to_string(unsigned long)+0x9a>

Disassembly of section .text.unlikely:

0000000000000000 <ivf::TopK::TopK(unsigned long) [clone .cold]>:
   0:	mov    0x8(%rbx),%rdi
   4:	mov    0x18(%rbx),%rsi
   8:	sub    %rdi,%rsi
   b:	test   %rdi,%rdi
   e:	je     20 <ivf::TopK::TopK(unsigned long) [clone .cold]+0x20>
  10:	vzeroupper 
  13:	call   18 <ivf::TopK::TopK(unsigned long) [clone .cold]+0x18>
  18:	mov    %rbp,%rdi
  1b:	call   20 <ivf::TopK::TopK(unsigned long) [clone .cold]+0x20>
  20:	vzeroupper 
  23:	jmp    18 <ivf::TopK::TopK(unsigned long) [clone .cold]+0x18>

0000000000000025 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]>:
  25:	mov    $0x10,%edi
  2a:	call   2f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xa>
  2f:	mov    %rax,%rdi
  32:	lea    0x0(%rip),%rsi        # 39 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x14>
  39:	mov    %rax,%rbp
  3c:	call   41 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1c>
  41:	mov    0x0(%rip),%rdx        # 48 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x23>
  48:	lea    0x0(%rip),%rsi        # 4f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2a>
  4f:	mov    %rbp,%rdi
  52:	call   57 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x32>
  57:	mov    $0x10,%edi
  5c:	call   61 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3c>
  61:	lea    0xc0(%rsp),%r14
  69:	mov    0x8(%rbx),%esi
  6c:	mov    %r14,%rdi
  6f:	mov    %rax,%r13
  72:	call   77 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x52>
  77:	lea    0x60(%rsp),%rbx
  7c:	mov    0x8(%rbp),%esi
  7f:	mov    %rbx,%rdi
  82:	call   87 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x62>
  87:	mov    %rsp,%rbp
  8a:	mov    %r12,%rsi
  8d:	mov    %rbp,%rdi
  90:	call   95 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x70>
  95:	mov    $0x1e,%r8d
  9b:	lea    0x0(%rip),%rcx        # a2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x7d>
  a2:	xor    %edx,%edx
  a4:	xor    %esi,%esi
  a6:	mov    %rbp,%rdi
  a9:	call   ae <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x89>
  ae:	lea    0x30(%rsp),%rbp
  b3:	mov    %rbp,0x20(%rsp)
  b8:	lea    0x10(%rax),%rdx
  bc:	mov    (%rax),%rcx
  bf:	cmp    %rdx,%rcx
  c2:	jne    28b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x266>
  c8:	vmovdqu 0x10(%rax),%xmm7
  cd:	vmovdqa %xmm7,0x30(%rsp)
  d3:	mov    0x8(%rax),%rcx
  d7:	movb   $0x0,0x10(%rax)
  db:	mov    %rcx,0x28(%rsp)
  e0:	mov    %rdx,(%rax)
  e3:	movq   $0x0,0x8(%rax)
  eb:	lea    0x40(%rsp),%r15
  f0:	lea    0x20(%rsp),%rsi
  f5:	lea    0x0(%rip),%rdx        # fc <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xd7>
  fc:	mov    %r15,%rdi
  ff:	call   104 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xdf>
 104:	lea    0x80(%rsp),%r12
 10c:	mov    %rbx,%rdx
 10f:	mov    %r15,%rsi
 112:	mov    %r12,%rdi
 115:	call   11a <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xf5>
 11a:	lea    0xa0(%rsp),%r15
 122:	lea    0x0(%rip),%rdx        # 129 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x104>
 129:	mov    %r12,%rsi
 12c:	mov    %r15,%rdi
 12f:	call   134 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x10f>
 134:	lea    0xe0(%rsp),%r12
 13c:	mov    %r14,%rdx
 13f:	mov    %r15,%rsi
 142:	mov    %r12,%rdi
 145:	call   14a <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x125>
 14a:	mov    %r12,%rsi
 14d:	mov    %r13,%rdi
 150:	call   155 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x130>
 155:	mov    0xe0(%rsp),%rdi
 15d:	lea    0xf0(%rsp),%rax
 165:	cmp    %rax,%rdi
 168:	je     17b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x156>
 16a:	mov    0xf0(%rsp),%rax
 172:	lea    0x1(%rax),%rsi
 176:	call   17b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x156>
 17b:	mov    0xa0(%rsp),%rdi
 183:	lea    0xb0(%rsp),%rax
 18b:	cmp    %rax,%rdi
 18e:	je     1a1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x17c>
 190:	mov    0xb0(%rsp),%rax
 198:	lea    0x1(%rax),%rsi
 19c:	call   1a1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x17c>
 1a1:	mov    0x80(%rsp),%rdi
 1a9:	lea    0x90(%rsp),%rax
 1b1:	cmp    %rax,%rdi
 1b4:	je     1c7 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a2>
 1b6:	mov    0x90(%rsp),%rax
 1be:	lea    0x1(%rax),%rsi
 1c2:	call   1c7 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a2>
 1c7:	mov    0x40(%rsp),%rdi
 1cc:	lea    0x50(%rsp),%rax
 1d1:	cmp    %rax,%rdi
 1d4:	je     1e4 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1bf>
 1d6:	mov    0x50(%rsp),%rax
 1db:	lea    0x1(%rax),%rsi
 1df:	call   1e4 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1bf>
 1e4:	mov    0x20(%rsp),%rdi
 1e9:	cmp    %rbp,%rdi
 1ec:	je     1fc <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d7>
 1ee:	mov    0x30(%rsp),%rax
 1f3:	lea    0x1(%rax),%rsi
 1f7:	call   1fc <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d7>
 1fc:	mov    (%rsp),%rdi
 200:	lea    0x10(%rsp),%rax
 205:	cmp    %rax,%rdi
 208:	je     218 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1f3>
 20a:	mov    0x10(%rsp),%rax
 20f:	lea    0x1(%rax),%rsi
 213:	call   218 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1f3>
 218:	mov    0x60(%rsp),%rdi
 21d:	lea    0x70(%rsp),%rax
 222:	cmp    %rax,%rdi
 225:	je     235 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x210>
 227:	mov    0x70(%rsp),%rax
 22c:	lea    0x1(%rax),%rsi
 230:	call   235 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x210>
 235:	mov    0xc0(%rsp),%rdi
 23d:	lea    0xd0(%rsp),%rax
 245:	cmp    %rax,%rdi
 248:	je     25b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x236>
 24a:	mov    0xd0(%rsp),%rax
 252:	lea    0x1(%rax),%rsi
 256:	call   25b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x236>
 25b:	mov    0x0(%rip),%rdx        # 262 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x23d>
 262:	lea    0x0(%rip),%rsi        # 269 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x244>
 269:	mov    %r13,%rdi
 26c:	call   271 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x24c>
 271:	endbr64 
 275:	mov    %rax,%r12
 278:	mov    %rbp,%rdi
 27b:	vzeroupper 
 27e:	call   283 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x25e>
 283:	mov    %r12,%rdi
 286:	call   28b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x266>
 28b:	mov    %rcx,0x20(%rsp)
 290:	mov    0x10(%rax),%rcx
 294:	mov    %rcx,0x30(%rsp)
 299:	jmp    d3 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xae>
 29e:	endbr64 
 2a2:	mov    %rax,%rbx
 2a5:	vzeroupper 
 2a8:	mov    (%rsp),%rdi
 2ac:	lea    0x10(%rsp),%rax
 2b1:	cmp    %rax,%rdi
 2b4:	je     2c4 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x29f>
 2b6:	mov    0x10(%rsp),%rax
 2bb:	lea    0x1(%rax),%rsi
 2bf:	call   2c4 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x29f>
 2c4:	mov    0x60(%rsp),%rdi
 2c9:	lea    0x70(%rsp),%rax
 2ce:	cmp    %rax,%rdi
 2d1:	je     2e1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2bc>
 2d3:	mov    0x70(%rsp),%rax
 2d8:	lea    0x1(%rax),%rsi
 2dc:	call   2e1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2bc>
 2e1:	mov    0xc0(%rsp),%rdi
 2e9:	lea    0xd0(%rsp),%rax
 2f1:	cmp    %rax,%rdi
 2f4:	je     307 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2e2>
 2f6:	mov    0xd0(%rsp),%rax
 2fe:	lea    0x1(%rax),%rsi
 302:	call   307 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2e2>
 307:	mov    %r13,%rdi
 30a:	call   30f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2ea>
 30f:	mov    %rbx,%rdi
 312:	call   317 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2f2>
 317:	endbr64 
 31b:	mov    %rax,%rbx
 31e:	vzeroupper 
 321:	jmp    2e1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2bc>
 323:	endbr64 
 327:	mov    %rax,%rbx
 32a:	vzeroupper 
 32d:	jmp    307 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2e2>
 32f:	endbr64 
 333:	mov    %rax,%rbx
 336:	vzeroupper 
 339:	jmp    2c4 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x29f>
 33b:	endbr64 
 33f:	mov    0xe0(%rsp),%rdi
 347:	mov    %rax,%rbx
 34a:	lea    0xf0(%rsp),%rax
 352:	cmp    %rax,%rdi
 355:	je     3f9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3d4>
 35b:	mov    0xf0(%rsp),%rax
 363:	lea    0x1(%rax),%rsi
 367:	vzeroupper 
 36a:	call   36f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x34a>
 36f:	mov    0xa0(%rsp),%rdi
 377:	lea    0xb0(%rsp),%rax
 37f:	cmp    %rax,%rdi
 382:	je     395 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x370>
 384:	mov    0xb0(%rsp),%rax
 38c:	lea    0x1(%rax),%rsi
 390:	call   395 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x370>
 395:	mov    0x80(%rsp),%rdi
 39d:	lea    0x90(%rsp),%rax
 3a5:	cmp    %rax,%rdi
 3a8:	je     3bb <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x396>
 3aa:	mov    0x90(%rsp),%rax
 3b2:	lea    0x1(%rax),%rsi
 3b6:	call   3bb <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x396>
 3bb:	mov    0x40(%rsp),%rdi
 3c0:	lea    0x50(%rsp),%rax
 3c5:	cmp    %rax,%rdi
 3c8:	je     3d8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3b3>
 3ca:	mov    0x50(%rsp),%rax
 3cf:	lea    0x1(%rax),%rsi
 3d3:	call   3d8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3b3>
 3d8:	mov    0x20(%rsp),%rdi
 3dd:	cmp    %rbp,%rdi
 3e0:	je     2a8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x283>
 3e6:	mov    0x30(%rsp),%rax
 3eb:	lea    0x1(%rax),%rsi
 3ef:	call   3f4 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3cf>
 3f4:	jmp    2a8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x283>
 3f9:	vzeroupper 
 3fc:	jmp    36f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x34a>
 401:	endbr64 
 405:	mov    %rax,%rbx
 408:	vzeroupper 
 40b:	jmp    36f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x34a>
 410:	endbr64 
 414:	mov    %rax,%rbx
 417:	vzeroupper 
 41a:	jmp    395 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x370>
 41f:	endbr64 
 423:	mov    %rax,%rbx
 426:	vzeroupper 
 429:	jmp    3bb <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x396>
 42b:	endbr64 
 42f:	mov    %rax,%rbx
 432:	vzeroupper 
 435:	jmp    3d8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3b3>

0000000000000437 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]>:
 437:	sub    %r12,%r14
 43a:	mov    %r14,%rsi
 43d:	mov    %r12,%rdi
 440:	vzeroupper 
 443:	call   448 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x11>
 448:	mov    %r13,%rdi
 44b:	call   450 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x19>
 450:	sub    %r12,%r14
 453:	test   %r12,%r12
 456:	jne    43a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x3>
 458:	vzeroupper 
 45b:	jmp    448 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x11>

000000000000045d <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>:
 45d:	mov    0x28(%rsp),%rdi
 462:	mov    0x38(%rsp),%rsi
 467:	sub    %rdi,%rsi
 46a:	test   %rdi,%rdi
 46d:	je     47f <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x22>
 46f:	vzeroupper 
 472:	call   477 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x1a>
 477:	mov    %rbp,%rdi
 47a:	call   47f <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x22>
 47f:	vzeroupper 
 482:	jmp    477 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x1a>

0000000000000484 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>:
 484:	mov    0x68(%rsp),%rdi
 489:	mov    0x78(%rsp),%rsi
 48e:	sub    %rdi,%rsi
 491:	test   %rdi,%rdi
 494:	je     4bd <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x39>
 496:	vzeroupper 
 499:	call   49e <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x1a>
 49e:	mov    0x40(%rsp),%rdi
 4a3:	mov    0x50(%rsp),%rsi
 4a8:	sub    %rdi,%rsi
 4ab:	test   %rdi,%rdi
 4ae:	je     4b5 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x31>
 4b0:	call   4b5 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x31>
 4b5:	mov    %rbp,%rdi
 4b8:	call   4bd <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x39>
 4bd:	vzeroupper 
 4c0:	jmp    49e <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x1a>

Disassembly of section .text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_:

0000000000000000 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)>:
   0:	endbr64 
   4:	push   %r13
   6:	mov    %rdx,%r13
   9:	push   %r12
   b:	mov    %rdi,%r12
   e:	mov    %rdx,%rdi
  11:	push   %rbp
  12:	mov    %rsi,%rbp
  15:	call   1a <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x1a>
  1a:	mov    %rax,%rdx
  1d:	movabs $0x3fffffffffffffff,%rax
  27:	sub    0x8(%rbp),%rax
  2b:	cmp    %rax,%rdx
  2e:	ja     8e <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x8e>
  30:	mov    %r13,%rsi
  33:	mov    %rbp,%rdi
  36:	call   3b <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x3b>
  3b:	lea    0x10(%r12),%rdx
  40:	mov    %rdx,(%r12)
  44:	lea    0x10(%rax),%rdx
  48:	mov    (%rax),%rcx
  4b:	cmp    %rdx,%rcx
  4e:	je     80 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x80>
  50:	mov    %rcx,(%r12)
  54:	mov    0x10(%rax),%rcx
  58:	mov    %rcx,0x10(%r12)
  5d:	mov    0x8(%rax),%rcx
  61:	mov    %rdx,(%rax)
  64:	movq   $0x0,0x8(%rax)
  6c:	mov    %rcx,0x8(%r12)
  71:	movb   $0x0,0x10(%rax)
  75:	mov    %r12,%rax
  78:	pop    %rbp
  79:	pop    %r12
  7b:	pop    %r13
  7d:	ret    
  7e:	xchg   %ax,%ax
  80:	vmovdqu 0x10(%rax),%xmm0
  85:	vmovdqu %xmm0,0x10(%r12)
  8c:	jmp    5d <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x5d>
  8e:	lea    0x0(%rip),%rdi        # 95 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x95>
  95:	call   9a <ivf::TopK::TopK(unsigned long)+0x5a>

Disassembly of section .text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S9_:

0000000000000000 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)>:
   0:	endbr64 
   4:	push   %r12
   6:	mov    %rdx,%r9
   9:	mov    %rdi,%r12
   c:	mov    0x8(%rsi),%r8
  10:	mov    0x8(%rdx),%rdx
  14:	mov    (%rsi),%rcx
  17:	mov    %rsi,%rdi
  1a:	add    $0x10,%rsi
  1e:	lea    (%r8,%rdx,1),%rax
  22:	cmp    %rsi,%rcx
  25:	je     e0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0xe0>
  2b:	mov    0x10(%rdi),%r10
  2f:	mov    (%r9),%rsi
  32:	cmp    %r10,%rax
  35:	jbe    4d <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x4d>
  37:	lea    0x10(%r9),%r10
  3b:	cmp    %r10,%rsi
  3e:	je     f0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0xf0>
  44:	mov    0x10(%r9),%r10
  48:	cmp    %r10,%rax
  4b:	jbe    98 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x98>
  4d:	call   52 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x52>
  52:	lea    0x10(%r12),%rdx
  57:	mov    %rdx,(%r12)
  5b:	lea    0x10(%rax),%rdx
  5f:	mov    (%rax),%rcx
  62:	cmp    %rdx,%rcx
  65:	je     d0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0xd0>
  67:	mov    %rcx,(%r12)
  6b:	mov    0x10(%rax),%rcx
  6f:	mov    %rcx,0x10(%r12)
  74:	mov    0x8(%rax),%rcx
  78:	mov    %rcx,0x8(%r12)
  7d:	mov    %rdx,(%rax)
  80:	movq   $0x0,0x8(%rax)
  88:	movb   $0x0,0x10(%rax)
  8c:	mov    %r12,%rax
  8f:	pop    %r12
  91:	ret    
  92:	nopw   0x0(%rax,%rax,1)
  98:	xor    %edx,%edx
  9a:	xor    %esi,%esi
  9c:	mov    %r9,%rdi
  9f:	call   a4 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0xa4>
  a4:	lea    0x10(%r12),%rdx
  a9:	mov    %rdx,(%r12)
  ad:	lea    0x10(%rax),%rdx
  b1:	mov    (%rax),%rcx
  b4:	cmp    %rdx,%rcx
  b7:	jne    67 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x67>
  b9:	vmovdqu 0x10(%rax),%xmm1
  be:	vmovdqu %xmm1,0x10(%r12)
  c5:	jmp    74 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x74>
  c7:	nopw   0x0(%rax,%rax,1)
  d0:	vmovdqu 0x10(%rax),%xmm0
  d5:	vmovdqu %xmm0,0x10(%r12)
  dc:	jmp    74 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x74>
  de:	xchg   %ax,%ax
  e0:	mov    $0xf,%r10d
  e6:	jmp    2f <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x2f>
  eb:	nopl   0x0(%rax,%rax,1)
  f0:	mov    $0xf,%r10d
  f6:	jmp    48 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x48>

Disassembly of section .text._ZNSt6vectorIN3ivf8NeighborESaIS1_EE17_M_realloc_insertIJRKS1_EEEvN9__gnu_cxx17__normal_iteratorIPS1_S3_EEDpOT_:

0000000000000000 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)>:
   0:	endbr64 
   4:	push   %r15
   6:	movabs $0x7ffffffffffffff,%rcx
  10:	push   %r14
  12:	push   %r13
  14:	push   %r12
  16:	push   %rbp
  17:	push   %rbx
  18:	sub    $0x28,%rsp
  1c:	mov    0x8(%rdi),%r14
  20:	mov    (%rdi),%r12
  23:	mov    %r14,%rax
  26:	sub    %r12,%rax
  29:	sar    $0x4,%rax
  2d:	cmp    %rcx,%rax
  30:	je     15d <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x15d>
  36:	test   %rax,%rax
  39:	mov    $0x1,%ecx
  3e:	cmovne %rax,%rcx
  42:	mov    %rsi,%rbp
  45:	add    %rcx,%rax
  48:	setb   %cl
  4b:	movzbl %cl,%ecx
  4e:	mov    %rdi,%r13
  51:	sub    %r12,%rsi
  54:	test   %rcx,%rcx
  57:	jne    110 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x110>
  5d:	test   %rax,%rax
  60:	jne    143 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x143>
  66:	mov    $0x10,%ecx
  6b:	xor    %ebx,%ebx
  6d:	xor    %r15d,%r15d
  70:	vmovdqu (%rdx),%xmm3
  74:	vmovdqu %xmm3,(%r15,%rsi,1)
  7a:	cmp    %r12,%rbp
  7d:	je     aa <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xaa>
  7f:	mov    %rbp,%rcx
  82:	sub    %r12,%rcx
  85:	mov    %r15,%rdx
  88:	mov    %r12,%rax
  8b:	nopl   0x0(%rax,%rax,1)
  90:	vmovdqu (%rax),%xmm2
  94:	add    $0x10,%rax
  98:	vmovdqu %xmm2,(%rdx)
  9c:	add    $0x10,%rdx
  a0:	cmp    %rbp,%rax
  a3:	jne    90 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x90>
  a5:	lea    0x10(%r15,%rcx,1),%rcx
  aa:	cmp    %r14,%rbp
  ad:	je     c6 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xc6>
  af:	sub    %rbp,%r14
  b2:	mov    %rcx,%rdi
  b5:	mov    %r14,%rdx
  b8:	mov    %rbp,%rsi
  bb:	call   c0 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xc0>
  c0:	mov    %rax,%rcx
  c3:	add    %r14,%rcx
  c6:	vmovq  %r15,%xmm1
  cb:	vpinsrq $0x1,%rcx,%xmm1,%xmm0
  d1:	test   %r12,%r12
  d4:	je     ef <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xef>
  d6:	mov    0x10(%r13),%rsi
  da:	mov    %r12,%rdi
  dd:	sub    %r12,%rsi
  e0:	vmovdqa %xmm0,(%rsp)
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
 11d:	mov    %rdx,0x18(%rsp)
 122:	mov    %rsi,(%rsp)
 126:	call   12b <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x12b>
 12b:	mov    %rax,%r15
 12e:	mov    (%rsp),%rsi
 132:	mov    0x18(%rsp),%rdx
 137:	add    %rax,%rbx
 13a:	lea    0x10(%rax),%rcx
 13e:	jmp    70 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x70>
 143:	movabs $0x7ffffffffffffff,%rcx
 14d:	cmp    %rcx,%rax
 150:	cmova  %rcx,%rax
 154:	shl    $0x4,%rax
 158:	mov    %rax,%rbx
 15b:	jmp    11a <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x11a>
 15d:	lea    0x0(%rip),%rdi        # 164 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x164>
 164:	call   169 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x9>

Disassembly of section .text._ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPN3ivf8NeighborESt6vectorIS3_SaIS3_EEEElS3_NS0_5__ops15_Iter_comp_iterIPFbRKS3_SC_EEEEvT_T0_SH_T1_T2_:

0000000000000000 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)>:
   0:	endbr64 
   4:	push   %r15
   6:	push   %r14
   8:	push   %r13
   a:	push   %r12
   c:	push   %rbp
   d:	mov    %rdi,%rbp
  10:	push   %rbx
  11:	sub    $0x68,%rsp
  15:	mov    %rcx,0x28(%rsp)
  1a:	mov    %rsi,0x10(%rsp)
  1f:	mov    %rdx,0x38(%rsp)
  24:	mov    %r8,0x8(%rsp)
  29:	vmovsd %xmm0,0x30(%rsp)
  2f:	mov    %rdx,%rcx
  32:	mov    %fs:0x28,%rax
  3b:	mov    %rax,0x58(%rsp)
  40:	xor    %eax,%eax
  42:	lea    -0x1(%rdx),%rax
  46:	mov    %rax,%r12
  49:	shr    $0x3f,%r12
  4d:	add    %rax,%r12
  50:	mov    %r12,%rax
  53:	sar    %rax
  56:	and    $0x1,%ecx
  59:	mov    %rax,0x18(%rsp)
  5e:	mov    %rcx,0x20(%rsp)
  63:	cmp    %rax,%rsi
  66:	jge    1b0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1b0>
  6c:	mov    %rsi,%r12
  6f:	jmp    96 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x96>
  71:	nopl   0x0(%rax)
  78:	vmovdqu 0x0(%r13),%xmm2
  7e:	vmovdqu %xmm2,0x0(%rbp,%r8,1)
  85:	cmp    0x18(%rsp),%r14
  8a:	jge    220 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x220>
  90:	mov    %r14,%rbx
  93:	mov    %rbx,%r12
  96:	lea    0x1(%r12),%rax
  9b:	lea    (%rax,%rax,1),%r14
  9f:	lea    -0x1(%r14),%rbx
  a3:	mov    %rbx,%rdx
  a6:	shl    $0x4,%rdx
  aa:	shl    $0x5,%rax
  ae:	lea    0x0(%rbp,%rdx,1),%r15
  b3:	lea    0x0(%rbp,%rax,1),%r13
  b8:	mov    0x8(%rsp),%rax
  bd:	mov    %r15,%rsi
  c0:	mov    %r13,%rdi
  c3:	call   *%rax
  c5:	mov    %r12,%r8
  c8:	shl    $0x4,%r8
  cc:	test   %al,%al
  ce:	je     78 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x78>
  d0:	vmovdqu (%r15),%xmm3
  d5:	vmovdqu %xmm3,0x0(%rbp,%r8,1)
  dc:	cmp    0x18(%rsp),%rbx
  e1:	jl     93 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x93>
  e3:	cmpq   $0x0,0x20(%rsp)
  e9:	je     1d0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1d0>
  ef:	mov    0x30(%rsp),%rax
  f4:	mov    %rax,0x40(%rsp)
  f9:	mov    0x28(%rsp),%rax
  fe:	mov    %rax,0x48(%rsp)
 103:	lea    -0x1(%rbx),%rax
 107:	mov    %rax,%r14
 10a:	shr    $0x3f,%r14
 10e:	add    %rax,%r14
 111:	sar    %r14
 114:	cmp    0x10(%rsp),%rbx
 119:	jle    179 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x179>
 11b:	lea    0x40(%rsp),%r12
 120:	jmp    155 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x155>
 122:	nopw   0x0(%rax,%rax,1)
 128:	lea    -0x1(%r14),%rdx
 12c:	mov    %rdx,%rax
 12f:	vmovdqu 0x0(%r13),%xmm1
 135:	shr    $0x3f,%rax
 139:	add    %rdx,%rax
 13c:	vmovdqu %xmm1,(%r15)
 141:	sar    %rax
 144:	mov    %r14,%rbx
 147:	cmp    %r14,0x10(%rsp)
 14c:	jge    210 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x210>
 152:	mov    %rax,%r14
 155:	mov    %r14,%r13
 158:	shl    $0x4,%r13
 15c:	mov    0x8(%rsp),%rax
 161:	add    %rbp,%r13
 164:	mov    %r12,%rsi
 167:	mov    %r13,%rdi
 16a:	shl    $0x4,%rbx
 16e:	call   *%rax
 170:	lea    0x0(%rbp,%rbx,1),%r15
 175:	test   %al,%al
 177:	jne    128 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x128>
 179:	vmovdqa 0x40(%rsp),%xmm4
 17f:	vmovdqu %xmm4,(%r15)
 184:	mov    0x58(%rsp),%rax
 189:	sub    %fs:0x28,%rax
 192:	jne    24d <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x24d>
 198:	add    $0x68,%rsp
 19c:	pop    %rbx
 19d:	pop    %rbp
 19e:	pop    %r12
 1a0:	pop    %r13
 1a2:	pop    %r14
 1a4:	pop    %r15
 1a6:	ret    
 1a7:	nopw   0x0(%rax,%rax,1)
 1b0:	mov    %rsi,%rdx
 1b3:	shl    $0x4,%rdx
 1b7:	cmpq   $0x0,0x20(%rsp)
 1bd:	lea    (%rdi,%rdx,1),%r15
 1c1:	jne    234 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x234>
 1c3:	mov    %rsi,%rbx
 1c6:	cs nopw 0x0(%rax,%rax,1)
 1d0:	mov    0x38(%rsp),%r13
 1d5:	sub    $0x2,%r13
 1d9:	mov    %r13,%rax
 1dc:	shr    $0x3f,%rax
 1e0:	add    %r13,%rax
 1e3:	sar    %rax
 1e6:	cmp    %rbx,%rax
 1e9:	jne    ef <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xef>
 1ef:	lea    0x1(%rbx,%rbx,1),%rbx
 1f4:	mov    %rbx,%rax
 1f7:	shl    $0x4,%rax
 1fb:	add    %rbp,%rax
 1fe:	vmovdqu (%rax),%xmm5
 202:	vmovdqu %xmm5,(%r15)
 207:	mov    %rax,%r15
 20a:	jmp    ef <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xef>
 20f:	nop
 210:	mov    %r13,%r15
 213:	jmp    179 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x179>
 218:	nopl   0x0(%rax,%rax,1)
 220:	cmpq   $0x0,0x20(%rsp)
 226:	mov    %r13,%r15
 229:	mov    %r14,%rbx
 22c:	jne    ef <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xef>
 232:	jmp    1d0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1d0>
 234:	mov    0x30(%rsp),%rax
 239:	mov    %rax,0x40(%rsp)
 23e:	mov    0x28(%rsp),%rax
 243:	mov    %rax,0x48(%rsp)
 248:	jmp    179 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x179>
 24d:	call   252 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf2>
