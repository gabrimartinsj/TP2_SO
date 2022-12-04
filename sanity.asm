
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 38             	sub    $0x38,%esp
	if (argc != 2){
  14:	83 39 02             	cmpl   $0x2,(%ecx)
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  17:	8b 41 04             	mov    0x4(%ecx),%eax
	if (argc != 2){
  1a:	74 13                	je     2f <main+0x2f>
				printf(1, "Usage: sanity [n]\n");
  1c:	50                   	push   %eax
  1d:	50                   	push   %eax
  1e:	68 90 09 00 00       	push   $0x990
  23:	6a 01                	push   $0x1
  25:	e8 46 06 00 00       	call   670 <printf>
				exit();
  2a:	e8 c3 04 00 00       	call   4f2 <exit>

	for (i = 0; i < 3; i++)
		for (j = 0; j < 3; j++)
			record[i][j] = 0;

	n = atoi(argv[1]);
  2f:	83 ec 0c             	sub    $0xc,%esp
  32:	ff 70 04             	pushl  0x4(%eax)
	int stime;
	int record[3][3];

	for (i = 0; i < 3; i++)
		for (j = 0; j < 3; j++)
			record[i][j] = 0;
  35:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
  3c:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  43:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  4a:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  51:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  58:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  5f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  66:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  6d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	n = atoi(argv[1]);
  74:	e8 07 04 00 00       	call   480 <atoi>
	n = n*3;
  79:	8d 1c 40             	lea    (%eax,%eax,2),%ebx
	int pid;

	for (i = 0; i < n; i++){
  7c:	83 c4 10             	add    $0x10,%esp
  7f:	85 db                	test   %ebx,%ebx
  81:	0f 8e 57 01 00 00    	jle    1de <main+0x1de>
  87:	31 f6                	xor    %esi,%esi
		j = i % 3;
		pid = fork();
  89:	e8 5c 04 00 00       	call   4ea <fork>
		if (pid == 0) {//child
  8e:	85 c0                	test   %eax,%eax
  90:	0f 84 c9 00 00 00    	je     15f <main+0x15f>

	n = atoi(argv[1]);
	n = n*3;
	int pid;

	for (i = 0; i < n; i++){
  96:	83 c6 01             	add    $0x1,%esi
  99:	39 f3                	cmp    %esi,%ebx
  9b:	75 ec                	jne    89 <main+0x89>
  9d:	31 ff                	xor    %edi,%edi
	}

	for (i = 0; i < n; i++){
		pid = wait2(&retime, &rutime, &stime);
		int res = (pid - 4) % 3; // correlates to j in the dispatching loop
		switch(res) {
  9f:	89 de                	mov    %ebx,%esi
  a1:	eb 4d                	jmp    f0 <main+0xf0>
  a3:	83 fb 02             	cmp    $0x2,%ebx
  a6:	0f 84 be 01 00 00    	je     26a <main+0x26a>
  ac:	85 db                	test   %ebx,%ebx
  ae:	75 35                	jne    e5 <main+0xe5>
			case 0: // CPU bound processes
				printf(1, "CPU-bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
  b0:	8b 55 b8             	mov    -0x48(%ebp),%edx
  b3:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  b6:	50                   	push   %eax
  b7:	8d 04 1a             	lea    (%edx,%ebx,1),%eax
  ba:	03 45 c0             	add    -0x40(%ebp),%eax
  bd:	50                   	push   %eax
  be:	ff 75 c0             	pushl  -0x40(%ebp)
  c1:	53                   	push   %ebx
  c2:	52                   	push   %edx
  c3:	51                   	push   %ecx
  c4:	68 a4 09 00 00       	push   $0x9a4
  c9:	6a 01                	push   $0x1
  cb:	e8 a0 05 00 00       	call   670 <printf>
				record[0][0] += retime;
  d0:	8b 45 b8             	mov    -0x48(%ebp),%eax
  d3:	01 45 c4             	add    %eax,-0x3c(%ebp)
				record[0][1] += rutime;
				record[0][2] += stime;
				break;
  d6:	83 c4 20             	add    $0x20,%esp
		int res = (pid - 4) % 3; // correlates to j in the dispatching loop
		switch(res) {
			case 0: // CPU bound processes
				printf(1, "CPU-bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
				record[0][0] += retime;
				record[0][1] += rutime;
  d9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  dc:	01 45 c8             	add    %eax,-0x38(%ebp)
				record[0][2] += stime;
  df:	8b 45 c0             	mov    -0x40(%ebp),%eax
  e2:	01 45 cc             	add    %eax,-0x34(%ebp)
			exit(); // children exit here
		}
		continue; // father continues to spawn the next child
	}

	for (i = 0; i < n; i++){
  e5:	83 c7 01             	add    $0x1,%edi
  e8:	39 fe                	cmp    %edi,%esi
  ea:	0f 84 ec 00 00 00    	je     1dc <main+0x1dc>
		pid = wait2(&retime, &rutime, &stime);
  f0:	8d 45 c0             	lea    -0x40(%ebp),%eax
  f3:	83 ec 04             	sub    $0x4,%esp
  f6:	50                   	push   %eax
  f7:	8d 45 bc             	lea    -0x44(%ebp),%eax
  fa:	50                   	push   %eax
  fb:	8d 45 b8             	lea    -0x48(%ebp),%eax
  fe:	50                   	push   %eax
  ff:	e8 ae 04 00 00       	call   5b2 <wait2>
		int res = (pid - 4) % 3; // correlates to j in the dispatching loop
		switch(res) {
 104:	8d 58 fc             	lea    -0x4(%eax),%ebx
		}
		continue; // father continues to spawn the next child
	}

	for (i = 0; i < n; i++){
		pid = wait2(&retime, &rutime, &stime);
 107:	89 c1                	mov    %eax,%ecx
		int res = (pid - 4) % 3; // correlates to j in the dispatching loop
		switch(res) {
 109:	b8 56 55 55 55       	mov    $0x55555556,%eax
 10e:	83 c4 10             	add    $0x10,%esp
 111:	f7 eb                	imul   %ebx
 113:	89 d8                	mov    %ebx,%eax
 115:	c1 f8 1f             	sar    $0x1f,%eax
 118:	29 c2                	sub    %eax,%edx
 11a:	8d 04 52             	lea    (%edx,%edx,2),%eax
 11d:	29 c3                	sub    %eax,%ebx
 11f:	83 fb 01             	cmp    $0x1,%ebx
 122:	0f 85 7b ff ff ff    	jne    a3 <main+0xa3>
				record[0][0] += retime;
				record[0][1] += rutime;
				record[0][2] += stime;
				break;
			case 1: // CPU bound processes, short tasks
				printf(1, "SCPU bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
 128:	8b 55 b8             	mov    -0x48(%ebp),%edx
 12b:	8b 5d bc             	mov    -0x44(%ebp),%ebx
 12e:	50                   	push   %eax
 12f:	8d 04 1a             	lea    (%edx,%ebx,1),%eax
 132:	03 45 c0             	add    -0x40(%ebp),%eax
 135:	50                   	push   %eax
 136:	ff 75 c0             	pushl  -0x40(%ebp)
 139:	53                   	push   %ebx
 13a:	52                   	push   %edx
 13b:	51                   	push   %ecx
 13c:	68 f0 09 00 00       	push   $0x9f0
 141:	6a 01                	push   $0x1
 143:	e8 28 05 00 00       	call   670 <printf>
				record[1][0] += retime;
 148:	8b 45 b8             	mov    -0x48(%ebp),%eax
				record[1][1] += rutime;
				record[1][2] += stime;
				break;
 14b:	83 c4 20             	add    $0x20,%esp
				record[0][1] += rutime;
				record[0][2] += stime;
				break;
			case 1: // CPU bound processes, short tasks
				printf(1, "SCPU bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
				record[1][0] += retime;
 14e:	01 45 d0             	add    %eax,-0x30(%ebp)
				record[1][1] += rutime;
 151:	8b 45 bc             	mov    -0x44(%ebp),%eax
 154:	01 45 d4             	add    %eax,-0x2c(%ebp)
				record[1][2] += stime;
 157:	8b 45 c0             	mov    -0x40(%ebp),%eax
 15a:	01 45 d8             	add    %eax,-0x28(%ebp)
				break;
 15d:	eb 86                	jmp    e5 <main+0xe5>

	for (i = 0; i < n; i++){
		j = i % 3;
		pid = fork();
		if (pid == 0) {//child
			j = (getpid() - 4) % 3; // ensures independence from the first son's pid when gathering the results in the second part of the program
 15f:	e8 0e 04 00 00       	call   572 <getpid>
			switch(j){
 164:	83 e8 04             	sub    $0x4,%eax
 167:	b9 03 00 00 00       	mov    $0x3,%ecx
 16c:	99                   	cltd   
 16d:	f7 f9                	idiv   %ecx
 16f:	83 fa 01             	cmp    $0x1,%edx
 172:	74 50                	je     1c4 <main+0x1c4>
 174:	83 fa 02             	cmp    $0x2,%edx
 177:	74 29                	je     1a2 <main+0x1a2>
 179:	85 d2                	test   %edx,%edx
 17b:	74 05                	je     182 <main+0x182>

	printf(1, "\nCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n",  record[0][2], record[0][0], record[0][0] + record[0][1] + record[0][2]);
	printf(1, "SCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n", record[1][2], record[1][0],  record[1][0] + record[1][1] + record[1][2]);
	printf(1, "I/O BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n", record[2][2], record[2][0],  record[2][0] + record[2][1] + record[2][2]);

	exit();
 17d:	e8 70 03 00 00       	call   4f2 <exit>
	for (i = 0; i < n; i++){
		j = i % 3;
		pid = fork();
		if (pid == 0) {//child
			j = (getpid() - 4) % 3; // ensures independence from the first son's pid when gathering the results in the second part of the program
			switch(j){
 182:	d9 ee                	fldz   
				case 0: //CPU‐bound process (CPU):
						for (double z = 0; z < 10000000.0; z+= 0.1){
 184:	dd 05 a8 0b 00 00    	fldl   0xba8
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 190:	dc c1                	fadd   %st,%st(1)
 192:	d9 05 b0 0b 00 00    	flds   0xbb0
 198:	df ea                	fucomip %st(2),%st
 19a:	77 f4                	ja     190 <main+0x190>
 19c:	dd d8                	fstp   %st(0)
 19e:	dd d8                	fstp   %st(0)
 1a0:	eb db                	jmp    17d <main+0x17d>
	for (i = 0; i < n; i++){
		j = i % 3;
		pid = fork();
		if (pid == 0) {//child
			j = (getpid() - 4) % 3; // ensures independence from the first son's pid when gathering the results in the second part of the program
			switch(j){
 1a2:	bb 64 00 00 00       	mov    $0x64,%ebx
 1a7:	89 f6                	mov    %esi,%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
						sys_yield();
					}
					break;
				case 2:// simulate I/O bound process (IO)
					for(k = 0; k < 100; k++){
						sleep(1);
 1b0:	83 ec 0c             	sub    $0xc,%esp
 1b3:	6a 01                	push   $0x1
 1b5:	e8 c8 03 00 00       	call   582 <sleep>
						for (j = 0; j < 1000000; j++){}
						sys_yield();
					}
					break;
				case 2:// simulate I/O bound process (IO)
					for(k = 0; k < 100; k++){
 1ba:	83 c4 10             	add    $0x10,%esp
 1bd:	83 eb 01             	sub    $0x1,%ebx
 1c0:	75 ee                	jne    1b0 <main+0x1b0>
 1c2:	eb b9                	jmp    17d <main+0x17d>
	for (i = 0; i < n; i++){
		j = i % 3;
		pid = fork();
		if (pid == 0) {//child
			j = (getpid() - 4) % 3; // ensures independence from the first son's pid when gathering the results in the second part of the program
			switch(j){
 1c4:	bb 64 00 00 00       	mov    $0x64,%ebx
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
					}
					break;
				case 1: //short tasks based CPU‐bound process (S‐CPU):
					for (k = 0; k < 100; k++){
						for (j = 0; j < 1000000; j++){}
						sys_yield();
 1d0:	e8 e5 03 00 00       	call   5ba <sys_yield>
						for (double z = 0; z < 10000000.0; z+= 0.1){
				         double x =  x + 3.14 * 89.64;   // useless calculations to consume CPU time
					}
					break;
				case 1: //short tasks based CPU‐bound process (S‐CPU):
					for (k = 0; k < 100; k++){
 1d5:	83 eb 01             	sub    $0x1,%ebx
 1d8:	75 f6                	jne    1d0 <main+0x1d0>
 1da:	eb a1                	jmp    17d <main+0x17d>
 1dc:	89 f3                	mov    %esi,%ebx
 1de:	8d 4d c4             	lea    -0x3c(%ebp),%ecx
 1e1:	8d 75 e8             	lea    -0x18(%ebp),%esi
		}
	}

	for (i = 0; i < 3; i++)
		for (j = 0; j < 3; j++)
			record[i][j] /= n;
 1e4:	8b 01                	mov    (%ecx),%eax
 1e6:	83 c1 0c             	add    $0xc,%ecx
 1e9:	99                   	cltd   
 1ea:	f7 fb                	idiv   %ebx
 1ec:	89 41 f4             	mov    %eax,-0xc(%ecx)
 1ef:	8b 41 f8             	mov    -0x8(%ecx),%eax
 1f2:	99                   	cltd   
 1f3:	f7 fb                	idiv   %ebx
 1f5:	89 41 f8             	mov    %eax,-0x8(%ecx)
 1f8:	8b 41 fc             	mov    -0x4(%ecx),%eax
 1fb:	99                   	cltd   
 1fc:	f7 fb                	idiv   %ebx
 1fe:	89 41 fc             	mov    %eax,-0x4(%ecx)
				record[2][2] += stime;
				break;
		}
	}

	for (i = 0; i < 3; i++)
 201:	39 f1                	cmp    %esi,%ecx
 203:	75 df                	jne    1e4 <main+0x1e4>
		for (j = 0; j < 3; j++)
			record[i][j] /= n;

	printf(1, "\nCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n",  record[0][2], record[0][0], record[0][0] + record[0][1] + record[0][2]);
 205:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 208:	8b 45 c8             	mov    -0x38(%ebp),%eax
 20b:	83 ec 0c             	sub    $0xc,%esp
 20e:	8b 55 cc             	mov    -0x34(%ebp),%edx
 211:	01 c8                	add    %ecx,%eax
 213:	01 d0                	add    %edx,%eax
 215:	50                   	push   %eax
 216:	51                   	push   %ecx
 217:	52                   	push   %edx
 218:	68 88 0a 00 00       	push   $0xa88
 21d:	6a 01                	push   $0x1
 21f:	e8 4c 04 00 00       	call   670 <printf>
	printf(1, "SCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n", record[1][2], record[1][0],  record[1][0] + record[1][1] + record[1][2]);
 224:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 227:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 22a:	83 c4 14             	add    $0x14,%esp
 22d:	8b 55 d8             	mov    -0x28(%ebp),%edx
 230:	01 c8                	add    %ecx,%eax
 232:	01 d0                	add    %edx,%eax
 234:	50                   	push   %eax
 235:	51                   	push   %ecx
 236:	52                   	push   %edx
 237:	68 e8 0a 00 00       	push   $0xae8
 23c:	6a 01                	push   $0x1
 23e:	e8 2d 04 00 00       	call   670 <printf>
	printf(1, "I/O BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n", record[2][2], record[2][0],  record[2][0] + record[2][1] + record[2][2]);
 243:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 246:	8b 45 e0             	mov    -0x20(%ebp),%eax
 249:	83 c4 14             	add    $0x14,%esp
 24c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 24f:	01 c8                	add    %ecx,%eax
 251:	01 d0                	add    %edx,%eax
 253:	50                   	push   %eax
 254:	51                   	push   %ecx
 255:	52                   	push   %edx
 256:	68 48 0b 00 00       	push   $0xb48
 25b:	6a 01                	push   $0x1
 25d:	e8 0e 04 00 00       	call   670 <printf>

	exit();
 262:	83 c4 20             	add    $0x20,%esp
 265:	e9 13 ff ff ff       	jmp    17d <main+0x17d>
				record[1][0] += retime;
				record[1][1] += rutime;
				record[1][2] += stime;
				break;
			case 2: // simulating I/O bound processes
				printf(1, "I/O bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
 26a:	8b 55 b8             	mov    -0x48(%ebp),%edx
 26d:	8b 5d bc             	mov    -0x44(%ebp),%ebx
 270:	50                   	push   %eax
 271:	8d 04 1a             	lea    (%edx,%ebx,1),%eax
 274:	03 45 c0             	add    -0x40(%ebp),%eax
 277:	50                   	push   %eax
 278:	ff 75 c0             	pushl  -0x40(%ebp)
 27b:	53                   	push   %ebx
 27c:	52                   	push   %edx
 27d:	51                   	push   %ecx
 27e:	68 3c 0a 00 00       	push   $0xa3c
 283:	6a 01                	push   $0x1
 285:	e8 e6 03 00 00       	call   670 <printf>
				record[2][0] += retime;
 28a:	8b 45 b8             	mov    -0x48(%ebp),%eax
				record[2][1] += rutime;
				record[2][2] += stime;
				break;
 28d:	83 c4 20             	add    $0x20,%esp
				record[1][1] += rutime;
				record[1][2] += stime;
				break;
			case 2: // simulating I/O bound processes
				printf(1, "I/O bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
				record[2][0] += retime;
 290:	01 45 dc             	add    %eax,-0x24(%ebp)
				record[2][1] += rutime;
 293:	8b 45 bc             	mov    -0x44(%ebp),%eax
 296:	01 45 e0             	add    %eax,-0x20(%ebp)
				record[2][2] += stime;
 299:	8b 45 c0             	mov    -0x40(%ebp),%eax
 29c:	01 45 e4             	add    %eax,-0x1c(%ebp)
				break;
 29f:	e9 41 fe ff ff       	jmp    e5 <main+0xe5>
 2a4:	66 90                	xchg   %ax,%ax
 2a6:	66 90                	xchg   %ax,%ax
 2a8:	66 90                	xchg   %ax,%ax
 2aa:	66 90                	xchg   %ax,%ax
 2ac:	66 90                	xchg   %ax,%ax
 2ae:	66 90                	xchg   %ax,%ax

000002b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ba:	89 c2                	mov    %eax,%edx
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c0:	83 c1 01             	add    $0x1,%ecx
 2c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2c7:	83 c2 01             	add    $0x1,%edx
 2ca:	84 db                	test   %bl,%bl
 2cc:	88 5a ff             	mov    %bl,-0x1(%edx)
 2cf:	75 ef                	jne    2c0 <strcpy+0x10>
    ;
  return os;
}
 2d1:	5b                   	pop    %ebx
 2d2:	5d                   	pop    %ebp
 2d3:	c3                   	ret    
 2d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	56                   	push   %esi
 2e4:	53                   	push   %ebx
 2e5:	8b 55 08             	mov    0x8(%ebp),%edx
 2e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2eb:	0f b6 02             	movzbl (%edx),%eax
 2ee:	0f b6 19             	movzbl (%ecx),%ebx
 2f1:	84 c0                	test   %al,%al
 2f3:	75 1e                	jne    313 <strcmp+0x33>
 2f5:	eb 29                	jmp    320 <strcmp+0x40>
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 300:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 303:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 306:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 309:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 30d:	84 c0                	test   %al,%al
 30f:	74 0f                	je     320 <strcmp+0x40>
 311:	89 f1                	mov    %esi,%ecx
 313:	38 d8                	cmp    %bl,%al
 315:	74 e9                	je     300 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 317:	29 d8                	sub    %ebx,%eax
}
 319:	5b                   	pop    %ebx
 31a:	5e                   	pop    %esi
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret    
 31d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 320:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 322:	29 d8                	sub    %ebx,%eax
}
 324:	5b                   	pop    %ebx
 325:	5e                   	pop    %esi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <strlen>:

uint
strlen(const char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 336:	80 39 00             	cmpb   $0x0,(%ecx)
 339:	74 12                	je     34d <strlen+0x1d>
 33b:	31 d2                	xor    %edx,%edx
 33d:	8d 76 00             	lea    0x0(%esi),%esi
 340:	83 c2 01             	add    $0x1,%edx
 343:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 347:	89 d0                	mov    %edx,%eax
 349:	75 f5                	jne    340 <strlen+0x10>
    ;
  return n;
}
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 34d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 34f:	5d                   	pop    %ebp
 350:	c3                   	ret    
 351:	eb 0d                	jmp    360 <memset>
 353:	90                   	nop
 354:	90                   	nop
 355:	90                   	nop
 356:	90                   	nop
 357:	90                   	nop
 358:	90                   	nop
 359:	90                   	nop
 35a:	90                   	nop
 35b:	90                   	nop
 35c:	90                   	nop
 35d:	90                   	nop
 35e:	90                   	nop
 35f:	90                   	nop

00000360 <memset>:

void*
memset(void *dst, int c, uint n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 367:	8b 4d 10             	mov    0x10(%ebp),%ecx
 36a:	8b 45 0c             	mov    0xc(%ebp),%eax
 36d:	89 d7                	mov    %edx,%edi
 36f:	fc                   	cld    
 370:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 372:	89 d0                	mov    %edx,%eax
 374:	5f                   	pop    %edi
 375:	5d                   	pop    %ebp
 376:	c3                   	ret    
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <strchr>:

char*
strchr(const char *s, char c)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	53                   	push   %ebx
 384:	8b 45 08             	mov    0x8(%ebp),%eax
 387:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 38a:	0f b6 10             	movzbl (%eax),%edx
 38d:	84 d2                	test   %dl,%dl
 38f:	74 1d                	je     3ae <strchr+0x2e>
    if(*s == c)
 391:	38 d3                	cmp    %dl,%bl
 393:	89 d9                	mov    %ebx,%ecx
 395:	75 0d                	jne    3a4 <strchr+0x24>
 397:	eb 17                	jmp    3b0 <strchr+0x30>
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a0:	38 ca                	cmp    %cl,%dl
 3a2:	74 0c                	je     3b0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3a4:	83 c0 01             	add    $0x1,%eax
 3a7:	0f b6 10             	movzbl (%eax),%edx
 3aa:	84 d2                	test   %dl,%dl
 3ac:	75 f2                	jne    3a0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 3ae:	31 c0                	xor    %eax,%eax
}
 3b0:	5b                   	pop    %ebx
 3b1:	5d                   	pop    %ebp
 3b2:	c3                   	ret    
 3b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003c0 <gets>:

char*
gets(char *buf, int max)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 3c8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 3cb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3ce:	eb 29                	jmp    3f9 <gets+0x39>
    cc = read(0, &c, 1);
 3d0:	83 ec 04             	sub    $0x4,%esp
 3d3:	6a 01                	push   $0x1
 3d5:	57                   	push   %edi
 3d6:	6a 00                	push   $0x0
 3d8:	e8 2d 01 00 00       	call   50a <read>
    if(cc < 1)
 3dd:	83 c4 10             	add    $0x10,%esp
 3e0:	85 c0                	test   %eax,%eax
 3e2:	7e 1d                	jle    401 <gets+0x41>
      break;
    buf[i++] = c;
 3e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3e8:	8b 55 08             	mov    0x8(%ebp),%edx
 3eb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3ed:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 3ef:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3f3:	74 1b                	je     410 <gets+0x50>
 3f5:	3c 0d                	cmp    $0xd,%al
 3f7:	74 17                	je     410 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f9:	8d 5e 01             	lea    0x1(%esi),%ebx
 3fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3ff:	7c cf                	jl     3d0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 401:	8b 45 08             	mov    0x8(%ebp),%eax
 404:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 408:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40b:	5b                   	pop    %ebx
 40c:	5e                   	pop    %esi
 40d:	5f                   	pop    %edi
 40e:	5d                   	pop    %ebp
 40f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 410:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 413:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 415:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 419:	8d 65 f4             	lea    -0xc(%ebp),%esp
 41c:	5b                   	pop    %ebx
 41d:	5e                   	pop    %esi
 41e:	5f                   	pop    %edi
 41f:	5d                   	pop    %ebp
 420:	c3                   	ret    
 421:	eb 0d                	jmp    430 <stat>
 423:	90                   	nop
 424:	90                   	nop
 425:	90                   	nop
 426:	90                   	nop
 427:	90                   	nop
 428:	90                   	nop
 429:	90                   	nop
 42a:	90                   	nop
 42b:	90                   	nop
 42c:	90                   	nop
 42d:	90                   	nop
 42e:	90                   	nop
 42f:	90                   	nop

00000430 <stat>:

int
stat(const char *n, struct stat *st)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	56                   	push   %esi
 434:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 435:	83 ec 08             	sub    $0x8,%esp
 438:	6a 00                	push   $0x0
 43a:	ff 75 08             	pushl  0x8(%ebp)
 43d:	e8 f0 00 00 00       	call   532 <open>
  if(fd < 0)
 442:	83 c4 10             	add    $0x10,%esp
 445:	85 c0                	test   %eax,%eax
 447:	78 27                	js     470 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 449:	83 ec 08             	sub    $0x8,%esp
 44c:	ff 75 0c             	pushl  0xc(%ebp)
 44f:	89 c3                	mov    %eax,%ebx
 451:	50                   	push   %eax
 452:	e8 f3 00 00 00       	call   54a <fstat>
 457:	89 c6                	mov    %eax,%esi
  close(fd);
 459:	89 1c 24             	mov    %ebx,(%esp)
 45c:	e8 b9 00 00 00       	call   51a <close>
  return r;
 461:	83 c4 10             	add    $0x10,%esp
 464:	89 f0                	mov    %esi,%eax
}
 466:	8d 65 f8             	lea    -0x8(%ebp),%esp
 469:	5b                   	pop    %ebx
 46a:	5e                   	pop    %esi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 470:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 475:	eb ef                	jmp    466 <stat+0x36>
 477:	89 f6                	mov    %esi,%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	53                   	push   %ebx
 484:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 487:	0f be 11             	movsbl (%ecx),%edx
 48a:	8d 42 d0             	lea    -0x30(%edx),%eax
 48d:	3c 09                	cmp    $0x9,%al
 48f:	b8 00 00 00 00       	mov    $0x0,%eax
 494:	77 1f                	ja     4b5 <atoi+0x35>
 496:	8d 76 00             	lea    0x0(%esi),%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 4a0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4a3:	83 c1 01             	add    $0x1,%ecx
 4a6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4aa:	0f be 11             	movsbl (%ecx),%edx
 4ad:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4b0:	80 fb 09             	cmp    $0x9,%bl
 4b3:	76 eb                	jbe    4a0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 4b5:	5b                   	pop    %ebx
 4b6:	5d                   	pop    %ebp
 4b7:	c3                   	ret    
 4b8:	90                   	nop
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
 4c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4c8:	8b 45 08             	mov    0x8(%ebp),%eax
 4cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ce:	85 db                	test   %ebx,%ebx
 4d0:	7e 14                	jle    4e6 <memmove+0x26>
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4df:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4e2:	39 da                	cmp    %ebx,%edx
 4e4:	75 f2                	jne    4d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4e6:	5b                   	pop    %ebx
 4e7:	5e                   	pop    %esi
 4e8:	5d                   	pop    %ebp
 4e9:	c3                   	ret    

000004ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ea:	b8 01 00 00 00       	mov    $0x1,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <exit>:
SYSCALL(exit)
 4f2:	b8 02 00 00 00       	mov    $0x2,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <wait>:
SYSCALL(wait)
 4fa:	b8 03 00 00 00       	mov    $0x3,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <pipe>:
SYSCALL(pipe)
 502:	b8 04 00 00 00       	mov    $0x4,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <read>:
SYSCALL(read)
 50a:	b8 05 00 00 00       	mov    $0x5,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <write>:
SYSCALL(write)
 512:	b8 10 00 00 00       	mov    $0x10,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <close>:
SYSCALL(close)
 51a:	b8 15 00 00 00       	mov    $0x15,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <kill>:
SYSCALL(kill)
 522:	b8 06 00 00 00       	mov    $0x6,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <exec>:
SYSCALL(exec)
 52a:	b8 07 00 00 00       	mov    $0x7,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <open>:
SYSCALL(open)
 532:	b8 0f 00 00 00       	mov    $0xf,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <mknod>:
SYSCALL(mknod)
 53a:	b8 11 00 00 00       	mov    $0x11,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <unlink>:
SYSCALL(unlink)
 542:	b8 12 00 00 00       	mov    $0x12,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <fstat>:
SYSCALL(fstat)
 54a:	b8 08 00 00 00       	mov    $0x8,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <link>:
SYSCALL(link)
 552:	b8 13 00 00 00       	mov    $0x13,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <mkdir>:
SYSCALL(mkdir)
 55a:	b8 14 00 00 00       	mov    $0x14,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <chdir>:
SYSCALL(chdir)
 562:	b8 09 00 00 00       	mov    $0x9,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <dup>:
SYSCALL(dup)
 56a:	b8 0a 00 00 00       	mov    $0xa,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <getpid>:
SYSCALL(getpid)
 572:	b8 0b 00 00 00       	mov    $0xb,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <sbrk>:
SYSCALL(sbrk)
 57a:	b8 0c 00 00 00       	mov    $0xc,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <sleep>:
SYSCALL(sleep)
 582:	b8 0d 00 00 00       	mov    $0xd,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <uptime>:
SYSCALL(uptime)
 58a:	b8 0e 00 00 00       	mov    $0xe,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <trace>:
SYSCALL(trace)
 592:	b8 16 00 00 00       	mov    $0x16,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <cs>:
SYSCALL(cs)
 59a:	b8 17 00 00 00       	mov    $0x17,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <set_tickets>:
SYSCALL(set_tickets)
 5a2:	b8 18 00 00 00       	mov    $0x18,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <set_priority>:
SYSCALL(set_priority)
 5aa:	b8 19 00 00 00       	mov    $0x19,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <wait2>:
SYSCALL(wait2)
 5b2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <sys_yield>:
SYSCALL(sys_yield)
 5ba:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    
 5c2:	66 90                	xchg   %ax,%ax
 5c4:	66 90                	xchg   %ax,%ax
 5c6:	66 90                	xchg   %ax,%ax
 5c8:	66 90                	xchg   %ax,%ax
 5ca:	66 90                	xchg   %ax,%ax
 5cc:	66 90                	xchg   %ax,%ax
 5ce:	66 90                	xchg   %ax,%ax

000005d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
 5d6:	89 c6                	mov    %eax,%esi
 5d8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5db:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5de:	85 db                	test   %ebx,%ebx
 5e0:	74 7e                	je     660 <printint+0x90>
 5e2:	89 d0                	mov    %edx,%eax
 5e4:	c1 e8 1f             	shr    $0x1f,%eax
 5e7:	84 c0                	test   %al,%al
 5e9:	74 75                	je     660 <printint+0x90>
    neg = 1;
    x = -xx;
 5eb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5ed:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 5f4:	f7 d8                	neg    %eax
 5f6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5f9:	31 ff                	xor    %edi,%edi
 5fb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5fe:	89 ce                	mov    %ecx,%esi
 600:	eb 08                	jmp    60a <printint+0x3a>
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 608:	89 cf                	mov    %ecx,%edi
 60a:	31 d2                	xor    %edx,%edx
 60c:	8d 4f 01             	lea    0x1(%edi),%ecx
 60f:	f7 f6                	div    %esi
 611:	0f b6 92 bc 0b 00 00 	movzbl 0xbbc(%edx),%edx
  }while((x /= base) != 0);
 618:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 61a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 61d:	75 e9                	jne    608 <printint+0x38>
  if(neg)
 61f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 622:	8b 75 c0             	mov    -0x40(%ebp),%esi
 625:	85 c0                	test   %eax,%eax
 627:	74 08                	je     631 <printint+0x61>
    buf[i++] = '-';
 629:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 62e:	8d 4f 02             	lea    0x2(%edi),%ecx
 631:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 635:	8d 76 00             	lea    0x0(%esi),%esi
 638:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63b:	83 ec 04             	sub    $0x4,%esp
 63e:	83 ef 01             	sub    $0x1,%edi
 641:	6a 01                	push   $0x1
 643:	53                   	push   %ebx
 644:	56                   	push   %esi
 645:	88 45 d7             	mov    %al,-0x29(%ebp)
 648:	e8 c5 fe ff ff       	call   512 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 64d:	83 c4 10             	add    $0x10,%esp
 650:	39 df                	cmp    %ebx,%edi
 652:	75 e4                	jne    638 <printint+0x68>
    putc(fd, buf[i]);
}
 654:	8d 65 f4             	lea    -0xc(%ebp),%esp
 657:	5b                   	pop    %ebx
 658:	5e                   	pop    %esi
 659:	5f                   	pop    %edi
 65a:	5d                   	pop    %ebp
 65b:	c3                   	ret    
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 660:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 662:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 669:	eb 8b                	jmp    5f6 <printint+0x26>
 66b:	90                   	nop
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000670 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 676:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 679:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 67c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 67f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 682:	89 45 d0             	mov    %eax,-0x30(%ebp)
 685:	0f b6 1e             	movzbl (%esi),%ebx
 688:	83 c6 01             	add    $0x1,%esi
 68b:	84 db                	test   %bl,%bl
 68d:	0f 84 b0 00 00 00    	je     743 <printf+0xd3>
 693:	31 d2                	xor    %edx,%edx
 695:	eb 39                	jmp    6d0 <printf+0x60>
 697:	89 f6                	mov    %esi,%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6a0:	83 f8 25             	cmp    $0x25,%eax
 6a3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 6a6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6ab:	74 18                	je     6c5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ad:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6b6:	6a 01                	push   $0x1
 6b8:	50                   	push   %eax
 6b9:	57                   	push   %edi
 6ba:	e8 53 fe ff ff       	call   512 <write>
 6bf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6c2:	83 c4 10             	add    $0x10,%esp
 6c5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6cc:	84 db                	test   %bl,%bl
 6ce:	74 73                	je     743 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 6d0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6d2:	0f be cb             	movsbl %bl,%ecx
 6d5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6d8:	74 c6                	je     6a0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6da:	83 fa 25             	cmp    $0x25,%edx
 6dd:	75 e6                	jne    6c5 <printf+0x55>
      if(c == 'd'){
 6df:	83 f8 64             	cmp    $0x64,%eax
 6e2:	0f 84 f8 00 00 00    	je     7e0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6e8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6ee:	83 f9 70             	cmp    $0x70,%ecx
 6f1:	74 5d                	je     750 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6f3:	83 f8 73             	cmp    $0x73,%eax
 6f6:	0f 84 84 00 00 00    	je     780 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6fc:	83 f8 63             	cmp    $0x63,%eax
 6ff:	0f 84 ea 00 00 00    	je     7ef <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 705:	83 f8 25             	cmp    $0x25,%eax
 708:	0f 84 c2 00 00 00    	je     7d0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 70e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 711:	83 ec 04             	sub    $0x4,%esp
 714:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 718:	6a 01                	push   $0x1
 71a:	50                   	push   %eax
 71b:	57                   	push   %edi
 71c:	e8 f1 fd ff ff       	call   512 <write>
 721:	83 c4 0c             	add    $0xc,%esp
 724:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 727:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 72a:	6a 01                	push   $0x1
 72c:	50                   	push   %eax
 72d:	57                   	push   %edi
 72e:	83 c6 01             	add    $0x1,%esi
 731:	e8 dc fd ff ff       	call   512 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 736:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 73d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 73f:	84 db                	test   %bl,%bl
 741:	75 8d                	jne    6d0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 743:	8d 65 f4             	lea    -0xc(%ebp),%esp
 746:	5b                   	pop    %ebx
 747:	5e                   	pop    %esi
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    
 74b:	90                   	nop
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 750:	83 ec 0c             	sub    $0xc,%esp
 753:	b9 10 00 00 00       	mov    $0x10,%ecx
 758:	6a 00                	push   $0x0
 75a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 75d:	89 f8                	mov    %edi,%eax
 75f:	8b 13                	mov    (%ebx),%edx
 761:	e8 6a fe ff ff       	call   5d0 <printint>
        ap++;
 766:	89 d8                	mov    %ebx,%eax
 768:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 76b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 76d:	83 c0 04             	add    $0x4,%eax
 770:	89 45 d0             	mov    %eax,-0x30(%ebp)
 773:	e9 4d ff ff ff       	jmp    6c5 <printf+0x55>
 778:	90                   	nop
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 780:	8b 45 d0             	mov    -0x30(%ebp),%eax
 783:	8b 18                	mov    (%eax),%ebx
        ap++;
 785:	83 c0 04             	add    $0x4,%eax
 788:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 78b:	b8 b4 0b 00 00       	mov    $0xbb4,%eax
 790:	85 db                	test   %ebx,%ebx
 792:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 795:	0f b6 03             	movzbl (%ebx),%eax
 798:	84 c0                	test   %al,%al
 79a:	74 23                	je     7bf <printf+0x14f>
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7a0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7a3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7a6:	83 ec 04             	sub    $0x4,%esp
 7a9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 7ab:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ae:	50                   	push   %eax
 7af:	57                   	push   %edi
 7b0:	e8 5d fd ff ff       	call   512 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7b5:	0f b6 03             	movzbl (%ebx),%eax
 7b8:	83 c4 10             	add    $0x10,%esp
 7bb:	84 c0                	test   %al,%al
 7bd:	75 e1                	jne    7a0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7bf:	31 d2                	xor    %edx,%edx
 7c1:	e9 ff fe ff ff       	jmp    6c5 <printf+0x55>
 7c6:	8d 76 00             	lea    0x0(%esi),%esi
 7c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7d0:	83 ec 04             	sub    $0x4,%esp
 7d3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7d6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7d9:	6a 01                	push   $0x1
 7db:	e9 4c ff ff ff       	jmp    72c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7e0:	83 ec 0c             	sub    $0xc,%esp
 7e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7e8:	6a 01                	push   $0x1
 7ea:	e9 6b ff ff ff       	jmp    75a <printf+0xea>
 7ef:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7f2:	83 ec 04             	sub    $0x4,%esp
 7f5:	8b 03                	mov    (%ebx),%eax
 7f7:	6a 01                	push   $0x1
 7f9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 7fc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7ff:	50                   	push   %eax
 800:	57                   	push   %edi
 801:	e8 0c fd ff ff       	call   512 <write>
 806:	e9 5b ff ff ff       	jmp    766 <printf+0xf6>
 80b:	66 90                	xchg   %ax,%ax
 80d:	66 90                	xchg   %ax,%ax
 80f:	90                   	nop

00000810 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 810:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 811:	a1 60 0e 00 00       	mov    0xe60,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 816:	89 e5                	mov    %esp,%ebp
 818:	57                   	push   %edi
 819:	56                   	push   %esi
 81a:	53                   	push   %ebx
 81b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 820:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 823:	39 c8                	cmp    %ecx,%eax
 825:	73 19                	jae    840 <free+0x30>
 827:	89 f6                	mov    %esi,%esi
 829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 830:	39 d1                	cmp    %edx,%ecx
 832:	72 1c                	jb     850 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 834:	39 d0                	cmp    %edx,%eax
 836:	73 18                	jae    850 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 838:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83e:	72 f0                	jb     830 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 840:	39 d0                	cmp    %edx,%eax
 842:	72 f4                	jb     838 <free+0x28>
 844:	39 d1                	cmp    %edx,%ecx
 846:	73 f0                	jae    838 <free+0x28>
 848:	90                   	nop
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 850:	8b 73 fc             	mov    -0x4(%ebx),%esi
 853:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 856:	39 d7                	cmp    %edx,%edi
 858:	74 19                	je     873 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 85a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 85d:	8b 50 04             	mov    0x4(%eax),%edx
 860:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 863:	39 f1                	cmp    %esi,%ecx
 865:	74 23                	je     88a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 867:	89 08                	mov    %ecx,(%eax)
  freep = p;
 869:	a3 60 0e 00 00       	mov    %eax,0xe60
}
 86e:	5b                   	pop    %ebx
 86f:	5e                   	pop    %esi
 870:	5f                   	pop    %edi
 871:	5d                   	pop    %ebp
 872:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 873:	03 72 04             	add    0x4(%edx),%esi
 876:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 879:	8b 10                	mov    (%eax),%edx
 87b:	8b 12                	mov    (%edx),%edx
 87d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 880:	8b 50 04             	mov    0x4(%eax),%edx
 883:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 886:	39 f1                	cmp    %esi,%ecx
 888:	75 dd                	jne    867 <free+0x57>
    p->s.size += bp->s.size;
 88a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 88d:	a3 60 0e 00 00       	mov    %eax,0xe60
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 892:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 895:	8b 53 f8             	mov    -0x8(%ebx),%edx
 898:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 89a:	5b                   	pop    %ebx
 89b:	5e                   	pop    %esi
 89c:	5f                   	pop    %edi
 89d:	5d                   	pop    %ebp
 89e:	c3                   	ret    
 89f:	90                   	nop

000008a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ac:	8b 15 60 0e 00 00    	mov    0xe60,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b2:	8d 78 07             	lea    0x7(%eax),%edi
 8b5:	c1 ef 03             	shr    $0x3,%edi
 8b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8bb:	85 d2                	test   %edx,%edx
 8bd:	0f 84 a3 00 00 00    	je     966 <malloc+0xc6>
 8c3:	8b 02                	mov    (%edx),%eax
 8c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8c8:	39 cf                	cmp    %ecx,%edi
 8ca:	76 74                	jbe    940 <malloc+0xa0>
 8cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8d2:	be 00 10 00 00       	mov    $0x1000,%esi
 8d7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 8de:	0f 43 f7             	cmovae %edi,%esi
 8e1:	ba 00 80 00 00       	mov    $0x8000,%edx
 8e6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8ec:	0f 46 da             	cmovbe %edx,%ebx
 8ef:	eb 10                	jmp    901 <malloc+0x61>
 8f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8fa:	8b 48 04             	mov    0x4(%eax),%ecx
 8fd:	39 cf                	cmp    %ecx,%edi
 8ff:	76 3f                	jbe    940 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 901:	39 05 60 0e 00 00    	cmp    %eax,0xe60
 907:	89 c2                	mov    %eax,%edx
 909:	75 ed                	jne    8f8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 90b:	83 ec 0c             	sub    $0xc,%esp
 90e:	53                   	push   %ebx
 90f:	e8 66 fc ff ff       	call   57a <sbrk>
  if(p == (char*)-1)
 914:	83 c4 10             	add    $0x10,%esp
 917:	83 f8 ff             	cmp    $0xffffffff,%eax
 91a:	74 1c                	je     938 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 91c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 91f:	83 ec 0c             	sub    $0xc,%esp
 922:	83 c0 08             	add    $0x8,%eax
 925:	50                   	push   %eax
 926:	e8 e5 fe ff ff       	call   810 <free>
  return freep;
 92b:	8b 15 60 0e 00 00    	mov    0xe60,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 931:	83 c4 10             	add    $0x10,%esp
 934:	85 d2                	test   %edx,%edx
 936:	75 c0                	jne    8f8 <malloc+0x58>
        return 0;
 938:	31 c0                	xor    %eax,%eax
 93a:	eb 1c                	jmp    958 <malloc+0xb8>
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 940:	39 cf                	cmp    %ecx,%edi
 942:	74 1c                	je     960 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 944:	29 f9                	sub    %edi,%ecx
 946:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 949:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 94c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 94f:	89 15 60 0e 00 00    	mov    %edx,0xe60
      return (void*)(p + 1);
 955:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 958:	8d 65 f4             	lea    -0xc(%ebp),%esp
 95b:	5b                   	pop    %ebx
 95c:	5e                   	pop    %esi
 95d:	5f                   	pop    %edi
 95e:	5d                   	pop    %ebp
 95f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 960:	8b 08                	mov    (%eax),%ecx
 962:	89 0a                	mov    %ecx,(%edx)
 964:	eb e9                	jmp    94f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 966:	c7 05 60 0e 00 00 64 	movl   $0xe64,0xe60
 96d:	0e 00 00 
 970:	c7 05 64 0e 00 00 64 	movl   $0xe64,0xe64
 977:	0e 00 00 
    base.s.size = 0;
 97a:	b8 64 0e 00 00       	mov    $0xe64,%eax
 97f:	c7 05 68 0e 00 00 00 	movl   $0x0,0xe68
 986:	00 00 00 
 989:	e9 3e ff ff ff       	jmp    8cc <malloc+0x2c>
