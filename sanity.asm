
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 48             	sub    $0x48,%esp
	if (argc != 2){
  18:	83 39 02             	cmpl   $0x2,(%ecx)
{
  1b:	8b 41 04             	mov    0x4(%ecx),%eax
	if (argc != 2){
  1e:	0f 85 19 01 00 00    	jne    13d <main+0x13d>
	int stime;
	int record[3][3];
	for (i = 0; i < 3; i++)
		for (j = 0; j < 3; j++)
			record[i][j] = 0;
	n = atoi(argv[1]);
  24:	83 ec 0c             	sub    $0xc,%esp
  27:	ff 70 04             	pushl  0x4(%eax)
	int pid;
	for (i = 0; i < n; i++) {
  2a:	31 db                	xor    %ebx,%ebx
			record[i][j] = 0;
  2c:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
  33:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  3a:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  41:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  48:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  4f:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  56:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  5d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	n = atoi(argv[1]);
  6b:	e8 40 04 00 00       	call   4b0 <atoi>
	for (i = 0; i < n; i++) {
  70:	83 c4 10             	add    $0x10,%esp
	n = atoi(argv[1]);
  73:	89 c7                	mov    %eax,%edi
	for (i = 0; i < n; i++) {
  75:	85 c0                	test   %eax,%eax
  77:	0f 8e d6 00 00 00    	jle    153 <main+0x153>
		j = i % 3;
		pid = fork();
  7d:	e8 99 04 00 00       	call   51b <fork>
		if (pid == 0) {//child
  82:	85 c0                	test   %eax,%eax
  84:	75 2f                	jne    b5 <main+0xb5>
			j = (getpid() - 4) % 3; // ensures independence from the first son's pid when gathering the results in the second part of the program
  86:	e8 18 05 00 00       	call   5a3 <getpid>
  8b:	b9 03 00 00 00       	mov    $0x3,%ecx
  90:	83 e8 04             	sub    $0x4,%eax
  93:	99                   	cltd   
  94:	f7 f9                	idiv   %ecx
			switch(j) {
  96:	83 fa 01             	cmp    $0x1,%edx
  99:	0f 84 88 01 00 00    	je     227 <main+0x227>
  9f:	83 fa 02             	cmp    $0x2,%edx
  a2:	0f 84 5d 01 00 00    	je     205 <main+0x205>
  a8:	85 d2                	test   %edx,%edx
  aa:	0f 84 2f 01 00 00    	je     1df <main+0x1df>
		for (j = 0; j < 3; j++)
			record[i][j] /= n;
	printf(1, "\n\nCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n\n",  record[0][2], record[0][0], record[0][0] + record[0][1] + record[0][2]);
	printf(1, "SCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n\n", record[1][2], record[1][0],  record[1][0] + record[1][1] + record[1][2]);
	printf(1, "I/O BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n\n", record[2][2], record[2][0],  record[2][0] + record[2][1] + record[2][2]);
	exit();
  b0:	e8 6e 04 00 00       	call   523 <exit>
	for (i = 0; i < n; i++) {
  b5:	83 c3 01             	add    $0x1,%ebx
  b8:	39 df                	cmp    %ebx,%edi
  ba:	75 c1                	jne    7d <main+0x7d>
  bc:	89 7d b4             	mov    %edi,-0x4c(%ebp)
	for (i = 0; i < n; i++) {
  bf:	31 db                	xor    %ebx,%ebx
  c1:	eb 0b                	jmp    ce <main+0xce>
		switch(res) {
  c3:	85 d2                	test   %edx,%edx
  c5:	0f 84 ae 01 00 00    	je     279 <main+0x279>
	for (i = 0; i < n; i++) {
  cb:	83 c3 01             	add    $0x1,%ebx
  ce:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  d1:	3b 5d b4             	cmp    -0x4c(%ebp),%ebx
  d4:	7d 7a                	jge    150 <main+0x150>
		pid = wait2(&retime, &rutime, &stime);
  d6:	50                   	push   %eax
  d7:	8d 45 c0             	lea    -0x40(%ebp),%eax
		int res = (pid - 4) % 3; // correlates to j in the dispatching loop
  da:	bf 03 00 00 00       	mov    $0x3,%edi
		pid = wait2(&retime, &rutime, &stime);
  df:	50                   	push   %eax
  e0:	8d 45 bc             	lea    -0x44(%ebp),%eax
  e3:	50                   	push   %eax
  e4:	8d 45 b8             	lea    -0x48(%ebp),%eax
  e7:	50                   	push   %eax
  e8:	e8 ee 04 00 00       	call   5db <wait2>
		switch(res) {
  ed:	83 c4 10             	add    $0x10,%esp
		pid = wait2(&retime, &rutime, &stime);
  f0:	89 c1                	mov    %eax,%ecx
		int res = (pid - 4) % 3; // correlates to j in the dispatching loop
  f2:	8d 40 fc             	lea    -0x4(%eax),%eax
  f5:	99                   	cltd   
  f6:	f7 ff                	idiv   %edi
		switch(res) {
  f8:	83 fa 01             	cmp    $0x1,%edx
  fb:	0f 84 3e 01 00 00    	je     23f <main+0x23f>
 101:	83 fa 02             	cmp    $0x2,%edx
 104:	75 bd                	jne    c3 <main+0xc3>
				printf(1, "I/O bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
 106:	8b 7d b8             	mov    -0x48(%ebp),%edi
 109:	8b 55 bc             	mov    -0x44(%ebp),%edx
 10c:	50                   	push   %eax
 10d:	8b 75 c0             	mov    -0x40(%ebp),%esi
 110:	8d 04 17             	lea    (%edi,%edx,1),%eax
 113:	01 f0                	add    %esi,%eax
 115:	50                   	push   %eax
 116:	56                   	push   %esi
 117:	52                   	push   %edx
 118:	57                   	push   %edi
 119:	51                   	push   %ecx
 11a:	68 b4 0a 00 00       	push   $0xab4
 11f:	6a 01                	push   $0x1
 121:	e8 7a 05 00 00       	call   6a0 <printf>
				record[2][0] += retime;
 126:	8b 45 b8             	mov    -0x48(%ebp),%eax
				break;
 129:	83 c4 20             	add    $0x20,%esp
				record[2][0] += retime;
 12c:	01 45 dc             	add    %eax,-0x24(%ebp)
				record[2][1] += rutime;
 12f:	8b 45 bc             	mov    -0x44(%ebp),%eax
 132:	01 45 e0             	add    %eax,-0x20(%ebp)
				record[2][2] += stime;
 135:	8b 45 c0             	mov    -0x40(%ebp),%eax
 138:	01 45 e4             	add    %eax,-0x1c(%ebp)
				break;
 13b:	eb 8e                	jmp    cb <main+0xcb>
				printf(1, "Usage: sanity [n]\n");
 13d:	50                   	push   %eax
 13e:	50                   	push   %eax
 13f:	68 08 0a 00 00       	push   $0xa08
 144:	6a 01                	push   $0x1
 146:	e8 55 05 00 00       	call   6a0 <printf>
				exit();
 14b:	e8 d3 03 00 00       	call   523 <exit>
 150:	8b 7d b4             	mov    -0x4c(%ebp),%edi
 153:	8d 4d c4             	lea    -0x3c(%ebp),%ecx
 156:	8d 5d e8             	lea    -0x18(%ebp),%ebx
			record[i][j] /= n;
 159:	8b 01                	mov    (%ecx),%eax
 15b:	83 c1 0c             	add    $0xc,%ecx
 15e:	99                   	cltd   
 15f:	f7 ff                	idiv   %edi
 161:	89 41 f4             	mov    %eax,-0xc(%ecx)
 164:	8b 41 f8             	mov    -0x8(%ecx),%eax
 167:	99                   	cltd   
 168:	f7 ff                	idiv   %edi
 16a:	89 41 f8             	mov    %eax,-0x8(%ecx)
 16d:	8b 41 fc             	mov    -0x4(%ecx),%eax
 170:	99                   	cltd   
 171:	f7 ff                	idiv   %edi
 173:	89 41 fc             	mov    %eax,-0x4(%ecx)
	for (i = 0; i < 3; i++)
 176:	39 d9                	cmp    %ebx,%ecx
 178:	75 df                	jne    159 <main+0x159>
	printf(1, "\n\nCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n\n",  record[0][2], record[0][0], record[0][0] + record[0][1] + record[0][2]);
 17a:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 17d:	8b 45 c8             	mov    -0x38(%ebp),%eax
 180:	83 ec 0c             	sub    $0xc,%esp
 183:	8b 55 cc             	mov    -0x34(%ebp),%edx
 186:	01 c8                	add    %ecx,%eax
 188:	01 d0                	add    %edx,%eax
 18a:	50                   	push   %eax
 18b:	51                   	push   %ecx
 18c:	52                   	push   %edx
 18d:	68 00 0b 00 00       	push   $0xb00
 192:	6a 01                	push   $0x1
 194:	e8 07 05 00 00       	call   6a0 <printf>
	printf(1, "SCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n\n", record[1][2], record[1][0],  record[1][0] + record[1][1] + record[1][2]);
 199:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 19c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 19f:	83 c4 14             	add    $0x14,%esp
 1a2:	8b 55 d8             	mov    -0x28(%ebp),%edx
 1a5:	01 c8                	add    %ecx,%eax
 1a7:	01 d0                	add    %edx,%eax
 1a9:	50                   	push   %eax
 1aa:	51                   	push   %ecx
 1ab:	52                   	push   %edx
 1ac:	68 64 0b 00 00       	push   $0xb64
 1b1:	6a 01                	push   $0x1
 1b3:	e8 e8 04 00 00       	call   6a0 <printf>
	printf(1, "I/O BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n\n", record[2][2], record[2][0],  record[2][0] + record[2][1] + record[2][2]);
 1b8:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 1bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1be:	83 c4 14             	add    $0x14,%esp
 1c1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 1c4:	01 c8                	add    %ecx,%eax
 1c6:	01 d0                	add    %edx,%eax
 1c8:	50                   	push   %eax
 1c9:	51                   	push   %ecx
 1ca:	52                   	push   %edx
 1cb:	68 c8 0b 00 00       	push   $0xbc8
 1d0:	6a 01                	push   $0x1
 1d2:	e8 c9 04 00 00       	call   6a0 <printf>
	exit();
 1d7:	83 c4 20             	add    $0x20,%esp
 1da:	e9 d1 fe ff ff       	jmp    b0 <main+0xb0>
			switch(j) {
 1df:	d9 ee                	fldz   
						for (double z = 0; z < 10000000.0; z+= 0.1){
 1e1:	dd 05 28 0c 00 00    	fldl   0xc28
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax
 1f0:	dc c1                	fadd   %st,%st(1)
 1f2:	d9 05 30 0c 00 00    	flds   0xc30
 1f8:	df f2                	fcomip %st(2),%st
 1fa:	77 f4                	ja     1f0 <main+0x1f0>
 1fc:	dd d8                	fstp   %st(0)
 1fe:	dd d8                	fstp   %st(0)
 200:	e9 ab fe ff ff       	jmp    b0 <main+0xb0>
			switch(j) {
 205:	bb 64 00 00 00       	mov    $0x64,%ebx
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
						sleep(1);
 210:	83 ec 0c             	sub    $0xc,%esp
 213:	6a 01                	push   $0x1
 215:	e8 99 03 00 00       	call   5b3 <sleep>
					for(k = 0; k < 100; k++){
 21a:	83 c4 10             	add    $0x10,%esp
 21d:	83 eb 01             	sub    $0x1,%ebx
 220:	75 ee                	jne    210 <main+0x210>
 222:	e9 89 fe ff ff       	jmp    b0 <main+0xb0>
			switch(j) {
 227:	bb 64 00 00 00       	mov    $0x64,%ebx
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
						sys_yield();
 230:	e8 ae 03 00 00       	call   5e3 <sys_yield>
					for (k = 0; k < 100; k++){
 235:	83 eb 01             	sub    $0x1,%ebx
 238:	75 f6                	jne    230 <main+0x230>
 23a:	e9 71 fe ff ff       	jmp    b0 <main+0xb0>
				printf(1, "SCPU bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
 23f:	8b 7d b8             	mov    -0x48(%ebp),%edi
 242:	8b 55 bc             	mov    -0x44(%ebp),%edx
 245:	50                   	push   %eax
 246:	8b 75 c0             	mov    -0x40(%ebp),%esi
 249:	8d 04 17             	lea    (%edi,%edx,1),%eax
 24c:	01 f0                	add    %esi,%eax
 24e:	50                   	push   %eax
 24f:	56                   	push   %esi
 250:	52                   	push   %edx
 251:	57                   	push   %edi
 252:	51                   	push   %ecx
 253:	68 68 0a 00 00       	push   $0xa68
 258:	6a 01                	push   $0x1
 25a:	e8 41 04 00 00       	call   6a0 <printf>
				record[1][0] += retime;
 25f:	8b 45 b8             	mov    -0x48(%ebp),%eax
				break;
 262:	83 c4 20             	add    $0x20,%esp
				record[1][0] += retime;
 265:	01 45 d0             	add    %eax,-0x30(%ebp)
				record[1][1] += rutime;
 268:	8b 45 bc             	mov    -0x44(%ebp),%eax
 26b:	01 45 d4             	add    %eax,-0x2c(%ebp)
				record[1][2] += stime;
 26e:	8b 45 c0             	mov    -0x40(%ebp),%eax
 271:	01 45 d8             	add    %eax,-0x28(%ebp)
				break;
 274:	e9 52 fe ff ff       	jmp    cb <main+0xcb>
				printf(1, "CPU-bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
 279:	8b 55 b8             	mov    -0x48(%ebp),%edx
 27c:	8b 7d bc             	mov    -0x44(%ebp),%edi
 27f:	50                   	push   %eax
 280:	8d 04 3a             	lea    (%edx,%edi,1),%eax
 283:	03 45 c0             	add    -0x40(%ebp),%eax
 286:	50                   	push   %eax
 287:	ff 75 c0             	pushl  -0x40(%ebp)
 28a:	57                   	push   %edi
 28b:	52                   	push   %edx
 28c:	51                   	push   %ecx
 28d:	68 1c 0a 00 00       	push   $0xa1c
 292:	6a 01                	push   $0x1
 294:	e8 07 04 00 00       	call   6a0 <printf>
				record[0][0] += retime;
 299:	03 75 b8             	add    -0x48(%ebp),%esi
				record[0][1] += rutime;
 29c:	8b 45 bc             	mov    -0x44(%ebp),%eax
				break;
 29f:	83 c4 20             	add    $0x20,%esp
				record[0][1] += rutime;
 2a2:	01 45 c8             	add    %eax,-0x38(%ebp)
				record[0][2] += stime;
 2a5:	8b 45 c0             	mov    -0x40(%ebp),%eax
				record[0][0] += retime;
 2a8:	89 75 c4             	mov    %esi,-0x3c(%ebp)
				record[0][2] += stime;
 2ab:	01 45 cc             	add    %eax,-0x34(%ebp)
				break;
 2ae:	e9 18 fe ff ff       	jmp    cb <main+0xcb>
 2b3:	66 90                	xchg   %ax,%ax
 2b5:	66 90                	xchg   %ax,%ax
 2b7:	66 90                	xchg   %ax,%ax
 2b9:	66 90                	xchg   %ax,%ax
 2bb:	66 90                	xchg   %ax,%ax
 2bd:	66 90                	xchg   %ax,%ax
 2bf:	90                   	nop

000002c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2c0:	f3 0f 1e fb          	endbr32 
 2c4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2c5:	31 c0                	xor    %eax,%eax
{
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	53                   	push   %ebx
 2ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2cd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 2d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 2d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 2d7:	83 c0 01             	add    $0x1,%eax
 2da:	84 d2                	test   %dl,%dl
 2dc:	75 f2                	jne    2d0 <strcpy+0x10>
    ;
  return os;
}
 2de:	89 c8                	mov    %ecx,%eax
 2e0:	5b                   	pop    %ebx
 2e1:	5d                   	pop    %ebp
 2e2:	c3                   	ret    
 2e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f0:	f3 0f 1e fb          	endbr32 
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	53                   	push   %ebx
 2f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 2fe:	0f b6 01             	movzbl (%ecx),%eax
 301:	0f b6 1a             	movzbl (%edx),%ebx
 304:	84 c0                	test   %al,%al
 306:	75 19                	jne    321 <strcmp+0x31>
 308:	eb 26                	jmp    330 <strcmp+0x40>
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 310:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 314:	83 c1 01             	add    $0x1,%ecx
 317:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 31a:	0f b6 1a             	movzbl (%edx),%ebx
 31d:	84 c0                	test   %al,%al
 31f:	74 0f                	je     330 <strcmp+0x40>
 321:	38 d8                	cmp    %bl,%al
 323:	74 eb                	je     310 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 325:	29 d8                	sub    %ebx,%eax
}
 327:	5b                   	pop    %ebx
 328:	5d                   	pop    %ebp
 329:	c3                   	ret    
 32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 330:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 332:	29 d8                	sub    %ebx,%eax
}
 334:	5b                   	pop    %ebx
 335:	5d                   	pop    %ebp
 336:	c3                   	ret    
 337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33e:	66 90                	xchg   %ax,%ax

00000340 <strlen>:

uint
strlen(const char *s)
{
 340:	f3 0f 1e fb          	endbr32 
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 34a:	80 3a 00             	cmpb   $0x0,(%edx)
 34d:	74 21                	je     370 <strlen+0x30>
 34f:	31 c0                	xor    %eax,%eax
 351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 358:	83 c0 01             	add    $0x1,%eax
 35b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 35f:	89 c1                	mov    %eax,%ecx
 361:	75 f5                	jne    358 <strlen+0x18>
    ;
  return n;
}
 363:	89 c8                	mov    %ecx,%eax
 365:	5d                   	pop    %ebp
 366:	c3                   	ret    
 367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 370:	31 c9                	xor    %ecx,%ecx
}
 372:	5d                   	pop    %ebp
 373:	89 c8                	mov    %ecx,%eax
 375:	c3                   	ret    
 376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37d:	8d 76 00             	lea    0x0(%esi),%esi

00000380 <memset>:

void*
memset(void *dst, int c, uint n)
{
 380:	f3 0f 1e fb          	endbr32 
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	57                   	push   %edi
 388:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 38b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 38e:	8b 45 0c             	mov    0xc(%ebp),%eax
 391:	89 d7                	mov    %edx,%edi
 393:	fc                   	cld    
 394:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 396:	89 d0                	mov    %edx,%eax
 398:	5f                   	pop    %edi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret    
 39b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 39f:	90                   	nop

000003a0 <strchr>:

char*
strchr(const char *s, char c)
{
 3a0:	f3 0f 1e fb          	endbr32 
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	8b 45 08             	mov    0x8(%ebp),%eax
 3aa:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3ae:	0f b6 10             	movzbl (%eax),%edx
 3b1:	84 d2                	test   %dl,%dl
 3b3:	75 16                	jne    3cb <strchr+0x2b>
 3b5:	eb 21                	jmp    3d8 <strchr+0x38>
 3b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3be:	66 90                	xchg   %ax,%ax
 3c0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 3c4:	83 c0 01             	add    $0x1,%eax
 3c7:	84 d2                	test   %dl,%dl
 3c9:	74 0d                	je     3d8 <strchr+0x38>
    if(*s == c)
 3cb:	38 d1                	cmp    %dl,%cl
 3cd:	75 f1                	jne    3c0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 3cf:	5d                   	pop    %ebp
 3d0:	c3                   	ret    
 3d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 3d8:	31 c0                	xor    %eax,%eax
}
 3da:	5d                   	pop    %ebp
 3db:	c3                   	ret    
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003e0 <gets>:

char*
gets(char *buf, int max)
{
 3e0:	f3 0f 1e fb          	endbr32 
 3e4:	55                   	push   %ebp
 3e5:	89 e5                	mov    %esp,%ebp
 3e7:	57                   	push   %edi
 3e8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e9:	31 f6                	xor    %esi,%esi
{
 3eb:	53                   	push   %ebx
 3ec:	89 f3                	mov    %esi,%ebx
 3ee:	83 ec 1c             	sub    $0x1c,%esp
 3f1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 3f4:	eb 33                	jmp    429 <gets+0x49>
 3f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 400:	83 ec 04             	sub    $0x4,%esp
 403:	8d 45 e7             	lea    -0x19(%ebp),%eax
 406:	6a 01                	push   $0x1
 408:	50                   	push   %eax
 409:	6a 00                	push   $0x0
 40b:	e8 2b 01 00 00       	call   53b <read>
    if(cc < 1)
 410:	83 c4 10             	add    $0x10,%esp
 413:	85 c0                	test   %eax,%eax
 415:	7e 1c                	jle    433 <gets+0x53>
      break;
    buf[i++] = c;
 417:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 41b:	83 c7 01             	add    $0x1,%edi
 41e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 421:	3c 0a                	cmp    $0xa,%al
 423:	74 23                	je     448 <gets+0x68>
 425:	3c 0d                	cmp    $0xd,%al
 427:	74 1f                	je     448 <gets+0x68>
  for(i=0; i+1 < max; ){
 429:	83 c3 01             	add    $0x1,%ebx
 42c:	89 fe                	mov    %edi,%esi
 42e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 431:	7c cd                	jl     400 <gets+0x20>
 433:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 435:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 438:	c6 03 00             	movb   $0x0,(%ebx)
}
 43b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43e:	5b                   	pop    %ebx
 43f:	5e                   	pop    %esi
 440:	5f                   	pop    %edi
 441:	5d                   	pop    %ebp
 442:	c3                   	ret    
 443:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 447:	90                   	nop
 448:	8b 75 08             	mov    0x8(%ebp),%esi
 44b:	8b 45 08             	mov    0x8(%ebp),%eax
 44e:	01 de                	add    %ebx,%esi
 450:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 452:	c6 03 00             	movb   $0x0,(%ebx)
}
 455:	8d 65 f4             	lea    -0xc(%ebp),%esp
 458:	5b                   	pop    %ebx
 459:	5e                   	pop    %esi
 45a:	5f                   	pop    %edi
 45b:	5d                   	pop    %ebp
 45c:	c3                   	ret    
 45d:	8d 76 00             	lea    0x0(%esi),%esi

00000460 <stat>:

int
stat(const char *n, struct stat *st)
{
 460:	f3 0f 1e fb          	endbr32 
 464:	55                   	push   %ebp
 465:	89 e5                	mov    %esp,%ebp
 467:	56                   	push   %esi
 468:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 469:	83 ec 08             	sub    $0x8,%esp
 46c:	6a 00                	push   $0x0
 46e:	ff 75 08             	pushl  0x8(%ebp)
 471:	e8 ed 00 00 00       	call   563 <open>
  if(fd < 0)
 476:	83 c4 10             	add    $0x10,%esp
 479:	85 c0                	test   %eax,%eax
 47b:	78 2b                	js     4a8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 47d:	83 ec 08             	sub    $0x8,%esp
 480:	ff 75 0c             	pushl  0xc(%ebp)
 483:	89 c3                	mov    %eax,%ebx
 485:	50                   	push   %eax
 486:	e8 f0 00 00 00       	call   57b <fstat>
  close(fd);
 48b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 48e:	89 c6                	mov    %eax,%esi
  close(fd);
 490:	e8 b6 00 00 00       	call   54b <close>
  return r;
 495:	83 c4 10             	add    $0x10,%esp
}
 498:	8d 65 f8             	lea    -0x8(%ebp),%esp
 49b:	89 f0                	mov    %esi,%eax
 49d:	5b                   	pop    %ebx
 49e:	5e                   	pop    %esi
 49f:	5d                   	pop    %ebp
 4a0:	c3                   	ret    
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 4a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4ad:	eb e9                	jmp    498 <stat+0x38>
 4af:	90                   	nop

000004b0 <atoi>:

int
atoi(const char *s)
{
 4b0:	f3 0f 1e fb          	endbr32 
 4b4:	55                   	push   %ebp
 4b5:	89 e5                	mov    %esp,%ebp
 4b7:	53                   	push   %ebx
 4b8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4bb:	0f be 02             	movsbl (%edx),%eax
 4be:	8d 48 d0             	lea    -0x30(%eax),%ecx
 4c1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 4c4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 4c9:	77 1a                	ja     4e5 <atoi+0x35>
 4cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4cf:	90                   	nop
    n = n*10 + *s++ - '0';
 4d0:	83 c2 01             	add    $0x1,%edx
 4d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 4d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 4da:	0f be 02             	movsbl (%edx),%eax
 4dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 4e0:	80 fb 09             	cmp    $0x9,%bl
 4e3:	76 eb                	jbe    4d0 <atoi+0x20>
  return n;
}
 4e5:	89 c8                	mov    %ecx,%eax
 4e7:	5b                   	pop    %ebx
 4e8:	5d                   	pop    %ebp
 4e9:	c3                   	ret    
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4f0:	f3 0f 1e fb          	endbr32 
 4f4:	55                   	push   %ebp
 4f5:	89 e5                	mov    %esp,%ebp
 4f7:	57                   	push   %edi
 4f8:	8b 45 10             	mov    0x10(%ebp),%eax
 4fb:	8b 55 08             	mov    0x8(%ebp),%edx
 4fe:	56                   	push   %esi
 4ff:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 502:	85 c0                	test   %eax,%eax
 504:	7e 0f                	jle    515 <memmove+0x25>
 506:	01 d0                	add    %edx,%eax
  dst = vdst;
 508:	89 d7                	mov    %edx,%edi
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 510:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 511:	39 f8                	cmp    %edi,%eax
 513:	75 fb                	jne    510 <memmove+0x20>
  return vdst;
}
 515:	5e                   	pop    %esi
 516:	89 d0                	mov    %edx,%eax
 518:	5f                   	pop    %edi
 519:	5d                   	pop    %ebp
 51a:	c3                   	ret    

0000051b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 51b:	b8 01 00 00 00       	mov    $0x1,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <exit>:
SYSCALL(exit)
 523:	b8 02 00 00 00       	mov    $0x2,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <wait>:
SYSCALL(wait)
 52b:	b8 03 00 00 00       	mov    $0x3,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <pipe>:
SYSCALL(pipe)
 533:	b8 04 00 00 00       	mov    $0x4,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <read>:
SYSCALL(read)
 53b:	b8 05 00 00 00       	mov    $0x5,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <write>:
SYSCALL(write)
 543:	b8 10 00 00 00       	mov    $0x10,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <close>:
SYSCALL(close)
 54b:	b8 15 00 00 00       	mov    $0x15,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <kill>:
SYSCALL(kill)
 553:	b8 06 00 00 00       	mov    $0x6,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <exec>:
SYSCALL(exec)
 55b:	b8 07 00 00 00       	mov    $0x7,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <open>:
SYSCALL(open)
 563:	b8 0f 00 00 00       	mov    $0xf,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <mknod>:
SYSCALL(mknod)
 56b:	b8 11 00 00 00       	mov    $0x11,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <unlink>:
SYSCALL(unlink)
 573:	b8 12 00 00 00       	mov    $0x12,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <fstat>:
SYSCALL(fstat)
 57b:	b8 08 00 00 00       	mov    $0x8,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <link>:
SYSCALL(link)
 583:	b8 13 00 00 00       	mov    $0x13,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <mkdir>:
SYSCALL(mkdir)
 58b:	b8 14 00 00 00       	mov    $0x14,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <chdir>:
SYSCALL(chdir)
 593:	b8 09 00 00 00       	mov    $0x9,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <dup>:
SYSCALL(dup)
 59b:	b8 0a 00 00 00       	mov    $0xa,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <getpid>:
SYSCALL(getpid)
 5a3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <sbrk>:
SYSCALL(sbrk)
 5ab:	b8 0c 00 00 00       	mov    $0xc,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <sleep>:
SYSCALL(sleep)
 5b3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <uptime>:
SYSCALL(uptime)
 5bb:	b8 0e 00 00 00       	mov    $0xe,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <trace>:
SYSCALL(trace)
 5c3:	b8 16 00 00 00       	mov    $0x16,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <cs>:
SYSCALL(cs)
 5cb:	b8 17 00 00 00       	mov    $0x17,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <set_tickets>:
SYSCALL(set_tickets)
 5d3:	b8 18 00 00 00       	mov    $0x18,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <wait2>:
SYSCALL(wait2)
 5db:	b8 19 00 00 00       	mov    $0x19,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <sys_yield>:
 5e3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    
 5eb:	66 90                	xchg   %ax,%ax
 5ed:	66 90                	xchg   %ax,%ax
 5ef:	90                   	nop

000005f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	83 ec 3c             	sub    $0x3c,%esp
 5f9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5fc:	89 d1                	mov    %edx,%ecx
{
 5fe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 601:	85 d2                	test   %edx,%edx
 603:	0f 89 7f 00 00 00    	jns    688 <printint+0x98>
 609:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 60d:	74 79                	je     688 <printint+0x98>
    neg = 1;
 60f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 616:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 618:	31 db                	xor    %ebx,%ebx
 61a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 61d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 620:	89 c8                	mov    %ecx,%eax
 622:	31 d2                	xor    %edx,%edx
 624:	89 cf                	mov    %ecx,%edi
 626:	f7 75 c4             	divl   -0x3c(%ebp)
 629:	0f b6 92 3c 0c 00 00 	movzbl 0xc3c(%edx),%edx
 630:	89 45 c0             	mov    %eax,-0x40(%ebp)
 633:	89 d8                	mov    %ebx,%eax
 635:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 638:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 63b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 63e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 641:	76 dd                	jbe    620 <printint+0x30>
  if(neg)
 643:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 646:	85 c9                	test   %ecx,%ecx
 648:	74 0c                	je     656 <printint+0x66>
    buf[i++] = '-';
 64a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 64f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 651:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 656:	8b 7d b8             	mov    -0x48(%ebp),%edi
 659:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 65d:	eb 07                	jmp    666 <printint+0x76>
 65f:	90                   	nop
 660:	0f b6 13             	movzbl (%ebx),%edx
 663:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 666:	83 ec 04             	sub    $0x4,%esp
 669:	88 55 d7             	mov    %dl,-0x29(%ebp)
 66c:	6a 01                	push   $0x1
 66e:	56                   	push   %esi
 66f:	57                   	push   %edi
 670:	e8 ce fe ff ff       	call   543 <write>
  while(--i >= 0)
 675:	83 c4 10             	add    $0x10,%esp
 678:	39 de                	cmp    %ebx,%esi
 67a:	75 e4                	jne    660 <printint+0x70>
    putc(fd, buf[i]);
}
 67c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 67f:	5b                   	pop    %ebx
 680:	5e                   	pop    %esi
 681:	5f                   	pop    %edi
 682:	5d                   	pop    %ebp
 683:	c3                   	ret    
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 688:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 68f:	eb 87                	jmp    618 <printint+0x28>
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop

000006a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6a0:	f3 0f 1e fb          	endbr32 
 6a4:	55                   	push   %ebp
 6a5:	89 e5                	mov    %esp,%ebp
 6a7:	57                   	push   %edi
 6a8:	56                   	push   %esi
 6a9:	53                   	push   %ebx
 6aa:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ad:	8b 75 0c             	mov    0xc(%ebp),%esi
 6b0:	0f b6 1e             	movzbl (%esi),%ebx
 6b3:	84 db                	test   %bl,%bl
 6b5:	0f 84 b4 00 00 00    	je     76f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 6bb:	8d 45 10             	lea    0x10(%ebp),%eax
 6be:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 6c1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 6c4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 6c6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6c9:	eb 33                	jmp    6fe <printf+0x5e>
 6cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6cf:	90                   	nop
 6d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 6d3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 6d8:	83 f8 25             	cmp    $0x25,%eax
 6db:	74 17                	je     6f4 <printf+0x54>
  write(fd, &c, 1);
 6dd:	83 ec 04             	sub    $0x4,%esp
 6e0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6e3:	6a 01                	push   $0x1
 6e5:	57                   	push   %edi
 6e6:	ff 75 08             	pushl  0x8(%ebp)
 6e9:	e8 55 fe ff ff       	call   543 <write>
 6ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 6f1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 6f4:	0f b6 1e             	movzbl (%esi),%ebx
 6f7:	83 c6 01             	add    $0x1,%esi
 6fa:	84 db                	test   %bl,%bl
 6fc:	74 71                	je     76f <printf+0xcf>
    c = fmt[i] & 0xff;
 6fe:	0f be cb             	movsbl %bl,%ecx
 701:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 704:	85 d2                	test   %edx,%edx
 706:	74 c8                	je     6d0 <printf+0x30>
      }
    } else if(state == '%'){
 708:	83 fa 25             	cmp    $0x25,%edx
 70b:	75 e7                	jne    6f4 <printf+0x54>
      if(c == 'd'){
 70d:	83 f8 64             	cmp    $0x64,%eax
 710:	0f 84 9a 00 00 00    	je     7b0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 716:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 71c:	83 f9 70             	cmp    $0x70,%ecx
 71f:	74 5f                	je     780 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 721:	83 f8 73             	cmp    $0x73,%eax
 724:	0f 84 d6 00 00 00    	je     800 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 72a:	83 f8 63             	cmp    $0x63,%eax
 72d:	0f 84 8d 00 00 00    	je     7c0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 733:	83 f8 25             	cmp    $0x25,%eax
 736:	0f 84 b4 00 00 00    	je     7f0 <printf+0x150>
  write(fd, &c, 1);
 73c:	83 ec 04             	sub    $0x4,%esp
 73f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 743:	6a 01                	push   $0x1
 745:	57                   	push   %edi
 746:	ff 75 08             	pushl  0x8(%ebp)
 749:	e8 f5 fd ff ff       	call   543 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 74e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 751:	83 c4 0c             	add    $0xc,%esp
 754:	6a 01                	push   $0x1
 756:	83 c6 01             	add    $0x1,%esi
 759:	57                   	push   %edi
 75a:	ff 75 08             	pushl  0x8(%ebp)
 75d:	e8 e1 fd ff ff       	call   543 <write>
  for(i = 0; fmt[i]; i++){
 762:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 766:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 769:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 76b:	84 db                	test   %bl,%bl
 76d:	75 8f                	jne    6fe <printf+0x5e>
    }
  }
}
 76f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 772:	5b                   	pop    %ebx
 773:	5e                   	pop    %esi
 774:	5f                   	pop    %edi
 775:	5d                   	pop    %ebp
 776:	c3                   	ret    
 777:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 780:	83 ec 0c             	sub    $0xc,%esp
 783:	b9 10 00 00 00       	mov    $0x10,%ecx
 788:	6a 00                	push   $0x0
 78a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 78d:	8b 45 08             	mov    0x8(%ebp),%eax
 790:	8b 13                	mov    (%ebx),%edx
 792:	e8 59 fe ff ff       	call   5f0 <printint>
        ap++;
 797:	89 d8                	mov    %ebx,%eax
 799:	83 c4 10             	add    $0x10,%esp
      state = 0;
 79c:	31 d2                	xor    %edx,%edx
        ap++;
 79e:	83 c0 04             	add    $0x4,%eax
 7a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7a4:	e9 4b ff ff ff       	jmp    6f4 <printf+0x54>
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 7b0:	83 ec 0c             	sub    $0xc,%esp
 7b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7b8:	6a 01                	push   $0x1
 7ba:	eb ce                	jmp    78a <printf+0xea>
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 7c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 7c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 7c6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 7c8:	6a 01                	push   $0x1
        ap++;
 7ca:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 7cd:	57                   	push   %edi
 7ce:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 7d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7d4:	e8 6a fd ff ff       	call   543 <write>
        ap++;
 7d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 7dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7df:	31 d2                	xor    %edx,%edx
 7e1:	e9 0e ff ff ff       	jmp    6f4 <printf+0x54>
 7e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 7f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 7f3:	83 ec 04             	sub    $0x4,%esp
 7f6:	e9 59 ff ff ff       	jmp    754 <printf+0xb4>
 7fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7ff:	90                   	nop
        s = (char*)*ap;
 800:	8b 45 d0             	mov    -0x30(%ebp),%eax
 803:	8b 18                	mov    (%eax),%ebx
        ap++;
 805:	83 c0 04             	add    $0x4,%eax
 808:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 80b:	85 db                	test   %ebx,%ebx
 80d:	74 17                	je     826 <printf+0x186>
        while(*s != 0){
 80f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 812:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 814:	84 c0                	test   %al,%al
 816:	0f 84 d8 fe ff ff    	je     6f4 <printf+0x54>
 81c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 81f:	89 de                	mov    %ebx,%esi
 821:	8b 5d 08             	mov    0x8(%ebp),%ebx
 824:	eb 1a                	jmp    840 <printf+0x1a0>
          s = "(null)";
 826:	bb 34 0c 00 00       	mov    $0xc34,%ebx
        while(*s != 0){
 82b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 82e:	b8 28 00 00 00       	mov    $0x28,%eax
 833:	89 de                	mov    %ebx,%esi
 835:	8b 5d 08             	mov    0x8(%ebp),%ebx
 838:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83f:	90                   	nop
  write(fd, &c, 1);
 840:	83 ec 04             	sub    $0x4,%esp
          s++;
 843:	83 c6 01             	add    $0x1,%esi
 846:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 849:	6a 01                	push   $0x1
 84b:	57                   	push   %edi
 84c:	53                   	push   %ebx
 84d:	e8 f1 fc ff ff       	call   543 <write>
        while(*s != 0){
 852:	0f b6 06             	movzbl (%esi),%eax
 855:	83 c4 10             	add    $0x10,%esp
 858:	84 c0                	test   %al,%al
 85a:	75 e4                	jne    840 <printf+0x1a0>
 85c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 85f:	31 d2                	xor    %edx,%edx
 861:	e9 8e fe ff ff       	jmp    6f4 <printf+0x54>
 866:	66 90                	xchg   %ax,%ax
 868:	66 90                	xchg   %ax,%ax
 86a:	66 90                	xchg   %ax,%ax
 86c:	66 90                	xchg   %ax,%ax
 86e:	66 90                	xchg   %ax,%ax

00000870 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 870:	f3 0f 1e fb          	endbr32 
 874:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 875:	a1 f0 0e 00 00       	mov    0xef0,%eax
{
 87a:	89 e5                	mov    %esp,%ebp
 87c:	57                   	push   %edi
 87d:	56                   	push   %esi
 87e:	53                   	push   %ebx
 87f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 882:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 884:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 887:	39 c8                	cmp    %ecx,%eax
 889:	73 15                	jae    8a0 <free+0x30>
 88b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 88f:	90                   	nop
 890:	39 d1                	cmp    %edx,%ecx
 892:	72 14                	jb     8a8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 894:	39 d0                	cmp    %edx,%eax
 896:	73 10                	jae    8a8 <free+0x38>
{
 898:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89a:	8b 10                	mov    (%eax),%edx
 89c:	39 c8                	cmp    %ecx,%eax
 89e:	72 f0                	jb     890 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a0:	39 d0                	cmp    %edx,%eax
 8a2:	72 f4                	jb     898 <free+0x28>
 8a4:	39 d1                	cmp    %edx,%ecx
 8a6:	73 f0                	jae    898 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8ae:	39 fa                	cmp    %edi,%edx
 8b0:	74 1e                	je     8d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8b2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8b5:	8b 50 04             	mov    0x4(%eax),%edx
 8b8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8bb:	39 f1                	cmp    %esi,%ecx
 8bd:	74 28                	je     8e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8bf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 8c1:	5b                   	pop    %ebx
  freep = p;
 8c2:	a3 f0 0e 00 00       	mov    %eax,0xef0
}
 8c7:	5e                   	pop    %esi
 8c8:	5f                   	pop    %edi
 8c9:	5d                   	pop    %ebp
 8ca:	c3                   	ret    
 8cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8cf:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 8d0:	03 72 04             	add    0x4(%edx),%esi
 8d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8d6:	8b 10                	mov    (%eax),%edx
 8d8:	8b 12                	mov    (%edx),%edx
 8da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8dd:	8b 50 04             	mov    0x4(%eax),%edx
 8e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8e3:	39 f1                	cmp    %esi,%ecx
 8e5:	75 d8                	jne    8bf <free+0x4f>
    p->s.size += bp->s.size;
 8e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 8ea:	a3 f0 0e 00 00       	mov    %eax,0xef0
    p->s.size += bp->s.size;
 8ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8f5:	89 10                	mov    %edx,(%eax)
}
 8f7:	5b                   	pop    %ebx
 8f8:	5e                   	pop    %esi
 8f9:	5f                   	pop    %edi
 8fa:	5d                   	pop    %ebp
 8fb:	c3                   	ret    
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000900 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 900:	f3 0f 1e fb          	endbr32 
 904:	55                   	push   %ebp
 905:	89 e5                	mov    %esp,%ebp
 907:	57                   	push   %edi
 908:	56                   	push   %esi
 909:	53                   	push   %ebx
 90a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 90d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 910:	8b 3d f0 0e 00 00    	mov    0xef0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 916:	8d 70 07             	lea    0x7(%eax),%esi
 919:	c1 ee 03             	shr    $0x3,%esi
 91c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 91f:	85 ff                	test   %edi,%edi
 921:	0f 84 a9 00 00 00    	je     9d0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 927:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 929:	8b 48 04             	mov    0x4(%eax),%ecx
 92c:	39 f1                	cmp    %esi,%ecx
 92e:	73 6d                	jae    99d <malloc+0x9d>
 930:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 936:	bb 00 10 00 00       	mov    $0x1000,%ebx
 93b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 93e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 945:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 948:	eb 17                	jmp    961 <malloc+0x61>
 94a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 950:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 952:	8b 4a 04             	mov    0x4(%edx),%ecx
 955:	39 f1                	cmp    %esi,%ecx
 957:	73 4f                	jae    9a8 <malloc+0xa8>
 959:	8b 3d f0 0e 00 00    	mov    0xef0,%edi
 95f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 961:	39 c7                	cmp    %eax,%edi
 963:	75 eb                	jne    950 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 965:	83 ec 0c             	sub    $0xc,%esp
 968:	ff 75 e4             	pushl  -0x1c(%ebp)
 96b:	e8 3b fc ff ff       	call   5ab <sbrk>
  if(p == (char*)-1)
 970:	83 c4 10             	add    $0x10,%esp
 973:	83 f8 ff             	cmp    $0xffffffff,%eax
 976:	74 1b                	je     993 <malloc+0x93>
  hp->s.size = nu;
 978:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 97b:	83 ec 0c             	sub    $0xc,%esp
 97e:	83 c0 08             	add    $0x8,%eax
 981:	50                   	push   %eax
 982:	e8 e9 fe ff ff       	call   870 <free>
  return freep;
 987:	a1 f0 0e 00 00       	mov    0xef0,%eax
      if((p = morecore(nunits)) == 0)
 98c:	83 c4 10             	add    $0x10,%esp
 98f:	85 c0                	test   %eax,%eax
 991:	75 bd                	jne    950 <malloc+0x50>
        return 0;
  }
}
 993:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 996:	31 c0                	xor    %eax,%eax
}
 998:	5b                   	pop    %ebx
 999:	5e                   	pop    %esi
 99a:	5f                   	pop    %edi
 99b:	5d                   	pop    %ebp
 99c:	c3                   	ret    
    if(p->s.size >= nunits){
 99d:	89 c2                	mov    %eax,%edx
 99f:	89 f8                	mov    %edi,%eax
 9a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 9a8:	39 ce                	cmp    %ecx,%esi
 9aa:	74 54                	je     a00 <malloc+0x100>
        p->s.size -= nunits;
 9ac:	29 f1                	sub    %esi,%ecx
 9ae:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 9b1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 9b4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 9b7:	a3 f0 0e 00 00       	mov    %eax,0xef0
}
 9bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9bf:	8d 42 08             	lea    0x8(%edx),%eax
}
 9c2:	5b                   	pop    %ebx
 9c3:	5e                   	pop    %esi
 9c4:	5f                   	pop    %edi
 9c5:	5d                   	pop    %ebp
 9c6:	c3                   	ret    
 9c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9ce:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 9d0:	c7 05 f0 0e 00 00 f4 	movl   $0xef4,0xef0
 9d7:	0e 00 00 
    base.s.size = 0;
 9da:	bf f4 0e 00 00       	mov    $0xef4,%edi
    base.s.ptr = freep = prevp = &base;
 9df:	c7 05 f4 0e 00 00 f4 	movl   $0xef4,0xef4
 9e6:	0e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 9eb:	c7 05 f8 0e 00 00 00 	movl   $0x0,0xef8
 9f2:	00 00 00 
    if(p->s.size >= nunits){
 9f5:	e9 36 ff ff ff       	jmp    930 <malloc+0x30>
 9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 a00:	8b 0a                	mov    (%edx),%ecx
 a02:	89 08                	mov    %ecx,(%eax)
 a04:	eb b1                	jmp    9b7 <malloc+0xb7>
