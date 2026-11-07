
results/server/vec/ivf_simd_default.o:     file format elf64-x86-64


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
  63:	cmp    %rcx,%rax
  66:	jne    30 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x30>
  68:	mov    %rdx,%rax
  6b:	and    $0xfffffffffffffffc,%rax
  6f:	test   $0x3,%dl
  72:	je     ba <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xba>
  74:	sub    %rax,%rdx
  77:	cmp    $0x1,%rdx
  7b:	je     a8 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xa8>
  7d:	movq   (%rdi,%rax,4),%xmm1
  82:	movq   (%rsi,%rax,4),%xmm2
  87:	mov    %rdx,%rcx
  8a:	and    $0xfffffffffffffffe,%rcx
  8e:	subps  %xmm2,%xmm1
  91:	add    %rcx,%rax
  94:	mulps  %xmm1,%xmm1
  97:	addss  %xmm1,%xmm0
  9b:	shufps $0xe5,%xmm1,%xmm1
  9f:	addss  %xmm1,%xmm0
  a3:	cmp    %rcx,%rdx
  a6:	je     ba <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xba>
  a8:	movss  (%rdi,%rax,4),%xmm1
  ad:	subss  (%rsi,%rax,4),%xmm1
  b2:	mulss  %xmm1,%xmm1
  b6:	addss  %xmm1,%xmm0
  ba:	cvtss2sd %xmm0,%xmm0
  be:	ret    
  bf:	nop
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
  f8:	je     202 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x132>
  fe:	lea    -0x1(%rdx),%rax
 102:	mov    %rsi,%rcx
 105:	cmp    $0x2,%rax
 109:	jbe    232 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x162>
 10f:	mov    %rdx,%rsi
 112:	pxor   %xmm5,%xmm5
 116:	xor    %eax,%eax
 118:	shr    $0x2,%rsi
 11c:	movapd %xmm5,%xmm4
 120:	shl    $0x4,%rsi
 124:	nopl   0x0(%rax)
 128:	movlps 0x8(%rdi,%rax,1),%xmm2
 12d:	movlps 0x8(%rcx,%rax,1),%xmm3
 132:	cvtps2pd (%rcx,%rax,1),%xmm0
 136:	cvtps2pd (%rdi,%rax,1),%xmm1
 13a:	cvtps2pd %xmm3,%xmm6
 13d:	subpd  %xmm0,%xmm1
 141:	cvtps2pd %xmm2,%xmm0
 144:	subpd  %xmm6,%xmm0
 148:	add    $0x10,%rax
 14c:	mulpd  %xmm1,%xmm1
 150:	mulpd  %xmm0,%xmm0
 154:	addpd  %xmm1,%xmm5
 158:	addpd  %xmm0,%xmm4
 15c:	cmp    %rax,%rsi
 15f:	jne    128 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x58>
 161:	mov    %rdx,%rax
 164:	movaps %xmm5,(%rsp)
 168:	movaps %xmm4,0x10(%rsp)
 16d:	and    $0xfffffffffffffffc,%rax
 171:	test   $0x3,%dl
 174:	je     202 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x132>
 17a:	pxor   %xmm0,%xmm0
 17e:	pxor   %xmm1,%xmm1
 182:	lea    0x1(%rax),%r8
 186:	cvtss2sd (%rdi,%rax,4),%xmm0
 18b:	cvtss2sd (%rcx,%rax,4),%xmm1
 190:	subsd  %xmm1,%xmm0
 194:	lea    0x0(,%rax,4),%rsi
 19c:	mulsd  %xmm0,%xmm0
 1a0:	addsd  (%rsp),%xmm0
 1a5:	movsd  %xmm0,(%rsp)
 1aa:	cmp    %r8,%rdx
 1ad:	jbe    202 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x132>
 1af:	pxor   %xmm1,%xmm1
 1b3:	pxor   %xmm2,%xmm2
 1b7:	add    $0x2,%rax
 1bb:	cvtss2sd 0x4(%rdi,%rsi,1),%xmm1
 1c1:	cvtss2sd 0x4(%rcx,%rsi,1),%xmm2
 1c7:	subsd  %xmm2,%xmm1
 1cb:	mulsd  %xmm1,%xmm1
 1cf:	addsd  %xmm0,%xmm1
 1d3:	movsd  %xmm1,(%rsp)
 1d8:	cmp    %rax,%rdx
 1db:	jbe    202 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x132>
 1dd:	pxor   %xmm0,%xmm0
 1e1:	pxor   %xmm2,%xmm2
 1e5:	cvtss2sd 0x8(%rdi,%rsi,1),%xmm0
 1eb:	cvtss2sd 0x8(%rcx,%rsi,1),%xmm2
 1f1:	subsd  %xmm2,%xmm0
 1f5:	mulsd  %xmm0,%xmm0
 1f9:	addsd  %xmm1,%xmm0
 1fd:	movsd  %xmm0,(%rsp)
 202:	pxor   %xmm0,%xmm0
 206:	addsd  (%rsp),%xmm0
 20b:	addsd  0x8(%rsp),%xmm0
 211:	addsd  0x10(%rsp),%xmm0
 217:	addsd  0x18(%rsp),%xmm0
 21d:	mov    0x28(%rsp),%rax
 222:	sub    %fs:0x28,%rax
 22b:	jne    239 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x169>
 22d:	add    $0x38,%rsp
 231:	ret    
 232:	xor    %eax,%eax
 234:	jmp    17a <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0xaa>
 239:	call   23e <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x16e>
 23e:	xchg   %ax,%ax

