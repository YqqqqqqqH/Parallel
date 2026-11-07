
results/vec/ivf_simd_native.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <ivf::l2_distance_f32(float const*, float const*, unsigned long)>:
   0:	endbr64
   4:	test   %rdx,%rdx
   7:	mov    %rsi,%rcx
   a:	je     140 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x140>
  10:	lea    -0x1(%rdx),%rax
  14:	cmp    $0x6,%rax
  18:	jbe    150 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x150>
  1e:	mov    %rdx,%rsi
  21:	xor    %eax,%eax
  23:	vxorps %xmm0,%xmm0,%xmm0
  27:	shr    $0x3,%rsi
  2b:	shl    $0x5,%rsi
  2f:	nop
  30:	vmovups (%rdi,%rax,1),%ymm4
  35:	vsubps (%rcx,%rax,1),%ymm4,%ymm1
  3a:	add    $0x20,%rax
  3e:	cmp    %rax,%rsi
  41:	vmulps %ymm1,%ymm1,%ymm1
  45:	vaddss %xmm1,%xmm0,%xmm0
  49:	vshufps $0x55,%xmm1,%xmm1,%xmm3
  4e:	vshufps $0xff,%xmm1,%xmm1,%xmm2
  53:	vaddss %xmm3,%xmm0,%xmm0
  57:	vunpckhps %xmm1,%xmm1,%xmm3
  5b:	vextractf128 $0x1,%ymm1,%xmm1
  61:	vaddss %xmm3,%xmm0,%xmm0
  65:	vaddss %xmm2,%xmm0,%xmm0
  69:	vshufps $0x55,%xmm1,%xmm1,%xmm2
  6e:	vaddss %xmm1,%xmm0,%xmm0
  72:	vaddss %xmm2,%xmm0,%xmm0
  76:	vunpckhps %xmm1,%xmm1,%xmm2
  7a:	vshufps $0xff,%xmm1,%xmm1,%xmm1
  7f:	vaddss %xmm2,%xmm0,%xmm0
  83:	vaddss %xmm1,%xmm0,%xmm0
  87:	jne    30 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x30>
  89:	mov    %rdx,%rax
  8c:	and    $0xfffffffffffffff8,%rax
  90:	test   $0x7,%dl
  93:	je     148 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x148>
  99:	vzeroupper
  9c:	mov    %rdx,%rsi
  9f:	sub    %rax,%rsi
  a2:	lea    -0x1(%rsi),%r8
  a6:	cmp    $0x2,%r8
  aa:	jbe    e7 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xe7>
  ac:	vmovups (%rdi,%rax,4),%xmm5
  b1:	vsubps (%rcx,%rax,4),%xmm5,%xmm1
  b6:	mov    %rsi,%r8
  b9:	and    $0xfffffffffffffffc,%r8
  bd:	add    %r8,%rax
  c0:	and    $0x3,%esi
  c3:	vmulps %xmm1,%xmm1,%xmm1
  c7:	vaddss %xmm1,%xmm0,%xmm0
  cb:	vshufps $0x55,%xmm1,%xmm1,%xmm2
  d0:	vaddss %xmm2,%xmm0,%xmm0
  d4:	vunpckhps %xmm1,%xmm1,%xmm2
  d8:	vshufps $0xff,%xmm1,%xmm1,%xmm1
  dd:	vaddss %xmm2,%xmm0,%xmm0
  e1:	vaddss %xmm1,%xmm0,%xmm0
  e5:	je     132 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x132>
  e7:	vmovss (%rdi,%rax,4),%xmm1
  ec:	vsubss (%rcx,%rax,4),%xmm1,%xmm1
  f1:	lea    0x1(%rax),%r8
  f5:	cmp    %rdx,%r8
  f8:	lea    0x0(,%rax,4),%rsi
 100:	vfmadd231ss %xmm1,%xmm1,%xmm0
 105:	jae    132 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x132>
 107:	vmovss 0x4(%rdi,%rsi,1),%xmm1
 10d:	vsubss 0x4(%rcx,%rsi,1),%xmm1,%xmm1
 113:	add    $0x2,%rax
 117:	cmp    %rdx,%rax
 11a:	vfmadd231ss %xmm1,%xmm1,%xmm0
 11f:	jae    132 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x132>
 121:	vmovss 0x8(%rdi,%rsi,1),%xmm1
 127:	vsubss 0x8(%rcx,%rsi,1),%xmm1,%xmm1
 12d:	vfmadd231ss %xmm1,%xmm1,%xmm0
 132:	vcvtss2sd %xmm0,%xmm0,%xmm0
 136:	ret
 137:	nopw   0x0(%rax,%rax,1)
 140:	vxorpd %xmm0,%xmm0,%xmm0
 144:	ret
 145:	nopl   (%rax)
 148:	vzeroupper
 14b:	vcvtss2sd %xmm0,%xmm0,%xmm0
 14f:	ret
 150:	xor    %eax,%eax
 152:	vxorps %xmm0,%xmm0,%xmm0
 156:	jmp    9c <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x9c>
 15b:	nopl   0x0(%rax,%rax,1)

