
results/vec/ivf_search_default.o:     file format elf64-x86-64


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
      33:	data16 cs nopw 0x0(%rax,%rax,1)
      3e:	xchg   %ax,%ax

0000000000000040 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)>:
      40:	endbr64
      44:	test   %rdx,%rdx
      47:	je     80 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)+0x40>
      49:	xor    %eax,%eax
      4b:	pxor   %xmm1,%xmm1
      4f:	nop
      50:	pxor   %xmm0,%xmm0
      54:	pxor   %xmm2,%xmm2
      58:	cvtss2sd (%rdi,%rax,4),%xmm0
      5d:	cvtss2sd (%rsi,%rax,4),%xmm2
      62:	subsd  %xmm2,%xmm0
      66:	add    $0x1,%rax
      6a:	mulsd  %xmm0,%xmm0
      6e:	addsd  %xmm0,%xmm1
      72:	cmp    %rax,%rdx
      75:	jne    50 <ivf::l2_distance_scalar(float const*, float const*, unsigned long)+0x10>
      77:	movapd %xmm1,%xmm0
      7b:	ret
      7c:	nopl   0x0(%rax)
      80:	pxor   %xmm1,%xmm1
      84:	movapd %xmm1,%xmm0
      88:	ret
      89:	nopl   0x0(%rax)

0000000000000090 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)>:
      90:	endbr64
      94:	push   %r15
      96:	mov    %rdx,%r15
      99:	push   %r14
      9b:	push   %r13
      9d:	mov    %rcx,%r13
      a0:	push   %r12
      a2:	push   %rbp
      a3:	push   %rbx
      a4:	test   %rdx,%rdx
      a7:	je     2a9 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x219>
      ad:	lea    0x0(,%r13,4),%r11
      b5:	mov    %rdi,%rbp
      b8:	xor    %r12d,%r12d
      bb:	xor    %edx,%edx
      bd:	mov    %r11,%rax
      c0:	mov    0x10(%rsi),%rcx
      c4:	mov    0x8(%rsi),%r14
      c8:	mov    %r11,-0x18(%rsp)
      cd:	sar    $0x2,%rax
      d1:	mov    %r11,%rbx
      d4:	xor    %r8d,%r8d
      d7:	mov    %rax,-0x8(%rsp)
      dc:	mov    %r11,%rax
      df:	lea    (%rcx,%r11,1),%r9
      e3:	sar    $0x4,%rbx
      e7:	and    $0xfffffffffffffff0,%rax
      eb:	shl    $0x2,%r14
      ef:	add    %rax,%rcx
      f2:	mov    %r13,%rax
      f5:	shl    $0x4,%rax
      f9:	mov    %rax,-0x10(%rsp)
      fe:	xchg   %ax,%ax
     100:	mov    -0x18(%rsp),%rax
     105:	mov    %r9,%r11
     108:	sub    %rax,%r11
     10b:	test   %r13,%r13
     10e:	je     196 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x106>
     114:	mov    0x0(%rbp),%r10
     118:	mov    -0x10(%rsp),%rsi
     11d:	mov    %r12,%rax
     120:	mov    %rdx,-0x20(%rsp)
     125:	shl    $0x4,%rax
     129:	lea    (%r10,%rax,1),%rdi
     12d:	add    %rsi,%r10
     130:	add    %rax,%r10
     133:	nopl   0x0(%rax,%rax,1)
     138:	mov    0x8(%rdi),%edx
     13b:	cmp    $0xffffffff,%edx
     13e:	je     188 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf8>
     140:	test   %rbx,%rbx
     143:	jle    257 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1c7>
     149:	mov    %r11,%rax
     14c:	jmp    178 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xe8>
     14e:	xchg   %ax,%ax
     150:	cmp    0x4(%rax),%edx
     153:	je     1e8 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x158>
     159:	cmp    0x8(%rax),%edx
     15c:	je     1f0 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x160>
     162:	cmp    0xc(%rax),%edx
     165:	je     200 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x170>
     16b:	add    $0x10,%rax
     16f:	cmp    %rcx,%rax
     172:	je     210 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x180>
     178:	cmp    (%rax),%edx
     17a:	jne    150 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xc0>
     17c:	cmp    %r9,%rax
     17f:	setne  %al
     182:	movzbl %al,%eax
     185:	add    %rax,%r8
     188:	add    $0x10,%rdi
     18c:	cmp    %r10,%rdi
     18f:	jne    138 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xa8>
     191:	mov    -0x20(%rsp),%rdx
     196:	add    $0x1,%rdx
     19a:	add    %r14,%r9
     19d:	add    %r13,%r12
     1a0:	add    %r14,%rcx
     1a3:	cmp    %rdx,%r15
     1a6:	jne    100 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x70>
     1ac:	test   %r8,%r8
     1af:	js     28a <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1fa>
     1b5:	pxor   %xmm0,%xmm0
     1b9:	cvtsi2sd %r8,%xmm0
     1be:	imul   %r13,%r15
     1c2:	test   %r15,%r15
     1c5:	js     261 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1d1>
     1cb:	pxor   %xmm1,%xmm1
     1cf:	pop    %rbx
     1d0:	pop    %rbp
     1d1:	cvtsi2sd %r15,%xmm1
     1d6:	pop    %r12
     1d8:	pop    %r13
     1da:	pop    %r14
     1dc:	pop    %r15
     1de:	divsd  %xmm1,%xmm0
     1e2:	ret
     1e3:	nopl   0x0(%rax,%rax,1)
     1e8:	add    $0x4,%rax
     1ec:	jmp    17c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xec>
     1ee:	xchg   %ax,%ax
     1f0:	add    $0x8,%rax
     1f4:	jmp    17c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xec>
     1f9:	nopl   0x0(%rax)
     200:	add    $0xc,%rax
     204:	jmp    17c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xec>
     209:	nopl   0x0(%rax)
     210:	mov    %r9,%rsi
     213:	sub    %rax,%rsi
     216:	sar    $0x2,%rsi
     21a:	cmp    $0x2,%rsi
     21e:	je     249 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1b9>
     220:	cmp    $0x3,%rsi
     224:	je     23d <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1ad>
     226:	cmp    $0x1,%rsi
     22a:	jne    188 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf8>
     230:	cmp    (%rax),%edx
     232:	jne    188 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xf8>
     238:	jmp    17c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xec>
     23d:	cmp    (%rax),%edx
     23f:	je     17c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xec>
     245:	add    $0x4,%rax
     249:	cmp    (%rax),%edx
     24b:	je     17c <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0xec>
     251:	add    $0x4,%rax
     255:	jmp    230 <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x1a0>
     257:	mov    -0x8(%rsp),%rsi
     25c:	mov    %r11,%rax
     25f:	jmp    21a <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x18a>
     261:	mov    %r15,%rax
     264:	and    $0x1,%r15d
     268:	pxor   %xmm1,%xmm1
     26c:	pop    %rbx
     26d:	shr    $1,%rax
     270:	pop    %rbp
     271:	pop    %r12
     273:	or     %r15,%rax
     276:	pop    %r13
     278:	pop    %r14
     27a:	cvtsi2sd %rax,%xmm1
     27f:	pop    %r15
     281:	addsd  %xmm1,%xmm1
     285:	divsd  %xmm1,%xmm0
     289:	ret
     28a:	mov    %r8,%rax
     28d:	and    $0x1,%r8d
     291:	pxor   %xmm0,%xmm0
     295:	shr    $1,%rax
     298:	or     %r8,%rax
     29b:	cvtsi2sd %rax,%xmm0
     2a0:	addsd  %xmm0,%xmm0
     2a4:	jmp    1be <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x12e>
     2a9:	pxor   %xmm0,%xmm0
     2ad:	jmp    1be <ivf::recall_at_k(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, ivf::Matrix<int> const&, unsigned long, unsigned long)+0x12e>
     2b2:	data16 cs nopw 0x0(%rax,%rax,1)
     2bd:	nopl   (%rax)

00000000000002c0 <ivf::TopK::TopK(unsigned long)>:
     2c0:	endbr64
     2c4:	push   %r12
     2c6:	mov    %rsi,%rax
     2c9:	pxor   %xmm0,%xmm0
     2cd:	push   %rbp
     2ce:	push   %rbx
     2cf:	mov    %rdi,%rbx
     2d2:	sub    $0x10,%rsp
     2d6:	shr    $0x3b,%rax
     2da:	mov    %rsi,(%rdi)
     2dd:	movq   $0x0,0x18(%rdi)
     2e5:	movups %xmm0,0x8(%rdi)
     2e9:	jne    37b <ivf::TopK::TopK(unsigned long)+0xbb>
     2ef:	test   %rsi,%rsi
     2f2:	jne    300 <ivf::TopK::TopK(unsigned long)+0x40>
     2f4:	add    $0x10,%rsp
     2f8:	pop    %rbx
     2f9:	pop    %rbp
     2fa:	pop    %r12
     2fc:	ret
     2fd:	nopl   (%rax)
     300:	shl    $0x4,%rsi
     304:	mov    %rsi,%rdi
     307:	mov    %rsi,%rbp
     30a:	call   30f <ivf::TopK::TopK(unsigned long)+0x4f>
     30f:	mov    0x10(%rbx),%rsi
     313:	mov    0x8(%rbx),%rdi
     317:	movq   %rax,%xmm0
     31c:	mov    %rax,%r12
     31f:	punpcklqdq %xmm0,%xmm0
     323:	cmp    %rdi,%rsi
     326:	je     34d <ivf::TopK::TopK(unsigned long)+0x8d>
     328:	sub    %rdi,%rsi
     32b:	mov    %rax,%rdx
     32e:	mov    %rdi,%rcx
     331:	add    %rax,%rsi
     334:	nopl   0x0(%rax)
     338:	movdqu (%rcx),%xmm1
     33c:	add    $0x10,%rdx
     340:	add    $0x10,%rcx
     344:	movups %xmm1,-0x10(%rdx)
     348:	cmp    %rdx,%rsi
     34b:	jne    338 <ivf::TopK::TopK(unsigned long)+0x78>
     34d:	test   %rdi,%rdi
     350:	je     367 <ivf::TopK::TopK(unsigned long)+0xa7>
     352:	mov    0x18(%rbx),%rsi
     356:	movaps %xmm0,(%rsp)
     35a:	sub    %rdi,%rsi
     35d:	call   362 <ivf::TopK::TopK(unsigned long)+0xa2>
     362:	movdqa (%rsp),%xmm0
     367:	add    %rbp,%r12
     36a:	movups %xmm0,0x8(%rbx)
     36e:	mov    %r12,0x18(%rbx)
     372:	add    $0x10,%rsp
     376:	pop    %rbx
     377:	pop    %rbp
     378:	pop    %r12
     37a:	ret
     37b:	lea    0x0(%rip),%rdi        # 382 <ivf::TopK::TopK(unsigned long)+0xc2>
     382:	call   387 <ivf::TopK::TopK(unsigned long)+0xc7>
     387:	endbr64
     38b:	mov    %rax,%rbp
     38e:	jmp    393 <ivf::TopK::TopK(unsigned long)+0xd3>
     393:	data16 cs nopw 0x0(%rax,%rax,1)
     39e:	xchg   %ax,%ax

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
     3f2:	je     4b0 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x110>
     3f8:	movq   0x0(%rip),%xmm2        # 400 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x60>
     400:	movsd  0x0(%rip),%xmm5        # 408 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x68>
     408:	xor    %ecx,%ecx
     40a:	movsd  0x0(%rip),%xmm6        # 412 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x72>
     412:	movsd  0x0(%rip),%xmm4        # 41a <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x7a>
     41a:	jmp    479 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xd9>
     41c:	nopl   0x0(%rax)
     420:	movapd %xmm0,%xmm1
     424:	andpd  %xmm2,%xmm1
     428:	ucomisd %xmm1,%xmm5
     42c:	jb     432 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x92>
     432:	movsd  0x0(%rbp),%xmm3
     437:	movapd %xmm3,%xmm1
     43b:	subsd  %xmm3,%xmm0
     43f:	andpd  %xmm2,%xmm1
     443:	mulsd  %xmm6,%xmm1
     447:	andpd  %xmm2,%xmm0
     44b:	addsd  %xmm6,%xmm1
     44f:	comisd %xmm0,%xmm1
     453:	jb     459 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xb9>
     459:	cmp    0x8(%rbx),%eax
     45c:	jne    462 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xc2>
     462:	nopw   0x0(%rax,%rax,1)
     468:	add    $0x1,%r12
     46c:	add    $0x10,%rbp
     470:	add    $0x10,%rbx
     474:	cmp    %rdx,%r12
     477:	jae    4b0 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x110>
     479:	mov    0x8(%rbp),%eax
     47c:	movsd  (%rbx),%xmm0
     480:	cmp    $0xffffffff,%eax
     483:	jne    420 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x80>
     485:	cmpl   $0xffffffff,0x8(%rbx)
     489:	jne    48f <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xef>
     48f:	ucomisd 0x0(%rip),%xmm0        # 497 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xf7>
     497:	setnp  %al
     49a:	ucomisd %xmm4,%xmm0
     49e:	cmovne %ecx,%eax
     4a1:	test   %al,%al
     4a3:	jne    468 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0xc8>
     4a5:	jmp    4aa <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x10a>
     4aa:	nopw   0x0(%rax,%rax,1)
     4b0:	mov    0x128(%rsp),%rax
     4b8:	sub    %fs:0x28,%rax
     4c1:	jne    4d5 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x135>
     4c3:	add    $0x138,%rsp
     4ca:	pop    %rbx
     4cb:	pop    %rbp
     4cc:	pop    %r12
     4ce:	pop    %r13
     4d0:	pop    %r14
     4d2:	pop    %r15
     4d4:	ret
     4d5:	call   4da <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&)+0x13a>
     4da:	nopw   0x0(%rax,%rax,1)

