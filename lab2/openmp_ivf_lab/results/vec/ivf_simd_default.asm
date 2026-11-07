
results/vec/ivf_simd_default.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <ivf::l2_distance_f32(float const*, float const*, unsigned long)>:
   0:	endbr64
   4:	test   %rdx,%rdx
   7:	je     c0 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xc0>
   d:	lea    -0x1(%rdx),%rax
  11:	cmp    $0x2,%rax
  15:	jbe    c5 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xc5>
  1b:	mov    %rdx,%rcx
  1e:	xor    %eax,%eax
  20:	pxor   %xmm0,%xmm0
  24:	shr    $0x2,%rcx
  28:	shl    $0x4,%rcx
  2c:	nopl   0x0(%rax)
  30:	movups (%rdi,%rax,1),%xmm1
  34:	movups (%rsi,%rax,1),%xmm3
  38:	add    $0x10,%rax
  3c:	subps  %xmm3,%xmm1
  3f:	mulps  %xmm1,%xmm1
  42:	addss  %xmm1,%xmm0
  46:	movaps %xmm1,%xmm2
  49:	shufps $0x55,%xmm1,%xmm2
  4d:	addss  %xmm2,%xmm0
  51:	movaps %xmm1,%xmm2
  54:	unpckhps %xmm1,%xmm2
  57:	shufps $0xff,%xmm1,%xmm1
  5b:	addss  %xmm2,%xmm0
  5f:	addss  %xmm1,%xmm0
  63:	cmp    %rax,%rcx
  66:	jne    30 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x30>
  68:	test   $0x3,%dl
  6b:	je     b7 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xb7>
  6d:	mov    %rdx,%rax
  70:	and    $0xfffffffffffffffc,%rax
  74:	sub    %rax,%rdx
  77:	cmp    $0x1,%rdx
  7b:	je     a5 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xa5>
  7d:	movq   (%rdi,%rax,4),%xmm1
  82:	movq   (%rsi,%rax,4),%xmm2
  87:	subps  %xmm2,%xmm1
  8a:	mulps  %xmm1,%xmm1
  8d:	addss  %xmm1,%xmm0
  91:	shufps $0xe5,%xmm1,%xmm1
  95:	addss  %xmm1,%xmm0
  99:	test   $0x1,%dl
  9c:	je     b7 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xb7>
  9e:	and    $0xfffffffffffffffe,%rdx
  a2:	add    %rdx,%rax
  a5:	movss  (%rdi,%rax,4),%xmm1
  aa:	subss  (%rsi,%rax,4),%xmm1
  af:	mulss  %xmm1,%xmm1
  b3:	addss  %xmm1,%xmm0
  b7:	cvtss2sd %xmm0,%xmm0
  bb:	ret
  bc:	nopl   0x0(%rax)
  c0:	pxor   %xmm0,%xmm0
  c4:	ret
  c5:	xor    %eax,%eax
  c7:	pxor   %xmm0,%xmm0
  cb:	jmp    74 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x74>
  cd:	nopl   (%rax)