0000000000000240 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)>:
 240:	endbr64 
 244:	sub    $0x28,%rsp
 248:	pxor   %xmm0,%xmm0
 24c:	mov    %fs:0x28,%rax
 255:	mov    %rax,0x18(%rsp)
 25a:	xor    %eax,%eax
 25c:	movaps %xmm0,(%rsp)
 260:	test   %rdx,%rdx
 263:	je     31e <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xde>
 269:	lea    -0x1(%rdx),%rax
 26d:	mov    %rsi,%rcx
 270:	cmp    $0x2,%rax
 274:	jbe    360 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x120>
 27a:	mov    %rdx,%rsi
 27d:	xor    %eax,%eax
 27f:	pxor   %xmm1,%xmm1
 283:	shr    $0x2,%rsi
 287:	shl    $0x4,%rsi
 28b:	nopl   0x0(%rax,%rax,1)
 290:	movups (%rdi,%rax,1),%xmm0
 294:	movups (%rcx,%rax,1),%xmm3
 298:	add    $0x10,%rax
 29c:	subps  %xmm3,%xmm0
 29f:	mulps  %xmm0,%xmm0
 2a2:	addps  %xmm0,%xmm1
 2a5:	cmp    %rsi,%rax
 2a8:	jne    290 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x50>
 2aa:	mov    %rdx,%rax
 2ad:	movaps %xmm1,(%rsp)
 2b1:	and    $0xfffffffffffffffc,%rax
 2b5:	test   $0x3,%dl
 2b8:	je     31e <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xde>
 2ba:	movss  (%rdi,%rax,4),%xmm0
 2bf:	subss  (%rcx,%rax,4),%xmm0
 2c4:	lea    0x1(%rax),%r8
 2c8:	lea    0x0(,%rax,4),%rsi
 2d0:	mulss  %xmm0,%xmm0
 2d4:	addss  (%rsp),%xmm0
 2d9:	movss  %xmm0,(%rsp)
 2de:	cmp    %r8,%rdx
 2e1:	jbe    31e <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xde>
 2e3:	movss  0x4(%rdi,%rsi,1),%xmm1
 2e9:	subss  0x4(%rcx,%rsi,1),%xmm1
 2ef:	add    $0x2,%rax
 2f3:	mulss  %xmm1,%xmm1
 2f7:	addss  %xmm0,%xmm1
 2fb:	movss  %xmm1,(%rsp)
 300:	cmp    %rax,%rdx
 303:	jbe    31e <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xde>
 305:	movss  0x8(%rdi,%rsi,1),%xmm0
 30b:	subss  0x8(%rcx,%rsi,1),%xmm0
 311:	mulss  %xmm0,%xmm0
 315:	addss  %xmm1,%xmm0
 319:	movss  %xmm0,(%rsp)
 31e:	movaps (%rsp),%xmm1
 322:	pxor   %xmm2,%xmm2
 326:	addss  %xmm1,%xmm2
 32a:	movaps %xmm1,%xmm0
 32d:	shufps $0x55,%xmm1,%xmm0
 331:	addss  %xmm2,%xmm0
 335:	movaps %xmm1,%xmm2
 338:	unpckhps %xmm1,%xmm2
 33b:	shufps $0xff,%xmm1,%xmm1
 33f:	addss  %xmm2,%xmm0
 343:	addss  %xmm1,%xmm0
 347:	cvtss2sd %xmm0,%xmm0
 34b:	mov    0x18(%rsp),%rax
 350:	sub    %fs:0x28,%rax
 359:	jne    367 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x127>
 35b:	add    $0x28,%rsp
 35f:	ret    
 360:	xor    %eax,%eax
 362:	jmp    2ba <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x7a>
 367:	call   36c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x12c>
 36c:	nopl   0x0(%rax)

