
result.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	00001197          	auipc	gp,0x1
   4:	97c18193          	addi	gp,gp,-1668 # 97c <_gbl_ptr>
   8:	40000113          	li	sp,1024
   c:	17c00293          	li	t0,380
  10:	17c00313          	li	t1,380

00000014 <_bss_init_loop>:
  14:	00628863          	beq	t0,t1,24 <_main_call>
  18:	0002a023          	sw	zero,0(t0)
  1c:	00428293          	addi	t0,t0,4
  20:	ff5ff06f          	j	14 <_bss_init_loop>

00000024 <_main_call>:
  24:	00000513          	li	a0,0
  28:	00000593          	li	a1,0
  2c:	0a8000ef          	jal	ra,d4 <main>

00000030 <_endless_loop>:
  30:	0000006f          	j	30 <_endless_loop>

00000034 <_Z8fibanacim>:
  34:	fd010113          	addi	sp,sp,-48
  38:	02812623          	sw	s0,44(sp)
  3c:	03010413          	addi	s0,sp,48
  40:	fca42e23          	sw	a0,-36(s0)
  44:	fdc42783          	lw	a5,-36(s0)
  48:	00079663          	bnez	a5,54 <_Z8fibanacim+0x20>
  4c:	00000793          	li	a5,0
  50:	0740006f          	j	c4 <_Z8fibanacim+0x90>
  54:	fdc42703          	lw	a4,-36(s0)
  58:	00300793          	li	a5,3
  5c:	00e7e663          	bltu	a5,a4,68 <_Z8fibanacim+0x34>
  60:	00100793          	li	a5,1
  64:	0600006f          	j	c4 <_Z8fibanacim+0x90>
  68:	00100793          	li	a5,1
  6c:	fef42623          	sw	a5,-20(s0)
  70:	00100793          	li	a5,1
  74:	fef42423          	sw	a5,-24(s0)
  78:	fe042023          	sw	zero,-32(s0)
  7c:	00300793          	li	a5,3
  80:	fef42223          	sw	a5,-28(s0)
  84:	0300006f          	j	b4 <_Z8fibanacim+0x80>
  88:	fe842783          	lw	a5,-24(s0)
  8c:	fef42023          	sw	a5,-32(s0)
  90:	fe842703          	lw	a4,-24(s0)
  94:	fec42783          	lw	a5,-20(s0)
  98:	00f707b3          	add	a5,a4,a5
  9c:	fef42423          	sw	a5,-24(s0)
  a0:	fe042783          	lw	a5,-32(s0)
  a4:	fef42623          	sw	a5,-20(s0)
  a8:	fe442783          	lw	a5,-28(s0)
  ac:	00178793          	addi	a5,a5,1
  b0:	fef42223          	sw	a5,-28(s0)
  b4:	fe442783          	lw	a5,-28(s0)
  b8:	fdc42703          	lw	a4,-36(s0)
  bc:	fce7e6e3          	bltu	a5,a4,88 <_Z8fibanacim+0x54>
  c0:	fe842783          	lw	a5,-24(s0)
  c4:	00078513          	mv	a0,a5
  c8:	02c12403          	lw	s0,44(sp)
  cc:	03010113          	addi	sp,sp,48
  d0:	00008067          	ret

000000d4 <main>:
  d4:	fd010113          	addi	sp,sp,-48
  d8:	02112623          	sw	ra,44(sp)
  dc:	02812423          	sw	s0,40(sp)
  e0:	03010413          	addi	s0,sp,48
  e4:	020007b7          	lui	a5,0x2000
  e8:	fef42423          	sw	a5,-24(s0)
  ec:	020007b7          	lui	a5,0x2000
  f0:	02478793          	addi	a5,a5,36 # 2000024 <_gbl_ptr+0x1fff6a8>
  f4:	fef42223          	sw	a5,-28(s0)
  f8:	020007b7          	lui	a5,0x2000
  fc:	00478793          	addi	a5,a5,4 # 2000004 <_gbl_ptr+0x1fff688>
 100:	fef42023          	sw	a5,-32(s0)
 104:	010007b7          	lui	a5,0x1000
 108:	fcf42e23          	sw	a5,-36(s0)
 10c:	fe442783          	lw	a5,-28(s0)
 110:	00100713          	li	a4,1
 114:	00e7a023          	sw	a4,0(a5) # 1000000 <_gbl_ptr+0xfff684>
 118:	fe442783          	lw	a5,-28(s0)
 11c:	0007a023          	sw	zero,0(a5)
 120:	fe042783          	lw	a5,-32(s0)
 124:	00100713          	li	a4,1
 128:	00e7a023          	sw	a4,0(a5)
 12c:	00a00793          	li	a5,10
 130:	fef42623          	sw	a5,-20(s0)
 134:	fec42503          	lw	a0,-20(s0)
 138:	efdff0ef          	jal	ra,34 <_Z8fibanacim>
 13c:	00050713          	mv	a4,a0
 140:	fe842783          	lw	a5,-24(s0)
 144:	00e7a023          	sw	a4,0(a5)
 148:	fdc42783          	lw	a5,-36(s0)
 14c:	0007a783          	lw	a5,0(a5)
 150:	fec42703          	lw	a4,-20(s0)
 154:	fef70ae3          	beq	a4,a5,148 <main+0x74>
 158:	fdc42783          	lw	a5,-36(s0)
 15c:	0007a783          	lw	a5,0(a5)
 160:	fef42623          	sw	a5,-20(s0)
 164:	fec42503          	lw	a0,-20(s0)
 168:	ecdff0ef          	jal	ra,34 <_Z8fibanacim>
 16c:	00050713          	mv	a4,a0
 170:	fe842783          	lw	a5,-24(s0)
 174:	00e7a023          	sw	a4,0(a5)
 178:	fd1ff06f          	j	148 <main+0x74>

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.4byte	0x3a434347
   4:	2820                	.2byte	0x2820
   6:	5078                	.2byte	0x5078
   8:	6361                	.2byte	0x6361
   a:	4e47206b          	.4byte	0x4e47206b
   e:	2055                	.2byte	0x2055
  10:	4952                	.2byte	0x4952
  12:	562d4353          	.4byte	0x562d4353
  16:	4520                	.2byte	0x4520
  18:	626d                	.2byte	0x626d
  1a:	6465                	.2byte	0x6465
  1c:	6564                	.2byte	0x6564
  1e:	2064                	.2byte	0x2064
  20:	20434347          	.4byte	0x20434347
  24:	3878                	.2byte	0x3878
  26:	5f36                	.2byte	0x5f36
  28:	3436                	.2byte	0x3436
  2a:	2029                	.2byte	0x2029
  2c:	3231                	.2byte	0x3231
  2e:	322e                	.2byte	0x322e
  30:	302e                	.2byte	0x302e
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	1b41                	.2byte	0x1b41
   2:	0000                	.2byte	0x0
   4:	7200                	.2byte	0x7200
   6:	7369                	.2byte	0x7369
   8:	01007663          	bgeu	zero,a6,14 <_bss_init_loop>
   c:	0011                	.2byte	0x11
   e:	0000                	.2byte	0x0
  10:	1004                	.2byte	0x1004
  12:	7205                	.2byte	0x7205
  14:	3376                	.2byte	0x3376
  16:	6932                	.2byte	0x6932
  18:	7032                	.2byte	0x7032
  1a:	0031                	.2byte	0x31
