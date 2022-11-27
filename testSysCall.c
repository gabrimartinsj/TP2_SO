#include "types.h"
#include "stat.h"
#include "user.h"

//programa de usuário para testar o trace

int main(void){
    getpid();

    trace(1);
    getpid();

    trace(0);
    getpid();
    
    trace(1);
    uptime();
    wait();
    getpid();

    trace(0);
    getpid();

    exit();
}