0000000000000370 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)>:
 370:	endbr64 
 374:	push   %r15
 376:	push   %r14
 378:	push   %r13
 37a:	mov    %rdi,%r13
 37d:	push   %r12
 37f:	mov    %rsi,%r12
 382:	push   %rbp
 383:	push   %rbx
 384:	sub    $0x28,%rsp
 388:	mov    0x50(%rdi),%r15
 38c:	mov    0x48(%rdi),%rbp
 390:	movss  0x0(%rip),%xmm6        # 398 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x28>
 398:	movss  0x0(%rip),%xmm7        # 3a0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x30>
 3a0:	mov    %rdx,0x18(%rsp)
 3a5:	mov    %r15,%rbx
 3a8:	sub    %rbp,%rbx
 3ab:	movss  %xmm6,0x10(%rsp)
 3b1:	sar    $0x2,%rbx
 3b5:	movss  %xmm7,0xc(%rsp)
 3bb:	je     420 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xb0>
 3bd:	xor    %r14d,%r14d
 3c0:	jmp    3ec <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x7c>
 3c2:	nopw   0x0(%rax,%rax,1)
 3c8:	movaps %xmm1,%xmm2
 3cb:	maxss  0x10(%rsp),%xmm1
 3d1:	minss  0xc(%rsp),%xmm2
 3d7:	add    $0x1,%r14
 3db:	movss  %xmm2,0xc(%rsp)
 3e1:	movss  %xmm1,0x10(%rsp)
 3e7:	cmp    %r14,%rbx
 3ea:	je     420 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xb0>
 3ec:	movss  0x0(%rbp,%r14,4),%xmm1
 3f3:	movaps %xmm1,%xmm0
 3f6:	movss  %xmm1,0x14(%rsp)
 3fc:	call   401 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x91>
 401:	movss  0x14(%rsp),%xmm1
 407:	ucomiss %xmm0,%xmm1
 40a:	jp     40e <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x9e>
 40c:	je     3c8 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x58>
 40e:	xor    %eax,%eax
 410:	add    $0x28,%rsp
 414:	pop    %rbx
 415:	pop    %rbp
 416:	pop    %r12
 418:	pop    %r13
 41a:	pop    %r14
 41c:	pop    %r15
 41e:	ret    
 41f:	nop
 420:	mov    0x8(%r13),%r14
 424:	mov    0x18(%rsp),%rbx
 429:	xor    %r13d,%r13d
 42c:	imul   %r14,%rbx
 430:	test   %rbx,%rbx
 433:	jne    464 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xf4>
 435:	jmp    490 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x120>
 437:	nopw   0x0(%rax,%rax,1)
 440:	movaps %xmm1,%xmm5
 443:	maxss  0x10(%rsp),%xmm1
 449:	minss  0xc(%rsp),%xmm5
 44f:	add    $0x1,%r13
 453:	movss  %xmm5,0xc(%rsp)
 459:	movss  %xmm1,0x10(%rsp)
 45f:	cmp    %r13,%rbx
 462:	je     490 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x120>
 464:	movss  (%r12,%r13,4),%xmm1
 46a:	movaps %xmm1,%xmm0
 46d:	movss  %xmm1,0x14(%rsp)
 473:	call   478 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x108>
 478:	movss  0x14(%rsp),%xmm1
 47e:	ucomiss %xmm0,%xmm1
 481:	jp     40e <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x9e>
 483:	je     440 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xd0>
 485:	jmp    40e <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x9e>
 487:	nopw   0x0(%rax,%rax,1)
 490:	cmpq   $0x0,0x18(%rsp)
 496:	sete   %al
 499:	cmp    %r15,%rbp
 49c:	sete   %dl
 49f:	and    %dl,%al
 4a1:	jne    410 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa0>
 4a7:	pxor   %xmm1,%xmm1
 4ab:	pxor   %xmm0,%xmm0
 4af:	cvtss2sd 0x10(%rsp),%xmm1
 4b5:	cvtss2sd 0xc(%rsp),%xmm0
 4bb:	subsd  %xmm0,%xmm1
 4bf:	test   %r14,%r14
 4c2:	js     4f8 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x188>
 4c4:	pxor   %xmm0,%xmm0
 4c8:	cvtsi2sd %r14,%xmm0
 4cd:	mulsd  %xmm1,%xmm0
 4d1:	mulsd  %xmm1,%xmm0
 4d5:	movsd  0x0(%rip),%xmm1        # 4dd <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x16d>
 4dd:	comisd %xmm0,%xmm1
 4e1:	seta   %al
 4e4:	add    $0x28,%rsp
 4e8:	pop    %rbx
 4e9:	pop    %rbp
 4ea:	pop    %r12
 4ec:	pop    %r13
 4ee:	pop    %r14
 4f0:	pop    %r15
 4f2:	ret    
 4f3:	nopl   0x0(%rax,%rax,1)
 4f8:	mov    %r14,%rax
 4fb:	and    $0x1,%r14d
 4ff:	pxor   %xmm0,%xmm0
 503:	shr    %rax
 506:	or     %r14,%rax
 509:	cvtsi2sd %rax,%xmm0
 50e:	addsd  %xmm0,%xmm0
 512:	jmp    4cd <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x15d>
 514:	data16 cs nopw 0x0(%rax,%rax,1)
 51f:	nop