00000000000004e0 <ivf::TopK::add(ivf::Neighbor)>:
     4e0:	endbr64
     4e4:	push   %rbx
     4e5:	mov    %rdi,%rbx
     4e8:	sub    $0x40,%rsp
     4ec:	mov    0x8(%rdi),%r9
     4f0:	mov    %rsi,0x18(%rsp)
     4f5:	mov    0x10(%rdi),%rsi
     4f9:	movq   %xmm0,0x10(%rsp)
     4ff:	mov    %fs:0x28,%rax
     508:	mov    %rax,0x38(%rsp)
     50d:	xor    %eax,%eax
     50f:	mov    %rsi,%rax
     512:	sub    %r9,%rax
     515:	mov    %rax,%rdx
     518:	sar    $0x4,%rdx
     51c:	cmp    (%rdi),%rdx
     51f:	jb     6b0 <ivf::TopK::add(ivf::Neighbor)+0x1d0>
     525:	movsd  0x10(%rsp),%xmm1
     52b:	movsd  (%r9),%xmm0
     530:	comisd %xmm1,%xmm0
     534:	jbe    598 <ivf::TopK::add(ivf::Neighbor)+0xb8>
     536:	cmp    $0x10,%rax
     53a:	jg     5b0 <ivf::TopK::add(ivf::Neighbor)+0xd0>
     53c:	mov    0x10(%rsp),%rax
     541:	sub    $0x1,%rdx
     545:	movsd  %xmm1,0x20(%rsp)
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
     585:	jne    79d <ivf::TopK::add(ivf::Neighbor)+0x2bd>
     58b:	add    $0x40,%rsp
     58f:	pop    %rbx
     590:	ret
     591:	nopl   0x0(%rax)
     598:	ucomisd %xmm0,%xmm1
     59c:	jp     577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     59e:	jne    577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     5a0:	mov    0x8(%r9),%ecx
     5a4:	cmp    %ecx,0x18(%rsp)
     5a8:	jge    577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     5aa:	jmp    536 <ivf::TopK::add(ivf::Neighbor)+0x56>
     5ac:	nopl   0x0(%rax)
     5b0:	mov    (%r9),%rax
     5b3:	movq   -0x10(%rsi),%xmm0
     5b8:	lea    -0x10(%rsi),%rdx
     5bc:	mov    %r9,%rdi
     5bf:	mov    -0x8(%rsi),%rcx
     5c3:	sub    %r9,%rdx
     5c6:	lea    0x0(%rip),%r8        # 5cd <ivf::TopK::add(ivf::Neighbor)+0xed>
     5cd:	movsd  %xmm1,0x8(%rsp)
     5d3:	mov    %rax,-0x10(%rsi)
     5d7:	mov    0x8(%r9),%eax
     5db:	sar    $0x4,%rdx
     5df:	mov    %eax,-0x8(%rsi)
     5e2:	xor    %esi,%esi
     5e4:	call   5e9 <ivf::TopK::add(ivf::Neighbor)+0x109>
     5e9:	mov    0x10(%rbx),%rdx
     5ed:	mov    0x8(%rbx),%r9
     5f1:	mov    0x10(%rsp),%rcx
     5f6:	movsd  0x8(%rsp),%xmm1
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
     624:	movsd  %xmm1,0x20(%rsp)
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
     6b4:	je     778 <ivf::TopK::add(ivf::Neighbor)+0x298>
     6ba:	movdqa 0x10(%rsp),%xmm2
     6c0:	add    $0x10,%rsi
     6c4:	movups %xmm2,-0x10(%rsi)
     6c8:	mov    %rsi,0x10(%rdi)
     6cc:	mov    %rsi,%rdx
     6cf:	mov    -0x8(%rsi),%ecx
     6d2:	movsd  -0x10(%rsi),%xmm0
     6d7:	sub    %r9,%rdx
     6da:	mov    %rdx,%rax
     6dd:	mov    %ecx,0x28(%rsp)
     6e1:	sar    $0x4,%rax
     6e5:	movsd  %xmm0,0x20(%rsp)
     6eb:	lea    -0x1(%rax),%r10
     6ef:	sub    $0x2,%rax
     6f3:	mov    %rax,%r8
     6f6:	shr    $0x3f,%r8
     6fa:	add    %rax,%r8
     6fd:	sar    $1,%r8
     700:	test   %r10,%r10
     703:	jle    793 <ivf::TopK::add(ivf::Neighbor)+0x2b3>
     709:	lea    0x20(%rsp),%rcx
     70e:	jmp    73c <ivf::TopK::add(ivf::Neighbor)+0x25c>
     710:	mov    (%rdi),%rdx
     713:	mov    %r8,%r10
     716:	mov    %rdx,(%rax)
     719:	mov    0x8(%rdi),%edx
     71c:	mov    %edx,0x8(%rax)
     71f:	lea    -0x1(%r8),%rdx
     723:	mov    %rdx,%rax
     726:	shr    $0x3f,%rax
     72a:	add    %rdx,%rax
     72d:	sar    $1,%rax
     730:	test   %r8,%r8
     733:	je     690 <ivf::TopK::add(ivf::Neighbor)+0x1b0>
     739:	mov    %rax,%r8
     73c:	mov    %r8,%rax
     73f:	mov    %rcx,%rsi
     742:	shl    $0x4,%rax
     746:	lea    (%r9,%rax,1),%rdi
     74a:	call   74f <ivf::TopK::add(ivf::Neighbor)+0x26f>
     74f:	mov    %eax,%edx
     751:	mov    %r10,%rax
     754:	shl    $0x4,%rax
     758:	add    %r9,%rax
     75b:	test   %dl,%dl
     75d:	jne    710 <ivf::TopK::add(ivf::Neighbor)+0x230>
     75f:	mov    0x20(%rsp),%rdx
     764:	mov    %rdx,(%rax)
     767:	mov    0x28(%rsp),%edx
     76b:	mov    %edx,0x8(%rax)
     76e:	jmp    577 <ivf::TopK::add(ivf::Neighbor)+0x97>
     773:	nopl   0x0(%rax,%rax,1)
     778:	lea    0x10(%rsp),%rdx
     77d:	lea    0x8(%rdi),%rdi
     781:	call   786 <ivf::TopK::add(ivf::Neighbor)+0x2a6>
     786:	mov    0x8(%rbx),%r9
     78a:	mov    0x10(%rbx),%rsi
     78e:	jmp    6cc <ivf::TopK::add(ivf::Neighbor)+0x1ec>
     793:	lea    -0x10(%r9,%rdx,1),%rax
     798:	jmp    568 <ivf::TopK::add(ivf::Neighbor)+0x88>
     79d:	call   7a2 <ivf::TopK::add(ivf::Neighbor)+0x2c2>
     7a2:	data16 cs nopw 0x0(%rax,%rax,1)
     7ad:	nopl   (%rax)

