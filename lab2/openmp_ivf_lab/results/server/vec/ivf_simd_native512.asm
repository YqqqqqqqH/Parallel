
results/server/vec/ivf_simd_native512.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <ivf::l2_distance_f32(float const*, float const*, unsigned long)>:
   0:	endbr64 
   4:	mov    %rsi,%rcx
   7:	test   %rdx,%rdx
   a:	je     220 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x220>
  10:	lea    -0x1(%rdx),%rax
  14:	cmp    $0xe,%rax
  18:	jbe    225 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x225>
  1e:	mov    %rdx,%rsi
  21:	shr    $0x4,%rsi
  25:	shl    $0x6,%rsi
  29:	xor    %eax,%eax
  2b:	vxorps %xmm0,%xmm0,%xmm0
  2f:	nop
  30:	vmovups (%rdi,%rax,1),%zmm5
  37:	vsubps (%rcx,%rax,1),%zmm5,%zmm1
  3e:	add    $0x40,%rax
  42:	vmulps %zmm1,%zmm1,%zmm1
  48:	vaddss %xmm1,%xmm0,%xmm0
  4c:	vshufps $0x55,%xmm1,%xmm1,%xmm4
  51:	vshufps $0xff,%xmm1,%xmm1,%xmm3
  56:	vaddss %xmm4,%xmm0,%xmm0
  5a:	vunpckhps %xmm1,%xmm1,%xmm4
  5e:	vextractf128 $0x1,%ymm1,%xmm2
  64:	vaddss %xmm4,%xmm0,%xmm0
  68:	vextractf32x8 $0x1,%zmm1,%ymm1
  6f:	vaddss %xmm3,%xmm0,%xmm0
  73:	vshufps $0x55,%xmm2,%xmm2,%xmm3
  78:	vaddss %xmm2,%xmm0,%xmm0
  7c:	vaddss %xmm3,%xmm0,%xmm0
  80:	vunpckhps %xmm2,%xmm2,%xmm3
  84:	vshufps $0xff,%xmm2,%xmm2,%xmm2
  89:	vaddss %xmm3,%xmm0,%xmm0
  8d:	vshufps $0x55,%xmm1,%xmm1,%xmm3
  92:	vaddss %xmm2,%xmm0,%xmm0
  96:	vshufps $0xff,%xmm1,%xmm1,%xmm2
  9b:	vaddss %xmm1,%xmm0,%xmm0
  9f:	vaddss %xmm3,%xmm0,%xmm0
  a3:	vunpckhps %xmm1,%xmm1,%xmm3
  a7:	vextractf128 $0x1,%ymm1,%xmm1
  ad:	vaddss %xmm3,%xmm0,%xmm0
  b1:	vaddss %xmm2,%xmm0,%xmm0
  b5:	vshufps $0x55,%xmm1,%xmm1,%xmm2
  ba:	vaddss %xmm1,%xmm0,%xmm0
  be:	vaddss %xmm2,%xmm0,%xmm0
  c2:	vunpckhps %xmm1,%xmm1,%xmm2
  c6:	vshufps $0xff,%xmm1,%xmm1,%xmm1
  cb:	vaddss %xmm2,%xmm0,%xmm0
  cf:	vaddss %xmm1,%xmm0,%xmm0
  d3:	cmp    %rsi,%rax
  d6:	jne    30 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x30>
  dc:	mov    %rdx,%rax
  df:	and    $0xfffffffffffffff0,%rax
  e3:	test   $0xf,%dl
  e6:	je     216 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x216>
  ec:	mov    %rdx,%rsi
  ef:	sub    %rax,%rsi
  f2:	lea    -0x1(%rsi),%r8
  f6:	cmp    $0x6,%r8
  fa:	jbe    15f <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x15f>
  fc:	vmovups (%rdi,%rax,4),%ymm6
 101:	mov    %rsi,%r8
 104:	vsubps (%rcx,%rax,4),%ymm6,%ymm1
 109:	and    $0xfffffffffffffff8,%r8
 10d:	add    %r8,%rax
 110:	vmulps %ymm1,%ymm1,%ymm1
 114:	vaddss %xmm1,%xmm0,%xmm0
 118:	vshufps $0x55,%xmm1,%xmm1,%xmm3
 11d:	vshufps $0xff,%xmm1,%xmm1,%xmm2
 122:	vaddss %xmm3,%xmm0,%xmm0
 126:	vunpckhps %xmm1,%xmm1,%xmm3
 12a:	vextractf128 $0x1,%ymm1,%xmm1
 130:	vaddss %xmm3,%xmm0,%xmm0
 134:	vaddss %xmm2,%xmm0,%xmm0
 138:	vshufps $0x55,%xmm1,%xmm1,%xmm2
 13d:	vaddss %xmm1,%xmm0,%xmm0
 141:	vaddss %xmm2,%xmm0,%xmm0
 145:	vunpckhps %xmm1,%xmm1,%xmm2
 149:	vshufps $0xff,%xmm1,%xmm1,%xmm1
 14e:	vaddss %xmm2,%xmm0,%xmm0
 152:	vaddss %xmm1,%xmm0,%xmm0
 156:	cmp    %r8,%rsi
 159:	je     216 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x216>
 15f:	vmovss (%rdi,%rax,4),%xmm1
 164:	lea    0x1(%rax),%r8
 168:	vsubss (%rcx,%rax,4),%xmm1,%xmm1
 16d:	lea    0x0(,%rax,4),%rsi
 175:	vfmadd231ss %xmm1,%xmm1,%xmm0
 17a:	cmp    %r8,%rdx
 17d:	jbe    216 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x216>
 183:	vmovss 0x4(%rdi,%rsi,1),%xmm1
 189:	lea    0x2(%rax),%r8
 18d:	vsubss 0x4(%rcx,%rsi,1),%xmm1,%xmm1
 193:	vfmadd231ss %xmm1,%xmm1,%xmm0
 198:	cmp    %r8,%rdx
 19b:	jbe    216 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x216>
 19d:	vmovss 0x8(%rdi,%rsi,1),%xmm1
 1a3:	lea    0x3(%rax),%r8
 1a7:	vsubss 0x8(%rcx,%rsi,1),%xmm1,%xmm1
 1ad:	vfmadd231ss %xmm1,%xmm1,%xmm0
 1b2:	cmp    %r8,%rdx
 1b5:	jbe    216 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x216>
 1b7:	vmovss 0xc(%rdi,%rsi,1),%xmm1
 1bd:	lea    0x4(%rax),%r8
 1c1:	vsubss 0xc(%rcx,%rsi,1),%xmm1,%xmm1
 1c7:	vfmadd231ss %xmm1,%xmm1,%xmm0
 1cc:	cmp    %r8,%rdx
 1cf:	jbe    216 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x216>
 1d1:	vmovss 0x10(%rdi,%rsi,1),%xmm1
 1d7:	lea    0x5(%rax),%r8
 1db:	vsubss 0x10(%rcx,%rsi,1),%xmm1,%xmm1
 1e1:	vfmadd231ss %xmm1,%xmm1,%xmm0
 1e6:	cmp    %r8,%rdx
 1e9:	jbe    216 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x216>
 1eb:	vmovss 0x14(%rdi,%rsi,1),%xmm1
 1f1:	add    $0x6,%rax
 1f5:	vsubss 0x14(%rcx,%rsi,1),%xmm1,%xmm1
 1fb:	vfmadd231ss %xmm1,%xmm1,%xmm0
 200:	cmp    %rax,%rdx
 203:	jbe    216 <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0x216>
 205:	vmovss 0x18(%rdi,%rsi,1),%xmm1
 20b:	vsubss 0x18(%rcx,%rsi,1),%xmm1,%xmm1
 211:	vfmadd231ss %xmm1,%xmm1,%xmm0
 216:	vcvtss2sd %xmm0,%xmm0,%xmm0
 21a:	vzeroupper 
 21d:	ret    
 21e:	xchg   %ax,%ax
 220:	vxorpd %xmm0,%xmm0,%xmm0
 224:	ret    
 225:	xor    %eax,%eax
 227:	vxorps %xmm0,%xmm0,%xmm0
 22b:	jmp    ec <ivf::l2_distance_f32(float const*, float const*, unsigned long)+0xec>