0000000000000160 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)>:
 160:	endbr64
 164:	push   %rbp
 165:	vpxor  %xmm0,%xmm0,%xmm0
 169:	mov    %rsp,%rbp
 16c:	and    $0xffffffffffffffe0,%rsp
 170:	sub    $0x60,%rsp
 174:	mov    %fs:0x28,%rax
 17d:	mov    %rax,0x58(%rsp)
 182:	xor    %eax,%eax
 184:	test   %rdx,%rdx
 187:	vmovdqa %ymm0,(%rsp)
 18c:	vmovdqa %ymm0,0x20(%rsp)
 192:	je     321 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1c1>
 198:	cmp    $0x7,%rdx
 19c:	mov    %rdi,%rcx
 19f:	jbe    369 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x209>
 1a5:	mov    %rdx,%rdi
 1a8:	vxorpd %xmm3,%xmm3,%xmm3
 1ac:	shr    $0x3,%rdi
 1b0:	vmovapd %ymm3,%ymm4
 1b4:	shl    $0x5,%rdi
 1b8:	nopl   0x0(%rax,%rax,1)
 1c0:	vmovups (%rcx,%rax,1),%ymm5
 1c5:	vmovups (%rsi,%rax,1),%ymm6
 1ca:	vcvtps2pd (%rsi,%rax,1),%ymm0
 1cf:	vcvtps2pd (%rcx,%rax,1),%ymm2
 1d4:	vsubpd %ymm0,%ymm2,%ymm2
 1d8:	add    $0x20,%rax
 1dc:	vextractf128 $0x1,%ymm5,%xmm0
 1e2:	vextractf128 $0x1,%ymm6,%xmm1
 1e8:	cmp    %rax,%rdi
 1eb:	vcvtps2pd %xmm0,%ymm0
 1ef:	vcvtps2pd %xmm1,%ymm1
 1f3:	vsubpd %ymm1,%ymm0,%ymm0
 1f7:	vfmadd231pd %ymm2,%ymm2,%ymm3
 1fc:	vfmadd231pd %ymm0,%ymm0,%ymm4
 201:	jne    1c0 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x60>
 203:	mov    %rdx,%rax
 206:	vmovapd %ymm3,(%rsp)
 20b:	and    $0xfffffffffffffff8,%rax
 20f:	test   $0x7,%dl
 212:	vmovapd %ymm4,0x20(%rsp)
 218:	je     321 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1c1>
 21e:	vxorps %xmm0,%xmm0,%xmm0
 222:	lea    0x1(%rax),%r8
 226:	lea    0x0(,%rax,4),%rdi
 22e:	vcvtss2sd (%rcx,%rax,4),%xmm0,%xmm1
 233:	vcvtss2sd (%rsi,%rax,4),%xmm0,%xmm2
 238:	vsubsd %xmm2,%xmm1,%xmm1
 23c:	cmp    %rdx,%r8
 23f:	vfmadd213sd (%rsp),%xmm1,%xmm1
 245:	vmovsd %xmm1,(%rsp)
 24a:	jae    321 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1c1>
 250:	vcvtss2sd 0x4(%rcx,%rdi,1),%xmm0,%xmm2
 256:	vcvtss2sd 0x4(%rsi,%rdi,1),%xmm0,%xmm3
 25c:	vsubsd %xmm3,%xmm2,%xmm2
 260:	lea    0x2(%rax),%r8
 264:	cmp    %rdx,%r8
 267:	vfmadd132sd %xmm2,%xmm1,%xmm2
 26c:	vmovsd %xmm2,(%rsp)
 271:	jae    321 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1c1>
 277:	vcvtss2sd 0x8(%rcx,%rdi,1),%xmm0,%xmm1
 27d:	vcvtss2sd 0x8(%rsi,%rdi,1),%xmm0,%xmm3
 283:	vsubsd %xmm3,%xmm1,%xmm1
 287:	lea    0x3(%rax),%r8
 28b:	cmp    %rdx,%r8
 28e:	vfmadd132sd %xmm1,%xmm2,%xmm1
 293:	vmovsd %xmm1,(%rsp)
 298:	jae    321 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1c1>
 29e:	vcvtss2sd 0xc(%rcx,%rdi,1),%xmm0,%xmm2
 2a4:	vcvtss2sd 0xc(%rsi,%rdi,1),%xmm0,%xmm3
 2aa:	vsubsd %xmm3,%xmm2,%xmm2
 2ae:	lea    0x4(%rax),%r8
 2b2:	cmp    %rdx,%r8
 2b5:	vfmadd132sd %xmm2,%xmm1,%xmm2
 2ba:	vmovsd %xmm2,(%rsp)
 2bf:	jae    321 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1c1>
 2c1:	vcvtss2sd 0x10(%rcx,%rdi,1),%xmm0,%xmm1
 2c7:	vcvtss2sd 0x10(%rsi,%rdi,1),%xmm0,%xmm3
 2cd:	vsubsd %xmm3,%xmm1,%xmm1
 2d1:	lea    0x5(%rax),%r8
 2d5:	cmp    %rdx,%r8
 2d8:	vfmadd132sd %xmm1,%xmm2,%xmm1
 2dd:	vmovsd %xmm1,(%rsp)
 2e2:	jae    321 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1c1>
 2e4:	vcvtss2sd 0x14(%rcx,%rdi,1),%xmm0,%xmm2
 2ea:	vcvtss2sd 0x14(%rsi,%rdi,1),%xmm0,%xmm3
 2f0:	vsubsd %xmm3,%xmm2,%xmm2
 2f4:	add    $0x6,%rax
 2f8:	cmp    %rdx,%rax
 2fb:	vfmadd132sd %xmm2,%xmm1,%xmm2
 300:	vmovsd %xmm2,(%rsp)
 305:	jae    321 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1c1>
 307:	vcvtss2sd 0x18(%rcx,%rdi,1),%xmm0,%xmm1
 30d:	vcvtss2sd 0x18(%rsi,%rdi,1),%xmm0,%xmm0
 313:	vsubsd %xmm0,%xmm1,%xmm0
 317:	vfmadd132sd %xmm0,%xmm2,%xmm0
 31c:	vmovsd %xmm0,(%rsp)
 321:	mov    0x58(%rsp),%rax
 326:	sub    %fs:0x28,%rax
 32f:	vxorpd %xmm0,%xmm0,%xmm0
 333:	vaddsd (%rsp),%xmm0,%xmm0
 338:	vaddsd 0x8(%rsp),%xmm0,%xmm0
 33e:	vaddsd 0x10(%rsp),%xmm0,%xmm0
 344:	vaddsd 0x18(%rsp),%xmm0,%xmm0
 34a:	vaddsd 0x20(%rsp),%xmm0,%xmm0
 350:	vaddsd 0x28(%rsp),%xmm0,%xmm0
 356:	vaddsd 0x30(%rsp),%xmm0,%xmm0
 35c:	vaddsd 0x38(%rsp),%xmm0,%xmm0
 362:	jne    370 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x210>
 364:	vzeroupper
 367:	leave
 368:	ret
 369:	xor    %eax,%eax
 36b:	jmp    21e <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0xbe>
 370:	vzeroupper
 373:	call   378 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x218>
 378:	nopl   0x0(%rax,%rax,1)