00000000000000d0 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)>:
  d0:	endbr64
  d4:	sub    $0x38,%rsp
  d8:	pxor   %xmm0,%xmm0
  dc:	mov    %fs:0x28,%rax
  e5:	mov    %rax,0x28(%rsp)
  ea:	xor    %eax,%eax
  ec:	movaps %xmm0,(%rsp)
  f0:	movaps %xmm0,0x10(%rsp)
  f5:	test   %rdx,%rdx
  f8:	je     1fc <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x12c>
  fe:	mov    %rdi,%rcx
 101:	cmp    $0x3,%rdx
 105:	jbe    22c <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x15c>
 10b:	mov    %rdx,%rdi
 10e:	pxor   %xmm4,%xmm4
 112:	shr    $0x2,%rdi
 116:	movapd %xmm4,%xmm5
 11a:	shl    $0x4,%rdi
 11e:	xchg   %ax,%ax
 120:	movups (%rsi,%rax,1),%xmm6
 124:	movups (%rcx,%rax,1),%xmm7
 128:	add    $0x10,%rax
 12c:	movhlps %xmm7,%xmm2
 12f:	movhlps %xmm6,%xmm3
 132:	cvtps2pd %xmm6,%xmm0
 135:	cvtps2pd %xmm7,%xmm1
 138:	cvtps2pd %xmm3,%xmm6
 13b:	subpd  %xmm0,%xmm1
 13f:	cvtps2pd %xmm2,%xmm0
 142:	subpd  %xmm6,%xmm0
 146:	mulpd  %xmm1,%xmm1
 14a:	mulpd  %xmm0,%xmm0
 14e:	addpd  %xmm1,%xmm4
 152:	addpd  %xmm0,%xmm5
 156:	cmp    %rax,%rdi
 159:	jne    120 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x50>
 15b:	mov    %rdx,%rax
 15e:	movaps %xmm4,(%rsp)
 162:	movaps %xmm5,0x10(%rsp)
 167:	and    $0xfffffffffffffffc,%rax
 16b:	test   $0x3,%dl
 16e:	je     1fc <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x12c>
 174:	pxor   %xmm0,%xmm0
 178:	pxor   %xmm1,%xmm1
 17c:	lea    0x1(%rax),%r8
 180:	cvtss2sd (%rcx,%rax,4),%xmm0
 185:	cvtss2sd (%rsi,%rax,4),%xmm1
 18a:	subsd  %xmm1,%xmm0
 18e:	lea    0x0(,%rax,4),%rdi
 196:	mulsd  %xmm0,%xmm0
 19a:	addsd  (%rsp),%xmm0
 19f:	movsd  %xmm0,(%rsp)
 1a4:	cmp    %rdx,%r8
 1a7:	jae    1fc <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x12c>
 1a9:	pxor   %xmm1,%xmm1
 1ad:	pxor   %xmm2,%xmm2
 1b1:	add    $0x2,%rax
 1b5:	cvtss2sd 0x4(%rcx,%rdi,1),%xmm1
 1bb:	cvtss2sd 0x4(%rsi,%rdi,1),%xmm2
 1c1:	subsd  %xmm2,%xmm1
 1c5:	mulsd  %xmm1,%xmm1
 1c9:	addsd  %xmm0,%xmm1
 1cd:	movsd  %xmm1,(%rsp)
 1d2:	cmp    %rdx,%rax
 1d5:	jae    1fc <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x12c>
 1d7:	pxor   %xmm0,%xmm0
 1db:	pxor   %xmm2,%xmm2
 1df:	cvtss2sd 0x8(%rcx,%rdi,1),%xmm0
 1e5:	cvtss2sd 0x8(%rsi,%rdi,1),%xmm2
 1eb:	subsd  %xmm2,%xmm0
 1ef:	mulsd  %xmm0,%xmm0
 1f3:	addsd  %xmm1,%xmm0
 1f7:	movsd  %xmm0,(%rsp)
 1fc:	pxor   %xmm0,%xmm0
 200:	addsd  (%rsp),%xmm0
 205:	addsd  0x8(%rsp),%xmm0
 20b:	addsd  0x10(%rsp),%xmm0
 211:	addsd  0x18(%rsp),%xmm0
 217:	mov    0x28(%rsp),%rax
 21c:	sub    %fs:0x28,%rax
 225:	jne    233 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x163>
 227:	add    $0x38,%rsp
 22b:	ret
 22c:	xor    %eax,%eax
 22e:	jmp    174 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0xa4>
 233:	call   238 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x168>
 238:	nopl   0x0(%rax,%rax,1)

