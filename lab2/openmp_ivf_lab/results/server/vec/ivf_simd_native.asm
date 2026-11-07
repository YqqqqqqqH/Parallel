
results/server/vec/ivf_simd_native.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <ivf::l2_distance_f32(float const*, float const*, unsigned long)>:
   0:	endbr64 
   4:	mov    %rdi,%rax
   7:	mov    %rsi,%rcx
   a:	test   %rdx,%rdx
   d:	je     140 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x140>
  13:	lea    -0x1(%rdx),%rsi
  17:	cmp    $0x6,%rsi
  1b:	jbe    150 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x150>
  21:	mov    %rdx,%rdi
  24:	shr    $0x3,%rdi
  28:	shl    $0x5,%rdi
  2c:	xor    %esi,%esi
  2e:	vxorps %xmm0,%xmm0,%xmm0
  32:	nopw   0x0(%rax,%rax,1)
  38:	vmovups (%rax,%rsi,1),%ymm4
  3d:	vsubps (%rcx,%rsi,1),%ymm4,%ymm1
  42:	add    $0x20,%rsi
  46:	vmulps %ymm1,%ymm1,%ymm1
  4a:	vaddss %xmm1,%xmm0,%xmm0
  4e:	vshufps $0x55,%xmm1,%xmm1,%xmm3
  53:	vshufps $0xff,%xmm1,%xmm1,%xmm2
  58:	vaddss %xmm3,%xmm0,%xmm0
  5c:	vunpckhps %xmm1,%xmm1,%xmm3
  60:	vextractf128 $0x1,%ymm1,%xmm1
  66:	vaddss %xmm3,%xmm0,%xmm0
  6a:	vaddss %xmm2,%xmm0,%xmm0
  6e:	vshufps $0x55,%xmm1,%xmm1,%xmm2
  73:	vaddss %xmm1,%xmm0,%xmm0
  77:	vaddss %xmm2,%xmm0,%xmm0
  7b:	vunpckhps %xmm1,%xmm1,%xmm2
  7f:	vshufps $0xff,%xmm1,%xmm1,%xmm1
  84:	vaddss %xmm2,%xmm0,%xmm0
  88:	vaddss %xmm1,%xmm0,%xmm0
  8c:	cmp    %rdi,%rsi
  8f:	jne    38 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x38>
  91:	mov    %rdx,%rsi
  94:	and    $0xfffffffffffffff8,%rsi
  98:	test   $0x7,%dl
  9b:	je     148 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x148>
  a1:	vzeroupper 
  a4:	mov    %rdx,%rdi
  a7:	sub    %rsi,%rdi
  aa:	lea    -0x1(%rdi),%r8
  ae:	cmp    $0x2,%r8
  b2:	jbe    ef <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xef>
  b4:	vmovups (%rax,%rsi,4),%xmm5
  b9:	mov    %rdi,%r8
  bc:	vsubps (%rcx,%rsi,4),%xmm5,%xmm1
  c1:	and    $0xfffffffffffffffc,%r8
  c5:	add    %r8,%rsi
  c8:	vmulps %xmm1,%xmm1,%xmm1
  cc:	vaddss %xmm1,%xmm0,%xmm0
  d0:	vshufps $0x55,%xmm1,%xmm1,%xmm2
  d5:	vaddss %xmm2,%xmm0,%xmm0
  d9:	vunpckhps %xmm1,%xmm1,%xmm2
  dd:	vshufps $0xff,%xmm1,%xmm1,%xmm1
  e2:	vaddss %xmm2,%xmm0,%xmm0
  e6:	vaddss %xmm1,%xmm0,%xmm0
  ea:	cmp    %r8,%rdi
  ed:	je     13a <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x13a>
  ef:	vmovss (%rax,%rsi,4),%xmm1
  f4:	lea    0x1(%rsi),%r8
  f8:	vsubss (%rcx,%rsi,4),%xmm1,%xmm1
  fd:	lea    0x0(,%rsi,4),%rdi
 105:	vfmadd231ss %xmm1,%xmm1,%xmm0
 10a:	cmp    %r8,%rdx
 10d:	jbe    13a <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x13a>
 10f:	vmovss 0x4(%rax,%rdi,1),%xmm1
 115:	add    $0x2,%rsi
 119:	vsubss 0x4(%rcx,%rdi,1),%xmm1,%xmm1
 11f:	vfmadd231ss %xmm1,%xmm1,%xmm0
 124:	cmp    %rsi,%rdx
 127:	jbe    13a <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x13a>
 129:	vmovss 0x8(%rax,%rdi,1),%xmm1
 12f:	vsubss 0x8(%rcx,%rdi,1),%xmm1,%xmm1
 135:	vfmadd231ss %xmm1,%xmm1,%xmm0
 13a:	vcvtss2sd %xmm0,%xmm0,%xmm0
 13e:	ret    
 13f:	nop
 140:	vxorpd %xmm0,%xmm0,%xmm0
 144:	ret    
 145:	nopl   (%rax)
 148:	vzeroupper 
 14b:	vcvtss2sd %xmm0,%xmm0,%xmm0
 14f:	ret    
 150:	xor    %esi,%esi
 152:	vxorps %xmm0,%xmm0,%xmm0
 156:	jmp    a4 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xa4>
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
 184:	vmovdqa %xmm0,(%rsp)
 189:	vmovdqa %xmm0,0x10(%rsp)
 18f:	vmovdqa %xmm0,0x20(%rsp)
 195:	vmovdqa %xmm0,0x30(%rsp)
 19b:	test   %rdx,%rdx
 19e:	je     32f <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1cf>
 1a4:	lea    -0x1(%rdx),%rax
 1a8:	mov    %rsi,%rcx
 1ab:	cmp    $0x6,%rax
 1af:	jbe    391 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x231>
 1b5:	mov    %rdx,%rsi
 1b8:	shr    $0x3,%rsi
 1bc:	vxorpd %xmm4,%xmm4,%xmm4
 1c0:	shl    $0x5,%rsi
 1c4:	xor    %eax,%eax
 1c6:	vmovapd %ymm4,%ymm3
 1ca:	nopw   0x0(%rax,%rax,1)
 1d0:	vmovups (%rdi,%rax,1),%ymm0
 1d5:	vmovups (%rcx,%rax,1),%ymm1
 1da:	vcvtps2pd %xmm0,%ymm2
 1de:	vcvtps2pd %xmm1,%ymm5
 1e2:	vextractf128 $0x1,%ymm0,%xmm0
 1e8:	vextractf128 $0x1,%ymm1,%xmm1
 1ee:	vsubpd %ymm5,%ymm2,%ymm2
 1f2:	vcvtps2pd %xmm0,%ymm0
 1f6:	vcvtps2pd %xmm1,%ymm1
 1fa:	vsubpd %ymm1,%ymm0,%ymm0
 1fe:	add    $0x20,%rax
 202:	vfmadd231pd %ymm2,%ymm2,%ymm4
 207:	vfmadd231pd %ymm0,%ymm0,%ymm3
 20c:	cmp    %rsi,%rax
 20f:	jne    1d0 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x70>
 211:	mov    %rdx,%rax
 214:	vmovapd %ymm4,(%rsp)
 219:	vmovapd %ymm3,0x20(%rsp)
 21f:	and    $0xfffffffffffffff8,%rax
 223:	test   $0x7,%dl
 226:	je     32f <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1cf>
 22c:	vxorps %xmm0,%xmm0,%xmm0
 230:	vcvtss2sd (%rdi,%rax,4),%xmm0,%xmm1
 235:	vcvtss2sd (%rcx,%rax,4),%xmm0,%xmm2
 23a:	vsubsd %xmm2,%xmm1,%xmm1
 23e:	lea    0x1(%rax),%r8
 242:	lea    0x0(,%rax,4),%rsi
 24a:	vfmadd213sd (%rsp),%xmm1,%xmm1
 250:	vmovsd %xmm1,(%rsp)
 255:	cmp    %r8,%rdx
 258:	jbe    32f <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1cf>
 25e:	vcvtss2sd 0x4(%rdi,%rsi,1),%xmm0,%xmm2
 264:	vcvtss2sd 0x4(%rcx,%rsi,1),%xmm0,%xmm3
 26a:	vsubsd %xmm3,%xmm2,%xmm2
 26e:	lea    0x2(%rax),%r8
 272:	vfmadd132sd %xmm2,%xmm1,%xmm2
 277:	vmovsd %xmm2,(%rsp)
 27c:	cmp    %r8,%rdx
 27f:	jbe    32f <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1cf>
 285:	vcvtss2sd 0x8(%rdi,%rsi,1),%xmm0,%xmm1
 28b:	vcvtss2sd 0x8(%rcx,%rsi,1),%xmm0,%xmm3
 291:	vsubsd %xmm3,%xmm1,%xmm1
 295:	lea    0x3(%rax),%r8
 299:	vfmadd132sd %xmm1,%xmm2,%xmm1
 29e:	vmovsd %xmm1,(%rsp)
 2a3:	cmp    %r8,%rdx
 2a6:	jbe    32f <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1cf>
 2ac:	vcvtss2sd 0xc(%rdi,%rsi,1),%xmm0,%xmm2
 2b2:	vcvtss2sd 0xc(%rcx,%rsi,1),%xmm0,%xmm3
 2b8:	vsubsd %xmm3,%xmm2,%xmm2
 2bc:	lea    0x4(%rax),%r8
 2c0:	vfmadd132sd %xmm2,%xmm1,%xmm2
 2c5:	vmovsd %xmm2,(%rsp)
 2ca:	cmp    %r8,%rdx
 2cd:	jbe    32f <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1cf>
 2cf:	vcvtss2sd 0x10(%rdi,%rsi,1),%xmm0,%xmm1
 2d5:	vcvtss2sd 0x10(%rcx,%rsi,1),%xmm0,%xmm3
 2db:	vsubsd %xmm3,%xmm1,%xmm1
 2df:	lea    0x5(%rax),%r8
 2e3:	vfmadd132sd %xmm1,%xmm2,%xmm1
 2e8:	vmovsd %xmm1,(%rsp)
 2ed:	cmp    %r8,%rdx
 2f0:	jbe    32f <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1cf>
 2f2:	vcvtss2sd 0x14(%rdi,%rsi,1),%xmm0,%xmm2
 2f8:	vcvtss2sd 0x14(%rcx,%rsi,1),%xmm0,%xmm3
 2fe:	vsubsd %xmm3,%xmm2,%xmm2
 302:	add    $0x6,%rax
 306:	vfmadd132sd %xmm2,%xmm1,%xmm2
 30b:	vmovsd %xmm2,(%rsp)
 310:	cmp    %rax,%rdx
 313:	jbe    32f <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x1cf>
 315:	vcvtss2sd 0x18(%rdi,%rsi,1),%xmm0,%xmm1
 31b:	vcvtss2sd 0x18(%rcx,%rsi,1),%xmm0,%xmm0
 321:	vsubsd %xmm0,%xmm1,%xmm0
 325:	vfmadd132sd %xmm0,%xmm2,%xmm0
 32a:	vmovsd %xmm0,(%rsp)
 32f:	vmovapd (%rsp),%ymm0
 334:	vxorpd %xmm1,%xmm1,%xmm1
 338:	vaddsd %xmm0,%xmm1,%xmm1
 33c:	vunpckhpd %xmm0,%xmm0,%xmm2
 340:	vextractf64x2 $0x1,%ymm0,%xmm0
 347:	vaddsd %xmm2,%xmm1,%xmm1
 34b:	vmovapd 0x20(%rsp),%ymm2
 351:	vaddsd %xmm0,%xmm1,%xmm1
 355:	vunpckhpd %xmm0,%xmm0,%xmm0
 359:	vunpckhpd %xmm2,%xmm2,%xmm3
 35d:	vaddsd %xmm0,%xmm1,%xmm1
 361:	vaddsd %xmm1,%xmm2,%xmm0
 365:	vextractf64x2 $0x1,%ymm2,%xmm1
 36c:	vaddsd %xmm3,%xmm0,%xmm0
 370:	vaddsd %xmm1,%xmm0,%xmm0
 374:	vunpckhpd %xmm1,%xmm1,%xmm1
 378:	vaddsd %xmm1,%xmm0,%xmm0
 37c:	mov    0x58(%rsp),%rax
 381:	sub    %fs:0x28,%rax
 38a:	jne    398 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x238>
 38c:	vzeroupper 
 38f:	leave  
 390:	ret    
 391:	xor    %eax,%eax
 393:	jmp    22c <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0xcc>
 398:	vzeroupper 
 39b:	call   3a0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)>

