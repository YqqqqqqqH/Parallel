
results/server/vec/ivf_search_default.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <ivf::better(ivf::Neighbor const&, ivf::Neighbor const&)>:
       0:	endbr64 
       4:	movsd  (%rdi),%xmm1
       8:	movsd  (%rsi),%xmm0
       c:	mov    $0x1,%eax
      11:	comisd %xmm1,%xmm0
      15:	ja     32 <ivf::better(ivf::Neighbor const&, ivf::Neighbor const&)+0x32>
      17:	ucomisd %xmm0,%xmm1
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
      49:	pxor   %xmm0,%xmm0
      4d:	push   %rbp
      4e:	push   %rbx
      4f:	mov    %rdi,%rbx
      52:	sub    $0x10,%rsp
      56:	shr    $0x3b,%rax
      5a:	mov    %rsi,(%rdi)
      5d:	movq   $0x0,0x18(%rdi)
      65:	movups %xmm0,0x8(%rdi)
      69:	jne    e3 <ivf::TopK::TopK(unsigned long)+0xa3>
      6b:	test   %rsi,%rsi
      6e:	je     da <ivf::TopK::TopK(unsigned long)+0x9a>
      70:	shl    $0x4,%rsi
      74:	mov    %rsi,%rdi
      77:	mov    %rsi,%rbp
      7a:	call   7f <ivf::TopK::TopK(unsigned long)+0x3f>
      7f:	mov    0x10(%rbx),%rsi
      83:	mov    0x8(%rbx),%rdi
      87:	movq   %rax,%xmm0
      8c:	mov    %rax,%r12
      8f:	punpcklqdq %xmm0,%xmm0
      93:	cmp    %rdi,%rsi
      96:	je     b5 <ivf::TopK::TopK(unsigned long)+0x75>
      98:	mov    %rax,%rcx
      9b:	mov    %rdi,%rdx
      9e:	xchg   %ax,%ax
      a0:	movdqu (%rdx),%xmm1
      a4:	add    $0x10,%rdx
      a8:	add    $0x10,%rcx
      ac:	movups %xmm1,-0x10(%rcx)
      b0:	cmp    %rdx,%rsi
      b3:	jne    a0 <ivf::TopK::TopK(unsigned long)+0x60>
      b5:	test   %rdi,%rdi
      b8:	je     cf <ivf::TopK::TopK(unsigned long)+0x8f>
      ba:	mov    0x18(%rbx),%rsi
      be:	movaps %xmm0,(%rsp)
      c2:	sub    %rdi,%rsi
      c5:	call   ca <ivf::TopK::TopK(unsigned long)+0x8a>
      ca:	movdqa (%rsp),%xmm0
      cf:	add    %rbp,%r12
      d2:	movups %xmm0,0x8(%rbx)
      d6:	mov    %r12,0x18(%rbx)
      da:	add    $0x10,%rsp
      de:	pop    %rbx
      df:	pop    %rbp
      e0:	pop    %r12
      e2:	ret    
      e3:	lea    0x0(%rip),%rdi        # ea <ivf::TopK::TopK(unsigned long)+0xaa>
      ea:	call   ef <ivf::TopK::TopK(unsigned long)+0xaf>
      ef:	endbr64 
      f3:	mov    %rax,%rbp
      f6:	jmp    fb <ivf::TopK::TopK(unsigned long)+0xbb>
      fb:	nopl   0x0(%rax,%rax,1)

0000000000000100 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)>:
     100:	endbr64 
     104:	test   %rdx,%rdx
     107:	je     140 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)+0x40>
     109:	xor    %eax,%eax
     10b:	pxor   %xmm1,%xmm1
     10f:	nop
     110:	pxor   %xmm0,%xmm0
     114:	pxor   %xmm2,%xmm2
     118:	cvtss2sd (%rdi,%rax,4),%xmm0
     11d:	cvtss2sd (%rsi,%rax,4),%xmm2
     122:	subsd  %xmm2,%xmm0
     126:	add    $0x1,%rax
     12a:	mulsd  %xmm0,%xmm0
     12e:	addsd  %xmm0,%xmm1
     132:	cmp    %rax,%rdx
     135:	jne    110 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)+0x10>
     137:	movapd %xmm1,%xmm0
     13b:	ret    
     13c:	nopl   0x0(%rax)
     140:	pxor   %xmm1,%xmm1
     144:	movapd %xmm1,%xmm0
     148:	ret    
     149:	nopl   0x0(%rax)

0000000000000150 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)>:
     150:	endbr64 
     154:	push   %r15
     156:	push   %r14
     158:	mov    %rcx,%r14
     15b:	push   %r13
     15d:	push   %r12
     15f:	push   %rbp
     160:	push   %rbx
     161:	mov    %rdx,-0x20(%rsp)
     166:	test   %rdx,%rdx
     169:	je     363 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x213>
     16f:	lea    0x0(,%rcx,4),%rax
     177:	mov    %rdi,%r12
     17a:	xor    %r13d,%r13d
     17d:	xor    %ebp,%ebp
     17f:	mov    0x10(%rsi),%rcx
     183:	mov    %rax,%rbx
     186:	mov    0x8(%rsi),%r15
     18a:	xor    %r8d,%r8d
     18d:	sar    $0x2,%rbx
     191:	lea    (%rcx,%rax,1),%r9
     195:	mov    %rbx,-0x8(%rsp)
     19a:	mov    %rax,%rbx
     19d:	and    $0xfffffffffffffff0,%rax
     1a1:	mov    %rax,-0x18(%rsp)
     1a6:	sar    $0x4,%rbx
     1aa:	add    %rax,%rcx
     1ad:	mov    %r14,%rax
     1b0:	shl    $0x4,%rax
     1b4:	shl    $0x2,%r15
     1b8:	mov    %rax,-0x10(%rsp)
     1bd:	nopl   (%rax)
     1c0:	mov    %rcx,%r11
     1c3:	sub    -0x18(%rsp),%r11
     1c8:	test   %r14,%r14
     1cb:	je     241 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf1>
     1cd:	mov    (%r12),%rdi
     1d1:	mov    %r13,%rax
     1d4:	shl    $0x4,%rax
     1d8:	lea    (%rdi,%rax,1),%rsi
     1dc:	add    -0x10(%rsp),%rdi
     1e1:	add    %rax,%rdi
     1e4:	nopl   0x0(%rax)
     1e8:	mov    0x8(%rsi),%edx
     1eb:	cmp    $0xffffffff,%edx
     1ee:	je     238 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe8>
     1f0:	test   %rbx,%rbx
     1f3:	jle    312 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1c2>
     1f9:	mov    %r11,%rax
     1fc:	jmp    228 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xd8>
     1fe:	xchg   %ax,%ax
     200:	cmp    0x4(%rax),%edx
     203:	je     298 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x148>
     209:	cmp    0x8(%rax),%edx
     20c:	je     2a0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x150>
     212:	cmp    0xc(%rax),%edx
     215:	je     2b0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x160>
     21b:	add    $0x10,%rax
     21f:	cmp    %rcx,%rax
     222:	je     2c0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x170>
     228:	cmp    (%rax),%edx
     22a:	jne    200 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xb0>
     22c:	cmp    %r9,%rax
     22f:	setne  %al
     232:	movzbl %al,%eax
     235:	add    %rax,%r8
     238:	add    $0x10,%rsi
     23c:	cmp    %rdi,%rsi
     23f:	jne    1e8 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x98>
     241:	add    $0x1,%rbp
     245:	add    %r15,%r9
     248:	add    %r14,%r13
     24b:	add    %r15,%rcx
     24e:	cmp    %rbp,-0x20(%rsp)
     253:	jne    1c0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x70>
     259:	test   %r8,%r8
     25c:	js     344 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1f4>
     262:	pxor   %xmm0,%xmm0
     266:	cvtsi2sd %r8,%xmm0
     26b:	mov    -0x20(%rsp),%rax
     270:	imul   %r14,%rax
     274:	test   %rax,%rax
     277:	js     31c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1cc>
     27d:	pxor   %xmm1,%xmm1
     281:	pop    %rbx
     282:	pop    %rbp
     283:	cvtsi2sd %rax,%xmm1
     288:	pop    %r12
     28a:	pop    %r13
     28c:	pop    %r14
     28e:	pop    %r15
     290:	divsd  %xmm1,%xmm0
     294:	ret    
     295:	nopl   (%rax)
     298:	add    $0x4,%rax
     29c:	jmp    22c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xdc>
     29e:	xchg   %ax,%ax
     2a0:	add    $0x8,%rax
     2a4:	jmp    22c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xdc>
     2a6:	cs nopw 0x0(%rax,%rax,1)
     2b0:	add    $0xc,%rax
     2b4:	jmp    22c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xdc>
     2b9:	nopl   0x0(%rax)
     2c0:	mov    %r9,%r10
     2c3:	sub    %rax,%r10
     2c6:	sar    $0x2,%r10
     2ca:	cmp    $0x2,%r10
     2ce:	je     2f9 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1a9>
     2d0:	cmp    $0x3,%r10
     2d4:	je     2ed <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x19d>
     2d6:	cmp    $0x1,%r10
     2da:	jne    238 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe8>
     2e0:	cmp    (%rax),%edx
     2e2:	jne    238 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe8>
     2e8:	jmp    22c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xdc>
     2ed:	cmp    (%rax),%edx
     2ef:	je     22c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xdc>
     2f5:	add    $0x4,%rax
     2f9:	cmp    (%rax),%edx
     2fb:	je     22c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xdc>
     301:	add    $0x4,%rax
     305:	cmp    (%rax),%edx
     307:	jne    238 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe8>
     30d:	jmp    22c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xdc>
     312:	mov    -0x8(%rsp),%r10
     317:	mov    %r11,%rax
     31a:	jmp    2ca <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x17a>
     31c:	mov    %rax,%rdx
     31f:	and    $0x1,%eax
     322:	pxor   %xmm1,%xmm1
     326:	pop    %rbx
     327:	shr    %rdx
     32a:	pop    %rbp
     32b:	pop    %r12
     32d:	or     %rax,%rdx
     330:	pop    %r13
     332:	pop    %r14
     334:	cvtsi2sd %rdx,%xmm1
     339:	pop    %r15
     33b:	addsd  %xmm1,%xmm1
     33f:	divsd  %xmm1,%xmm0
     343:	ret    
     344:	mov    %r8,%rax
     347:	and    $0x1,%r8d
     34b:	pxor   %xmm0,%xmm0
     34f:	shr    %rax
     352:	or     %r8,%rax
     355:	cvtsi2sd %rax,%xmm0
     35a:	addsd  %xmm0,%xmm0
     35e:	jmp    26b <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x11b>
     363:	pxor   %xmm0,%xmm0
     367:	jmp    26b <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x11b>
     36c:	nopl   0x0(%rax)