00000000000007b0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)>:
     7b0:	endbr64
     7b4:	push   %r15
     7b6:	push   %r14
     7b8:	push   %r13
     7ba:	push   %r12
     7bc:	push   %rbp
     7bd:	push   %rbx
     7be:	sub    $0x48,%rsp
     7c2:	mov    %fs:0x28,%rax
     7cb:	mov    %rax,0x38(%rsp)
     7d0:	mov    0x10(%rsi),%rax
     7d4:	mov    %rax,0x8(%rsp)
     7d9:	shr    $0x3b,%rax
     7dd:	jne    bc9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x419>
     7e3:	cmpq   $0x0,0x8(%rsp)
     7e9:	mov    %rdi,%r14
     7ec:	mov    %rcx,%r13
     7ef:	je     af9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x349>
     7f5:	shlq   $0x4,0x8(%rsp)
     7fb:	mov    0x8(%rsp),%r12
     800:	mov    %rsi,%r15
     803:	mov    %rdx,%rbp
     806:	mov    %r12,%rdi
     809:	call   80e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x5e>
     80e:	movsd  0x0(%rip),%xmm0        # 816 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x66>
     816:	add    %rax,%r12
     819:	mov    %rax,0x20(%rsp)
     81e:	mov    %rax,%rbx
     821:	mov    %r12,0x30(%rsp)
     826:	cs nopw 0x0(%rax,%rax,1)
     830:	movl   $0xffffffff,0x8(%rax)
     837:	add    $0x10,%rax
     83b:	movsd  %xmm0,-0x10(%rax)
     840:	cmp    %r12,%rax
     843:	jne    830 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x80>
     845:	mov    0x10(%r15),%r8
     849:	mov    %r12,0x28(%rsp)
     84e:	test   %r8,%r8
     851:	je     8c0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x110>
     853:	mov    0x8(%r15),%rcx
     857:	mov    0x60(%r15),%rdx
     85b:	mov    %rbx,%rdi
     85e:	xor    %esi,%esi
     860:	lea    0x0(,%rcx,4),%r9
     868:	nopl   0x0(%rax,%rax,1)
     870:	pxor   %xmm1,%xmm1
     874:	test   %rcx,%rcx
     877:	je     8a8 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xf8>
     879:	xor    %eax,%eax
     87b:	nopl   0x0(%rax,%rax,1)
     880:	pxor   %xmm0,%xmm0
     884:	pxor   %xmm2,%xmm2
     888:	cvtss2sd 0x0(%rbp,%rax,4),%xmm0
     88e:	cvtss2sd (%rdx,%rax,4),%xmm2
     893:	subsd  %xmm2,%xmm0
     897:	add    $0x1,%rax
     89b:	mulsd  %xmm0,%xmm0
     89f:	addsd  %xmm0,%xmm1
     8a3:	cmp    %rax,%rcx
     8a6:	jne    880 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xd0>
     8a8:	mov    %esi,0x8(%rdi)
     8ab:	add    $0x1,%rsi
     8af:	add    $0x10,%rdi
     8b3:	add    %r9,%rdx
     8b6:	movsd  %xmm1,-0x10(%rdi)
     8bb:	cmp    %r8,%rsi
     8be:	jne    870 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0xc0>
     8c0:	mov    %r13,%rax
     8c3:	lea    0x0(%rip),%r15        # 8ca <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x11a>
     8ca:	shl    $0x4,%rax
     8ce:	lea    (%rbx,%rax,1),%rdi
     8d2:	mov    %rax,0x18(%rsp)
     8d7:	mov    %rdi,0x10(%rsp)
     8dc:	cmp    $0x10,%rax
     8e0:	jg     b3b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x38b>
     8e6:	cmp    %r12,0x10(%rsp)
     8eb:	jae    9aa <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1fa>
     8f1:	mov    0x18(%rsp),%rax
     8f6:	mov    0x10(%rsp),%rbp
     8fb:	sar    $0x4,%rax
     8ff:	mov    %rax,(%rsp)
     903:	nopl   0x0(%rax,%rax,1)
     908:	movsd  0x0(%rbp),%xmm1
     90d:	movsd  (%rbx),%xmm0
     911:	comisd %xmm1,%xmm0
     915:	ja     927 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x177>
     917:	ucomisd %xmm0,%xmm1
     91b:	jp     94e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x19e>
     91d:	jne    94e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x19e>
     91f:	mov    0x8(%rbx),%eax
     922:	cmp    %eax,0x8(%rbp)
     925:	jge    94e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x19e>
     927:	mov    (%rbx),%rax
     92a:	movq   0x0(%rbp),%xmm0
     92f:	mov    %r15,%r8
     932:	xor    %esi,%esi
     934:	mov    0x8(%rbp),%rcx
     938:	mov    (%rsp),%rdx
     93c:	mov    %rbx,%rdi
     93f:	mov    %rax,0x0(%rbp)
     943:	mov    0x8(%rbx),%eax
     946:	mov    %eax,0x8(%rbp)
     949:	call   94e <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x19e>
     94e:	add    $0x10,%rbp
     952:	cmp    %r12,%rbp
     955:	jb     908 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x158>
     957:	cmpq   $0x10,0x18(%rsp)
     95d:	jle    9aa <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1fa>
     95f:	mov    0x10(%rsp),%rbp
     964:	lea    0x0(%rip),%r15        # 96b <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1bb>
     96b:	sub    $0x10,%rbp
     96f:	nop
     970:	mov    (%rbx),%rax
     973:	movq   0x0(%rbp),%xmm0
     978:	mov    %rbp,%r12
     97b:	mov    %r15,%r8
     97e:	mov    0x8(%rbp),%rcx
     982:	sub    %rbx,%r12
     985:	xor    %esi,%esi
     987:	mov    %rbx,%rdi
     98a:	mov    %rax,0x0(%rbp)
     98e:	mov    0x8(%rbx),%eax
     991:	mov    %r12,%rdx
     994:	sar    $0x4,%rdx
     998:	mov    %eax,0x8(%rbp)
     99b:	call   9a0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1f0>
     9a0:	sub    $0x10,%rbp
     9a4:	cmp    $0x10,%r12
     9a8:	jg     970 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1c0>
     9aa:	mov    %r13,%rax
     9ad:	shr    $0x3d,%rax
     9b1:	jne    bea <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x43a>
     9b7:	pxor   %xmm0,%xmm0
     9bb:	movq   $0x0,0x10(%r14)
     9c3:	movups %xmm0,(%r14)
     9c7:	test   %r13,%r13
     9ca:	je     b9c <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3ec>
     9d0:	lea    0x0(,%r13,4),%r12
     9d8:	mov    %r12,%rdi
     9db:	call   9e0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x230>
     9e0:	lea    (%rax,%r12,1),%r15
     9e4:	mov    %rax,(%r14)
     9e7:	mov    %rax,%rbp
     9ea:	lea    0x4(%rax),%rdi
     9ee:	mov    %r15,0x10(%r14)
     9f2:	movl   $0x0,(%rax)
     9f8:	cmp    $0x1,%r13
     9fc:	je     ba9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3f9>
     a02:	cmp    %rdi,%r15
     a05:	je     a13 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x263>
     a07:	lea    -0x4(%r12),%rdx
     a0c:	xor    %esi,%esi
     a0e:	call   a13 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x263>
     a13:	lea    -0x1(%r13),%rcx
     a17:	mov    %r15,0x8(%r14)
     a1b:	cmp    $0x3,%rcx
     a1f:	jbe    bb8 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x408>
     a25:	mov    %rcx,%rsi
     a28:	mov    %rbp,%rdx
     a2b:	lea    0x8(%rbx),%rax
     a2f:	shr    $0x2,%rsi
     a33:	shl    $0x4,%rsi
     a37:	add    %rbp,%rsi
     a3a:	nopw   0x0(%rax,%rax,1)
     a40:	movdqu (%rax),%xmm0
     a44:	movdqu 0x10(%rax),%xmm3
     a49:	add    $0x10,%rdx
     a4d:	add    $0x40,%rax
     a51:	movdqu -0x20(%rax),%xmm1
     a56:	movdqu -0x10(%rax),%xmm4
     a5b:	shufps $0x88,%xmm3,%xmm0
     a5f:	shufps $0x88,%xmm4,%xmm1
     a63:	shufps $0x88,%xmm1,%xmm0
     a67:	movups %xmm0,-0x10(%rdx)
     a6b:	cmp    %rsi,%rdx
     a6e:	jne    a40 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x290>
     a70:	mov    %rcx,%rax
     a73:	and    $0xfffffffffffffffc,%rax
     a77:	mov    %rax,%rdx
     a7a:	lea    0x0(,%rax,4),%rcx
     a82:	shl    $0x4,%rdx
     a86:	mov    0x8(%rbx,%rdx,1),%esi
     a8a:	mov    %esi,0x0(%rbp,%rax,4)
     a8e:	lea    0x1(%rax),%rsi
     a92:	cmp    %r13,%rsi
     a95:	jae    ac1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x311>
     a97:	mov    0x18(%rbx,%rdx,1),%esi
     a9b:	mov    %esi,0x4(%rbp,%rcx,1)
     a9f:	lea    0x2(%rax),%rsi
     aa3:	cmp    %r13,%rsi
     aa6:	jae    ac1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x311>
     aa8:	mov    0x28(%rbx,%rdx,1),%esi
     aac:	add    $0x3,%rax
     ab0:	mov    %esi,0x8(%rbp,%rcx,1)
     ab4:	cmp    %r13,%rax
     ab7:	jae    ac1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x311>
     ab9:	mov    0x38(%rbx,%rdx,1),%eax
     abd:	mov    %eax,0xc(%rbp,%rcx,1)
     ac1:	test   %rbx,%rbx
     ac4:	je     ad3 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x323>
     ac6:	mov    0x8(%rsp),%rsi
     acb:	mov    %rbx,%rdi
     ace:	call   ad3 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x323>
     ad3:	mov    0x38(%rsp),%rax
     ad8:	sub    %fs:0x28,%rax
     ae1:	jne    be5 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x435>
     ae7:	add    $0x48,%rsp
     aeb:	mov    %r14,%rax
     aee:	pop    %rbx
     aef:	pop    %rbp
     af0:	pop    %r12
     af2:	pop    %r13
     af4:	pop    %r14
     af6:	pop    %r15
     af8:	ret
     af9:	mov    %rcx,%rax
     afc:	lea    0x0(%rip),%r15        # b03 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x353>
     b03:	xor    %ebx,%ebx
     b05:	movq   $0x0,0x20(%rsp)
     b0e:	movq   $0x0,0x30(%rsp)
     b17:	shl    $0x4,%rax
     b1b:	movq   $0x0,0x28(%rsp)
     b24:	mov    %rax,0x10(%rsp)
     b29:	mov    %rax,0x18(%rsp)
     b2e:	cmp    $0x10,%rax
     b32:	jle    9aa <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1fa>
     b38:	xor    %r12d,%r12d
     b3b:	sar    $0x4,%rax
     b3f:	mov    %rax,(%rsp)
     b43:	sub    $0x2,%rax
     b47:	mov    %rax,%rbp
     b4a:	shr    $0x3f,%rbp
     b4e:	add    %rax,%rbp
     b51:	sar    $1,%rbp
     b54:	jmp    b64 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3b4>
     b56:	cs nopw 0x0(%rax,%rax,1)
     b60:	sub    $0x1,%rbp
     b64:	mov    %rbp,%rax
     b67:	mov    (%rsp),%rdx
     b6b:	mov    %r15,%r8
     b6e:	mov    %rbp,%rsi
     b71:	shl    $0x4,%rax
     b75:	mov    %rbx,%rdi
     b78:	movq   (%rbx,%rax,1),%xmm0
     b7d:	mov    0x8(%rbx,%rax,1),%rcx
     b82:	call   b87 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3d7>
     b87:	test   %rbp,%rbp
     b8a:	jne    b60 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x3b0>
     b8c:	cmp    %r12,0x10(%rsp)
     b91:	jb     8f1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x141>
     b97:	jmp    95f <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x1af>
     b9c:	movq   $0x0,0x10(%r14)
     ba4:	jmp    ac1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x311>
     ba9:	mov    0x8(%rbx),%eax
     bac:	mov    %rdi,0x8(%r14)
     bb0:	mov    %eax,0x0(%rbp)
     bb3:	jmp    ac1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x311>
     bb8:	mov    0x8(%rbx),%eax
     bbb:	xor    %ecx,%ecx
     bbd:	xor    %edx,%edx
     bbf:	mov    %eax,0x0(%rbp)
     bc2:	xor    %eax,%eax
     bc4:	jmp    a97 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x2e7>
     bc9:	mov    0x38(%rsp),%rax
     bce:	sub    %fs:0x28,%rax
     bd7:	jne    be5 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x435>
     bd9:	lea    0x0(%rip),%rdi        # be0 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x430>
     be0:	call   be5 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x435>
     be5:	call   bea <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x43a>
     bea:	mov    0x38(%rsp),%rax
     bef:	sub    %fs:0x28,%rax
     bf8:	jne    be5 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x435>
     bfa:	lea    0x0(%rip),%rdi        # c01 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x451>
     c01:	call   c06 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x456>
     c06:	endbr64
     c0a:	mov    %rax,%rbx
     c0d:	jmp    c12 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long)+0x462>
     c12:	data16 cs nopw 0x0(%rax,%rax,1)
     c1d:	nopl   (%rax)