00000000000003a0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)>:
 3a0:	endbr64 
 3a4:	push   %rbp
 3a5:	vpxor  %xmm0,%xmm0,%xmm0
 3a9:	mov    %rsp,%rbp
 3ac:	and    $0xffffffffffffffe0,%rsp
 3b0:	sub    $0x40,%rsp
 3b4:	mov    %fs:0x28,%rax
 3bd:	mov    %rax,0x38(%rsp)
 3c2:	xor    %eax,%eax
 3c4:	vmovdqa %xmm0,(%rsp)
 3c9:	vmovdqa %xmm0,0x10(%rsp)
 3cf:	test   %rdx,%rdx
 3d2:	je     50c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x16c>
 3d8:	lea    -0x1(%rdx),%rax
 3dc:	mov    %rsi,%rcx
 3df:	cmp    $0x6,%rax
 3e3:	jbe    570 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x1d0>
 3e9:	mov    %rdx,%rsi
 3ec:	shr    $0x3,%rsi
 3f0:	shl    $0x5,%rsi
 3f4:	xor    %eax,%eax
 3f6:	vxorps %xmm1,%xmm1,%xmm1
 3fa:	nopw   0x0(%rax,%rax,1)
 400:	vmovups (%rdi,%rax,1),%ymm4
 405:	vsubps (%rcx,%rax,1),%ymm4,%ymm0
 40a:	add    $0x20,%rax
 40e:	vfmadd231ps %ymm0,%ymm0,%ymm1
 413:	cmp    %rsi,%rax
 416:	jne    400 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x60>
 418:	mov    %rdx,%rax
 41b:	vmovaps %ymm1,(%rsp)
 420:	and    $0xfffffffffffffff8,%rax
 424:	test   $0x7,%dl
 427:	je     50c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x16c>
 42d:	vmovss (%rdi,%rax,4),%xmm0
 432:	lea    0x1(%rax),%r8
 436:	vsubss (%rcx,%rax,4),%xmm0,%xmm0
 43b:	lea    0x0(,%rax,4),%rsi
 443:	vfmadd213ss (%rsp),%xmm0,%xmm0
 449:	vmovss %xmm0,(%rsp)
 44e:	cmp    %r8,%rdx
 451:	jbe    50c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x16c>
 457:	vmovss 0x4(%rdi,%rsi,1),%xmm1
 45d:	lea    0x2(%rax),%r8
 461:	vsubss 0x4(%rcx,%rsi,1),%xmm1,%xmm1
 467:	vfmadd132ss %xmm1,%xmm0,%xmm1
 46c:	vmovss %xmm1,(%rsp)
 471:	cmp    %r8,%rdx
 474:	jbe    50c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x16c>
 47a:	vmovss 0x8(%rdi,%rsi,1),%xmm0
 480:	lea    0x3(%rax),%r8
 484:	vsubss 0x8(%rcx,%rsi,1),%xmm0,%xmm0
 48a:	vfmadd132ss %xmm0,%xmm1,%xmm0
 48f:	vmovss %xmm0,(%rsp)
 494:	cmp    %r8,%rdx
 497:	jbe    50c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x16c>
 499:	vmovss 0xc(%rdi,%rsi,1),%xmm1
 49f:	lea    0x4(%rax),%r8
 4a3:	vsubss 0xc(%rcx,%rsi,1),%xmm1,%xmm1
 4a9:	vfmadd132ss %xmm1,%xmm0,%xmm1
 4ae:	vmovss %xmm1,(%rsp)
 4b3:	cmp    %r8,%rdx
 4b6:	jbe    50c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x16c>
 4b8:	vmovss 0x10(%rdi,%rsi,1),%xmm0
 4be:	lea    0x5(%rax),%r8
 4c2:	vsubss 0x10(%rcx,%rsi,1),%xmm0,%xmm0
 4c8:	vfmadd132ss %xmm0,%xmm1,%xmm0
 4cd:	vmovss %xmm0,(%rsp)
 4d2:	cmp    %r8,%rdx
 4d5:	jbe    50c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x16c>
 4d7:	vmovss 0x14(%rdi,%rsi,1),%xmm1
 4dd:	add    $0x6,%rax
 4e1:	vsubss 0x14(%rcx,%rsi,1),%xmm1,%xmm1
 4e7:	vfmadd132ss %xmm1,%xmm0,%xmm1
 4ec:	vmovss %xmm1,(%rsp)
 4f1:	cmp    %rax,%rdx
 4f4:	jbe    50c <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x16c>
 4f6:	vmovss 0x18(%rdi,%rsi,1),%xmm0
 4fc:	vsubss 0x18(%rcx,%rsi,1),%xmm0,%xmm0
 502:	vfmadd132ss %xmm0,%xmm1,%xmm0
 507:	vmovss %xmm0,(%rsp)
 50c:	vmovaps (%rsp),%ymm1
 511:	vxorps %xmm3,%xmm3,%xmm3
 515:	vaddss %xmm1,%xmm3,%xmm3
 519:	vshufps $0x55,%xmm1,%xmm1,%xmm0
 51e:	vshufps $0xff,%xmm1,%xmm1,%xmm2
 523:	vaddss %xmm3,%xmm0,%xmm0
 527:	vunpckhps %xmm1,%xmm1,%xmm3
 52b:	vextractf128 $0x1,%ymm1,%xmm1
 531:	vaddss %xmm3,%xmm0,%xmm0
 535:	vaddss %xmm2,%xmm0,%xmm0
 539:	vshufps $0x55,%xmm1,%xmm1,%xmm2
 53e:	vaddss %xmm1,%xmm0,%xmm0
 542:	vaddss %xmm2,%xmm0,%xmm0
 546:	vunpckhps %xmm1,%xmm1,%xmm2
 54a:	vshufps $0xff,%xmm1,%xmm1,%xmm1
 54f:	vaddss %xmm2,%xmm0,%xmm0
 553:	vaddss %xmm1,%xmm0,%xmm0
 557:	vcvtss2sd %xmm0,%xmm0,%xmm0
 55b:	mov    0x38(%rsp),%rax
 560:	sub    %fs:0x28,%rax
 569:	jne    577 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x1d7>
 56b:	vzeroupper 
 56e:	leave  
 56f:	ret    
 570:	xor    %eax,%eax
 572:	jmp    42d <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x8d>
 577:	vzeroupper 
 57a:	call   57f <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x1df>
 57f:	nop