0000000000000370 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)>:
     370:	endbr64 
     374:	push   %r15
     376:	push   %r14
     378:	push   %r13
     37a:	push   %r12
     37c:	push   %rbp
     37d:	push   %rbx
     37e:	sub    $0x118,%rsp
     385:	mov    (%rdi),%rbx
     388:	mov    (%rsi),%rbp
     38b:	mov    %fs:0x28,%rax
     394:	mov    %rax,0x108(%rsp)
     39c:	xor    %eax,%eax
     39e:	mov    0x8(%rdi),%rax
     3a2:	mov    0x8(%rsi),%rcx
     3a6:	sub    %rbx,%rax
     3a9:	sub    %rbp,%rcx
     3ac:	mov    %rax,%rdx
     3af:	sar    $0x4,%rdx
     3b3:	cmp    %rcx,%rax
     3b6:	jne    3bc <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x4c>
     3bc:	xor    %r12d,%r12d
     3bf:	test   %rdx,%rdx
     3c2:	je     478 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x108>
     3c8:	movq   0x0(%rip),%xmm2        # 3d0 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x60>
     3d0:	movsd  0x0(%rip),%xmm4        # 3d8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x68>
     3d8:	xor    %ecx,%ecx
     3da:	movsd  0x0(%rip),%xmm5        # 3e2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x72>
     3e2:	movsd  0x0(%rip),%xmm6        # 3ea <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x7a>
     3ea:	jmp    443 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xd3>
     3ec:	nopl   0x0(%rax)
     3f0:	movapd %xmm0,%xmm1
     3f4:	andpd  %xmm2,%xmm1
     3f8:	ucomisd %xmm1,%xmm4
     3fc:	jb     402 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x92>
     402:	movsd  0x0(%rbp),%xmm3
     407:	movapd %xmm3,%xmm1
     40b:	subsd  %xmm3,%xmm0
     40f:	andpd  %xmm2,%xmm1
     413:	mulsd  %xmm5,%xmm1
     417:	andpd  %xmm2,%xmm0
     41b:	addsd  %xmm5,%xmm1
     41f:	comisd %xmm0,%xmm1
     423:	jb     429 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xb9>
     429:	cmp    0x8(%rbx),%eax
     42c:	jne    432 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xc2>
     432:	add    $0x1,%r12
     436:	add    $0x10,%rbp
     43a:	add    $0x10,%rbx
     43e:	cmp    %rdx,%r12
     441:	je     478 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x108>
     443:	mov    0x8(%rbp),%eax
     446:	movsd  (%rbx),%xmm0
     44a:	cmp    $0xffffffff,%eax
     44d:	jne    3f0 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x80>
     44f:	cmpl   $0xffffffff,0x8(%rbx)
     453:	jne    459 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xe9>
     459:	ucomisd 0x0(%rip),%xmm0        # 461 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xf1>
     461:	setnp  %al
     464:	ucomisd %xmm6,%xmm0
     468:	cmovne %ecx,%eax
     46b:	test   %al,%al
     46d:	jne    432 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xc2>
     46f:	jmp    474 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x104>
     474:	nopl   0x0(%rax)
     478:	mov    0x108(%rsp),%rax
     480:	sub    %fs:0x28,%rax
     489:	jne    49d <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x12d>
     48b:	add    $0x118,%rsp
     492:	pop    %rbx
     493:	pop    %rbp
     494:	pop    %r12
     496:	pop    %r13
     498:	pop    %r14
     49a:	pop    %r15
     49c:	ret    
     49d:	call   4a2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x132>
     4a2:	data16 cs nopw 0x0(%rax,%rax,1)
     4ad:	nopl   (%rax)

00000000000004b0 <ivf::TopK::add(ivf::Neighbor)>:
     4b0:	endbr64 
     4b4:	push   %rbx
     4b5:	mov    %rdi,%rbx
     4b8:	sub    $0x30,%rsp
     4bc:	mov    0x8(%rdi),%r9
     4c0:	mov    %rsi,0x8(%rsp)
     4c5:	mov    0x10(%rdi),%rsi
     4c9:	movq   %xmm0,(%rsp)
     4ce:	mov    %rsi,%rdx
     4d1:	mov    %fs:0x28,%rax
     4da:	mov    %rax,0x28(%rsp)
     4df:	xor    %eax,%eax
     4e1:	sub    %r9,%rdx
     4e4:	mov    %rdx,%rax
     4e7:	sar    $0x4,%rax
     4eb:	cmp    %rax,(%rdi)
     4ee:	ja     5e0 <ivf::TopK::add(ivf::Neighbor)+0x130>
     4f4:	movsd  (%rsp),%xmm1
     4f9:	movsd  (%r9),%xmm0
     4fe:	comisd %xmm1,%xmm0
     502:	jbe    5c0 <ivf::TopK::add(ivf::Neighbor)+0x110>
     508:	cmp    $0x10,%rdx
     50c:	jg     6b8 <ivf::TopK::add(ivf::Neighbor)+0x208>
     512:	movdqa (%rsp),%xmm4
     517:	lea    -0x1(%rax),%rdx
     51b:	sub    $0x2,%rax
     51f:	mov    %rax,%r8
     522:	movups %xmm4,-0x10(%rsi)
     526:	shr    $0x3f,%r8
     52a:	mov    -0x8(%rsi),%ecx
     52d:	movsd  -0x10(%rsi),%xmm0
     532:	add    %rax,%r8
     535:	mov    %ecx,0x18(%rsp)
     539:	sar    %r8
     53c:	movsd  %xmm0,0x10(%rsp)
     542:	test   %rdx,%rdx
     545:	jle    721 <ivf::TopK::add(ivf::Neighbor)+0x271>
     54b:	lea    0x10(%rsp),%rsi
     550:	jmp    57f <ivf::TopK::add(ivf::Neighbor)+0xcf>
     552:	nopw   0x0(%rax,%rax,1)
     558:	movdqu (%rcx),%xmm2
     55c:	movups %xmm2,(%rdx)
     55f:	lea    -0x1(%r8),%rdx
     563:	mov    %rdx,%rax
     566:	shr    $0x3f,%rax
     56a:	add    %rdx,%rax
     56d:	mov    %r8,%rdx
     570:	sar    %rax
     573:	test   %r8,%r8
     576:	jle    690 <ivf::TopK::add(ivf::Neighbor)+0x1e0>
     57c:	mov    %rax,%r8
     57f:	mov    %r8,%rcx
     582:	shl    $0x4,%rdx
     586:	shl    $0x4,%rcx
     58a:	add    %r9,%rdx
     58d:	add    %r9,%rcx
     590:	mov    %rcx,%rdi
     593:	call   598 <ivf::TopK::add(ivf::Neighbor)+0xe8>
     598:	test   %al,%al
     59a:	jne    558 <ivf::TopK::add(ivf::Neighbor)+0xa8>
     59c:	movdqa 0x10(%rsp),%xmm5
     5a2:	movups %xmm5,(%rdx)
     5a5:	mov    0x28(%rsp),%rax
     5aa:	sub    %fs:0x28,%rax
     5b3:	jne    737 <ivf::TopK::add(ivf::Neighbor)+0x287>
     5b9:	add    $0x30,%rsp
     5bd:	pop    %rbx
     5be:	ret    
     5bf:	nop
     5c0:	ucomisd %xmm0,%xmm1
     5c4:	jp     5a5 <ivf::TopK::add(ivf::Neighbor)+0xf5>
     5c6:	jne    5a5 <ivf::TopK::add(ivf::Neighbor)+0xf5>
     5c8:	mov    0x8(%r9),%edi
     5cc:	cmp    %edi,0x8(%rsp)
     5d0:	jge    5a5 <ivf::TopK::add(ivf::Neighbor)+0xf5>
     5d2:	jmp    508 <ivf::TopK::add(ivf::Neighbor)+0x58>
     5d7:	nopw   0x0(%rax,%rax,1)
     5e0:	cmp    0x18(%rdi),%rsi
     5e4:	je     708 <ivf::TopK::add(ivf::Neighbor)+0x258>
     5ea:	movdqa (%rsp),%xmm7
     5ef:	add    $0x10,%rsi
     5f3:	movups %xmm7,-0x10(%rsi)
     5f7:	mov    %rsi,0x10(%rdi)
     5fb:	mov    %rsi,%rcx
     5fe:	mov    -0x8(%rsi),%edi
     601:	movsd  -0x10(%rsi),%xmm0
     606:	sub    %r9,%rcx
     609:	mov    %rcx,%rax
     60c:	mov    %edi,0x18(%rsp)
     610:	sar    $0x4,%rax
     614:	movsd  %xmm0,0x10(%rsp)
     61a:	lea    -0x1(%rax),%rdx
     61e:	sub    $0x2,%rax
     622:	mov    %rax,%r8
     625:	shr    $0x3f,%r8
     629:	add    %rax,%r8
     62c:	sar    %r8
     62f:	test   %rdx,%rdx
     632:	jle    72d <ivf::TopK::add(ivf::Neighbor)+0x27d>
     638:	lea    0x10(%rsp),%rsi
     63d:	jmp    663 <ivf::TopK::add(ivf::Neighbor)+0x1b3>
     63f:	nop
     640:	movdqu (%rcx),%xmm3
     644:	movups %xmm3,(%rdx)
     647:	lea    -0x1(%r8),%rdx
     64b:	mov    %rdx,%rax
     64e:	shr    $0x3f,%rax
     652:	add    %rdx,%rax
     655:	mov    %r8,%rdx
     658:	sar    %rax
     65b:	test   %r8,%r8
     65e:	jle    6a0 <ivf::TopK::add(ivf::Neighbor)+0x1f0>
     660:	mov    %rax,%r8
     663:	mov    %r8,%rcx
     666:	shl    $0x4,%rdx
     66a:	shl    $0x4,%rcx
     66e:	add    %r9,%rdx
     671:	add    %r9,%rcx
     674:	mov    %rcx,%rdi
     677:	call   67c <ivf::TopK::add(ivf::Neighbor)+0x1cc>
     67c:	test   %al,%al
     67e:	jne    640 <ivf::TopK::add(ivf::Neighbor)+0x190>
     680:	movdqa 0x10(%rsp),%xmm6
     686:	movups %xmm6,(%rdx)
     689:	jmp    5a5 <ivf::TopK::add(ivf::Neighbor)+0xf5>
     68e:	xchg   %ax,%ax
     690:	mov    %rcx,%rdx
     693:	jmp    59c <ivf::TopK::add(ivf::Neighbor)+0xec>
     698:	nopl   0x0(%rax,%rax,1)
     6a0:	movdqa 0x10(%rsp),%xmm6
     6a6:	mov    %rcx,%rdx
     6a9:	movups %xmm6,(%rdx)
     6ac:	jmp    5a5 <ivf::TopK::add(ivf::Neighbor)+0xf5>
     6b1:	nopl   0x0(%rax)
     6b8:	mov    -0x10(%rsi),%rax
     6bc:	movdqu (%r9),%xmm7
     6c1:	lea    -0x10(%rsi),%rdx
     6c5:	mov    %r9,%rdi
     6c8:	mov    -0x8(%rsi),%rcx
     6cc:	sub    %r9,%rdx
     6cf:	lea    0x0(%rip),%r8        # 6d6 <ivf::TopK::add(ivf::Neighbor)+0x226>
     6d6:	movups %xmm7,-0x10(%rsi)
     6da:	movq   %rax,%xmm0
     6df:	xor    %esi,%esi
     6e1:	sar    $0x4,%rdx
     6e5:	call   6ea <ivf::TopK::add(ivf::Neighbor)+0x23a>
     6ea:	mov    0x10(%rbx),%rsi
     6ee:	mov    0x8(%rbx),%r9
     6f2:	mov    %rsi,%rax
     6f5:	sub    %r9,%rax
     6f8:	sar    $0x4,%rax
     6fc:	jmp    512 <ivf::TopK::add(ivf::Neighbor)+0x62>
     701:	nopl   0x0(%rax)
     708:	mov    %rsp,%rdx
     70b:	lea    0x8(%rdi),%rdi
     70f:	call   714 <ivf::TopK::add(ivf::Neighbor)+0x264>
     714:	mov    0x8(%rbx),%r9
     718:	mov    0x10(%rbx),%rsi
     71c:	jmp    5fb <ivf::TopK::add(ivf::Neighbor)+0x14b>
     721:	shl    $0x4,%rdx
     725:	add    %r9,%rdx
     728:	jmp    59c <ivf::TopK::add(ivf::Neighbor)+0xec>
     72d:	lea    -0x10(%r9,%rcx,1),%rdx
     732:	jmp    680 <ivf::TopK::add(ivf::Neighbor)+0x1d0>
     737:	call   73c <ivf::TopK::add(ivf::Neighbor)+0x28c>
     73c:	nopl   0x0(%rax)