0000000000000c20 <ivf::TopK::finish(ivf::Neighbor*)>:
     c20:	endbr64
     c24:	push   %r15
     c26:	push   %r14
     c28:	push   %r13
     c2a:	mov    %rdi,%r13
     c2d:	push   %r12
     c2f:	push   %rbp
     c30:	mov    %rsi,%rbp
     c33:	push   %rbx
     c34:	sub    $0x8,%rsp
     c38:	mov    0x10(%rdi),%rbx
     c3c:	mov    0x8(%rdi),%r12
     c40:	mov    %rbx,%rdx
     c43:	sub    $0x10,%rbx
     c47:	sub    %r12,%rdx
     c4a:	cmp    $0x10,%rdx
     c4e:	jle    d08 <ivf::TopK::finish(ivf::Neighbor*)+0xe8>
     c54:	lea    0x0(%rip),%r14        # c5b <ivf::TopK::finish(ivf::Neighbor*)+0x3b>
     c5b:	nopl   0x0(%rax,%rax,1)
     c60:	mov    (%r12),%rax
     c64:	movq   (%rbx),%xmm0
     c68:	mov    %rbx,%r15
     c6b:	mov    %r14,%r8
     c6e:	mov    0x8(%rbx),%rcx
     c72:	sub    %r12,%r15
     c75:	xor    %esi,%esi
     c77:	mov    %r12,%rdi
     c7a:	mov    %rax,(%rbx)
     c7d:	mov    0x8(%r12),%eax
     c82:	mov    %r15,%rdx
     c85:	sub    $0x10,%rbx
     c89:	sar    $0x4,%rdx
     c8d:	mov    %eax,0x18(%rbx)
     c90:	call   c95 <ivf::TopK::finish(ivf::Neighbor*)+0x75>
     c95:	cmp    $0x10,%r15
     c99:	jg     c60 <ivf::TopK::finish(ivf::Neighbor*)+0x40>
     c9b:	mov    0x8(%r13),%r12
     c9f:	mov    0x10(%r13),%rdx
     ca3:	sub    %r12,%rdx
     ca6:	cmp    $0x10,%rdx
     caa:	jle    d08 <ivf::TopK::finish(ivf::Neighbor*)+0xe8>
     cac:	mov    %r12,%rsi
     caf:	mov    %rbp,%rdi
     cb2:	call   cb7 <ivf::TopK::finish(ivf::Neighbor*)+0x97>
     cb7:	mov    0x10(%r13),%rdx
     cbb:	sub    0x8(%r13),%rdx
     cbf:	mov    0x0(%r13),%rax
     cc3:	add    %rbp,%rdx
     cc6:	movsd  0x0(%rip),%xmm0        # cce <ivf::TopK::finish(ivf::Neighbor*)+0xae>
     cce:	shl    $0x4,%rax
     cd2:	add    %rbp,%rax
     cd5:	cmp    %rdx,%rax
     cd8:	je     cf5 <ivf::TopK::finish(ivf::Neighbor*)+0xd5>
     cda:	nopw   0x0(%rax,%rax,1)
     ce0:	movl   $0xffffffff,0x8(%rdx)
     ce7:	add    $0x10,%rdx
     ceb:	movsd  %xmm0,-0x10(%rdx)
     cf0:	cmp    %rdx,%rax
     cf3:	jne    ce0 <ivf::TopK::finish(ivf::Neighbor*)+0xc0>
     cf5:	add    $0x8,%rsp
     cf9:	pop    %rbx
     cfa:	pop    %rbp
     cfb:	pop    %r12
     cfd:	pop    %r13
     cff:	pop    %r14
     d01:	pop    %r15
     d03:	ret
     d04:	nopl   0x0(%rax)
     d08:	cmp    $0x10,%rdx
     d0c:	jne    cbf <ivf::TopK::finish(ivf::Neighbor*)+0x9f>
     d0e:	mov    (%r12),%rax
     d12:	mov    %rax,0x0(%rbp)
     d16:	mov    0x8(%r12),%eax
     d1b:	mov    %eax,0x8(%rbp)
     d1e:	jmp    cbf <ivf::TopK::finish(ivf::Neighbor*)+0x9f>

0000000000000d20 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)>:
     d20:	endbr64
     d24:	push   %r15
     d26:	push   %r14
     d28:	push   %r13
     d2a:	push   %r12
     d2c:	push   %rbp
     d2d:	push   %rbx
     d2e:	sub    $0x58,%rsp
     d32:	mov    %rdx,0x10(%rsp)
     d37:	mov    %rcx,0x8(%rsp)
     d3c:	mov    %r8,0x18(%rsp)
     d41:	mov    %fs:0x28,%rax
     d4a:	mov    %rax,0x48(%rsp)
     d4f:	xor    %eax,%eax
     d51:	test   %rdx,%rdx
     d54:	je     e72 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x152>
     d5a:	lea    0x20(%rsp),%rax
     d5f:	mov    %rdi,%r12
     d62:	mov    %rsi,%r15
     d65:	xor    %r13d,%r13d
     d68:	movabs $0xffffffff00000000,%r14
     d72:	mov    %rax,(%rsp)
     d76:	cs nopw 0x0(%rax,%rax,1)
     d80:	mov    0x8(%rsp),%rax
     d85:	mov    (%rsp),%rdi
     d89:	mov    (%rax),%rsi
     d8c:	call   d91 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x71>
     d91:	cmpq   $0x0,(%r12)
     d96:	je     e2b <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x10b>
     d9c:	xor    %ebx,%ebx
     d9e:	xchg   %ax,%ax
     da0:	mov    0x8(%r12),%rcx
     da5:	mov    0x48(%r12),%rsi
     daa:	mov    %rcx,%rax
     dad:	mov    %rcx,%rdx
     db0:	imul   %rbx,%rax
     db4:	imul   %r13,%rdx
     db8:	shl    $0x2,%rax
     dbc:	shl    $0x2,%rdx
     dc0:	test   %rcx,%rcx
     dc3:	je     e98 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x178>
     dc9:	add    %rax,%rsi
     dcc:	add    %r15,%rdx
     dcf:	pxor   %xmm1,%xmm1
     dd3:	xor    %eax,%eax
     dd5:	nopl   (%rax)
     dd8:	pxor   %xmm0,%xmm0
     ddc:	pxor   %xmm2,%xmm2
     de0:	cvtss2sd (%rdx,%rax,4),%xmm0
     de5:	cvtss2sd (%rsi,%rax,4),%xmm2
     dea:	subsd  %xmm2,%xmm0
     dee:	add    $0x1,%rax
     df2:	mulsd  %xmm0,%xmm0
     df6:	addsd  %xmm0,%xmm1
     dfa:	cmp    %rax,%rcx
     dfd:	jne    dd8 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xb8>
     dff:	mov    0x30(%r12),%rax
     e04:	and    %r14,%rbp
     e07:	mov    (%rsp),%rdi
     e0b:	movapd %xmm1,%xmm0
     e0f:	mov    (%rax,%rbx,4),%eax
     e12:	or     %rax,%rbp
     e15:	mov    %rbp,%rsi
     e18:	call   e1d <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xfd>
     e1d:	add    $0x1,%rbx
     e21:	cmp    (%r12),%rbx
     e25:	jb     da0 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x80>
     e2b:	mov    0x8(%rsp),%rax
     e30:	mov    (%rsp),%rdi
     e34:	mov    (%rax),%rsi
     e37:	mov    0x18(%rsp),%rax
     e3c:	imul   %r13,%rsi
     e40:	shl    $0x4,%rsi
     e44:	add    %rax,%rsi
     e47:	call   e4c <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x12c>
     e4c:	mov    0x28(%rsp),%rdi
     e51:	test   %rdi,%rdi
     e54:	je     ea1 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x181>
     e56:	mov    0x38(%rsp),%rsi
     e5b:	add    $0x1,%r13
     e5f:	sub    %rdi,%rsi
     e62:	call   e67 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x147>
     e67:	cmp    %r13,0x10(%rsp)
     e6c:	jne    d80 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x60>
     e72:	mov    0x48(%rsp),%rax
     e77:	sub    %fs:0x28,%rax
     e80:	jne    eb2 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x192>
     e82:	add    $0x58,%rsp
     e86:	pop    %rbx
     e87:	pop    %rbp
     e88:	pop    %r12
     e8a:	pop    %r13
     e8c:	pop    %r14
     e8e:	pop    %r15
     e90:	ret
     e91:	nopl   0x0(%rax)
     e98:	pxor   %xmm1,%xmm1
     e9c:	jmp    dff <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xdf>
     ea1:	add    $0x1,%r13
     ea5:	cmp    %r13,0x10(%rsp)
     eaa:	jne    d80 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x60>
     eb0:	jmp    e72 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x152>
     eb2:	call   eb7 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x197>
     eb7:	endbr64
     ebb:	mov    %rax,%rbx
     ebe:	jmp    ec3 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1a3>
     ec3:	data16 cs nopw 0x0(%rax,%rax,1)
     ece:	xchg   %ax,%ax