0000000000000580 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)>:
 580:	endbr64 
 584:	mov    0x50(%rdi),%r9
 588:	mov    0x48(%rdi),%rcx
 58c:	mov    %rdx,%r8
 58f:	mov    %r9,%rdx
 592:	sub    %rcx,%rdx
 595:	sar    $0x2,%rdx
 599:	vmovss 0x0(%rip),%xmm1        # 5a1 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x21>
 5a1:	vmovss 0x0(%rip),%xmm2        # 5a9 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x29>
 5a9:	je     5e0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x60>
 5ab:	xor    %eax,%eax
 5ad:	jmp    5c0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x40>
 5af:	nop
 5b0:	inc    %rax
 5b3:	vminss %xmm2,%xmm0,%xmm2
 5b7:	vmaxss %xmm1,%xmm0,%xmm1
 5bb:	cmp    %rax,%rdx
 5be:	je     5e0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x60>
 5c0:	vmovss (%rcx,%rax,4),%xmm0
 5c5:	vrndscaless $0xc,%xmm0,%xmm0,%xmm3
 5cc:	vucomiss %xmm3,%xmm0
 5d0:	jp     5d4 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x54>
 5d2:	je     5b0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x30>
 5d4:	xor    %eax,%eax
 5d6:	ret    
 5d7:	nopw   0x0(%rax,%rax,1)
 5e0:	mov    0x8(%rdi),%rdi
 5e4:	xor    %eax,%eax
 5e6:	mov    %rdi,%rdx
 5e9:	imul   %r8,%rdx
 5ed:	test   %rdx,%rdx
 5f0:	jne    608 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x88>
 5f2:	jmp    620 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa0>
 5f4:	nopl   0x0(%rax)
 5f8:	inc    %rax
 5fb:	vminss %xmm2,%xmm0,%xmm2
 5ff:	vmaxss %xmm1,%xmm0,%xmm1
 603:	cmp    %rax,%rdx
 606:	je     620 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa0>
 608:	vmovss (%rsi,%rax,4),%xmm0
 60d:	vrndscaless $0xc,%xmm0,%xmm0,%xmm3
 614:	vucomiss %xmm3,%xmm0
 618:	jp     5d4 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x54>
 61a:	je     5f8 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x78>
 61c:	jmp    5d4 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x54>
 61e:	xchg   %ax,%ax
 620:	test   %r8,%r8
 623:	sete   %al
 626:	cmp    %r9,%rcx
 629:	sete   %dl
 62c:	and    %dl,%al
 62e:	jne    65e <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xde>
 630:	vxorps %xmm0,%xmm0,%xmm0
 634:	vcvtusi2sd %rdi,%xmm0,%xmm0
 63a:	vcvtss2sd %xmm2,%xmm2,%xmm2
 63e:	vcvtss2sd %xmm1,%xmm1,%xmm1
 642:	vsubsd %xmm2,%xmm1,%xmm1
 646:	vmulsd %xmm1,%xmm0,%xmm0
 64a:	vmulsd %xmm1,%xmm0,%xmm0
 64e:	vmovsd 0x0(%rip),%xmm1        # 656 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xd6>
 656:	vcomisd %xmm0,%xmm1
 65a:	seta   %al
 65d:	ret    
 65e:	ret    
 65f:	nop

0000000000000660 <ivf::dist_name(ivf::DistKind)>:
 660:	endbr64 
 664:	lea    0x0(%rip),%rax        # 66b <ivf::dist_name(ivf::DistKind)+0xb>
 66b:	cmp    $0x2,%edi
 66e:	je     6ad <ivf::dist_name(ivf::DistKind)+0x4d>
 670:	jg     698 <ivf::dist_name(ivf::DistKind)+0x38>
 672:	lea    0x0(%rip),%rax        # 679 <ivf::dist_name(ivf::DistKind)+0x19>
 679:	test   %edi,%edi
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