0000000000000740 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)>:
     740:	endbr64 
     744:	push   %r15
     746:	push   %r14
     748:	push   %r13
     74a:	push   %r12
     74c:	push   %rbp
     74d:	push   %rbx
     74e:	sub    $0x28,%rsp
     752:	mov    0x10(%rsi),%rax
     756:	mov    %rdi,0x10(%rsp)
     75b:	mov    %rax,%rdi
     75e:	mov    %rcx,0x8(%rsp)
     763:	shr    $0x3b,%rdi
     767:	jne    b0f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3cf>
     76d:	mov    %rax,%r13
     770:	shl    $0x4,%r13
     774:	test   %rax,%rax
     777:	je     aca <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x38a>
     77d:	mov    %r13,%rdi
     780:	mov    %rsi,%r12
     783:	mov    %rdx,%rbx
     786:	call   78b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x4b>
     78b:	movsd  0x0(%rip),%xmm0        # 793 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x53>
     793:	mov    %rax,%rbp
     796:	add    %rax,%r13
     799:	nopl   0x0(%rax)
     7a0:	movl   $0xffffffff,0x8(%rax)
     7a7:	add    $0x10,%rax
     7ab:	movsd  %xmm0,-0x10(%rax)
     7b0:	cmp    %rax,%r13
     7b3:	jne    7a0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x60>
     7b5:	mov    0x10(%r12),%r8
     7ba:	test   %r8,%r8
     7bd:	je     82f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xef>
     7bf:	mov    0x8(%r12),%rcx
     7c4:	mov    0x60(%r12),%rdx
     7c9:	mov    %rbp,%rdi
     7cc:	xor    %esi,%esi
     7ce:	pxor   %xmm3,%xmm3
     7d2:	lea    0x0(,%rcx,4),%r9
     7da:	nopw   0x0(%rax,%rax,1)
     7e0:	test   %rcx,%rcx
     7e3:	je     aa0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x360>
     7e9:	xor    %eax,%eax
     7eb:	movapd %xmm3,%xmm1
     7ef:	nop
     7f0:	pxor   %xmm0,%xmm0
     7f4:	pxor   %xmm2,%xmm2
     7f8:	cvtss2sd (%rbx,%rax,4),%xmm0
     7fd:	cvtss2sd (%rdx,%rax,4),%xmm2
     802:	subsd  %xmm2,%xmm0
     806:	add    $0x1,%rax
     80a:	mulsd  %xmm0,%xmm0
     80e:	addsd  %xmm0,%xmm1
     812:	cmp    %rax,%rcx
     815:	jne    7f0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xb0>
     817:	mov    %esi,0x8(%rdi)
     81a:	add    $0x1,%rsi
     81e:	add    $0x10,%rdi
     822:	add    %r9,%rdx
     825:	movsd  %xmm1,-0x10(%rdi)
     82a:	cmp    %r8,%rsi
     82d:	jne    7e0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xa0>
     82f:	mov    0x8(%rsp),%rax
     834:	lea    0x0(%rip),%r15        # 83b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xfb>
     83b:	shl    $0x4,%rax
     83f:	mov    %rax,%r14
     842:	mov    %rax,0x18(%rsp)
     847:	lea    0x0(%rbp,%rax,1),%rbx
     84c:	sar    $0x4,%r14
     850:	cmp    $0x10,%rax
     854:	jle    aa9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x369>
     85a:	lea    -0x2(%r14),%rax
     85e:	mov    %rax,%r12
     861:	shr    $0x3f,%r12
     865:	add    %rax,%r12
     868:	sar    %r12
     86b:	jmp    874 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x134>
     86d:	nopl   (%rax)
     870:	sub    $0x1,%r12
     874:	mov    %r12,%rdx
     877:	mov    %r15,%r8
     87a:	mov    %r12,%rsi
     87d:	mov    %rbp,%rdi
     880:	shl    $0x4,%rdx
     884:	mov    0x0(%rbp,%rdx,1),%rax
     889:	mov    0x8(%rbp,%rdx,1),%rcx
     88e:	mov    %r14,%rdx
     891:	movq   %rax,%xmm0
     896:	call   89b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x15b>
     89b:	test   %r12,%r12
     89e:	jne    870 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x130>
     8a0:	cmp    %r13,%rbx
     8a3:	jae    901 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1c1>
     8a5:	mov    %rbx,%r12
     8a8:	jmp    8b9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x179>
     8aa:	nopw   0x0(%rax,%rax,1)
     8b0:	add    $0x10,%r12
     8b4:	cmp    %r12,%r13
     8b7:	jbe    8f9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1b9>
     8b9:	mov    %rbp,%rsi
     8bc:	mov    %r12,%rdi
     8bf:	call   8c4 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x184>
     8c4:	test   %al,%al
     8c6:	je     8b0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x170>
     8c8:	mov    (%r12),%rax
     8cc:	movdqu 0x0(%rbp),%xmm7
     8d1:	mov    %r15,%r8
     8d4:	mov    %r14,%rdx
     8d7:	mov    0x8(%r12),%rcx
     8dc:	xor    %esi,%esi
     8de:	mov    %rbp,%rdi
     8e1:	movups %xmm7,(%r12)
     8e6:	movq   %rax,%xmm0
     8eb:	call   8f0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1b0>
     8f0:	add    $0x10,%r12
     8f4:	cmp    %r12,%r13
     8f7:	ja     8b9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x179>
     8f9:	cmpq   $0x10,0x18(%rsp)
     8ff:	jle    948 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x208>
     901:	lea    0x0(%rip),%r14        # 908 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1c8>
     908:	nopl   0x0(%rax,%rax,1)
     910:	sub    $0x10,%rbx
     914:	mov    (%rbx),%rax
     917:	movdqu 0x0(%rbp),%xmm4
     91c:	mov    %r14,%r8
     91f:	mov    %rbx,%r12
     922:	mov    0x8(%rbx),%rcx
     926:	xor    %esi,%esi
     928:	mov    %rbp,%rdi
     92b:	sub    %rbp,%r12
     92e:	movups %xmm4,(%rbx)
     931:	movq   %rax,%xmm0
     936:	mov    %r12,%rdx
     939:	sar    $0x4,%rdx
     93d:	call   942 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x202>
     942:	cmp    $0x10,%r12
     946:	jg     910 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1d0>
     948:	mov    0x8(%rsp),%rax
     94d:	shr    $0x3d,%rax
     951:	jne    b1b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3db>
     957:	mov    0x10(%rsp),%r15
     95c:	mov    0x8(%rsp),%rax
     961:	pxor   %xmm0,%xmm0
     965:	movq   $0x0,0x10(%r15)
     96d:	lea    0x0(,%rax,4),%r12
     975:	movups %xmm0,(%r15)
     979:	test   %rax,%rax
     97c:	je     ac0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x380>
     982:	mov    %r12,%rdi
     985:	call   98a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x24a>
     98a:	lea    (%rax,%r12,1),%r14
     98e:	cmpq   $0x1,0x8(%rsp)
     994:	mov    %rax,(%r15)
     997:	mov    %rax,%rbx
     99a:	mov    %r14,0x10(%r15)
     99e:	lea    0x4(%rax),%rdi
     9a2:	movl   $0x0,(%rax)
     9a8:	je     af8 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3b8>
     9ae:	cmp    %rdi,%r14
     9b1:	je     9bf <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x27f>
     9b3:	lea    -0x4(%r12),%rdx
     9b8:	xor    %esi,%esi
     9ba:	call   9bf <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x27f>
     9bf:	mov    0x10(%rsp),%rax
     9c4:	mov    %r14,0x8(%rax)
     9c8:	mov    0x8(%rsp),%rax
     9cd:	lea    -0x1(%rax),%rcx
     9d1:	cmp    $0x3,%rcx
     9d5:	jbe    b08 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3c8>
     9db:	mov    %rcx,%rsi
     9de:	mov    %rbx,%rdx
     9e1:	lea    0x8(%rbp),%rax
     9e5:	shr    $0x2,%rsi
     9e9:	shl    $0x4,%rsi
     9ed:	add    %rbx,%rsi
     9f0:	movdqu (%rax),%xmm0
     9f4:	movdqu 0x10(%rax),%xmm5
     9f9:	add    $0x10,%rdx
     9fd:	add    $0x40,%rax
     a01:	movdqu -0x20(%rax),%xmm1
     a06:	movdqu -0x10(%rax),%xmm6
     a0b:	shufps $0x88,%xmm5,%xmm0
     a0f:	shufps $0x88,%xmm6,%xmm1
     a13:	shufps $0x88,%xmm1,%xmm0
     a17:	movups %xmm0,-0x10(%rdx)
     a1b:	cmp    %rdx,%rsi
     a1e:	jne    9f0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2b0>
     a20:	mov    %rcx,%rax
     a23:	and    $0xfffffffffffffffc,%rax
     a27:	mov    %rax,%rdx
     a2a:	mov    0x8(%rsp),%rdi
     a2f:	lea    0x0(,%rax,4),%rcx
     a37:	shl    $0x4,%rdx
     a3b:	mov    0x8(%rbp,%rdx,1),%esi
     a3f:	mov    %esi,(%rbx,%rax,4)
     a42:	lea    0x1(%rax),%rsi
     a46:	cmp    %rdi,%rsi
     a49:	jae    a75 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x335>
     a4b:	mov    0x18(%rbp,%rdx,1),%esi
     a4f:	mov    %esi,0x4(%rbx,%rcx,1)
     a53:	lea    0x2(%rax),%rsi
     a57:	cmp    %rsi,%rdi
     a5a:	jbe    a75 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x335>
     a5c:	mov    0x28(%rbp,%rdx,1),%esi
     a60:	add    $0x3,%rax
     a64:	mov    %esi,0x8(%rbx,%rcx,1)
     a68:	cmp    %rax,%rdi
     a6b:	jbe    a75 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x335>
     a6d:	mov    0x38(%rbp,%rdx,1),%eax
     a71:	mov    %eax,0xc(%rbx,%rcx,1)
     a75:	test   %rbp,%rbp
     a78:	je     a88 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x348>
     a7a:	mov    %r13,%rsi
     a7d:	mov    %rbp,%rdi
     a80:	sub    %rbp,%rsi
     a83:	call   a88 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x348>
     a88:	mov    0x10(%rsp),%rax
     a8d:	add    $0x28,%rsp
     a91:	pop    %rbx
     a92:	pop    %rbp
     a93:	pop    %r12
     a95:	pop    %r13
     a97:	pop    %r14
     a99:	pop    %r15
     a9b:	ret    
     a9c:	nopl   0x0(%rax)
     aa0:	movapd %xmm3,%xmm1
     aa4:	jmp    817 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xd7>
     aa9:	cmp    %rbx,%r13
     aac:	ja     8a5 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x165>
     ab2:	jmp    948 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x208>
     ab7:	nopw   0x0(%rax,%rax,1)
     ac0:	movq   $0x0,0x10(%r15)
     ac8:	jmp    a75 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x335>
     aca:	mov    %rcx,%rbx
     acd:	lea    0x0(%rip),%r15        # ad4 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x394>
     ad4:	xor    %r13d,%r13d
     ad7:	xor    %ebp,%ebp
     ad9:	shl    $0x4,%rbx
     add:	mov    %rbx,%r14
     ae0:	mov    %rbx,0x18(%rsp)
     ae5:	sar    $0x4,%r14
     ae9:	cmp    $0x10,%rbx
     aed:	jle    948 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x208>
     af3:	jmp    85a <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x11a>
     af8:	mov    0x10(%rsp),%rax
     afd:	mov    %rdi,0x8(%rax)
     b01:	xor    %eax,%eax
     b03:	jmp    a27 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2e7>
     b08:	xor    %eax,%eax
     b0a:	jmp    a27 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2e7>
     b0f:	lea    0x0(%rip),%rdi        # b16 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3d6>
     b16:	call   b1b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3db>
     b1b:	lea    0x0(%rip),%rdi        # b22 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3e2>
     b22:	call   b27 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3e7>
     b27:	endbr64 
     b2b:	mov    %rax,%r12
     b2e:	jmp    b33 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3f3>
     b33:	endbr64 
     b37:	mov    %rax,%r12
     b3a:	jmp    b3f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3ff>
     b3f:	nop