0000000000000ed0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)>:
     ed0:	endbr64
     ed4:	push   %r15
     ed6:	movabs $0xffffffff00000000,%r15
     ee0:	push   %r14
     ee2:	push   %r13
     ee4:	mov    %rdi,%r13
     ee7:	push   %r12
     ee9:	push   %rbp
     eea:	push   %rbx
     eeb:	sub    $0xa8,%rsp
     ef2:	mov    %rsi,0x38(%rsp)
     ef7:	mov    %rdx,0x28(%rsp)
     efc:	mov    %rcx,0x30(%rsp)
     f01:	mov    %r8,0x40(%rsp)
     f06:	mov    %fs:0x28,%rax
     f0f:	mov    %rax,0x98(%rsp)
     f17:	xor    %eax,%eax
     f19:	lea    0x50(%rsp),%rax
     f1e:	movq   $0x0,0x18(%rsp)
     f27:	mov    %rax,0x48(%rsp)
     f2c:	lea    0x70(%rsp),%rax
     f31:	mov    %rax,(%rsp)
     f35:	test   %rdx,%rdx
     f38:	je     10bd <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1ed>
     f3e:	mov    0x18(%rsp),%rax
     f43:	imul   0x8(%r13),%rax
     f48:	mov    0x38(%rsp),%rsi
     f4d:	mov    0x30(%rsp),%r14
     f52:	mov    0x48(%rsp),%rdi
     f57:	lea    (%rsi,%rax,4),%rbx
     f5b:	mov    0x8(%r14),%rcx
     f5f:	mov    %r13,%rsi
     f62:	mov    %rbx,%rdx
     f65:	call   f6a <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x9a>
     f6a:	mov    (%r14),%rsi
     f6d:	mov    (%rsp),%rdi
     f71:	call   f76 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xa6>
     f76:	mov    0x50(%rsp),%rax
     f7b:	mov    0x58(%rsp),%rsi
     f80:	mov    %rax,0x20(%rsp)
     f85:	mov    %rsi,0x10(%rsp)
     f8a:	cmp    %rax,%rsi
     f8d:	je     1050 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x180>
     f93:	mov    %rax,%rsi
     f96:	mov    0x18(%r13),%rax
     f9a:	mov    %rsi,0x8(%rsp)
     f9f:	nop
     fa0:	mov    0x8(%rsp),%rsi
     fa5:	mov    (%rsi),%ecx
     fa7:	mov    %rcx,%rdx
     faa:	mov    (%rax,%rcx,8),%rbp
     fae:	add    $0x1,%edx
     fb1:	lea    0x0(,%rdx,8),%r14
     fb9:	cmp    (%rax,%rdx,8),%rbp
     fbd:	jae    103a <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x16a>
     fbf:	nop
     fc0:	mov    0x8(%r13),%rdx
     fc4:	mov    0x48(%r13),%rcx
     fc8:	mov    %rdx,%rax
     fcb:	imul   %rbp,%rax
     fcf:	shl    $0x2,%rax
     fd3:	test   %rdx,%rdx
     fd6:	je     10e8 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x218>
     fdc:	add    %rax,%rcx
     fdf:	pxor   %xmm1,%xmm1
     fe3:	xor    %eax,%eax
     fe5:	nopl   (%rax)
     fe8:	pxor   %xmm0,%xmm0
     fec:	pxor   %xmm2,%xmm2
     ff0:	cvtss2sd (%rbx,%rax,4),%xmm0
     ff5:	cvtss2sd (%rcx,%rax,4),%xmm2
     ffa:	subsd  %xmm2,%xmm0
     ffe:	add    $0x1,%rax
    1002:	mulsd  %xmm0,%xmm0
    1006:	addsd  %xmm0,%xmm1
    100a:	cmp    %rax,%rdx
    100d:	jne    fe8 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x118>
    100f:	mov    0x30(%r13),%rax
    1013:	and    %r15,%r12
    1016:	mov    (%rsp),%rdi
    101a:	movapd %xmm1,%xmm0
    101e:	mov    (%rax,%rbp,4),%eax
    1021:	or     %rax,%r12
    1024:	mov    %r12,%rsi
    1027:	call   102c <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x15c>
    102c:	mov    0x18(%r13),%rax
    1030:	add    $0x1,%rbp
    1034:	cmp    (%rax,%r14,1),%rbp
    1038:	jb     fc0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xf0>
    103a:	addq   $0x4,0x8(%rsp)
    1040:	mov    0x8(%rsp),%rdi
    1045:	cmp    %rdi,0x10(%rsp)
    104a:	jne    fa0 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0xd0>
    1050:	mov    0x30(%rsp),%rax
    1055:	mov    0x18(%rsp),%rsi
    105a:	mov    (%rsp),%rdi
    105e:	imul   (%rax),%rsi
    1062:	mov    0x40(%rsp),%rax
    1067:	shl    $0x4,%rsi
    106b:	add    %rax,%rsi
    106e:	call   1073 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1a3>
    1073:	mov    0x78(%rsp),%rdi
    1078:	test   %rdi,%rdi
    107b:	je     108d <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1bd>
    107d:	mov    0x88(%rsp),%rsi
    1085:	sub    %rdi,%rsi
    1088:	call   108d <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1bd>
    108d:	mov    0x20(%rsp),%rdi
    1092:	test   %rdi,%rdi
    1095:	je     10f1 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x221>
    1097:	mov    0x60(%rsp),%rsi
    109c:	sub    %rdi,%rsi
    109f:	call   10a4 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1d4>
    10a4:	addq   $0x1,0x18(%rsp)
    10aa:	mov    0x28(%rsp),%rsi
    10af:	mov    0x18(%rsp),%rax
    10b4:	cmp    %rsi,%rax
    10b7:	jne    f3e <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x6e>
    10bd:	mov    0x98(%rsp),%rax
    10c5:	sub    %fs:0x28,%rax
    10ce:	jne    1109 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x239>
    10d0:	add    $0xa8,%rsp
    10d7:	pop    %rbx
    10d8:	pop    %rbp
    10d9:	pop    %r12
    10db:	pop    %r13
    10dd:	pop    %r14
    10df:	pop    %r15
    10e1:	ret
    10e2:	nopw   0x0(%rax,%rax,1)
    10e8:	pxor   %xmm1,%xmm1
    10ec:	jmp    100f <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x13f>
    10f1:	addq   $0x1,0x18(%rsp)
    10f7:	mov    0x18(%rsp),%rax
    10fc:	cmp    %rax,0x28(%rsp)
    1101:	jne    f3e <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x6e>
    1107:	jmp    10bd <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x1ed>
    1109:	call   110e <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x23e>
    110e:	endbr64
    1112:	mov    %rax,%rbx
    1115:	jmp    111a <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x24a>
    111a:	endbr64
    111e:	mov    %rax,%rbx
    1121:	jmp    1126 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*)+0x256>

Disassembly of section .text._ZNSt7__cxx119to_stringEi:

0000000000000000 <std::__cxx11::to_string(int)>:
   0:	endbr64
   4:	push   %r14
   6:	mov    %esi,%ecx
   8:	push   %r13
   a:	shr    $0x1f,%ecx
   d:	mov    %rdi,%r13
  10:	push   %r12
  12:	movzbl %cl,%r14d
  16:	push   %rbp
  17:	mov    %esi,%ebp
  19:	push   %rbx
  1a:	sub    $0xe0,%rsp
  21:	mov    %fs:0x28,%rax
  2a:	mov    %rax,0xd8(%rsp)
  32:	xor    %eax,%eax
  34:	neg    %ebp
  36:	cmovs  %esi,%ebp
  39:	mov    %ecx,%esi
  3b:	cmp    $0x9,%ebp
  3e:	jbe    33a <std::__cxx11::to_string(int)+0x33a>
  44:	cmp    $0x63,%ebp
  47:	jbe    214 <std::__cxx11::to_string(int)+0x214>
  4d:	cmp    $0x3e7,%ebp
  53:	jbe    35a <std::__cxx11::to_string(int)+0x35a>
  59:	cmp    $0x270f,%ebp
  5f:	jbe    369 <std::__cxx11::to_string(int)+0x369>
  65:	mov    %ebp,%ebx
  67:	mov    $0x5,%eax
  6c:	cmp    $0x1869f,%ebp
  72:	jbe    30d <std::__cxx11::to_string(int)+0x30d>
  78:	cmp    $0xf423f,%ebp
  7e:	jbe    378 <std::__cxx11::to_string(int)+0x378>
  84:	mov    $0x6,%r12d
  8a:	mov    $0x7,%eax
  8f:	cmp    $0x98967f,%ebp
  95:	jbe    311 <std::__cxx11::to_string(int)+0x311>
  9b:	cmp    $0x5f5e0ff,%ebp
  a1:	jbe    320 <std::__cxx11::to_string(int)+0x320>
  a7:	cmp    $0x3b9ac9ff,%rbx
  ae:	jbe    308 <std::__cxx11::to_string(int)+0x308>
  b4:	mov    $0x9,%r12d
  ba:	lea    0x10(%r13),%rax
  be:	lea    0x1(%r12,%rsi,1),%esi
  c3:	mov    %rax,0x0(%r13)
  c7:	mov    $0x2d,%edx
  cc:	mov    %r13,%rdi
  cf:	call   d4 <std::__cxx11::to_string(int)+0xd4>
  d4:	movdqa 0x0(%rip),%xmm0        # dc <std::__cxx11::to_string(int)+0xdc>
  dc:	mov    0x0(%r13),%rcx
  e0:	movaps %xmm0,(%rsp)
  e4:	movdqa 0x0(%rip),%xmm0        # ec <std::__cxx11::to_string(int)+0xec>
  ec:	add    %r14,%rcx
  ef:	movaps %xmm0,0x10(%rsp)
  f4:	movdqa 0x0(%rip),%xmm0        # fc <std::__cxx11::to_string(int)+0xfc>
  fc:	movaps %xmm0,0x20(%rsp)
 101:	movdqa 0x0(%rip),%xmm0        # 109 <std::__cxx11::to_string(int)+0x109>
 109:	movaps %xmm0,0x30(%rsp)
 10e:	movdqa 0x0(%rip),%xmm0        # 116 <std::__cxx11::to_string(int)+0x116>
 116:	movaps %xmm0,0x40(%rsp)
 11b:	movdqa 0x0(%rip),%xmm0        # 123 <std::__cxx11::to_string(int)+0x123>
 123:	movaps %xmm0,0x50(%rsp)
 128:	movdqa 0x0(%rip),%xmm0        # 130 <std::__cxx11::to_string(int)+0x130>
 130:	movaps %xmm0,0x60(%rsp)
 135:	movdqa 0x0(%rip),%xmm0        # 13d <std::__cxx11::to_string(int)+0x13d>
 13d:	movaps %xmm0,0x70(%rsp)
 142:	movdqa 0x0(%rip),%xmm0        # 14a <std::__cxx11::to_string(int)+0x14a>
 14a:	movaps %xmm0,0x80(%rsp)
 152:	movdqa 0x0(%rip),%xmm0        # 15a <std::__cxx11::to_string(int)+0x15a>
 15a:	movaps %xmm0,0x90(%rsp)
 162:	movdqa 0x0(%rip),%xmm0        # 16a <std::__cxx11::to_string(int)+0x16a>
 16a:	movaps %xmm0,0xa0(%rsp)
 172:	movdqa 0x0(%rip),%xmm0        # 17a <std::__cxx11::to_string(int)+0x17a>
 17a:	movaps %xmm0,0xb0(%rsp)
 182:	movdqa 0x0(%rip),%xmm0        # 18a <std::__cxx11::to_string(int)+0x18a>
 18a:	movups %xmm0,0xb9(%rsp)
 192:	jmp    19a <std::__cxx11::to_string(int)+0x19a>
 194:	nopl   0x0(%rax)
 198:	mov    %ebp,%ebx
 19a:	imul   $0x51eb851f,%rbx,%rdx
 1a1:	mov    %ebp,%eax
 1a3:	shr    $0x25,%rdx
 1a7:	imul   $0x64,%edx,%esi
 1aa:	sub    %esi,%eax
 1ac:	mov    %ebp,%esi
 1ae:	mov    %edx,%ebp
 1b0:	mov    %r12d,%edx
 1b3:	add    %eax,%eax
 1b5:	lea    0x1(%rax),%edi
 1b8:	movzbl (%rsp,%rax,1),%eax
 1bc:	movzbl (%rsp,%rdi,1),%edi
 1c0:	mov    %dil,(%rcx,%rdx,1)
 1c4:	lea    -0x1(%r12),%edx
 1c9:	sub    $0x2,%r12d
 1cd:	mov    %al,(%rcx,%rdx,1)
 1d0:	cmp    $0x270f,%esi
 1d6:	ja     198 <std::__cxx11::to_string(int)+0x198>
 1d8:	cmp    $0x3e7,%esi
 1de:	ja     2f0 <std::__cxx11::to_string(int)+0x2f0>
 1e4:	add    $0x30,%ebp
 1e7:	mov    %bpl,(%rcx)
 1ea:	mov    0xd8(%rsp),%rax
 1f2:	sub    %fs:0x28,%rax
 1fb:	jne    383 <std::__cxx11::to_string(int)+0x383>
 201:	add    $0xe0,%rsp
 208:	mov    %r13,%rax
 20b:	pop    %rbx
 20c:	pop    %rbp
 20d:	pop    %r12
 20f:	pop    %r13
 211:	pop    %r14
 213:	ret
 214:	lea    0x10(%rdi),%rax
 218:	add    $0x2,%esi
 21b:	mov    $0x2d,%edx
 220:	mov    %rax,(%rdi)
 223:	call   228 <std::__cxx11::to_string(int)+0x228>
 228:	movdqa 0x0(%rip),%xmm0        # 230 <std::__cxx11::to_string(int)+0x230>
 230:	mov    0x0(%r13),%rcx
 234:	movaps %xmm0,(%rsp)
 238:	movdqa 0x0(%rip),%xmm0        # 240 <std::__cxx11::to_string(int)+0x240>
 240:	add    %r14,%rcx
 243:	movaps %xmm0,0x10(%rsp)
 248:	movdqa 0x0(%rip),%xmm0        # 250 <std::__cxx11::to_string(int)+0x250>
 250:	movaps %xmm0,0x20(%rsp)
 255:	movdqa 0x0(%rip),%xmm0        # 25d <std::__cxx11::to_string(int)+0x25d>
 25d:	movaps %xmm0,0x30(%rsp)
 262:	movdqa 0x0(%rip),%xmm0        # 26a <std::__cxx11::to_string(int)+0x26a>
 26a:	movaps %xmm0,0x40(%rsp)
 26f:	movdqa 0x0(%rip),%xmm0        # 277 <std::__cxx11::to_string(int)+0x277>
 277:	movaps %xmm0,0x50(%rsp)
 27c:	movdqa 0x0(%rip),%xmm0        # 284 <std::__cxx11::to_string(int)+0x284>
 284:	movaps %xmm0,0x60(%rsp)
 289:	movdqa 0x0(%rip),%xmm0        # 291 <std::__cxx11::to_string(int)+0x291>
 291:	movaps %xmm0,0x70(%rsp)
 296:	movdqa 0x0(%rip),%xmm0        # 29e <std::__cxx11::to_string(int)+0x29e>
 29e:	movaps %xmm0,0x80(%rsp)
 2a6:	movdqa 0x0(%rip),%xmm0        # 2ae <std::__cxx11::to_string(int)+0x2ae>
 2ae:	movaps %xmm0,0x90(%rsp)
 2b6:	movdqa 0x0(%rip),%xmm0        # 2be <std::__cxx11::to_string(int)+0x2be>
 2be:	movaps %xmm0,0xa0(%rsp)
 2c6:	movdqa 0x0(%rip),%xmm0        # 2ce <std::__cxx11::to_string(int)+0x2ce>
 2ce:	movaps %xmm0,0xb0(%rsp)
 2d6:	movdqa 0x0(%rip),%xmm0        # 2de <std::__cxx11::to_string(int)+0x2de>
 2de:	movups %xmm0,0xb9(%rsp)
 2e6:	cs nopw 0x0(%rax,%rax,1)
 2f0:	add    %ebp,%ebp
 2f2:	lea    0x1(%rbp),%eax
 2f5:	movzbl (%rsp,%rbp,1),%ebp
 2f9:	movzbl (%rsp,%rax,1),%eax
 2fd:	mov    %al,0x1(%rcx)
 300:	jmp    1e7 <std::__cxx11::to_string(int)+0x1e7>
 305:	nopl   (%rax)
 308:	mov    $0x9,%eax
 30d:	lea    -0x1(%rax),%r12d
 311:	lea    0x10(%r13),%rdx
 315:	add    %eax,%esi
 317:	mov    %rdx,0x0(%r13)
 31b:	jmp    c7 <std::__cxx11::to_string(int)+0xc7>
 320:	mov    $0x8,%eax
 325:	lea    0x10(%r13),%rdx
 329:	mov    $0x7,%r12d
 32f:	mov    %rdx,0x0(%r13)
 333:	add    %eax,%esi
 335:	jmp    c7 <std::__cxx11::to_string(int)+0xc7>
 33a:	lea    0x10(%rdi),%rax
 33e:	add    $0x1,%esi
 341:	mov    $0x2d,%edx
 346:	mov    %rax,(%rdi)
 349:	call   34e <std::__cxx11::to_string(int)+0x34e>
 34e:	mov    0x0(%r13),%rcx
 352:	add    %r14,%rcx
 355:	jmp    1e4 <std::__cxx11::to_string(int)+0x1e4>
 35a:	mov    $0x2,%r12d
 360:	mov    $0x3,%eax
 365:	mov    %ebp,%ebx
 367:	jmp    311 <std::__cxx11::to_string(int)+0x311>
 369:	mov    $0x3,%r12d
 36f:	mov    $0x4,%eax
 374:	mov    %ebp,%ebx
 376:	jmp    311 <std::__cxx11::to_string(int)+0x311>
 378:	mov    $0x5,%r12d
 37e:	jmp    ba <std::__cxx11::to_string(int)+0xba>
 383:	call   388 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x93>

Disassembly of section .text._ZNSt7__cxx119to_stringEm:

0000000000000000 <std::__cxx11::to_string(unsigned long)>:
   0:	endbr64
   4:	push   %rbp
   5:	mov    %rdi,%rbp
   8:	push   %rbx
   9:	mov    %rsi,%rbx
   c:	sub    $0xe8,%rsp
  13:	mov    %fs:0x28,%rax
  1c:	mov    %rax,0xd8(%rsp)
  24:	xor    %eax,%eax
  26:	cmp    $0x9,%rsi
  2a:	jbe    338 <std::__cxx11::to_string(unsigned long)+0x338>
  30:	cmp    $0x63,%rsi
  34:	jbe    21d <std::__cxx11::to_string(unsigned long)+0x21d>
  3a:	cmp    $0x3e7,%rsi
  41:	jbe    354 <std::__cxx11::to_string(unsigned long)+0x354>
  47:	cmp    $0x270f,%rsi
  4e:	jbe    35e <std::__cxx11::to_string(unsigned long)+0x35e>
  54:	movabs $0x346dc5d63886594b,%rdi
  5e:	mov    %rsi,%rdx
  61:	mov    $0x1,%esi
  66:	jmp    97 <std::__cxx11::to_string(unsigned long)+0x97>
  68:	nopl   0x0(%rax,%rax,1)
  70:	cmp    $0xf423f,%rcx
  77:	jbe    308 <std::__cxx11::to_string(unsigned long)+0x308>
  7d:	cmp    $0x98967f,%rcx
  84:	jbe    320 <std::__cxx11::to_string(unsigned long)+0x320>
  8a:	cmp    $0x5f5e0ff,%rcx
  91:	jbe    330 <std::__cxx11::to_string(unsigned long)+0x330>
  97:	mov    %rdx,%rax
  9a:	mov    %rdx,%rcx
  9d:	mul    %rdi
  a0:	mov    %esi,%eax
  a2:	add    $0x4,%esi
  a5:	shr    $0xb,%rdx
  a9:	cmp    $0x1869f,%rcx
  b0:	ja     70 <std::__cxx11::to_string(unsigned long)+0x70>
  b2:	lea    0x10(%rbp),%rax
  b6:	mov    %rax,0x0(%rbp)
  ba:	mov    %rbp,%rdi
  bd:	xor    %edx,%edx
  bf:	call   c4 <std::__cxx11::to_string(unsigned long)+0xc4>
  c4:	movdqa 0x0(%rip),%xmm0        # cc <std::__cxx11::to_string(unsigned long)+0xcc>
  cc:	mov    0x8(%rbp),%eax
  cf:	movabs $0x28f5c28f5c28f5c3,%rdi
  d9:	mov    0x0(%rbp),%rsi
  dd:	movaps %xmm0,(%rsp)
  e1:	movdqa 0x0(%rip),%xmm0        # e9 <std::__cxx11::to_string(unsigned long)+0xe9>
  e9:	lea    -0x1(%rax),%ecx
  ec:	movaps %xmm0,0x10(%rsp)
  f1:	movdqa 0x0(%rip),%xmm0        # f9 <std::__cxx11::to_string(unsigned long)+0xf9>
  f9:	movaps %xmm0,0x20(%rsp)
  fe:	movdqa 0x0(%rip),%xmm0        # 106 <std::__cxx11::to_string(unsigned long)+0x106>
 106:	movaps %xmm0,0x30(%rsp)
 10b:	movdqa 0x0(%rip),%xmm0        # 113 <std::__cxx11::to_string(unsigned long)+0x113>
 113:	movaps %xmm0,0x40(%rsp)
 118:	movdqa 0x0(%rip),%xmm0        # 120 <std::__cxx11::to_string(unsigned long)+0x120>
 120:	movaps %xmm0,0x50(%rsp)
 125:	movdqa 0x0(%rip),%xmm0        # 12d <std::__cxx11::to_string(unsigned long)+0x12d>
 12d:	movaps %xmm0,0x60(%rsp)
 132:	movdqa 0x0(%rip),%xmm0        # 13a <std::__cxx11::to_string(unsigned long)+0x13a>
 13a:	movaps %xmm0,0x70(%rsp)
 13f:	movdqa 0x0(%rip),%xmm0        # 147 <std::__cxx11::to_string(unsigned long)+0x147>
 147:	movaps %xmm0,0x80(%rsp)
 14f:	movdqa 0x0(%rip),%xmm0        # 157 <std::__cxx11::to_string(unsigned long)+0x157>
 157:	movaps %xmm0,0x90(%rsp)
 15f:	movdqa 0x0(%rip),%xmm0        # 167 <std::__cxx11::to_string(unsigned long)+0x167>
 167:	movaps %xmm0,0xa0(%rsp)
 16f:	movdqa 0x0(%rip),%xmm0        # 177 <std::__cxx11::to_string(unsigned long)+0x177>
 177:	movaps %xmm0,0xb0(%rsp)
 17f:	movdqa 0x0(%rip),%xmm0        # 187 <std::__cxx11::to_string(unsigned long)+0x187>
 187:	movups %xmm0,0xb9(%rsp)
 18f:	nop
 190:	mov    %rbx,%rdx
 193:	shr    $0x2,%rdx
 197:	mov    %rdx,%rax
 19a:	mul    %rdi
 19d:	mov    %rbx,%rax
 1a0:	mov    %rdx,%r8
 1a3:	and    $0xfffffffffffffffc,%rdx
 1a7:	shr    $0x2,%r8
 1ab:	add    %r8,%rdx
 1ae:	lea    (%rdx,%rdx,4),%rdx
 1b2:	shl    $0x2,%rdx
 1b6:	sub    %rdx,%rax
 1b9:	mov    %rbx,%rdx
 1bc:	mov    %r8,%rbx
 1bf:	mov    %ecx,%r8d
 1c2:	add    %rax,%rax
 1c5:	movzbl 0x1(%rsp,%rax,1),%r9d
 1cb:	movzbl (%rsp,%rax,1),%eax
 1cf:	mov    %r9b,(%rsi,%r8,1)
 1d3:	lea    -0x1(%rcx),%r8d
 1d7:	sub    $0x2,%ecx
 1da:	mov    %al,(%rsi,%r8,1)
 1de:	cmp    $0x270f,%rdx
 1e5:	ja     190 <std::__cxx11::to_string(unsigned long)+0x190>
 1e7:	cmp    $0x3e7,%rdx
 1ee:	ja     2f0 <std::__cxx11::to_string(unsigned long)+0x2f0>
 1f4:	add    $0x30,%ebx
 1f7:	mov    %bl,(%rsi)
 1f9:	mov    0xd8(%rsp),%rax
 201:	sub    %fs:0x28,%rax
 20a:	jne    368 <std::__cxx11::to_string(unsigned long)+0x368>
 210:	add    $0xe8,%rsp
 217:	mov    %rbp,%rax
 21a:	pop    %rbx
 21b:	pop    %rbp
 21c:	ret
 21d:	lea    0x10(%rdi),%rax
 221:	mov    $0x2,%esi
 226:	xor    %edx,%edx
 228:	mov    %rax,(%rdi)
 22b:	call   230 <std::__cxx11::to_string(unsigned long)+0x230>
 230:	movdqa 0x0(%rip),%xmm0        # 238 <std::__cxx11::to_string(unsigned long)+0x238>
 238:	mov    0x0(%rbp),%rsi
 23c:	movaps %xmm0,(%rsp)
 240:	movdqa 0x0(%rip),%xmm0        # 248 <std::__cxx11::to_string(unsigned long)+0x248>
 248:	movaps %xmm0,0x10(%rsp)
 24d:	movdqa 0x0(%rip),%xmm0        # 255 <std::__cxx11::to_string(unsigned long)+0x255>
 255:	movaps %xmm0,0x20(%rsp)
 25a:	movdqa 0x0(%rip),%xmm0        # 262 <std::__cxx11::to_string(unsigned long)+0x262>
 262:	movaps %xmm0,0x30(%rsp)
 267:	movdqa 0x0(%rip),%xmm0        # 26f <std::__cxx11::to_string(unsigned long)+0x26f>
 26f:	movaps %xmm0,0x40(%rsp)
 274:	movdqa 0x0(%rip),%xmm0        # 27c <std::__cxx11::to_string(unsigned long)+0x27c>
 27c:	movaps %xmm0,0x50(%rsp)
 281:	movdqa 0x0(%rip),%xmm0        # 289 <std::__cxx11::to_string(unsigned long)+0x289>
 289:	movaps %xmm0,0x60(%rsp)
 28e:	movdqa 0x0(%rip),%xmm0        # 296 <std::__cxx11::to_string(unsigned long)+0x296>
 296:	movaps %xmm0,0x70(%rsp)
 29b:	movdqa 0x0(%rip),%xmm0        # 2a3 <std::__cxx11::to_string(unsigned long)+0x2a3>
 2a3:	movaps %xmm0,0x80(%rsp)
 2ab:	movdqa 0x0(%rip),%xmm0        # 2b3 <std::__cxx11::to_string(unsigned long)+0x2b3>
 2b3:	movaps %xmm0,0x90(%rsp)
 2bb:	movdqa 0x0(%rip),%xmm0        # 2c3 <std::__cxx11::to_string(unsigned long)+0x2c3>
 2c3:	movaps %xmm0,0xa0(%rsp)
 2cb:	movdqa 0x0(%rip),%xmm0        # 2d3 <std::__cxx11::to_string(unsigned long)+0x2d3>
 2d3:	movaps %xmm0,0xb0(%rsp)
 2db:	movdqa 0x0(%rip),%xmm0        # 2e3 <std::__cxx11::to_string(unsigned long)+0x2e3>
 2e3:	movups %xmm0,0xb9(%rsp)
 2eb:	nopl   0x0(%rax,%rax,1)
 2f0:	add    %rbx,%rbx
 2f3:	movzbl 0x1(%rsp,%rbx,1),%eax
 2f8:	movzbl (%rsp,%rbx,1),%ebx
 2fc:	mov    %al,0x1(%rsi)
 2ff:	jmp    1f7 <std::__cxx11::to_string(unsigned long)+0x1f7>
 304:	nopl   0x0(%rax)
 308:	lea    0x10(%rbp),%rdx
 30c:	lea    0x5(%rax),%esi
 30f:	mov    %rdx,0x0(%rbp)
 313:	jmp    ba <std::__cxx11::to_string(unsigned long)+0xba>
 318:	nopl   0x0(%rax,%rax,1)
 320:	lea    0x6(%rax),%esi
 323:	jmp    b2 <std::__cxx11::to_string(unsigned long)+0xb2>
 328:	nopl   0x0(%rax,%rax,1)
 330:	lea    0x7(%rax),%esi
 333:	jmp    b2 <std::__cxx11::to_string(unsigned long)+0xb2>
 338:	lea    0x10(%rdi),%rax
 33c:	mov    $0x1,%esi
 341:	xor    %edx,%edx
 343:	mov    %rax,(%rdi)
 346:	call   34b <std::__cxx11::to_string(unsigned long)+0x34b>
 34b:	mov    0x0(%rbp),%rsi
 34f:	jmp    1f4 <std::__cxx11::to_string(unsigned long)+0x1f4>
 354:	mov    $0x3,%esi
 359:	jmp    b2 <std::__cxx11::to_string(unsigned long)+0xb2>
 35e:	mov    $0x4,%esi
 363:	jmp    b2 <std::__cxx11::to_string(unsigned long)+0xb2>
 368:	call   36d <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x78>

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
   4:	call   9 <ivf::TopK::TopK(unsigned long) [clone .cold]+0x9>
   9:	mov    %rbp,%rdi
   c:	call   11 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]>

0000000000000011 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]>:
  11:	mov    $0x10,%edi
  16:	call   1b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xa>
  1b:	lea    0x0(%rip),%rsi        # 22 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x11>
  22:	mov    %rax,%rdi
  25:	mov    %rax,%rbx
  28:	call   2d <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1c>
  2d:	mov    0x128(%rsp),%rax
  35:	sub    %fs:0x28,%rax
  3e:	jne    1ae <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x19d>
  44:	mov    0x0(%rip),%rdx        # 4b <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x3a>
  4b:	lea    0x0(%rip),%rsi        # 52 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x41>
  52:	mov    %rbx,%rdi
  55:	call   5a <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x49>
  5a:	mov    $0x10,%edi
  5f:	call   64 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x53>
  64:	mov    0x8(%rbx),%esi
  67:	lea    0xe0(%rsp),%rdi
  6f:	lea    0x20(%rsp),%rbx
  74:	mov    %rax,(%rsp)
  78:	mov    %rdi,0x8(%rsp)
  7d:	call   82 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x71>
  82:	mov    0x8(%rbp),%esi
  85:	lea    0x80(%rsp),%rdi
  8d:	mov    %rdi,0x10(%rsp)
  92:	call   97 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x86>
  97:	mov    %r12,%rsi
  9a:	mov    %rbx,%rdi
  9d:	call   a2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x91>
  a2:	lea    0x0(%rip),%rdx        # a9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x98>
  a9:	xor    %esi,%esi
  ab:	mov    %rbx,%rdi
  ae:	call   b3 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xa2>
  b3:	lea    0x40(%rsp),%rbp
  b8:	mov    %rax,%rsi
  bb:	mov    %rbp,%rdi
  be:	call   c3 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xb2>
  c3:	lea    0x0(%rip),%rsi        # ca <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xb9>
  ca:	mov    %rbp,%rdi
  cd:	call   d2 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xc1>
  d2:	lea    0x60(%rsp),%r12
  d7:	mov    %rax,%rsi
  da:	lea    0xa0(%rsp),%r13
  e2:	mov    %r12,%rdi
  e5:	call   ea <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xd9>
  ea:	mov    0x10(%rsp),%rdx
  ef:	mov    %r12,%rsi
  f2:	mov    %r13,%rdi
  f5:	call   fa <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xe9>
  fa:	lea    0x0(%rip),%rsi        # 101 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xf0>
 101:	mov    %r13,%rdi
 104:	call   109 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0xf8>
 109:	lea    0xc0(%rsp),%r14
 111:	mov    %rax,%rsi
 114:	lea    0x100(%rsp),%r15
 11c:	mov    %r14,%rdi
 11f:	call   124 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x113>
 124:	mov    0x8(%rsp),%rdx
 129:	mov    %r14,%rsi
 12c:	mov    %r15,%rdi
 12f:	call   134 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x123>
 134:	mov    (%rsp),%rdi
 138:	mov    %r15,%rsi
 13b:	call   140 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x12f>
 140:	mov    %r15,%rdi
 143:	call   148 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x137>
 148:	mov    %r14,%rdi
 14b:	call   150 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x13f>
 150:	mov    %r13,%rdi
 153:	call   158 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x147>
 158:	mov    %r12,%rdi
 15b:	call   160 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x14f>
 160:	mov    %rbp,%rdi
 163:	call   168 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x157>
 168:	mov    %rbx,%rdi
 16b:	call   170 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x15f>
 170:	mov    0x10(%rsp),%rdi
 175:	call   17a <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x169>
 17a:	mov    0x8(%rsp),%rdi
 17f:	call   184 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x173>
 184:	mov    0x128(%rsp),%rax
 18c:	sub    %fs:0x28,%rax
 195:	jne    1b3 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a2>
 197:	mov    0x0(%rip),%rdx        # 19e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x18d>
 19e:	mov    (%rsp),%rdi
 1a2:	lea    0x0(%rip),%rsi        # 1a9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x198>
 1a9:	call   1ae <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x19d>
 1ae:	call   1b3 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a2>
 1b3:	call   1b8 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1a7>
 1b8:	endbr64
 1bc:	mov    %r15,%rdi
 1bf:	mov    %rax,0x18(%rsp)
 1c4:	call   1c9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1b8>
 1c9:	mov    0x18(%rsp),%r15
 1ce:	mov    %r14,%rdi
 1d1:	call   1d6 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1c5>
 1d6:	mov    %r13,%rdi
 1d9:	mov    %r15,%r13
 1dc:	call   1e1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d0>
 1e1:	mov    %r12,%rdi
 1e4:	call   1e9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d8>
 1e9:	mov    %rbp,%rdi
 1ec:	mov    %r13,%rbp
 1ef:	call   1f4 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1e3>
 1f4:	mov    %rbx,%rdi
 1f7:	call   1fc <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1eb>
 1fc:	mov    0x10(%rsp),%rdi
 201:	call   206 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1f5>
 206:	mov    0x8(%rsp),%rdi
 20b:	call   210 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1ff>
 210:	mov    (%rsp),%rdi
 214:	call   219 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x208>
 219:	mov    0x128(%rsp),%rax
 221:	sub    %fs:0x28,%rax
 22a:	jne    279 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x268>
 22c:	mov    %rbp,%rdi
 22f:	call   234 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x223>
 234:	endbr64
 238:	mov    %rax,%r15
 23b:	jmp    1ce <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1bd>
 23d:	endbr64
 241:	mov    %rax,%rbp
 244:	jmp    1f4 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1e3>
 246:	endbr64
 24a:	mov    %rax,%rbp
 24d:	jmp    1fc <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1eb>
 24f:	endbr64
 253:	mov    %rbx,%rdi
 256:	mov    %rax,%rbp
 259:	call   25e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x24d>
 25e:	mov    0x128(%rsp),%rax
 266:	sub    %fs:0x28,%rax
 26f:	jne    27e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x26d>
 271:	mov    %rbp,%rdi
 274:	call   279 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x268>
 279:	call   27e <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x26d>
 27e:	call   283 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x272>
 283:	endbr64
 287:	mov    %rax,%r13
 28a:	jmp    1e1 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d0>
 28f:	endbr64
 293:	mov    %rax,%r13
 296:	jmp    1e9 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1d8>
 29b:	endbr64
 29f:	mov    %rax,%r15
 2a2:	jmp    1d6 <ivf::check_result(std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > const&) [clone .cold]+0x1c5>