0000000000000230 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)>:
 230:	endbr64 
 234:	push   %rbp
 235:	vpxor  %xmm0,%xmm0,%xmm0
 239:	mov    %rsp,%rbp
 23c:	and    $0xffffffffffffffc0,%rsp
 240:	sub    $0xc0,%rsp
 247:	mov    %fs:0x28,%rax
 250:	mov    %rax,0xb8(%rsp)
 258:	xor    %eax,%eax
 25a:	vmovdqa %xmm0,(%rsp)
 25f:	vmovdqa %xmm0,0x10(%rsp)
 265:	vmovdqa %xmm0,0x20(%rsp)
 26b:	vmovdqa %xmm0,0x30(%rsp)
 271:	vmovdqa %xmm0,0x40(%rsp)
 277:	vmovdqa %xmm0,0x50(%rsp)
 27d:	vmovdqa %xmm0,0x60(%rsp)
 283:	vmovdqa %xmm0,0x70(%rsp)
 289:	test   %rdx,%rdx
 28c:	je     570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 292:	lea    -0x1(%rdx),%rax
 296:	mov    %rsi,%rcx
 299:	cmp    $0xe,%rax
 29d:	jbe    625 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x3f5>
 2a3:	mov    %rdx,%rsi
 2a6:	shr    $0x4,%rsi
 2aa:	vxorpd %xmm4,%xmm4,%xmm4
 2ae:	shl    $0x6,%rsi
 2b2:	xor    %eax,%eax
 2b4:	vmovapd %zmm4,%zmm3
 2ba:	nopw   0x0(%rax,%rax,1)
 2c0:	vmovups (%rdi,%rax,1),%zmm0
 2c7:	vmovups (%rcx,%rax,1),%zmm1
 2ce:	vcvtps2pd %ymm0,%zmm2
 2d4:	vcvtps2pd %ymm1,%zmm5
 2da:	vextractf32x8 $0x1,%zmm0,%ymm0
 2e1:	vextractf32x8 $0x1,%zmm1,%ymm1
 2e8:	vsubpd %zmm5,%zmm2,%zmm2
 2ee:	vcvtps2pd %ymm0,%zmm0
 2f4:	vcvtps2pd %ymm1,%zmm1
 2fa:	vsubpd %zmm1,%zmm0,%zmm0
 300:	add    $0x40,%rax
 304:	vfmadd231pd %zmm2,%zmm2,%zmm4
 30a:	vfmadd231pd %zmm0,%zmm0,%zmm3
 310:	cmp    %rsi,%rax
 313:	jne    2c0 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x90>
 315:	mov    %rdx,%rsi
 318:	vmovapd %zmm4,(%rsp)
 31f:	vmovapd %zmm3,0x40(%rsp)
 327:	and    $0xfffffffffffffff0,%rsi
 32b:	test   $0xf,%dl
 32e:	je     570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 334:	vxorps %xmm0,%xmm0,%xmm0
 338:	vcvtss2sd (%rdi,%rsi,4),%xmm0,%xmm1
 33d:	vcvtss2sd (%rcx,%rsi,4),%xmm0,%xmm2
 342:	vsubsd %xmm2,%xmm1,%xmm1
 346:	lea    0x1(%rsi),%r8
 34a:	lea    0x0(,%rsi,4),%rax
 352:	vfmadd213sd (%rsp),%xmm1,%xmm1
 358:	vmovsd %xmm1,(%rsp)
 35d:	cmp    %r8,%rdx
 360:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 366:	vcvtss2sd 0x4(%rdi,%rax,1),%xmm0,%xmm2
 36c:	vcvtss2sd 0x4(%rcx,%rax,1),%xmm0,%xmm3
 372:	vsubsd %xmm3,%xmm2,%xmm2
 376:	lea    0x2(%rsi),%r8
 37a:	vfmadd132sd %xmm2,%xmm1,%xmm2
 37f:	vmovsd %xmm2,(%rsp)
 384:	cmp    %r8,%rdx
 387:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 38d:	vcvtss2sd 0x8(%rdi,%rax,1),%xmm0,%xmm1
 393:	vcvtss2sd 0x8(%rcx,%rax,1),%xmm0,%xmm3
 399:	vsubsd %xmm3,%xmm1,%xmm1
 39d:	lea    0x3(%rsi),%r8
 3a1:	vfmadd132sd %xmm1,%xmm2,%xmm1
 3a6:	vmovsd %xmm1,(%rsp)
 3ab:	cmp    %r8,%rdx
 3ae:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 3b4:	vcvtss2sd 0xc(%rdi,%rax,1),%xmm0,%xmm2
 3ba:	vcvtss2sd 0xc(%rcx,%rax,1),%xmm0,%xmm3
 3c0:	vsubsd %xmm3,%xmm2,%xmm2
 3c4:	lea    0x4(%rsi),%r8
 3c8:	vfmadd132sd %xmm2,%xmm1,%xmm2
 3cd:	vmovsd %xmm2,(%rsp)
 3d2:	cmp    %r8,%rdx
 3d5:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 3db:	vcvtss2sd 0x10(%rdi,%rax,1),%xmm0,%xmm1
 3e1:	vcvtss2sd 0x10(%rcx,%rax,1),%xmm0,%xmm3
 3e7:	vsubsd %xmm3,%xmm1,%xmm1
 3eb:	lea    0x5(%rsi),%r8
 3ef:	vfmadd132sd %xmm1,%xmm2,%xmm1
 3f4:	vmovsd %xmm1,(%rsp)
 3f9:	cmp    %r8,%rdx
 3fc:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 402:	vcvtss2sd 0x14(%rdi,%rax,1),%xmm0,%xmm2
 408:	vcvtss2sd 0x14(%rcx,%rax,1),%xmm0,%xmm3
 40e:	vsubsd %xmm3,%xmm2,%xmm2
 412:	lea    0x6(%rsi),%r8
 416:	vfmadd132sd %xmm2,%xmm1,%xmm2
 41b:	vmovsd %xmm2,(%rsp)
 420:	cmp    %r8,%rdx
 423:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 429:	vcvtss2sd 0x18(%rdi,%rax,1),%xmm0,%xmm1
 42f:	vcvtss2sd 0x18(%rcx,%rax,1),%xmm0,%xmm3
 435:	vsubsd %xmm3,%xmm1,%xmm1
 439:	lea    0x7(%rsi),%r8
 43d:	vfmadd132sd %xmm1,%xmm2,%xmm1
 442:	vmovsd %xmm1,(%rsp)
 447:	cmp    %r8,%rdx
 44a:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 450:	vcvtss2sd 0x1c(%rdi,%rax,1),%xmm0,%xmm2
 456:	vcvtss2sd 0x1c(%rcx,%rax,1),%xmm0,%xmm3
 45c:	vsubsd %xmm3,%xmm2,%xmm2
 460:	lea    0x8(%rsi),%r8
 464:	vfmadd132sd %xmm2,%xmm1,%xmm2
 469:	vmovsd %xmm2,(%rsp)
 46e:	cmp    %r8,%rdx
 471:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 477:	vcvtss2sd 0x20(%rdi,%rax,1),%xmm0,%xmm1
 47d:	vcvtss2sd 0x20(%rcx,%rax,1),%xmm0,%xmm3
 483:	vsubsd %xmm3,%xmm1,%xmm1
 487:	lea    0x9(%rsi),%r8
 48b:	vfmadd132sd %xmm1,%xmm2,%xmm1
 490:	vmovsd %xmm1,(%rsp)
 495:	cmp    %r8,%rdx
 498:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 49e:	vcvtss2sd 0x24(%rdi,%rax,1),%xmm0,%xmm2
 4a4:	vcvtss2sd 0x24(%rcx,%rax,1),%xmm0,%xmm3
 4aa:	vsubsd %xmm3,%xmm2,%xmm2
 4ae:	lea    0xa(%rsi),%r8
 4b2:	vfmadd132sd %xmm2,%xmm1,%xmm2
 4b7:	vmovsd %xmm2,(%rsp)
 4bc:	cmp    %r8,%rdx
 4bf:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 4c5:	vcvtss2sd 0x28(%rdi,%rax,1),%xmm0,%xmm1
 4cb:	vcvtss2sd 0x28(%rcx,%rax,1),%xmm0,%xmm3
 4d1:	vsubsd %xmm3,%xmm1,%xmm1
 4d5:	lea    0xb(%rsi),%r8
 4d9:	vfmadd132sd %xmm1,%xmm2,%xmm1
 4de:	vmovsd %xmm1,(%rsp)
 4e3:	cmp    %r8,%rdx
 4e6:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 4ec:	vcvtss2sd 0x2c(%rdi,%rax,1),%xmm0,%xmm2
 4f2:	vcvtss2sd 0x2c(%rcx,%rax,1),%xmm0,%xmm3
 4f8:	vsubsd %xmm3,%xmm2,%xmm2
 4fc:	lea    0xc(%rsi),%r8
 500:	vfmadd132sd %xmm2,%xmm1,%xmm2
 505:	vmovsd %xmm2,(%rsp)
 50a:	cmp    %r8,%rdx
 50d:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 50f:	vcvtss2sd 0x30(%rdi,%rax,1),%xmm0,%xmm1
 515:	vcvtss2sd 0x30(%rcx,%rax,1),%xmm0,%xmm3
 51b:	vsubsd %xmm3,%xmm1,%xmm1
 51f:	lea    0xd(%rsi),%r8
 523:	vfmadd132sd %xmm1,%xmm2,%xmm1
 528:	vmovsd %xmm1,(%rsp)
 52d:	cmp    %r8,%rdx
 530:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 532:	vcvtss2sd 0x34(%rdi,%rax,1),%xmm0,%xmm2
 538:	vcvtss2sd 0x34(%rcx,%rax,1),%xmm0,%xmm3
 53e:	vsubsd %xmm3,%xmm2,%xmm2
 542:	add    $0xe,%rsi
 546:	vfmadd132sd %xmm2,%xmm1,%xmm2
 54b:	vmovsd %xmm2,(%rsp)
 550:	cmp    %rsi,%rdx
 553:	jbe    570 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x340>
 555:	vcvtss2sd 0x38(%rdi,%rax,1),%xmm0,%xmm1
 55b:	vcvtss2sd 0x38(%rcx,%rax,1),%xmm0,%xmm0
 561:	vsubsd %xmm0,%xmm1,%xmm0
 565:	vfmadd132sd %xmm0,%xmm2,%xmm0
 56a:	vmovsd %xmm0,(%rsp)
 56f:	nop
 570:	vmovapd (%rsp),%zmm0
 577:	vxorpd %xmm1,%xmm1,%xmm1
 57b:	vaddsd %xmm0,%xmm1,%xmm1
 57f:	vunpckhpd %xmm0,%xmm0,%xmm3
 583:	vextractf64x2 $0x1,%ymm0,%xmm2
 58a:	vaddsd %xmm3,%xmm1,%xmm1
 58e:	vextractf64x4 $0x1,%zmm0,%ymm0
 595:	vaddsd %xmm2,%xmm1,%xmm1
 599:	vunpckhpd %xmm2,%xmm2,%xmm2
 59d:	vaddsd %xmm2,%xmm1,%xmm1
 5a1:	vunpckhpd %xmm0,%xmm0,%xmm2
 5a5:	vaddsd %xmm0,%xmm1,%xmm1
 5a9:	vextractf64x2 $0x1,%ymm0,%xmm0
 5b0:	vaddsd %xmm2,%xmm1,%xmm1
 5b4:	vmovapd 0x40(%rsp),%zmm2
 5bc:	vaddsd %xmm0,%xmm1,%xmm1
 5c0:	vunpckhpd %xmm0,%xmm0,%xmm0
 5c4:	vunpckhpd %xmm2,%xmm2,%xmm4
 5c8:	vaddsd %xmm0,%xmm1,%xmm1
 5cc:	vaddsd %xmm1,%xmm2,%xmm0
 5d0:	vextractf64x2 $0x1,%ymm2,%xmm1
 5d7:	vaddsd %xmm4,%xmm0,%xmm0
 5db:	vaddsd %xmm1,%xmm0,%xmm0
 5df:	vunpckhpd %xmm1,%xmm1,%xmm1
 5e3:	vaddsd %xmm1,%xmm0,%xmm0
 5e7:	vextractf64x4 $0x1,%zmm2,%ymm1
 5ee:	vunpckhpd %xmm1,%xmm1,%xmm2
 5f2:	vaddsd %xmm1,%xmm0,%xmm0
 5f6:	vextractf64x2 $0x1,%ymm1,%xmm1
 5fd:	vaddsd %xmm2,%xmm0,%xmm0
 601:	vaddsd %xmm1,%xmm0,%xmm0
 605:	vunpckhpd %xmm1,%xmm1,%xmm1
 609:	vaddsd %xmm1,%xmm0,%xmm0
 60d:	mov    0xb8(%rsp),%rax
 615:	sub    %fs:0x28,%rax
 61e:	jne    62c <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x3fc>
 620:	vzeroupper 
 623:	leave  
 624:	ret    
 625:	xor    %esi,%esi
 627:	jmp    334 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x104>
 62c:	vzeroupper 
 62f:	call   634 <ivf::l2_distance_simd64(float const*, float const*, unsigned long)+0x404>
 634:	data16 cs nopw 0x0(%rax,%rax,1)
 63f:	nop