0000000000000b40 <ivf::TopK::finish(ivf::Neighbor*)>:
     b40:	endbr64 
     b44:	push   %r15
     b46:	push   %r14
     b48:	push   %r13
     b4a:	push   %r12
     b4c:	mov    %rdi,%r12
     b4f:	push   %rbp
     b50:	mov    %rsi,%rbp
     b53:	push   %rbx
     b54:	sub    $0x8,%rsp
     b58:	mov    0x10(%rdi),%rbx
     b5c:	mov    0x8(%rdi),%r14
     b60:	mov    %rbx,%rdx
     b63:	sub    %r14,%rdx
     b66:	cmp    $0x10,%rdx
     b6a:	jle    bc8 <ivf::TopK::finish(ivf::Neighbor*)+0x88>
     b6c:	lea    0x0(%rip),%r13        # b73 <ivf::TopK::finish(ivf::Neighbor*)+0x33>
     b73:	sub    $0x10,%rbx
     b77:	nopw   0x0(%rax,%rax,1)
     b80:	mov    %rbx,%r15
     b83:	mov    (%rbx),%rax
     b86:	movdqu (%r14),%xmm1
     b8b:	mov    %r13,%r8
     b8e:	sub    %r14,%r15
     b91:	mov    0x8(%rbx),%rcx
     b95:	xor    %esi,%esi
     b97:	mov    %r14,%rdi
     b9a:	mov    %r15,%rdx
     b9d:	movups %xmm1,(%rbx)
     ba0:	movq   %rax,%xmm0
     ba5:	sub    $0x10,%rbx
     ba9:	sar    $0x4,%rdx
     bad:	call   bb2 <ivf::TopK::finish(ivf::Neighbor*)+0x72>
     bb2:	cmp    $0x10,%r15
     bb6:	jg     b80 <ivf::TopK::finish(ivf::Neighbor*)+0x40>
     bb8:	mov    0x10(%r12),%rbx
     bbd:	mov    0x8(%r12),%r14
     bc2:	mov    %rbx,%rdx
     bc5:	sub    %r14,%rdx
     bc8:	cmp    %r14,%rbx
     bcb:	je     be2 <ivf::TopK::finish(ivf::Neighbor*)+0xa2>
     bcd:	mov    %r14,%rsi
     bd0:	mov    %rbp,%rdi
     bd3:	call   bd8 <ivf::TopK::finish(ivf::Neighbor*)+0x98>
     bd8:	mov    0x10(%r12),%rdx
     bdd:	sub    0x8(%r12),%rdx
     be2:	mov    (%r12),%rcx
     be6:	lea    0x0(%rbp,%rdx,1),%rax
     beb:	movsd  0x0(%rip),%xmm0        # bf3 <ivf::TopK::finish(ivf::Neighbor*)+0xb3>
     bf3:	shl    $0x4,%rcx
     bf7:	add    %rbp,%rcx
     bfa:	cmp    %rax,%rcx
     bfd:	je     c15 <ivf::TopK::finish(ivf::Neighbor*)+0xd5>
     bff:	nop
     c00:	movl   $0xffffffff,0x8(%rax)
     c07:	add    $0x10,%rax
     c0b:	movsd  %xmm0,-0x10(%rax)
     c10:	cmp    %rax,%rcx
     c13:	jne    c00 <ivf::TopK::finish(ivf::Neighbor*)+0xc0>
     c15:	add    $0x8,%rsp
     c19:	pop    %rbx
     c1a:	pop    %rbp
     c1b:	pop    %r12
     c1d:	pop    %r13
     c1f:	pop    %r14
     c21:	pop    %r15
     c23:	ret    
     c24:	data16 cs nopw 0x0(%rax,%rax,1)
     c2f:	nop

0000000000000c30 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)>:
     c30:	endbr64 
     c34:	push   %r15
     c36:	movabs $0xffffffff00000000,%r15
     c40:	push   %r14
     c42:	push   %r13
     c44:	xor    %r13d,%r13d
     c47:	push   %r12
     c49:	mov    %rdi,%r12
     c4c:	push   %rbp
     c4d:	push   %rbx
     c4e:	sub    $0x58,%rsp
     c52:	mov    %rsi,(%rsp)
     c56:	lea    0x20(%rsp),%r14
     c5b:	mov    %rdx,0x10(%rsp)
     c60:	mov    %rcx,0x8(%rsp)
     c65:	mov    %r8,0x18(%rsp)
     c6a:	mov    %fs:0x28,%rax
     c73:	mov    %rax,0x48(%rsp)
     c78:	xor    %eax,%eax
     c7a:	test   %rdx,%rdx
     c7d:	je     d75 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x145>
     c83:	nopl   0x0(%rax,%rax,1)
     c88:	mov    0x8(%rsp),%rax
     c8d:	mov    %r14,%rdi
     c90:	xor    %ebx,%ebx
     c92:	mov    (%rax),%rsi
     c95:	call   c9a <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x6a>
     c9a:	cmpq   $0x0,(%r12)
     c9f:	je     d32 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x102>
     ca5:	nopl   (%rax)
     ca8:	mov    0x8(%r12),%rdx
     cad:	mov    0x48(%r12),%r8
     cb2:	pxor   %xmm1,%xmm1
     cb6:	lea    0x0(,%rdx,4),%rax
     cbe:	mov    %rax,%rdi
     cc1:	imul   %r13,%rax
     cc5:	imul   %rbx,%rdi
     cc9:	mov    %rax,%rcx
     ccc:	test   %rdx,%rdx
     ccf:	je     d07 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xd7>
     cd1:	mov    (%rsp),%rsi
     cd5:	xor    %eax,%eax
     cd7:	add    %rcx,%rsi
     cda:	lea    (%r8,%rdi,1),%rcx
     cde:	xchg   %ax,%ax
     ce0:	pxor   %xmm0,%xmm0
     ce4:	pxor   %xmm2,%xmm2
     ce8:	cvtss2sd (%rsi,%rax,4),%xmm0
     ced:	cvtss2sd (%rcx,%rax,4),%xmm2
     cf2:	subsd  %xmm2,%xmm0
     cf6:	add    $0x1,%rax
     cfa:	mulsd  %xmm0,%xmm0
     cfe:	addsd  %xmm0,%xmm1
     d02:	cmp    %rax,%rdx
     d05:	jne    ce0 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xb0>
     d07:	mov    0x30(%r12),%rax
     d0c:	and    %r15,%rbp
     d0f:	movapd %xmm1,%xmm0
     d13:	mov    %r14,%rdi
     d16:	mov    (%rax,%rbx,4),%eax
     d19:	or     %rax,%rbp
     d1c:	mov    %rbp,%rsi
     d1f:	call   d24 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xf4>
     d24:	add    $0x1,%rbx
     d28:	cmp    %rbx,(%r12)
     d2c:	ja     ca8 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x78>
     d32:	mov    0x8(%rsp),%rax
     d37:	mov    %r14,%rdi
     d3a:	mov    (%rax),%rsi
     d3d:	imul   %r13,%rsi
     d41:	shl    $0x4,%rsi
     d45:	add    0x18(%rsp),%rsi
     d4a:	call   d4f <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x11f>
     d4f:	mov    0x28(%rsp),%rdi
     d54:	test   %rdi,%rdi
     d57:	je     d94 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x164>
     d59:	mov    0x38(%rsp),%rsi
     d5e:	add    $0x1,%r13
     d62:	sub    %rdi,%rsi
     d65:	call   d6a <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x13a>
     d6a:	cmp    0x10(%rsp),%r13
     d6f:	jne    c88 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x58>
     d75:	mov    0x48(%rsp),%rax
     d7a:	sub    %fs:0x28,%rax
     d83:	jne    da5 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x175>
     d85:	add    $0x58,%rsp
     d89:	pop    %rbx
     d8a:	pop    %rbp
     d8b:	pop    %r12
     d8d:	pop    %r13
     d8f:	pop    %r14
     d91:	pop    %r15
     d93:	ret    
     d94:	add    $0x1,%r13
     d98:	cmp    %r13,0x10(%rsp)
     d9d:	jne    c88 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x58>
     da3:	jmp    d75 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x145>
     da5:	call   daa <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x17a>
     daa:	endbr64 
     dae:	mov    %rax,%rbp
     db1:	jmp    db6 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x186>
     db6:	cs nopw 0x0(%rax,%rax,1)