0000000000000380 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)>:
 380:	endbr64
 384:	push   %rbp
 385:	vpxor  %xmm0,%xmm0,%xmm0
 389:	mov    %rsp,%rbp
 38c:	and    $0xffffffffffffffe0,%rsp
 390:	sub    $0x40,%rsp
 394:	mov    %fs:0x28,%rax
 39d:	mov    %rax,0x38(%rsp)
 3a2:	xor    %eax,%eax
 3a4:	test   %rdx,%rdx
 3a7:	vmovdqa %ymm0,(%rsp)
 3ac:	je     4df <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x15f>
 3b2:	cmp    $0x7,%rdx
 3b6:	mov    %rdi,%rcx
 3b9:	jbe    52b <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x1ab>
 3bf:	mov    %rdx,%rdi
 3c2:	vxorps %xmm1,%xmm1,%xmm1
 3c6:	shr    $0x3,%rdi
 3ca:	shl    $0x5,%rdi
 3ce:	xchg   %ax,%ax
 3d0:	vmovups (%rcx,%rax,1),%ymm2
 3d5:	vsubps (%rsi,%rax,1),%ymm2,%ymm0
 3da:	add    $0x20,%rax
 3de:	cmp    %rax,%rdi
 3e1:	vmulps %ymm0,%ymm0,%ymm0
 3e5:	vaddps %ymm0,%ymm1,%ymm1
 3e9:	jne    3d0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x50>
 3eb:	mov    %rdx,%rax
 3ee:	vmovaps %ymm1,(%rsp)
 3f3:	and    $0xfffffffffffffff8,%rax
 3f7:	test   $0x7,%dl
 3fa:	je     4df <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x15f>
 400:	vmovss (%rcx,%rax,4),%xmm0
 405:	vsubss (%rsi,%rax,4),%xmm0,%xmm0
 40a:	lea    0x1(%rax),%r8
 40e:	vfmadd213ss (%rsp),%xmm0,%xmm0
 414:	cmp    %rdx,%r8
 417:	lea    0x0(,%rax,4),%rdi
 41f:	vmovss %xmm0,(%rsp)
 424:	jae    4df <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x15f>
 42a:	vmovss 0x4(%rcx,%rdi,1),%xmm1
 430:	vsubss 0x4(%rsi,%rdi,1),%xmm1,%xmm1
 436:	lea    0x2(%rax),%r8
 43a:	cmp    %rdx,%r8
 43d:	vfmadd132ss %xmm1,%xmm0,%xmm1
 442:	vmovss %xmm1,(%rsp)
 447:	jae    4df <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x15f>
 44d:	vmovss 0x8(%rcx,%rdi,1),%xmm0
 453:	vsubss 0x8(%rsi,%rdi,1),%xmm0,%xmm0
 459:	lea    0x3(%rax),%r8
 45d:	cmp    %rdx,%r8
 460:	vfmadd132ss %xmm0,%xmm1,%xmm0
 465:	vmovss %xmm0,(%rsp)
 46a:	jae    4df <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x15f>
 46c:	vmovss 0xc(%rcx,%rdi,1),%xmm1
 472:	vsubss 0xc(%rsi,%rdi,1),%xmm1,%xmm1
 478:	lea    0x4(%rax),%r8
 47c:	cmp    %rdx,%r8
 47f:	vfmadd132ss %xmm1,%xmm0,%xmm1
 484:	vmovss %xmm1,(%rsp)
 489:	jae    4df <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x15f>
 48b:	vmovss 0x10(%rcx,%rdi,1),%xmm0
 491:	vsubss 0x10(%rsi,%rdi,1),%xmm0,%xmm0
 497:	lea    0x5(%rax),%r8
 49b:	cmp    %rdx,%r8
 49e:	vfmadd132ss %xmm0,%xmm1,%xmm0
 4a3:	vmovss %xmm0,(%rsp)
 4a8:	jae    4df <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x15f>
 4aa:	vmovss 0x14(%rcx,%rdi,1),%xmm1
 4b0:	vsubss 0x14(%rsi,%rdi,1),%xmm1,%xmm1
 4b6:	add    $0x6,%rax
 4ba:	cmp    %rdx,%rax
 4bd:	vfmadd132ss %xmm1,%xmm0,%xmm1
 4c2:	vmovss %xmm1,(%rsp)
 4c7:	jae    4df <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x15f>
 4c9:	vmovss 0x18(%rcx,%rdi,1),%xmm0
 4cf:	vsubss 0x18(%rsi,%rdi,1),%xmm0,%xmm0
 4d5:	vfmadd132ss %xmm0,%xmm1,%xmm0
 4da:	vmovss %xmm0,(%rsp)
 4df:	mov    0x38(%rsp),%rax
 4e4:	sub    %fs:0x28,%rax
 4ed:	vxorps %xmm0,%xmm0,%xmm0
 4f1:	vaddss (%rsp),%xmm0,%xmm0
 4f6:	vaddss 0x4(%rsp),%xmm0,%xmm0
 4fc:	vaddss 0x8(%rsp),%xmm0,%xmm0
 502:	vaddss 0xc(%rsp),%xmm0,%xmm0
 508:	vaddss 0x10(%rsp),%xmm0,%xmm0
 50e:	vaddss 0x14(%rsp),%xmm0,%xmm0
 514:	vaddss 0x18(%rsp),%xmm0,%xmm0
 51a:	vaddss 0x1c(%rsp),%xmm0,%xmm0
 520:	vcvtss2sd %xmm0,%xmm0,%xmm0
 524:	jne    532 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x1b2>
 526:	vzeroupper
 529:	leave
 52a:	ret
 52b:	xor    %eax,%eax
 52d:	jmp    400 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x80>
 532:	vzeroupper
 535:	call   53a <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x1ba>
 53a:	nopw   0x0(%rax,%rax,1)