0000000000000640 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)>:
 640:	endbr64 
 644:	push   %rbp
 645:	vpxor  %xmm0,%xmm0,%xmm0
 649:	mov    %rsp,%rbp
 64c:	and    $0xffffffffffffffc0,%rsp
 650:	add    $0xffffffffffffff80,%rsp
 654:	mov    %fs:0x28,%rax
 65d:	mov    %rax,0x78(%rsp)
 662:	xor    %eax,%eax
 664:	vmovdqa %xmm0,(%rsp)
 669:	vmovdqa %xmm0,0x10(%rsp)
 66f:	vmovdqa %xmm0,0x20(%rsp)
 675:	vmovdqa %xmm0,0x30(%rsp)
 67b:	test   %rdx,%rdx
 67e:	je     8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 684:	lea    -0x1(%rdx),%rax
 688:	mov    %rsi,%rcx
 68b:	cmp    $0xe,%rax
 68f:	jbe    994 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x354>
 695:	mov    %rdx,%rsi
 698:	shr    $0x4,%rsi
 69c:	shl    $0x6,%rsi
 6a0:	xor    %eax,%eax
 6a2:	vxorps %xmm1,%xmm1,%xmm1
 6a6:	cs nopw 0x0(%rax,%rax,1)
 6b0:	vmovups (%rdi,%rax,1),%zmm4
 6b7:	vsubps (%rcx,%rax,1),%zmm4,%zmm0
 6be:	add    $0x40,%rax
 6c2:	vfmadd231ps %zmm0,%zmm0,%zmm1
 6c8:	cmp    %rsi,%rax
 6cb:	jne    6b0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x70>
 6cd:	mov    %rdx,%rsi
 6d0:	vmovaps %zmm1,(%rsp)
 6d7:	and    $0xfffffffffffffff0,%rsi
 6db:	test   $0xf,%dl
 6de:	je     8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 6e4:	vmovss (%rdi,%rsi,4),%xmm0
 6e9:	lea    0x1(%rsi),%r8
 6ed:	vsubss (%rcx,%rsi,4),%xmm0,%xmm0
 6f2:	lea    0x0(,%rsi,4),%rax
 6fa:	vfmadd213ss (%rsp),%xmm0,%xmm0
 700:	vmovss %xmm0,(%rsp)
 705:	cmp    %r8,%rdx
 708:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 70e:	vmovss 0x4(%rdi,%rax,1),%xmm1
 714:	lea    0x2(%rsi),%r8
 718:	vsubss 0x4(%rcx,%rax,1),%xmm1,%xmm1
 71e:	vfmadd132ss %xmm1,%xmm0,%xmm1
 723:	vmovss %xmm1,(%rsp)
 728:	cmp    %r8,%rdx
 72b:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 731:	vmovss 0x8(%rdi,%rax,1),%xmm0
 737:	lea    0x3(%rsi),%r8
 73b:	vsubss 0x8(%rcx,%rax,1),%xmm0,%xmm0
 741:	vfmadd132ss %xmm0,%xmm1,%xmm0
 746:	vmovss %xmm0,(%rsp)
 74b:	cmp    %r8,%rdx
 74e:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 754:	vmovss 0xc(%rdi,%rax,1),%xmm1
 75a:	lea    0x4(%rsi),%r8
 75e:	vsubss 0xc(%rcx,%rax,1),%xmm1,%xmm1
 764:	vfmadd132ss %xmm1,%xmm0,%xmm1
 769:	vmovss %xmm1,(%rsp)
 76e:	cmp    %r8,%rdx
 771:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 777:	vmovss 0x10(%rdi,%rax,1),%xmm0
 77d:	lea    0x5(%rsi),%r8
 781:	vsubss 0x10(%rcx,%rax,1),%xmm0,%xmm0
 787:	vfmadd132ss %xmm0,%xmm1,%xmm0
 78c:	vmovss %xmm0,(%rsp)
 791:	cmp    %r8,%rdx
 794:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 79a:	vmovss 0x14(%rdi,%rax,1),%xmm1
 7a0:	lea    0x6(%rsi),%r8
 7a4:	vsubss 0x14(%rcx,%rax,1),%xmm1,%xmm1
 7aa:	vfmadd132ss %xmm1,%xmm0,%xmm1
 7af:	vmovss %xmm1,(%rsp)
 7b4:	cmp    %r8,%rdx
 7b7:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 7bd:	vmovss 0x18(%rdi,%rax,1),%xmm0
 7c3:	lea    0x7(%rsi),%r8
 7c7:	vsubss 0x18(%rcx,%rax,1),%xmm0,%xmm0
 7cd:	vfmadd132ss %xmm0,%xmm1,%xmm0
 7d2:	vmovss %xmm0,(%rsp)
 7d7:	cmp    %r8,%rdx
 7da:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 7e0:	vmovss 0x1c(%rdi,%rax,1),%xmm1
 7e6:	lea    0x8(%rsi),%r8
 7ea:	vsubss 0x1c(%rcx,%rax,1),%xmm1,%xmm1
 7f0:	vfmadd132ss %xmm1,%xmm0,%xmm1
 7f5:	vmovss %xmm1,(%rsp)
 7fa:	cmp    %r8,%rdx
 7fd:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 803:	vmovss 0x20(%rdi,%rax,1),%xmm0
 809:	lea    0x9(%rsi),%r8
 80d:	vsubss 0x20(%rcx,%rax,1),%xmm0,%xmm0
 813:	vfmadd132ss %xmm0,%xmm1,%xmm0
 818:	vmovss %xmm0,(%rsp)
 81d:	cmp    %r8,%rdx
 820:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 826:	vmovss 0x24(%rdi,%rax,1),%xmm1
 82c:	lea    0xa(%rsi),%r8
 830:	vsubss 0x24(%rcx,%rax,1),%xmm1,%xmm1
 836:	vfmadd132ss %xmm1,%xmm0,%xmm1
 83b:	vmovss %xmm1,(%rsp)
 840:	cmp    %r8,%rdx
 843:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 849:	vmovss 0x28(%rdi,%rax,1),%xmm0
 84f:	lea    0xb(%rsi),%r8
 853:	vsubss 0x28(%rcx,%rax,1),%xmm0,%xmm0
 859:	vfmadd132ss %xmm0,%xmm1,%xmm0
 85e:	vmovss %xmm0,(%rsp)
 863:	cmp    %r8,%rdx
 866:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 868:	vmovss 0x2c(%rdi,%rax,1),%xmm1
 86e:	lea    0xc(%rsi),%r8
 872:	vsubss 0x2c(%rcx,%rax,1),%xmm1,%xmm1
 878:	vfmadd132ss %xmm1,%xmm0,%xmm1
 87d:	vmovss %xmm1,(%rsp)
 882:	cmp    %r8,%rdx
 885:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 887:	vmovss 0x30(%rdi,%rax,1),%xmm0
 88d:	lea    0xd(%rsi),%r8
 891:	vsubss 0x30(%rcx,%rax,1),%xmm0,%xmm0
 897:	vfmadd132ss %xmm0,%xmm1,%xmm0
 89c:	vmovss %xmm0,(%rsp)
 8a1:	cmp    %r8,%rdx
 8a4:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 8a6:	vmovss 0x34(%rdi,%rax,1),%xmm1
 8ac:	add    $0xe,%rsi
 8b0:	vsubss 0x34(%rcx,%rax,1),%xmm1,%xmm1
 8b6:	vfmadd132ss %xmm1,%xmm0,%xmm1
 8bb:	vmovss %xmm1,(%rsp)
 8c0:	cmp    %rsi,%rdx
 8c3:	jbe    8e0 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x2a0>
 8c5:	vmovss 0x38(%rdi,%rax,1),%xmm0
 8cb:	vsubss 0x38(%rcx,%rax,1),%xmm0,%xmm0
 8d1:	vfmadd132ss %xmm0,%xmm1,%xmm0
 8d6:	vmovss %xmm0,(%rsp)
 8db:	nopl   0x0(%rax,%rax,1)
 8e0:	vmovaps (%rsp),%ymm1
 8e5:	vxorps %xmm0,%xmm0,%xmm0
 8e9:	vaddss %xmm1,%xmm0,%xmm0
 8ed:	vshufps $0x55,%xmm1,%xmm1,%xmm3
 8f2:	vshufps $0xff,%xmm1,%xmm1,%xmm2
 8f7:	vaddss %xmm3,%xmm0,%xmm0
 8fb:	vunpckhps %xmm1,%xmm1,%xmm3
 8ff:	vextractf128 $0x1,%ymm1,%xmm1
 905:	vaddss %xmm3,%xmm0,%xmm0
 909:	vmovaps (%rsp),%zmm5
 910:	vaddss %xmm2,%xmm0,%xmm0
 914:	vshufps $0x55,%xmm1,%xmm1,%xmm2
 919:	vaddss %xmm1,%xmm0,%xmm0
 91d:	vaddss %xmm2,%xmm0,%xmm0
 921:	vunpckhps %xmm1,%xmm1,%xmm2
 925:	vshufps $0xff,%xmm1,%xmm1,%xmm1
 92a:	vaddss %xmm2,%xmm0,%xmm0
 92e:	vaddss %xmm1,%xmm0,%xmm0
 932:	vextractf32x8 $0x1,%zmm5,%ymm1
 939:	vshufps $0x55,%xmm1,%xmm1,%xmm3
 93e:	vaddss %xmm1,%xmm0,%xmm0
 942:	vshufps $0xff,%xmm1,%xmm1,%xmm2
 947:	vaddss %xmm3,%xmm0,%xmm0
 94b:	vunpckhps %xmm1,%xmm1,%xmm3
 94f:	vextractf128 $0x1,%ymm1,%xmm1
 955:	vaddss %xmm3,%xmm0,%xmm0
 959:	vaddss %xmm2,%xmm0,%xmm0
 95d:	vshufps $0x55,%xmm1,%xmm1,%xmm2
 962:	vaddss %xmm1,%xmm0,%xmm0
 966:	vaddss %xmm2,%xmm0,%xmm0
 96a:	vunpckhps %xmm1,%xmm1,%xmm2
 96e:	vshufps $0xff,%xmm1,%xmm1,%xmm1
 973:	vaddss %xmm2,%xmm0,%xmm0
 977:	vaddss %xmm1,%xmm0,%xmm0
 97b:	vcvtss2sd %xmm0,%xmm0,%xmm0
 97f:	mov    0x78(%rsp),%rax
 984:	sub    %fs:0x28,%rax
 98d:	jne    99b <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x35b>
 98f:	vzeroupper 
 992:	leave  
 993:	ret    
 994:	xor    %esi,%esi
 996:	jmp    6e4 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0xa4>
 99b:	vzeroupper 
 99e:	call   9a3 <ivf::l2_distance_simd32(float const*, float const*, unsigned long)+0x363>
 9a3:	data16 cs nopw 0x0(%rax,%rax,1)
 9ae:	xchg   %ax,%ax