0000000000000dc0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)>:
     dc0:	endbr64 
     dc4:	push   %r15
     dc6:	push   %r14
     dc8:	push   %r13
     dca:	mov    %rdi,%r13
     dcd:	push   %r12
     dcf:	push   %rbp
     dd0:	push   %rbx
     dd1:	sub    $0x98,%rsp
     dd8:	mov    %rsi,0x28(%rsp)
     ddd:	lea    0x60(%rsp),%r15
     de2:	mov    %rdx,0x18(%rsp)
     de7:	mov    %rcx,0x20(%rsp)
     dec:	mov    %r8,0x30(%rsp)
     df1:	mov    %fs:0x28,%rax
     dfa:	mov    %rax,0x88(%rsp)
     e02:	xor    %eax,%eax
     e04:	lea    0x40(%rsp),%rax
     e09:	movq   $0x0,0x10(%rsp)
     e12:	mov    %rax,0x38(%rsp)
     e17:	test   %rdx,%rdx
     e1a:	je     fa6 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1e6>
     e20:	mov    0x10(%rsp),%rax
     e25:	imul   0x8(%r13),%rax
     e2a:	mov    %r13,%rsi
     e2d:	mov    0x28(%rsp),%rdi
     e32:	mov    0x20(%rsp),%r14
     e37:	lea    (%rdi,%rax,4),%rbx
     e3b:	mov    0x8(%r14),%rcx
     e3f:	mov    0x38(%rsp),%rdi
     e44:	mov    %rbx,%rdx
     e47:	call   e4c <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x8c>
     e4c:	mov    (%r14),%rsi
     e4f:	mov    %r15,%rdi
     e52:	call   e57 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x97>
     e57:	mov    0x48(%rsp),%rax
     e5c:	mov    0x40(%rsp),%rdx
     e61:	mov    %rax,0x8(%rsp)
     e66:	cmp    %rdx,%rax
     e69:	je     f43 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x183>
     e6f:	mov    %rdx,(%rsp)
     e73:	mov    0x18(%r13),%rax
     e77:	nopw   0x0(%rax,%rax,1)
     e80:	mov    (%rsp),%rdi
     e84:	mov    (%rdi),%ecx
     e86:	mov    %rcx,%rdx
     e89:	mov    (%rax,%rcx,8),%rbp
     e8d:	add    $0x1,%edx
     e90:	lea    0x0(,%rdx,8),%r14
     e98:	cmp    (%rax,%rdx,8),%rbp
     e9c:	jae    f2f <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x16f>
     ea2:	nopw   0x0(%rax,%rax,1)
     ea8:	mov    0x8(%r13),%rdx
     eac:	mov    0x48(%r13),%rsi
     eb0:	pxor   %xmm1,%xmm1
     eb4:	mov    %rdx,%rax
     eb7:	imul   %rbp,%rax
     ebb:	lea    0x0(,%rax,4),%rcx
     ec3:	test   %rdx,%rdx
     ec6:	je     ef7 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x137>
     ec8:	xor    %eax,%eax
     eca:	add    %rsi,%rcx
     ecd:	nopl   (%rax)
     ed0:	pxor   %xmm0,%xmm0
     ed4:	pxor   %xmm2,%xmm2
     ed8:	cvtss2sd (%rbx,%rax,4),%xmm0
     edd:	cvtss2sd (%rcx,%rax,4),%xmm2
     ee2:	subsd  %xmm2,%xmm0
     ee6:	add    $0x1,%rax
     eea:	mulsd  %xmm0,%xmm0
     eee:	addsd  %xmm0,%xmm1
     ef2:	cmp    %rax,%rdx
     ef5:	jne    ed0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x110>
     ef7:	mov    0x30(%r13),%rax
     efb:	movapd %xmm1,%xmm0
     eff:	movabs $0xffffffff00000000,%rdi
     f09:	and    %rdi,%r12
     f0c:	mov    %r15,%rdi
     f0f:	mov    (%rax,%rbp,4),%eax
     f12:	or     %rax,%r12
     f15:	mov    %r12,%rsi
     f18:	call   f1d <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x15d>
     f1d:	mov    0x18(%r13),%rax
     f21:	add    $0x1,%rbp
     f25:	cmp    %rbp,(%rax,%r14,1)
     f29:	ja     ea8 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xe8>
     f2f:	addq   $0x4,(%rsp)
     f34:	mov    (%rsp),%rsi
     f38:	cmp    %rsi,0x8(%rsp)
     f3d:	jne    e80 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xc0>
     f43:	mov    0x20(%rsp),%rax
     f48:	mov    0x10(%rsp),%rsi
     f4d:	mov    %r15,%rdi
     f50:	imul   (%rax),%rsi
     f54:	shl    $0x4,%rsi
     f58:	add    0x30(%rsp),%rsi
     f5d:	call   f62 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1a2>
     f62:	mov    0x68(%rsp),%rdi
     f67:	test   %rdi,%rdi
     f6a:	je     f79 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1b9>
     f6c:	mov    0x78(%rsp),%rsi
     f71:	sub    %rdi,%rsi
     f74:	call   f79 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1b9>
     f79:	mov    0x40(%rsp),%rdi
     f7e:	test   %rdi,%rdi
     f81:	je     fcb <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x20b>
     f83:	mov    0x50(%rsp),%rsi
     f88:	sub    %rdi,%rsi
     f8b:	call   f90 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1d0>
     f90:	addq   $0x1,0x10(%rsp)
     f96:	mov    0x10(%rsp),%rax
     f9b:	cmp    0x18(%rsp),%rax
     fa0:	jne    e20 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x60>
     fa6:	mov    0x88(%rsp),%rax
     fae:	sub    %fs:0x28,%rax
     fb7:	jne    fe3 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x223>
     fb9:	add    $0x98,%rsp
     fc0:	pop    %rbx
     fc1:	pop    %rbp
     fc2:	pop    %r12
     fc4:	pop    %r13
     fc6:	pop    %r14
     fc8:	pop    %r15
     fca:	ret    
     fcb:	addq   $0x1,0x10(%rsp)
     fd1:	mov    0x10(%rsp),%rax
     fd6:	cmp    %rax,0x18(%rsp)
     fdb:	jne    e20 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x60>
     fe1:	jmp    fa6 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1e6>
     fe3:	call   fe8 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x228>
     fe8:	endbr64 
     fec:	mov    %rax,%rbp
     fef:	jmp    ff4 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x234>
     ff4:	endbr64 
     ff8:	mov    %rax,%rbp
     ffb:	jmp    1000 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x240>

Disassembly of section .text._ZNSt7__cxx119to_stringEi:

0000000000000000 <std::__cxx11::to_string(int)>:
   0:	endbr64 
   4:	push   %r14
   6:	mov    %esi,%r14d
   9:	push   %r13
   b:	shr    $0x1f,%r14d
   f:	mov    %rdi,%r13
  12:	push   %r12
  14:	push   %rbp
  15:	mov    %esi,%ebp
  17:	neg    %ebp
  19:	push   %rbx
  1a:	cmovs  %esi,%ebp
  1d:	cmp    $0x9,%ebp
  20:	jbe    1ac <std::__cxx11::to_string(int)+0x1ac>
  26:	cmp    $0x63,%ebp
  29:	jbe    1ce <std::__cxx11::to_string(int)+0x1ce>
  2f:	cmp    $0x3e7,%ebp
  35:	jbe    1ee <std::__cxx11::to_string(int)+0x1ee>
  3b:	mov    %ebp,%ebx
  3d:	mov    %rbx,%rdx
  40:	cmp    $0x270f,%ebp
  46:	jbe    1de <std::__cxx11::to_string(int)+0x1de>
  4c:	movabs $0x346dc5d63886594b,%rdi
  56:	mov    $0x1,%ecx
  5b:	jmp    81 <std::__cxx11::to_string(int)+0x81>
  5d:	nopl   (%rax)
  60:	cmp    $0x63,%edx
  63:	jbe    130 <std::__cxx11::to_string(int)+0x130>
  69:	cmp    $0x3e7,%edx
  6f:	jbe    190 <std::__cxx11::to_string(int)+0x190>
  75:	cmp    $0x270f,%edx
  7b:	jbe    1a0 <std::__cxx11::to_string(int)+0x1a0>
  81:	mov    %rdx,%rax
  84:	mov    %rdx,%rsi
  87:	mul    %rdi
  8a:	mov    %ecx,%eax
  8c:	add    $0x4,%ecx
  8f:	shr    $0xb,%rdx
  93:	cmp    $0x1869f,%rsi
  9a:	ja     60 <std::__cxx11::to_string(int)+0x60>
  9c:	lea    0x3(%rax),%r12d
  a0:	lea    0x10(%r13),%rax
  a4:	lea    (%r14,%rcx,1),%esi
  a8:	mov    $0x2d,%edx
  ad:	mov    %r13,%rdi
  b0:	mov    %rax,0x0(%r13)
  b4:	call   b9 <std::__cxx11::to_string(int)+0xb9>
  b9:	movzbl %r14b,%ecx
  bd:	add    0x0(%r13),%rcx
  c1:	lea    0x0(%rip),%rsi        # c8 <std::__cxx11::to_string(int)+0xc8>
  c8:	jmp    d2 <std::__cxx11::to_string(int)+0xd2>
  ca:	nopw   0x0(%rax,%rax,1)
  d0:	mov    %ebp,%ebx
  d2:	imul   $0x51eb851f,%rbx,%rdx
  d9:	mov    %ebp,%eax
  db:	shr    $0x25,%rdx
  df:	imul   $0x64,%edx,%edi
  e2:	sub    %edi,%eax
  e4:	mov    %ebp,%edi
  e6:	mov    %edx,%ebp
  e8:	mov    %r12d,%edx
  eb:	add    %eax,%eax
  ed:	lea    0x1(%rax),%r8d
  f1:	movzbl (%rsi,%rax,1),%eax
  f5:	movzbl (%rsi,%r8,1),%r8d
  fa:	mov    %r8b,(%rcx,%rdx,1)
  fe:	lea    -0x1(%r12),%edx
 103:	sub    $0x2,%r12d
 107:	mov    %al,(%rcx,%rdx,1)
 10a:	cmp    $0x270f,%edi
 110:	ja     d0 <std::__cxx11::to_string(int)+0xd0>
 112:	cmp    $0x3e7,%edi
 118:	ja     169 <std::__cxx11::to_string(int)+0x169>
 11a:	add    $0x30,%ebp
 11d:	mov    %r13,%rax
 120:	mov    %bpl,(%rcx)
 123:	pop    %rbx
 124:	pop    %rbp
 125:	pop    %r12
 127:	pop    %r13
 129:	pop    %r14
 12b:	ret    
 12c:	nopl   0x0(%rax)
 130:	add    $0x5,%eax
 133:	mov    %ecx,%r12d
 136:	lea    0x10(%r13),%rdx
 13a:	lea    (%r14,%rax,1),%esi
 13e:	mov    %r13,%rdi
 141:	mov    %ebp,%ebx
 143:	mov    %rdx,0x0(%r13)
 147:	mov    $0x2d,%edx
 14c:	call   151 <std::__cxx11::to_string(int)+0x151>
 151:	movzbl %r14b,%ecx
 155:	lea    0x0(%rip),%rsi        # 15c <std::__cxx11::to_string(int)+0x15c>
 15c:	add    0x0(%r13),%rcx
 160:	cmp    $0x63,%ebp
 163:	ja     c1 <std::__cxx11::to_string(int)+0xc1>
 169:	add    %ebp,%ebp
 16b:	lea    0x1(%rbp),%eax
 16e:	movzbl (%rsi,%rbp,1),%ebp
 172:	movzbl (%rsi,%rax,1),%eax
 176:	mov    %bpl,(%rcx)
 179:	mov    %al,0x1(%rcx)
 17c:	mov    %r13,%rax
 17f:	pop    %rbx
 180:	pop    %rbp
 181:	pop    %r12
 183:	pop    %r13
 185:	pop    %r14
 187:	ret    
 188:	nopl   0x0(%rax,%rax,1)
 190:	lea    0x6(%rax),%ecx
 193:	lea    0x5(%rax),%r12d
 197:	jmp    a0 <std::__cxx11::to_string(int)+0xa0>
 19c:	nopl   0x0(%rax)
 1a0:	lea    0x7(%rax),%ecx
 1a3:	lea    0x6(%rax),%r12d
 1a7:	jmp    a0 <std::__cxx11::to_string(int)+0xa0>
 1ac:	lea    0x10(%rdi),%rax
 1b0:	lea    0x1(%r14),%esi
 1b4:	mov    $0x2d,%edx
 1b9:	mov    %rax,(%rdi)
 1bc:	call   1c1 <std::__cxx11::to_string(int)+0x1c1>
 1c1:	movzbl %r14b,%ecx
 1c5:	add    0x0(%r13),%rcx
 1c9:	jmp    11a <std::__cxx11::to_string(int)+0x11a>
 1ce:	mov    $0x2,%eax
 1d3:	mov    $0x1,%r12d
 1d9:	jmp    136 <std::__cxx11::to_string(int)+0x136>
 1de:	mov    $0x3,%r12d
 1e4:	mov    $0x4,%ecx
 1e9:	jmp    a0 <std::__cxx11::to_string(int)+0xa0>
 1ee:	mov    $0x2,%r12d
 1f4:	mov    $0x3,%ecx
 1f9:	mov    %ebp,%ebx
 1fb:	jmp    a0 <std::__cxx11::to_string(int)+0xa0>