00000000000002a7 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]>:
 2a7:	lea    0x20(%rsp),%rdi
 2ac:	call   2b1 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0xa>
 2b1:	mov    0x38(%rsp),%rax
 2b6:	sub    %fs:0x28,%rax
 2bf:	jne    2c9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x22>
 2c1:	mov    %rbx,%rdi
 2c4:	call   2c9 <ivf::select_lists(ivf::IVFIndex const&, float const*, unsigned long) [clone .cold]+0x22>
 2c9:	call   2ce <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>

00000000000002ce <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>:
 2ce:	lea    0x28(%rsp),%rdi
 2d3:	call   2d8 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0xa>
 2d8:	mov    0x48(%rsp),%rax
 2dd:	sub    %fs:0x28,%rax
 2e6:	jne    2f0 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x22>
 2e8:	mov    %rbx,%rdi
 2eb:	call   2f0 <ivf::search_exact_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x22>
 2f0:	call   2f5 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>

00000000000002f5 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]>:
 2f5:	lea    0x78(%rsp),%rdi
 2fa:	call   2ff <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0xa>
 2ff:	mov    0x50(%rsp),%rdi
 304:	mov    0x60(%rsp),%rsi
 309:	sub    %rdi,%rsi
 30c:	test   %rdi,%rdi
 30f:	je     316 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x21>
 311:	call   316 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x21>
 316:	mov    0x98(%rsp),%rax
 31e:	sub    %fs:0x28,%rax
 327:	jne    331 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x3c>
 329:	mov    %rbx,%rdi
 32c:	call   331 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x3c>
 331:	call   336 <ivf::search_ivf_serial(ivf::IVFIndex const&, float const*, unsigned long, ivf::SearchOptions const&, ivf::Neighbor*) [clone .cold]+0x41>

Disassembly of section .text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_S9_:

0000000000000000 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)>:
   0:	endbr64
   4:	push   %rbx
   5:	mov    %rsi,%r10
   8:	mov    0x8(%rsi),%r8
   c:	mov    %rdi,%rbx
   f:	mov    (%rsi),%rcx
  12:	mov    %rdx,%rdi
  15:	mov    0x8(%rdx),%rdx
  19:	lea    0x10(%r10),%r9
  1d:	mov    (%rdi),%rsi
  20:	lea    (%rdx,%r8,1),%rax
  24:	cmp    %r9,%rcx
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
 112:	mov    %r9,(%r8,%rcx,1)
 116:	cmp    %edi,%edx
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
 19e:	mov    %r9,(%r8,%rcx,1)
 1a2:	cmp    %edi,%edx
 1a4:	jb     195 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x195>
 1a6:	jmp    89 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x89>
 1ab:	nopl   0x0(%rax,%rax,1)
 1b0:	test   $0x4,%dil
 1b4:	jne    1e4 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x1e4>
 1b6:	test   %edi,%edi
 1b8:	je     8d <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > std::operator+<char, std::char_traits<char>, std::allocator<char> >(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&&)+0x8d>
 1be:	movzbl 0x10(%rax),%edx
 1c2:	mov    %dl,0x10(%rbx)
 1c5:	test   $0x2,%dil
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
 204:	call   209 <.LC19+0x139>

Disassembly of section .text._ZNSt6vectorIN3ivf8NeighborESaIS1_EE17_M_realloc_insertIJRKS1_EEEvN9__gnu_cxx17__normal_iteratorIPS1_S3_EEDpOT_:

0000000000000000 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)>:
   0:	endbr64
   4:	push   %r15
   6:	push   %r14
   8:	push   %r13
   a:	push   %r12
   c:	push   %rbp
   d:	push   %rbx
   e:	mov    %rdx,%rbx
  11:	movabs $0x7ffffffffffffff,%rdx
  1b:	sub    $0x18,%rsp
  1f:	mov    0x8(%rdi),%r15
  23:	mov    (%rdi),%r12
  26:	mov    %r15,%rax
  29:	sub    %r12,%rax
  2c:	sar    $0x4,%rax
  30:	cmp    %rdx,%rax
  33:	je     182 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x182>
  39:	mov    %rsi,%rdx
  3c:	mov    %rdi,%r14
  3f:	mov    %rsi,%r13
  42:	sub    %r12,%rdx
  45:	cmp    %r15,%r12
  48:	je     148 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x148>
  4e:	lea    (%rax,%rax,1),%rcx
  52:	cmp    %rax,%rcx
  55:	jb     108 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x108>
  5b:	test   %rcx,%rcx
  5e:	jne    168 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x168>
  64:	movdqu (%rbx),%xmm2
  68:	xor    %ebp,%ebp
  6a:	xor    %r8d,%r8d
  6d:	mov    $0x10,%ebx
  72:	movups %xmm2,(%rdx)
  75:	cmp    %r12,%rsi
  78:	je     ae <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xae>
  7a:	mov    %r13,%rcx
  7d:	mov    %r8,%rax
  80:	mov    %r12,%rdx
  83:	sub    %r12,%rcx
  86:	add    %r8,%rcx
  89:	nopl   0x0(%rax)
  90:	movdqu (%rdx),%xmm0
  94:	add    $0x10,%rax
  98:	add    $0x10,%rdx
  9c:	movups %xmm0,-0x10(%rax)
  a0:	cmp    %rcx,%rax
  a3:	jne    90 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x90>
  a5:	lea    0x10(%rax),%rbx
  a9:	cmp    %r15,%r13
  ac:	je     cc <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xcc>
  ae:	sub    %r13,%r15
  b1:	mov    %rbx,%rdi
  b4:	mov    %r13,%rsi
  b7:	mov    %r8,0x8(%rsp)
  bc:	mov    %r15,%rdx
  bf:	add    %r15,%rbx
  c2:	call   c7 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xc7>
  c7:	mov    0x8(%rsp),%r8
  cc:	test   %r12,%r12
  cf:	je     ea <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xea>
  d1:	mov    0x10(%r14),%rsi
  d5:	mov    %r12,%rdi
  d8:	mov    %r8,0x8(%rsp)
  dd:	sub    %r12,%rsi
  e0:	call   e5 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xe5>
  e5:	mov    0x8(%rsp),%r8
  ea:	mov    %r8,(%r14)
  ed:	mov    %rbx,0x8(%r14)
  f1:	mov    %rbp,0x10(%r14)
  f5:	add    $0x18,%rsp
  f9:	pop    %rbx
  fa:	pop    %rbp
  fb:	pop    %r12
  fd:	pop    %r13
  ff:	pop    %r14
 101:	pop    %r15
 103:	ret
 104:	nopl   0x0(%rax)
 108:	movabs $0x7ffffffffffffff0,%rbp
 112:	mov    %rbp,%rdi
 115:	mov    %rdx,0x8(%rsp)
 11a:	call   11f <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x11f>
 11f:	movdqu (%rbx),%xmm1
 123:	mov    0x8(%rsp),%rdx
 128:	mov    %rax,%r8
 12b:	add    %rax,%rbp
 12e:	lea    0x10(%rax),%rbx
 132:	movups %xmm1,(%rax,%rdx,1)
 136:	cmp    %r12,%r13
 139:	jne    7a <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x7a>
 13f:	jmp    a9 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0xa9>
 144:	nopl   0x0(%rax)
 148:	add    $0x1,%rax
 14c:	jb     108 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x108>
 14e:	movabs $0x7ffffffffffffff,%rcx
 158:	cmp    %rcx,%rax
 15b:	cmovbe %rax,%rcx
 15f:	mov    %rcx,%rbp
 162:	shl    $0x4,%rbp
 166:	jmp    112 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x112>
 168:	movabs $0x7ffffffffffffff,%rax
 172:	cmp    %rax,%rcx
 175:	cmova  %rax,%rcx
 179:	shl    $0x4,%rcx
 17d:	mov    %rcx,%rbp
 180:	jmp    112 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x112>
 182:	lea    0x0(%rip),%rdi        # 189 <void std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> >::_M_realloc_insert<ivf::Neighbor const&>(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, ivf::Neighbor const&)+0x189>
 189:	call   18e <.LC19+0xbe>

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
  2d:	movsd  %xmm0,0x30(%rsp)
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
  5c:	mov    %rax,0x18(%rsp)
  61:	cmp    %rax,%rsi
  64:	jge    1c0 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x1c0>
  6a:	mov    %rsi,%r8
  6d:	jmp    97 <void std::__adjust_heap<__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)> >(__gnu_cxx::__normal_iterator<ivf::Neighbor*, std::vector<ivf::Neighbor, std::allocator<ivf::Neighbor> > >, long, long, ivf::Neighbor, __gnu_cxx::__ops::_Iter_comp_iter<bool (*)(ivf::Neighbor const&, ivf::Neighbor const&)>)+0x97>
  6f:	nop
  70:	mov    0x0(%r13),%rax
  74:	shl    $0x4,%r8
  78:	add    %rbp,%r8
  7b:	mov    %rax,(%r8)
  7e:	mov    0x8(%r13),%eax
  82:	mov    %eax,0x8(%r8)
  86:	cmp    %r14,0x18(%rsp)
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
 184:	lea    0x0(%rbp,%rdx,1),%r15
 189:	test   %al,%al
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
 25d:	call   262 <.LC19+0x192>
