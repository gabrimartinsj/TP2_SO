#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void) {

    int aux1, aux2;
    char c = '0';
    int pid;
    int retime, rutime, stime;

    pid = fork();
    if (pid == 0) {
        set_tickets(1);
        c = '1';
        pid = fork();
        if (pid == 0) {
            set_tickets(100);
            c = '2';
            pid = fork();
            if (pid == 0) {
                set_tickets(1);
                c = '3';
                pid = fork();
                if (pid == 0) {
                    set_tickets(1);
                    c = '4';
                }
            }
        }
    }

    for (int i = 0; i < 100; i++) {
        aux1 = i;
        aux2 = i;
        for (int j = 0; j < 10000000; j++) {
            aux1 += 1;
            aux2 += 1;
            if (j % 10000 == 0) {
                aux1 /= aux2;
                aux2 %= 25;
            }
        }
        printf(0, "%c ", c);
    }

    if (aux2 > aux1) {
        exit();
    }
    wait2(&retime, &rutime, &stime);
    printf(0, "\n%d, %d, %d\n", retime, rutime, stime);
    exit();
    return 0;
}