Disassembly of section .text._ZNSt7__cxx119to_stringEm:

0000000000000000 <std::__cxx11::to_string(unsigned long)>:
   0:	endbr64 
   4:	push   %r12
   6:	mov    %rdi,%r12
   9:	push   %rbx
   a:	mov    %rsi,%rbx
   d:	sub    $0x8,%rsp
  11:	cmp    $0x9,%rsi
  15:	jbe    1ad <std::__cxx11::to_string(unsigned long)+0x1ad>
  1b:	cmp    $0x63,%rsi
  1f:	jbe    1c9 <std::__cxx11::to_string(unsigned long)+0x1c9>
  25:	cmp    $0x3e7,%rsi
  2c:	jbe    1dd <std::__cxx11::to_string(unsigned long)+0x1dd>
  32:	cmp    $0x270f,%rsi
  39:	jbe    1d3 <std::__cxx11::to_string(unsigned long)+0x1d3>
  3f:	movabs $0x346dc5d63886594b,%rdi
  49:	mov    %rsi,%rdx
  4c:	mov    $0x1,%esi
  51:	jmp    7f <std::__cxx11::to_string(unsigned long)+0x7f>
  53:	nopl   0x0(%rax,%rax,1)
  58:	cmp    $0xf423f,%rcx
  5f:	jbe    140 <std::__cxx11::to_string(unsigned long)+0x140>
  65:	cmp    $0x98967f,%rcx
  6c:	jbe    180 <std::__cxx11::to_string(unsigned long)+0x180>
  72:	cmp    $0x5f5e0ff,%rcx
  79:	jbe    190 <std::__cxx11::to_string(unsigned long)+0x190>
  7f:	mov    %rdx,%rax
  82:	mov    %rdx,%rcx
  85:	mul    %rdi
  88:	mov    %esi,%eax
  8a:	add    $0x4,%esi
  8d:	shr    $0xb,%rdx
  91:	cmp    $0x1869f,%rcx
  98:	ja     58 <std::__cxx11::to_string(unsigned long)+0x58>
  9a:	lea    0x10(%r12),%rax
  9f:	xor    %edx,%edx
  a1:	mov    %r12,%rdi
  a4:	mov    %rax,(%r12)
  a8:	call   ad <std::__cxx11::to_string(unsigned long)+0xad>
  ad:	mov    0x8(%r12),%eax
  b2:	mov    (%r12),%rsi
  b6:	lea    -0x1(%rax),%ecx
  b9:	lea    0x0(%rip),%rdi        # c0 <std::__cxx11::to_string(unsigned long)+0xc0>
  c0:	movabs $0x28f5c28f5c28f5c3,%r8
  ca:	nopw   0x0(%rax,%rax,1)
  d0:	mov    %rbx,%rdx
  d3:	shr    $0x2,%rdx
  d7:	mov    %rdx,%rax
  da:	mul    %r8
  dd:	mov    %rdx,%r9
  e0:	and    $0xfffffffffffffffc,%rdx
  e4:	shr    $0x2,%r9
  e8:	add    %r9,%rdx
  eb:	lea    (%rdx,%rdx,4),%rax
  ef:	mov    %rbx,%rdx
  f2:	shl    $0x2,%rax
  f6:	sub    %rax,%rdx
  f9:	mov    %rbx,%rax
  fc:	mov    %r9,%rbx
  ff:	mov    %ecx,%r9d
 102:	movzbl 0x1(%rdi,%rdx,2),%r10d
 108:	movzbl (%rdi,%rdx,2),%edx
 10c:	mov    %r10b,(%rsi,%r9,1)
 110:	lea    -0x1(%rcx),%r9d
 114:	sub    $0x2,%ecx
 117:	mov    %dl,(%rsi,%r9,1)
 11b:	cmp    $0x270f,%rax
 121:	ja     d0 <std::__cxx11::to_string(unsigned long)+0xd0>
 123:	cmp    $0x3e7,%rax
 129:	ja     167 <std::__cxx11::to_string(unsigned long)+0x167>
 12b:	add    $0x30,%ebx
 12e:	mov    %r12,%rax
 131:	mov    %bl,(%rsi)
 133:	add    $0x8,%rsp
 137:	pop    %rbx
 138:	pop    %r12
 13a:	ret    
 13b:	nopl   0x0(%rax,%rax,1)
 140:	lea    0x5(%rax),%esi
 143:	lea    0x10(%r12),%rax
 148:	mov    %r12,%rdi
 14b:	xor    %edx,%edx
 14d:	mov    %rax,(%r12)
 151:	call   156 <std::__cxx11::to_string(unsigned long)+0x156>
 156:	mov    (%r12),%rsi
 15a:	lea    0x0(%rip),%rdi        # 161 <std::__cxx11::to_string(unsigned long)+0x161>
 161:	cmp    $0x63,%rbx
 165:	ja     1a0 <std::__cxx11::to_string(unsigned long)+0x1a0>
 167:	movzbl 0x1(%rdi,%rbx,2),%eax
 16c:	movzbl (%rdi,%rbx,2),%ebx
 170:	mov    %al,0x1(%rsi)
 173:	mov    %r12,%rax
 176:	mov    %bl,(%rsi)
 178:	add    $0x8,%rsp
 17c:	pop    %rbx
 17d:	pop    %r12
 17f:	ret    
 180:	lea    0x6(%rax),%esi
 183:	jmp    9a <std::__cxx11::to_string(unsigned long)+0x9a>
 188:	nopl   0x0(%rax,%rax,1)
 190:	lea    0x7(%rax),%esi
 193:	jmp    9a <std::__cxx11::to_string(unsigned long)+0x9a>
 198:	nopl   0x0(%rax,%rax,1)
 1a0:	mov    0x8(%r12),%eax
 1a5:	lea    -0x1(%rax),%ecx
 1a8:	jmp    b9 <std::__cxx11::to_string(unsigned long)+0xb9>
 1ad:	lea    0x10(%rdi),%rax
 1b1:	mov    $0x1,%esi
 1b6:	xor    %edx,%edx
 1b8:	mov    %rax,(%rdi)
 1bb:	call   1c0 <std::__cxx11::to_string(unsigned long)+0x1c0>
 1c0:	mov    (%r12),%rsi
 1c4:	jmp    12b <std::__cxx11::to_string(unsigned long)+0x12b>
 1c9:	mov    $0x2,%esi
 1ce:	jmp    143 <std::__cxx11::to_string(unsigned long)+0x143>
 1d3:	mov    $0x4,%esi
 1d8:	jmp    9a <std::__cxx11::to_string(unsigned long)+0x9a>
 1dd:	mov    $0x3,%esi
 1e2:	jmp    9a <std::__cxx11::to_string(unsigned long)+0x9a>

Disassembly of section .text.unlikely:

0000000000000000 <ivf::TopK::TopK(unsigned long) [clone .cold]>:
   0:	mov    0x8(%rbx),%rdi
   4:	mov    0x18(%rbx),%rsi
   8:	sub    %rdi,%rsi
   b:	test   %rdi,%rdi
   e:	je     15 <ivf::TopK::TopK(unsigned long) [clone .cold]+0x15>
  10:	call   15 <ivf::TopK::TopK(unsigned long) [clone .cold]+0x15>
  15:	mov    %rbp,%rdi
  18:	call   1d <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]>