0000000000000520 <ivf::dist_name(ivf::DistKind)>:
 520:	endbr64 
 524:	lea    0x0(%rip),%rax        # 52b <ivf::dist_name(ivf::DistKind)+0xb>
 52b:	cmp    $0x2,%edi
 52e:	je     56d <ivf::dist_name(ivf::DistKind)+0x4d>
 530:	jg     558 <ivf::dist_name(ivf::DistKind)+0x38>
 532:	lea    0x0(%rip),%rax        # 539 <ivf::dist_name(ivf::DistKind)+0x19>
 539:	test   %edi,%edi
 53b:	je     56d <ivf::dist_name(ivf::DistKind)+0x4d>
 53d:	cmp    $0x1,%edi
 540:	lea    0x0(%rip),%rdx        # 547 <ivf::dist_name(ivf::DistKind)+0x27>
 547:	lea    0x0(%rip),%rax        # 54e <ivf::dist_name(ivf::DistKind)+0x2e>
 54e:	cmove  %rdx,%rax
 552:	ret    
 553:	nopl   0x0(%rax,%rax,1)
 558:	cmp    $0x3,%edi
 55b:	lea    0x0(%rip),%rax        # 562 <ivf::dist_name(ivf::DistKind)+0x42>
 562:	lea    0x0(%rip),%rdx        # 569 <ivf::dist_name(ivf::DistKind)+0x49>
 569:	cmove  %rdx,%rax
 56d:	ret    
