#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_wait2(void)
{
  int *retime;
  int *rutime;
  int *stime;

  if(argptr(0, (void*)&retime, sizeof(retime)) < 0 ||  argptr(1, (void*)&rutime, sizeof(rutime)) < 0 || argptr(2, (void*)&stime, sizeof(stime)) < 0)
    return -1;

  return wait2(retime, rutime, stime);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// Sys call para rastrear um processo
int
sys_trace(void)
{
  if (argint(0, &myproc()->traceflag) < 0)
    return -1;

  return 0;
}

// Sys call para avaliar troca de contextos
int
sys_cs(void)
{
  int aux;
  aux = myproc()->counter;
  return aux;
}

// Sys call para definir a quantidade de tickets
int
sys_set_tickets(void)
{
  int n;

  if (argint(0, &n) < 0)
    return -1;

  myproc()->tickets = n;

  return n;
}

// Sys call para definir a prioridade
int
sys_set_priority(void)
{
  int pid, pr;

  if(argint(0, &pid) < 0)
    return -1;
  if(argint(1, &pr) < 0)
    return -1;

  return set_priority(pid, pr);
}