0000000000000540 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)>:
 540:	endbr64
 544:	mov    0x50(%rdi),%r9
 548:	mov    0x48(%rdi),%rcx
 54c:	mov    %r9,%r8
 54f:	sub    %rcx,%r8
 552:	sar    $0x2,%r8
 556:	cmp    %r9,%rcx
 559:	je     5de <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x9e>
 55f:	vmovss 0x0(%rip),%xmm1        # 567 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x27>
 567:	vmovss 0x0(%rip),%xmm2        # 56f <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x2f>
 56f:	xor    %eax,%eax
 571:	jmp    589 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x49>
 573:	nopl   0x0(%rax,%rax,1)
 578:	add    $0x1,%rax
 57c:	vminss %xmm2,%xmm0,%xmm2
 580:	vmaxss %xmm1,%xmm0,%xmm1
 584:	cmp    %r8,%rax
 587:	jae    5a0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x60>
 589:	vmovss (%rcx,%rax,4),%xmm0
 58e:	vroundss $0xc,%xmm0,%xmm0,%xmm3
 594:	vucomiss %xmm3,%xmm0
 598:	jp     59c <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x5c>
 59a:	je     578 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x38>
 59c:	xor    %eax,%eax
 59e:	ret
 59f:	nop
 5a0:	mov    0x8(%rdi),%r8
 5a4:	mov    %rdx,%rdi
 5a7:	imul   %r8,%rdi
 5ab:	test   %rdi,%rdi
 5ae:	je     610 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xd0>
 5b0:	xor    %eax,%eax
 5b2:	jmp    5c9 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x89>
 5b4:	nopl   0x0(%rax)
 5b8:	add    $0x1,%rax
 5bc:	vminss %xmm2,%xmm0,%xmm2
 5c0:	vmaxss %xmm1,%xmm0,%xmm1
 5c4:	cmp    %rdi,%rax
 5c7:	je     600 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xc0>
 5c9:	vmovss (%rsi,%rax,4),%xmm0
 5ce:	vroundss $0xc,%xmm0,%xmm0,%xmm3
 5d4:	vucomiss %xmm3,%xmm0
 5d8:	jp     59c <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x5c>
 5da:	je     5b8 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x78>
 5dc:	jmp    59c <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x5c>
 5de:	mov    0x8(%rdi),%r8
 5e2:	vmovss 0x0(%rip),%xmm2        # 5ea <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xaa>
 5ea:	vmovss 0x0(%rip),%xmm1        # 5f2 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xb2>
 5f2:	mov    %r8,%rdi
 5f5:	imul   %rdx,%rdi
 5f9:	test   %rdi,%rdi
 5fc:	jne    5b0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x70>
 5fe:	xchg   %ax,%ax
 600:	cmp    %r9,%rcx
 603:	sete   %al
 606:	test   %rdx,%rdx
 609:	sete   %dl
 60c:	and    %dl,%al
 60e:	jne    642 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x102>
 610:	test   %r8,%r8
 613:	vcvtss2sd %xmm1,%xmm1,%xmm1
 617:	vcvtss2sd %xmm2,%xmm2,%xmm2
 61b:	vxorps %xmm0,%xmm0,%xmm0
 61f:	vsubsd %xmm2,%xmm1,%xmm1
 623:	js     648 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x108>
 625:	vcvtsi2sd %r8,%xmm0,%xmm0
 62a:	vmulsd %xmm1,%xmm0,%xmm0
 62e:	vmulsd %xmm1,%xmm0,%xmm0
 632:	vmovsd 0x0(%rip),%xmm1        # 63a <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xfa>
 63a:	vcomisd %xmm0,%xmm1
 63e:	seta   %al
 641:	ret
 642:	ret
 643:	nopl   0x0(%rax,%rax,1)
 648:	mov    %r8,%rax
 64b:	and    $0x1,%r8d
 64f:	shr    $1,%rax
 652:	or     %r8,%rax
 655:	vcvtsi2sd %rax,%xmm0,%xmm0
 65a:	vaddsd %xmm0,%xmm0,%xmm0
 65e:	jmp    62a <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xea>