0000000000000240 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)>:
 240:	endbr64
 244:	sub    $0x28,%rsp
 248:	pxor   %xmm0,%xmm0
 24c:	mov    %fs:0x28,%rax
 255:	mov    %rax,0x18(%rsp)
 25a:	xor    %eax,%eax
 25c:	movaps %xmm0,(%rsp)
 260:	test   %rdx,%rdx
 263:	je     316 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xd6>
 269:	mov    %rdi,%rcx
 26c:	cmp    $0x3,%rdx
 270:	jbe    34a <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x10a>
 276:	mov    %rdx,%rdi
 279:	pxor   %xmm1,%xmm1
 27d:	shr    $0x2,%rdi
 281:	shl    $0x4,%rdi
 285:	nopl   (%rax)
 288:	movups (%rcx,%rax,1),%xmm0
 28c:	movups (%rsi,%rax,1),%xmm2
 290:	add    $0x10,%rax
 294:	subps  %xmm2,%xmm0
 297:	mulps  %xmm0,%xmm0
 29a:	addps  %xmm0,%xmm1
 29d:	cmp    %rdi,%rax
 2a0:	jne    288 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x48>
 2a2:	mov    %rdx,%rax
 2a5:	movaps %xmm1,(%rsp)
 2a9:	and    $0xfffffffffffffffc,%rax
 2ad:	test   $0x3,%dl
 2b0:	je     316 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xd6>
 2b2:	movss  (%rcx,%rax,4),%xmm0
 2b7:	subss  (%rsi,%rax,4),%xmm0
 2bc:	lea    0x1(%rax),%r8
 2c0:	lea    0x0(,%rax,4),%rdi
 2c8:	mulss  %xmm0,%xmm0
 2cc:	addss  (%rsp),%xmm0
 2d1:	movss  %xmm0,(%rsp)
 2d6:	cmp    %rdx,%r8
 2d9:	jae    316 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xd6>
 2db:	movss  0x4(%rcx,%rdi,1),%xmm1
 2e1:	subss  0x4(%rsi,%rdi,1),%xmm1
 2e7:	add    $0x2,%rax
 2eb:	mulss  %xmm1,%xmm1
 2ef:	addss  %xmm0,%xmm1
 2f3:	movss  %xmm1,(%rsp)
 2f8:	cmp    %rdx,%rax
 2fb:	jae    316 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xd6>
 2fd:	movss  0x8(%rcx,%rdi,1),%xmm0
 303:	subss  0x8(%rsi,%rdi,1),%xmm0
 309:	mulss  %xmm0,%xmm0
 30d:	addss  %xmm1,%xmm0
 311:	movss  %xmm0,(%rsp)
 316:	pxor   %xmm0,%xmm0
 31a:	addss  (%rsp),%xmm0
 31f:	addss  0x4(%rsp),%xmm0
 325:	addss  0x8(%rsp),%xmm0
 32b:	addss  0xc(%rsp),%xmm0
 331:	cvtss2sd %xmm0,%xmm0
 335:	mov    0x18(%rsp),%rax
 33a:	sub    %fs:0x28,%rax
 343:	jne    351 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x111>
 345:	add    $0x28,%rsp
 349:	ret
 34a:	xor    %eax,%eax
 34c:	jmp    2b2 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x72>
 351:	call   356 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x116>
 356:	cs nopw 0x0(%rax,%rax,1)