000000000000001d <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]>:
  1d:	mov    $0x10,%edi
  22:	call   27 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xa>
  27:	lea    0x0(%rip),%rsi        # 2e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x11>
  2e:	mov    %rax,%rdi
  31:	mov    %rax,%rbp
  34:	call   39 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1c>
  39:	mov    0x0(%rip),%rdx        # 40 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x23>
  40:	lea    0x0(%rip),%rsi        # 47 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2a>
  47:	mov    %rbp,%rdi
  4a:	call   4f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x32>
  4f:	mov    $0x10,%edi
  54:	lea    0xc0(%rsp),%r14
  5c:	call   61 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x44>
  61:	mov    0x8(%rbx),%esi
  64:	mov    %r14,%rdi
  67:	mov    %rax,%r13
  6a:	call   6f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x52>
  6f:	lea    0x60(%rsp),%rbx
  74:	mov    0x8(%rbp),%esi
  77:	mov    %rbx,%rdi
  7a:	call   7f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x62>
  7f:	mov    %rsp,%rbp
  82:	mov    %r12,%rsi
  85:	mov    %rbp,%rdi
  88:	call   8d <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x70>
  8d:	mov    $0x1e,%r8d
  93:	xor    %edx,%edx
  95:	xor    %esi,%esi
  97:	mov    %rbp,%rdi
  9a:	lea    0x0(%rip),%rcx        # a1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x84>
  a1:	call   a6 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x89>
  a6:	lea    0x30(%rsp),%rbp
  ab:	lea    0x10(%rax),%rdx
  af:	mov    %rbp,0x20(%rsp)
  b4:	mov    (%rax),%rcx
  b7:	cmp    %rdx,%rcx
  ba:	jne    27f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x262>
  c0:	movdqu 0x10(%rax),%xmm7
  c5:	movaps %xmm7,0x30(%rsp)
  ca:	mov    0x8(%rax),%rcx
  ce:	movb   $0x0,0x10(%rax)
  d2:	lea    0x40(%rsp),%r15
  d7:	lea    0x20(%rsp),%rsi
  dc:	mov    %r15,%rdi
  df:	mov    %rcx,0x28(%rsp)
  e4:	mov    %rdx,(%rax)
  e7:	lea    0x0(%rip),%rdx        # ee <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xd1>
  ee:	movq   $0x0,0x8(%rax)
  f6:	call   fb <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xde>
  fb:	lea    0x80(%rsp),%r12
 103:	mov    %rbx,%rdx
 106:	mov    %r15,%rsi
 109:	mov    %r12,%rdi
 10c:	call   111 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xf4>
 111:	lea    0xa0(%rsp),%r15
 119:	lea    0x0(%rip),%rdx        # 120 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x103>
 120:	mov    %r12,%rsi
 123:	mov    %r15,%rdi
 126:	call   12b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x10e>
 12b:	lea    0xe0(%rsp),%r12
 133:	mov    %r14,%rdx
 136:	mov    %r15,%rsi
 139:	mov    %r12,%rdi
 13c:	call   141 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x124>
 141:	mov    %r12,%rsi
 144:	mov    %r13,%rdi
 147:	call   14c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x12f>
 14c:	mov    0xe0(%rsp),%rdi
 154:	lea    0xf0(%rsp),%rax
 15c:	cmp    %rax,%rdi
 15f:	je     172 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x155>
 161:	mov    0xf0(%rsp),%rax
 169:	lea    0x1(%rax),%rsi
 16d:	call   172 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x155>
 172:	mov    0xa0(%rsp),%rdi
 17a:	lea    0xb0(%rsp),%rax
 182:	cmp    %rax,%rdi
 185:	je     198 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x17b>
 187:	mov    0xb0(%rsp),%rax
 18f:	lea    0x1(%rax),%rsi
 193:	call   198 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x17b>
 198:	mov    0x80(%rsp),%rdi
 1a0:	lea    0x90(%rsp),%rax
 1a8:	cmp    %rax,%rdi
 1ab:	je     1be <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a1>
 1ad:	mov    0x90(%rsp),%rax
 1b5:	lea    0x1(%rax),%rsi
 1b9:	call   1be <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a1>
 1be:	mov    0x40(%rsp),%rdi
 1c3:	lea    0x50(%rsp),%rax
 1c8:	cmp    %rax,%rdi
 1cb:	je     1db <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1be>
 1cd:	mov    0x50(%rsp),%rax
 1d2:	lea    0x1(%rax),%rsi
 1d6:	call   1db <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1be>
 1db:	mov    0x20(%rsp),%rdi
 1e0:	cmp    %rbp,%rdi
 1e3:	je     1f3 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d6>
 1e5:	mov    0x30(%rsp),%rax
 1ea:	lea    0x1(%rax),%rsi
 1ee:	call   1f3 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d6>
 1f3:	mov    (%rsp),%rdi
 1f7:	lea    0x10(%rsp),%rax
 1fc:	cmp    %rax,%rdi
 1ff:	je     20f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1f2>
 201:	mov    0x10(%rsp),%rax
 206:	lea    0x1(%rax),%rsi
 20a:	call   20f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1f2>
 20f:	mov    0x60(%rsp),%rdi
 214:	lea    0x70(%rsp),%rax
 219:	cmp    %rax,%rdi
 21c:	je     22c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x20f>
 21e:	mov    0x70(%rsp),%rax
 223:	lea    0x1(%rax),%rsi
 227:	call   22c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x20f>
 22c:	mov    0xc0(%rsp),%rdi
 234:	lea    0xd0(%rsp),%rax
 23c:	cmp    %rax,%rdi
 23f:	je     252 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x235>
 241:	mov    0xd0(%rsp),%rax
 249:	lea    0x1(%rax),%rsi
 24d:	call   252 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x235>
 252:	mov    0x0(%rip),%rdx        # 259 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x23c>
 259:	lea    0x0(%rip),%rsi        # 260 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x243>
 260:	mov    %r13,%rdi
 263:	call   268 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x24b>
 268:	endbr64 
 26c:	mov    %rax,%r12
 26f:	mov    %rbp,%rdi
 272:	call   277 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x25a>
 277:	mov    %r12,%rdi
 27a:	call   27f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x262>
 27f:	mov    %rcx,0x20(%rsp)
 284:	mov    0x10(%rax),%rcx
 288:	mov    %rcx,0x30(%rsp)
 28d:	jmp    ca <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xad>
 292:	endbr64 
 296:	mov    %rax,%rbx
 299:	mov    (%rsp),%rdi
 29d:	lea    0x10(%rsp),%rax
 2a2:	cmp    %rax,%rdi
 2a5:	je     2b5 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x298>
 2a7:	mov    0x10(%rsp),%rax
 2ac:	lea    0x1(%rax),%rsi
 2b0:	call   2b5 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x298>
 2b5:	mov    0x60(%rsp),%rdi
 2ba:	lea    0x70(%rsp),%rax
 2bf:	cmp    %rax,%rdi
 2c2:	je     2d2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2b5>
 2c4:	mov    0x70(%rsp),%rax
 2c9:	lea    0x1(%rax),%rsi
 2cd:	call   2d2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2b5>
 2d2:	mov    0xc0(%rsp),%rdi
 2da:	lea    0xd0(%rsp),%rax
 2e2:	cmp    %rax,%rdi
 2e5:	je     2f8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2db>
 2e7:	mov    0xd0(%rsp),%rax
 2ef:	lea    0x1(%rax),%rsi
 2f3:	call   2f8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2db>
 2f8:	mov    %r13,%rdi
 2fb:	call   300 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2e3>
 300:	mov    %rbx,%rdi
 303:	call   308 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2eb>
 308:	endbr64 
 30c:	mov    %rax,%rbx
 30f:	jmp    2d2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2b5>
 311:	endbr64 
 315:	mov    %rax,%rbx
 318:	jmp    2f8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x2db>
 31a:	endbr64 
 31e:	mov    %rax,%rbx
 321:	jmp    2b5 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x298>
 323:	endbr64 
 327:	mov    0xe0(%rsp),%rdi
 32f:	mov    %rax,%rbx
 332:	lea    0xf0(%rsp),%rax
 33a:	cmp    %rax,%rdi
 33d:	je     350 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x333>
 33f:	mov    0xf0(%rsp),%rax
 347:	lea    0x1(%rax),%rsi
 34b:	call   350 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x333>
 350:	mov    0xa0(%rsp),%rdi
 358:	lea    0xb0(%rsp),%rax
 360:	cmp    %rax,%rdi
 363:	je     376 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x359>
 365:	mov    0xb0(%rsp),%rax
 36d:	lea    0x1(%rax),%rsi
 371:	call   376 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x359>
 376:	mov    0x80(%rsp),%rdi
 37e:	lea    0x90(%rsp),%rax
 386:	cmp    %rax,%rdi
 389:	je     39c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x37f>
 38b:	mov    0x90(%rsp),%rax
 393:	lea    0x1(%rax),%rsi
 397:	call   39c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x37f>
 39c:	mov    0x40(%rsp),%rdi
 3a1:	lea    0x50(%rsp),%rax
 3a6:	cmp    %rax,%rdi
 3a9:	je     3b9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x39c>
 3ab:	mov    0x50(%rsp),%rax
 3b0:	lea    0x1(%rax),%rsi
 3b4:	call   3b9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x39c>
 3b9:	mov    0x20(%rsp),%rdi
 3be:	cmp    %rbp,%rdi
 3c1:	je     299 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x27c>
 3c7:	mov    0x30(%rsp),%rax
 3cc:	lea    0x1(%rax),%rsi
 3d0:	call   3d5 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3b8>
 3d5:	jmp    299 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x27c>
 3da:	endbr64 
 3de:	mov    %rax,%rbx
 3e1:	jmp    350 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x333>
 3e6:	endbr64 
 3ea:	mov    %rax,%rbx
 3ed:	jmp    376 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x359>
 3ef:	endbr64 
 3f3:	mov    %rax,%rbx
 3f6:	jmp    39c <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x37f>
 3f8:	endbr64 
 3fc:	mov    %rax,%rbx
 3ff:	jmp    3b9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x39c>

0000000000000401 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]>:
 401:	sub    %rbp,%r13
 404:	mov    %r13,%rsi
 407:	mov    %rbp,%rdi
 40a:	call   40f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0xe>
 40f:	mov    %r12,%rdi
 412:	call   417 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x16>
 417:	sub    %rbp,%r13
 41a:	test   %rbp,%rbp
 41d:	jne    404 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x3>
 41f:	jmp    40f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0xe>

0000000000000421 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>:
 421:	mov    0x28(%rsp),%rdi
 426:	mov    0x38(%rsp),%rsi
 42b:	sub    %rdi,%rsi
 42e:	test   %rdi,%rdi
 431:	je     438 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x17>
 433:	call   438 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x17>
 438:	mov    %rbp,%rdi
 43b:	call   440 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>

0000000000000440 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>:
 440:	mov    0x68(%rsp),%rdi
 445:	mov    0x78(%rsp),%rsi
 44a:	sub    %rdi,%rsi
 44d:	test   %rdi,%rdi
 450:	je     457 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x17>
 452:	call   457 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x17>
 457:	mov    0x40(%rsp),%rdi
 45c:	mov    0x50(%rsp),%rsi
 461:	sub    %rdi,%rsi
 464:	test   %rdi,%rdi
 467:	je     46e <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x2e>
 469:	call   46e <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x2e>
 46e:	mov    %rbp,%rdi
 471:	call   476 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x36>

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
  2e:	ja     8d <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x8d>
  30:	mov    %r13,%rsi
  33:	mov    %rbp,%rdi
  36:	call   3b <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x3b>
  3b:	lea    0x10(%r12),%rdx
  40:	mov    %rdx,(%r12)
  44:	mov    (%rax),%rcx
  47:	lea    0x10(%rax),%rdx
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
  80:	movdqu 0x10(%rax),%xmm0
  85:	movups %xmm0,0x10(%r12)
  8b:	jmp    5d <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x5d>
  8d:	lea    0x0(%rip),%rdi        # 94 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, char const*)+0x94>
  94:	call   99 <ivf::TopK::TopK(unsigned long)+0x59>

Disassembly of section .text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S9_:

0000000000000000 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)>:
   0:	endbr64 
   4:	push   %r12
   6:	mov    %rdx,%r9
   9:	mov    0x8(%rsi),%r8
   d:	mov    %rdi,%r12
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
  5b:	mov    (%rax),%rcx
  5e:	lea    0x10(%rax),%rdx
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
  ad:	mov    (%rax),%rcx
  b0:	lea    0x10(%rax),%rdx
  b4:	cmp    %rdx,%rcx
  b7:	jne    67 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x67>
  b9:	movdqu 0x10(%rax),%xmm1
  be:	movups %xmm1,0x10(%r12)
  c4:	jmp    74 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x74>
  c6:	cs nopw 0x0(%rax,%rax,1)
  d0:	movdqu 0x10(%rax),%xmm0
  d5:	movups %xmm0,0x10(%r12)
  db:	jmp    74 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x74>
  dd:	nopl   (%rax)
  e0:	mov    $0xf,%r10d
  e6:	jmp    2f <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x2f>
  eb:	nopl   0x0(%rax,%rax,1)
  f0:	mov    $0xf,%r10d
  f6:	jmp    48 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x48>

Disassembly of section .text._ZNSt6vectorIN3ivf8NeighborESaIS1_EE17_M_realloc_insertIJRKS1_EEEvN9__gnu_cxx17__normal_iteratorIPS1_S3_EEDpOT_:

0000000000000000 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)>:
   0:	endbr64 
   4:	movabs $0x7ffffffffffffff,%rcx
   e:	push   %r15
  10:	push   %r14
  12:	push   %r13
  14:	push   %r12
  16:	push   %rbp
  17:	push   %rbx
  18:	sub    $0x28,%rsp
  1c:	mov    0x8(%rdi),%r15
  20:	mov    (%rdi),%r12
  23:	mov    %r15,%rax
  26:	sub    %r12,%rax
  29:	sar    $0x4,%rax
  2d:	cmp    %rcx,%rax
  30:	je     15d <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x15d>
  36:	test   %rax,%rax
  39:	mov    $0x1,%ecx
  3e:	mov    %rsi,%rbp
  41:	mov    %rdi,%r13
  44:	cmovne %rax,%rcx
  48:	add    %rcx,%rax
  4b:	setb   %cl
  4e:	sub    %r12,%rsi
  51:	movzbl %cl,%ecx
  54:	test   %rcx,%rcx
  57:	jne    110 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x110>
  5d:	test   %rax,%rax
  60:	jne    143 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x143>
  66:	mov    $0x10,%ecx
  6b:	xor    %ebx,%ebx
  6d:	xor    %r14d,%r14d
  70:	movdqu (%rdx),%xmm2
  74:	movups %xmm2,(%r14,%rsi,1)
  79:	cmp    %r12,%rbp
  7c:	je     aa <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xaa>
  7e:	mov    %rbp,%rcx
  81:	mov    %r14,%rdx
  84:	mov    %r12,%rax
  87:	sub    %r12,%rcx
  8a:	nopw   0x0(%rax,%rax,1)
  90:	movdqu (%rax),%xmm1
  94:	add    $0x10,%rax
  98:	add    $0x10,%rdx
  9c:	movups %xmm1,-0x10(%rdx)
  a0:	cmp    %rbp,%rax
  a3:	jne    90 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x90>
  a5:	lea    0x10(%r14,%rcx,1),%rcx
  aa:	cmp    %r15,%rbp
  ad:	je     c6 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xc6>
  af:	sub    %rbp,%r15
  b2:	mov    %rcx,%rdi
  b5:	mov    %rbp,%rsi
  b8:	mov    %r15,%rdx
  bb:	call   c0 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xc0>
  c0:	mov    %rax,%rcx
  c3:	add    %r15,%rcx
  c6:	movq   %r14,%xmm0
  cb:	movq   %rcx,%xmm3
  d0:	punpcklqdq %xmm3,%xmm0
  d4:	test   %r12,%r12
  d7:	je     f1 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xf1>
  d9:	mov    0x10(%r13),%rsi
  dd:	mov    %r12,%rdi
  e0:	movaps %xmm0,(%rsp)
  e4:	sub    %r12,%rsi
  e7:	call   ec <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xec>
  ec:	movdqa (%rsp),%xmm0
  f1:	mov    %rbx,0x10(%r13)
  f5:	movups %xmm0,0x0(%r13)
  fa:	add    $0x28,%rsp
  fe:	pop    %rbx
  ff:	pop    %rbp
 100:	pop    %r12
 102:	pop    %r13
 104:	pop    %r14
 106:	pop    %r15
 108:	ret    
 109:	nopl   0x0(%rax)
 110:	movabs $0x7ffffffffffffff0,%rbx
 11a:	mov    %rbx,%rdi
 11d:	mov    %rdx,0x18(%rsp)
 122:	mov    %rsi,(%rsp)
 126:	call   12b <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x12b>
 12b:	mov    (%rsp),%rsi
 12f:	mov    0x18(%rsp),%rdx
 134:	mov    %rax,%r14
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
 164:	call   169 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x19>

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
  1a:	mov    %rdx,%rcx
  1d:	mov    %rsi,0x10(%rsp)
  22:	and    $0x1,%ecx
  25:	mov    %rdx,0x38(%rsp)
  2a:	mov    %r8,0x8(%rsp)
  2f:	movsd  %xmm0,0x30(%rsp)
  35:	mov    %fs:0x28,%rax
  3e:	mov    %rax,0x58(%rsp)
  43:	xor    %eax,%eax
  45:	lea    -0x1(%rdx),%rax
  49:	mov    %rcx,0x20(%rsp)
  4e:	mov    %rax,%r12
  51:	shr    $0x3f,%r12
  55:	add    %rax,%r12
  58:	mov    %r12,%rax
  5b:	sar    %rax
  5e:	mov    %rax,0x18(%rsp)
  63:	cmp    %rax,%rsi
  66:	jge    1a0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1a0>
  6c:	mov    %rsi,%r12
  6f:	jmp    95 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x95>
  71:	nopl   0x0(%rax)
  78:	movdqu 0x0(%r13),%xmm2
  7e:	movups %xmm2,0x0(%rbp,%r8,1)
  84:	cmp    0x18(%rsp),%r14
  89:	jge    210 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x210>
  8f:	mov    %r14,%rbx
  92:	mov    %rbx,%r12
  95:	lea    0x1(%r12),%rax
  9a:	lea    (%rax,%rax,1),%r14
  9e:	shl    $0x5,%rax
  a2:	lea    -0x1(%r14),%rbx
  a6:	lea    0x0(%rbp,%rax,1),%r13
  ab:	mov    0x8(%rsp),%rax
  b0:	mov    %rbx,%rdx
  b3:	mov    %r13,%rdi
  b6:	shl    $0x4,%rdx
  ba:	lea    0x0(%rbp,%rdx,1),%r15
  bf:	mov    %r15,%rsi
  c2:	call   *%rax
  c4:	mov    %r12,%r8
  c7:	shl    $0x4,%r8
  cb:	test   %al,%al
  cd:	je     78 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x78>
  cf:	movdqu (%r15),%xmm3
  d4:	movups %xmm3,0x0(%rbp,%r8,1)
  da:	cmp    0x18(%rsp),%rbx
  df:	jl     92 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x92>
  e1:	cmpq   $0x0,0x20(%rsp)
  e7:	je     1c0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1c0>
  ed:	mov    0x30(%rsp),%rax
  f2:	mov    %rax,0x40(%rsp)
  f7:	mov    0x28(%rsp),%rax
  fc:	mov    %rax,0x48(%rsp)
 101:	lea    -0x1(%rbx),%rax
 105:	mov    %rax,%r14
 108:	shr    $0x3f,%r14
 10c:	add    %rax,%r14
 10f:	sar    %r14
 112:	cmp    0x10(%rsp),%rbx
 117:	jle    170 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x170>
 119:	lea    0x40(%rsp),%r12
 11e:	jmp    14c <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x14c>
 120:	lea    -0x1(%r14),%rdx
 124:	movdqu 0x0(%r13),%xmm1
 12a:	mov    %r14,%rbx
 12d:	mov    %rdx,%rax
 130:	shr    $0x3f,%rax
 134:	movups %xmm1,(%r15)
 138:	add    %rdx,%rax
 13b:	sar    %rax
 13e:	cmp    %r14,0x10(%rsp)
 143:	jge    200 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x200>
 149:	mov    %rax,%r14
 14c:	mov    %r14,%r13
 14f:	mov    0x8(%rsp),%rax
 154:	mov    %r12,%rsi
 157:	shl    $0x4,%rbx
 15b:	shl    $0x4,%r13
 15f:	lea    0x0(%rbp,%rbx,1),%r15
 164:	add    %rbp,%r13
 167:	mov    %r13,%rdi
 16a:	call   *%rax
 16c:	test   %al,%al
 16e:	jne    120 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x120>
 170:	movdqa 0x40(%rsp),%xmm4
 176:	movups %xmm4,(%r15)
 17a:	mov    0x58(%rsp),%rax
 17f:	sub    %fs:0x28,%rax
 188:	jne    23d <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x23d>
 18e:	add    $0x68,%rsp
 192:	pop    %rbx
 193:	pop    %rbp
 194:	pop    %r12
 196:	pop    %r13
 198:	pop    %r14
 19a:	pop    %r15
 19c:	ret    
 19d:	nopl   (%rax)
 1a0:	mov    %rsi,%rdx
 1a3:	shl    $0x4,%rdx
 1a7:	cmpq   $0x0,0x20(%rsp)
 1ad:	lea    (%rdi,%rdx,1),%r15
 1b1:	jne    224 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x224>
 1b3:	mov    %rsi,%rbx
 1b6:	cs nopw 0x0(%rax,%rax,1)
 1c0:	mov    0x38(%rsp),%r13
 1c5:	sub    $0x2,%r13
 1c9:	mov    %r13,%rax
 1cc:	shr    $0x3f,%rax
 1d0:	add    %r13,%rax
 1d3:	sar    %rax
 1d6:	cmp    %rbx,%rax
 1d9:	jne    ed <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xed>
 1df:	lea    0x1(%rbx,%rbx,1),%rbx
 1e4:	mov    %rbx,%rax
 1e7:	shl    $0x4,%rax
 1eb:	add    %rbp,%rax
 1ee:	movdqu (%rax),%xmm5
 1f2:	movups %xmm5,(%r15)
 1f6:	mov    %rax,%r15
 1f9:	jmp    ed <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xed>
 1fe:	xchg   %ax,%ax
 200:	mov    %r13,%r15
 203:	jmp    170 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x170>
 208:	nopl   0x0(%rax,%rax,1)
 210:	cmpq   $0x0,0x20(%rsp)
 216:	mov    %r13,%r15
 219:	mov    %r14,%rbx
 21c:	jne    ed <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0xed>
 222:	jmp    1c0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1c0>
 224:	mov    0x30(%rsp),%rax
 229:	mov    %rax,0x40(%rsp)
 22e:	mov    0x28(%rsp),%rax
 233:	mov    %rax,0x48(%rsp)
 238:	jmp    170 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x170>
 23d:	call   242 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf2>