0000000000000660 <ivf::dist_name(ivf::DistKind)>:
 660:	endbr64
 664:	cmp    $0x2,%edi
 667:	lea    0x0(%rip),%rax        # 66e <ivf::dist_name(ivf::DistKind)+0xe>
 66e:	je     6ad <ivf::dist_name(ivf::DistKind)+0x4d>
 670:	jg     698 <ivf::dist_name(ivf::DistKind)+0x38>
 672:	test   %edi,%edi
 674:	lea    0x0(%rip),%rax        # 67b <ivf::dist_name(ivf::DistKind)+0x1b>
 67b:	je     6ad <ivf::dist_name(ivf::DistKind)+0x4d>
 67d:	cmp    $0x1,%edi
 680:	lea    0x0(%rip),%rdx        # 687 <ivf::dist_name(ivf::DistKind)+0x27>
 687:	lea    0x0(%rip),%rax        # 68e <ivf::dist_name(ivf::DistKind)+0x2e>
 68e:	cmove  %rdx,%rax
 692:	ret
 693:	nopl   0x0(%rax,%rax,1)
 698:	cmp    $0x3,%edi
 69b:	lea    0x0(%rip),%rax        # 6a2 <ivf::dist_name(ivf::DistKind)+0x42>
 6a2:	lea    0x0(%rip),%rdx        # 6a9 <ivf::dist_name(ivf::DistKind)+0x49>
 6a9:	cmove  %rdx,%rax
 6ad:	ret
