#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
	if (argc != 2){
				printf(1, "Usage: sanity [n]\n");
				exit();
 	}

	int i, n, k, j = 0;
	int retime;		//Variavéis a serem monitoradas
	int rutime;
	int stime;
	int record[3][3];

	for (i = 0; i < 3; i++)
		for (j = 0; j < 3; j++)
			record[i][j] = 0;

	n = atoi(argv[1]);
	n = n*3; //3*N processos
	int pid;

	for (i = 0; i < n; i++){
		j = i % 3;
		pid = fork();
		if (pid == 0) { //child
			j = (getpid() - 4) % 3; //Garante indepência do pid do primeiro filho
			switch(j){
				case 0: //Processos CPU‐bound (CPU):
						for (double z = 0; z < 10000000.0; z+= 0.1){
				         double x =  x + 3.14 * 89.64;   // calculando tempo de uso da CPU
					}
					break;
				case 1: //Processos curtos CPU‐bound (S‐CPU):
					for (k = 0; k < 100; k++){
						for (j = 0; j < 1000000; j++){}
						sys_yield();
					}
					break;
				case 2://Processos simulando I/O bound (IO)
					for(k = 0; k < 100; k++){
						sleep(1);
					}
					break;
			}
			exit(); // children exit here
		}
		continue; // father continues to spawn the next child
	}

	for (i = 0; i < n; i++){
		pid = wait2(&retime, &rutime, &stime);
		int res = (pid - 4) % 3;
		switch(res) {
			case 0: // simulando processos CPU bound
				printf(1, "CPU-bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
				record[0][0] += retime;
				record[0][1] += rutime;
				record[0][2] += stime;
				break;
			case 1: // simulando processos CPU bound (tarefas curtas)
				printf(1, "SCPU bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
				record[1][0] += retime;
				record[1][1] += rutime;
				record[1][2] += stime;
				break;
			case 2: // simulando processos I/O bound
				printf(1, "I/O bound, pid: %d, ready: %d, running: %d, sleeping: %d, turnaround: %d\n", pid, retime, rutime, stime, retime + rutime + stime);
				record[2][0] += retime;
				record[2][1] += rutime;
				record[2][2] += stime;
				break;
		}
	}

	for (i = 0; i < 3; i++)
		for (j = 0; j < 3; j++)
			record[i][j] /= n;
	
	//imprime a média de tempo para conclusão dos processos.
	printf(1, "\nCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n",  record[0][2], record[0][0], record[0][0] + record[0][1] + record[0][2]);
	printf(1, "SCPU BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n", record[1][2], record[1][0],  record[1][0] + record[1][1] + record[1][2]);
	printf(1, "I/O BOUND - Average sleeping time: %d - Average ready time: %d - Average turnaround time: %d\n\n", record[2][2], record[2][0],  record[2][0] + record[2][1] + record[2][2]);

	exit();
}