00000000000009b0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)>:
 9b0:	endbr64 
 9b4:	mov    0x50(%rdi),%r9
 9b8:	mov    0x48(%rdi),%rcx
 9bc:	mov    %rdx,%r8
 9bf:	mov    %r9,%rdx
 9c2:	sub    %rcx,%rdx
 9c5:	sar    $0x2,%rdx
 9c9:	vmovss 0x0(%rip),%xmm1        # 9d1 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x21>
 9d1:	vmovss 0x0(%rip),%xmm2        # 9d9 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x29>
 9d9:	je     a10 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x60>
 9db:	xor    %eax,%eax
 9dd:	jmp    9f0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x40>
 9df:	nop
 9e0:	inc    %rax
 9e3:	vminss %xmm2,%xmm0,%xmm2
 9e7:	vmaxss %xmm1,%xmm0,%xmm1
 9eb:	cmp    %rax,%rdx
 9ee:	je     a10 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x60>
 9f0:	vmovss (%rcx,%rax,4),%xmm0
 9f5:	vrndscaless $0xc,%xmm0,%xmm0,%xmm3
 9fc:	vucomiss %xmm3,%xmm0
 a00:	jp     a04 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x54>
 a02:	je     9e0 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x30>
 a04:	xor    %eax,%eax
 a06:	ret    
 a07:	nopw   0x0(%rax,%rax,1)
 a10:	mov    0x8(%rdi),%rdi
 a14:	xor    %eax,%eax
 a16:	mov    %rdi,%rdx
 a19:	imul   %r8,%rdx
 a1d:	test   %rdx,%rdx
 a20:	jne    a38 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x88>
 a22:	jmp    a50 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa0>
 a24:	nopl   0x0(%rax)
 a28:	inc    %rax
 a2b:	vminss %xmm2,%xmm0,%xmm2
 a2f:	vmaxss %xmm1,%xmm0,%xmm1
 a33:	cmp    %rax,%rdx
 a36:	je     a50 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xa0>
 a38:	vmovss (%rsi,%rax,4),%xmm0
 a3d:	vrndscaless $0xc,%xmm0,%xmm0,%xmm3
 a44:	vucomiss %xmm3,%xmm0
 a48:	jp     a04 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x54>
 a4a:	je     a28 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x78>
 a4c:	jmp    a04 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0x54>
 a4e:	xchg   %ax,%ax
 a50:	test   %r8,%r8
 a53:	sete   %al
 a56:	cmp    %r9,%rcx
 a59:	sete   %dl
 a5c:	and    %dl,%al
 a5e:	jne    a8e <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xde>
 a60:	vxorps %xmm0,%xmm0,%xmm0
 a64:	vcvtusi2sd %rdi,%xmm0,%xmm0
 a6a:	vcvtss2sd %xmm2,%xmm2,%xmm2
 a6e:	vcvtss2sd %xmm1,%xmm1,%xmm1
 a72:	vsubsd %xmm2,%xmm1,%xmm1
 a76:	vmulsd %xmm1,%xmm0,%xmm0
 a7a:	vmulsd %xmm1,%xmm0,%xmm0
 a7e:	vmovsd 0x0(%rip),%xmm1        # a86 <ivf::f32_distance_exact(ivf::IVFIndex const&, float const*, unsigned long)+0xd6>
 a86:	vcomisd %xmm0,%xmm1
 a8a:	seta   %al
 a8d:	ret    
 a8e:	ret    
 a8f:	nop