0000000000000360 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)>:
 360:	endbr64
 364:	push   %r15
 366:	push   %r14
 368:	push   %r13
 36a:	mov    %rdi,%r13
 36d:	push   %r12
 36f:	mov    %rsi,%r12
 372:	push   %rbp
 373:	push   %rbx
 374:	sub    $0x28,%rsp
 378:	mov    0x50(%rdi),%r15
 37c:	mov    0x48(%rdi),%rbx
 380:	mov    %rdx,0x18(%rsp)
 385:	mov    %r15,%rbp
 388:	sub    %rbx,%rbp
 38b:	sar    $0x2,%rbp
 38f:	cmp    %r15,%rbx
 392:	je     48a <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x12a>
 398:	movss  0x0(%rip),%xmm6        # 3a0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x40>
 3a0:	movss  0x0(%rip),%xmm7        # 3a8 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x48>
 3a8:	xor    %r14d,%r14d
 3ab:	movss  %xmm6,0xc(%rsp)
 3b1:	movss  %xmm7,0x10(%rsp)
 3b7:	jmp    3e4 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x84>
 3b9:	nopl   0x0(%rax)
 3c0:	movaps %xmm1,%xmm2
 3c3:	maxss  0xc(%rsp),%xmm1
 3c9:	minss  0x10(%rsp),%xmm2
 3cf:	add    $0x1,%r14
 3d3:	movss  %xmm2,0x10(%rsp)
 3d9:	movss  %xmm1,0xc(%rsp)
 3df:	cmp    %rbp,%r14
 3e2:	jae    420 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xc0>
 3e4:	movss  (%rbx,%r14,4),%xmm1
 3ea:	movaps %xmm1,%xmm0
 3ed:	movss  %xmm1,0x14(%rsp)
 3f3:	call   3f8 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x98>
 3f8:	movss  0x14(%rsp),%xmm1
 3fe:	ucomiss %xmm0,%xmm1
 401:	jp     405 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa5>
 403:	je     3c0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x60>
 405:	xor    %eax,%eax
 407:	add    $0x28,%rsp
 40b:	pop    %rbx
 40c:	pop    %rbp
 40d:	pop    %r12
 40f:	pop    %r13
 411:	pop    %r14
 413:	pop    %r15
 415:	ret
 416:	cs nopw 0x0(%rax,%rax,1)
 420:	mov    0x8(%r13),%r14
 424:	mov    0x18(%rsp),%rbp
 429:	imul   %r14,%rbp
 42d:	test   %rbp,%rbp
 430:	je     4d7 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x177>
 436:	xor    %r13d,%r13d
 439:	jmp    464 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x104>
 43b:	nopl   0x0(%rax,%rax,1)
 440:	movaps %xmm1,%xmm5
 443:	maxss  0xc(%rsp),%xmm1
 449:	minss  0x10(%rsp),%xmm5
 44f:	add    $0x1,%r13
 453:	movss  %xmm5,0x10(%rsp)
 459:	movss  %xmm1,0xc(%rsp)
 45f:	cmp    %rbp,%r13
 462:	je     4c0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x160>
 464:	movss  (%r12,%r13,4),%xmm1
 46a:	movaps %xmm1,%xmm0
 46d:	movss  %xmm1,0x14(%rsp)
 473:	call   478 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x118>
 478:	movss  0x14(%rsp),%xmm1
 47e:	ucomiss %xmm0,%xmm1
 481:	jp     405 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa5>
 483:	je     440 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xe0>
 485:	jmp    405 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa5>
 48a:	mov    0x8(%rdi),%r14
 48e:	mov    %rdx,%rbp
 491:	movss  0x0(%rip),%xmm6        # 499 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x139>
 499:	movss  0x0(%rip),%xmm7        # 4a1 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x141>
 4a1:	imul   %r14,%rbp
 4a5:	movss  %xmm6,0x10(%rsp)
 4ab:	movss  %xmm7,0xc(%rsp)
 4b1:	test   %rbp,%rbp
 4b4:	jne    436 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xd6>
 4ba:	nopw   0x0(%rax,%rax,1)
 4c0:	cmp    %r15,%rbx
 4c3:	sete   %al
 4c6:	cmpq   $0x0,0x18(%rsp)
 4cc:	sete   %dl
 4cf:	and    %dl,%al
 4d1:	jne    407 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa7>
 4d7:	pxor   %xmm1,%xmm1
 4db:	pxor   %xmm0,%xmm0
 4df:	cvtss2sd 0xc(%rsp),%xmm1
 4e5:	cvtss2sd 0x10(%rsp),%xmm0
 4eb:	subsd  %xmm0,%xmm1
 4ef:	test   %r14,%r14
 4f2:	js     528 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x1c8>
 4f4:	pxor   %xmm0,%xmm0
 4f8:	cvtsi2sd %r14,%xmm0
 4fd:	mulsd  %xmm1,%xmm0
 501:	mulsd  %xmm1,%xmm0
 505:	movsd  0x0(%rip),%xmm1        # 50d <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x1ad>
 50d:	comisd %xmm0,%xmm1
 511:	seta   %al
 514:	add    $0x28,%rsp
 518:	pop    %rbx
 519:	pop    %rbp
 51a:	pop    %r12
 51c:	pop    %r13
 51e:	pop    %r14
 520:	pop    %r15
 522:	ret
 523:	nopl   0x0(%rax,%rax,1)
 528:	mov    %r14,%rax
 52b:	and    $0x1,%r14d
 52f:	pxor   %xmm0,%xmm0
 533:	shr    $1,%rax
 536:	or     %r14,%rax
 539:	cvtsi2sd %rax,%xmm0
 53e:	addsd  %xmm0,%xmm0
 542:	jmp    4fd <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x19d>
 544:	data16 cs nopw 0x0(%rax,%rax,1)
 54f:	nop

0000000000000550 <ivf::dist_name(ivf::DistKind)>:
 550:	endbr64
 554:	lea    0x0(%rip),%rax        # 55b <ivf::dist_name(ivf::DistKind)+0xb>
 55b:	cmp    $0x2,%edi
 55e:	je     59d <ivf::dist_name(ivf::DistKind)+0x4d>
 560:	jg     588 <ivf::dist_name(ivf::DistKind)+0x38>
 562:	lea    0x0(%rip),%rax        # 569 <ivf::dist_name(ivf::DistKind)+0x19>
 569:	test   %edi,%edi
 56b:	je     59d <ivf::dist_name(ivf::DistKind)+0x4d>
 56d:	cmp    $0x1,%edi
 570:	lea    0x0(%rip),%rdx        # 577 <ivf::dist_name(ivf::DistKind)+0x27>
 577:	lea    0x0(%rip),%rax        # 57e <ivf::dist_name(ivf::DistKind)+0x2e>
 57e:	cmove  %rdx,%rax
 582:	ret
 583:	nopl   0x0(%rax,%rax,1)
 588:	cmp    $0x3,%edi
 58b:	lea    0x0(%rip),%rax        # 592 <ivf::dist_name(ivf::DistKind)+0x42>
 592:	lea    0x0(%rip),%rdx        # 599 <ivf::dist_name(ivf::DistKind)+0x49>
 599:	cmove  %rdx,%rax
 59d:	ret