0000000000000a90 <ivf::dist_name(ivf::DistKind)>:
 a90:	endbr64 
 a94:	lea    0x0(%rip),%rax        # a9b <ivf::dist_name(ivf::DistKind)+0xb>
 a9b:	cmp    $0x2,%edi
 a9e:	je     add <ivf::dist_name(ivf::DistKind)+0x4d>
 aa0:	jg     ac8 <ivf::dist_name(ivf::DistKind)+0x38>
 aa2:	lea    0x0(%rip),%rax        # aa9 <ivf::dist_name(ivf::DistKind)+0x19>
 aa9:	test   %edi,%edi
 aab:	je     add <ivf::dist_name(ivf::DistKind)+0x4d>
 aad:	cmp    $0x1,%edi
 ab0:	lea    0x0(%rip),%rdx        # ab7 <ivf::dist_name(ivf::DistKind)+0x27>
 ab7:	lea    0x0(%rip),%rax        # abe <ivf::dist_name(ivf::DistKind)+0x2e>
 abe:	cmove  %rdx,%rax
 ac2:	ret    
 ac3:	nopl   0x0(%rax,%rax,1)
 ac8:	cmp    $0x3,%edi
 acb:	lea    0x0(%rip),%rax        # ad2 <ivf::dist_name(ivf::DistKind)+0x42>
 ad2:	lea    0x0(%rip),%rdx        # ad9 <ivf::dist_name(ivf::DistKind)+0x49>
 ad9:	cmove  %rdx,%rax
 add:	ret    
