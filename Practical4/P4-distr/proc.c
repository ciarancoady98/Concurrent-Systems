// ONLY MODIFY CODE BELOW THE NEXT OCCURENCE OF THE FOLLOWING LINE !
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#include "types.h"
#include "defs.h"
#include <stdio.h>
#include "proc.h"
#include <limits.h>

#define NCPU 1

struct cpu cpus[NCPU];
int ncpu;

void printstate(enum procstate pstate){ // DO NOT MODIFY
  switch(pstate) {
    case UNUSED   : printf("UNUSED");   break;
    case EMBRYO   : printf("EMBRYO");   break;
    case SLEEPING : printf("SLEEPING"); break;
    case RUNNABLE : printf("RUNNABLE"); break;
    case RUNNING  : printf("RUNNING");  break;
    case ZOMBIE   : printf("ZOMBIE");   break;
    default       : printf("????????");
  }
}

// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.

// local to scheduler in xv6, but here we need them to persist outside,
// because while xv6 runs scheduler as a "coroutine" via swtch,
// here swtch is just a regular procedure call.
struct proc *p;
struct cpu *c = cpus;

// +++++++ ONLY MODIFY BELOW THIS LINE ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void scheduler(void){
  int runnableFound; // DO NOT MODIFY/DELETE

  c->proc = 0;

  runnableFound = 1 ; // force one pass over ptable

  //intialise all the processes to have 0 executions
  int numberOfExecutions[NPROC];
  for(int i = 0; i < NPROC; i++){
    numberOfExecutions[i] = 0;
  }

  /*
  This method takes an index and implements some simple
  modulo arithmetic, if the index has fallen off the end
  of the array, wrap it back around to the start by subtracting
  the size of the array from it
  */
  int getIndex(int index){
    int temp = index;
    if(index >= NPROC){
      temp = index - NPROC;
    }
    return temp;
  }
  int lastRun = -1;
  int searchIndex = 0;
  while(runnableFound){ // DO NOT MODIFY
    // Enable interrupts on this processor.
    // sti();
    runnableFound = 0; // DO NOT MODIFY
    // Loop over process table looking for process to run.
    // acquire(&ptable.lock);
    int lowest = INT_MAX;
    int lowestIndex = 0;
    int count = 0;
    /*
    Loop through the array of processes looking for the one
    that has been executed the least amount of times. When
    found update lowest & lowestIndex. If we find there is
    more than one process that has been executed the least
    aount of times do nothing as we have alread stored the
    next process that is to occur in round robin order
    (this is because we started our search with the index
    after the last executed process and due to the wrapping
    around affect)
    */
    searchIndex = lastRun + 1;
    while(count < NPROC){
      p = &ptable.proc[getIndex(searchIndex + count)];
      if(p->state == RUNNABLE){
        runnableFound = 1; // DO NOT MODIFY/DELETE/BYPASS
        if(numberOfExecutions[p->pid] < lowest){
          lowestIndex = p->pid;
          lowest = numberOfExecutions[p->pid];
        }
      }
      count = count + 1;
    }
    if(runnableFound){
      numberOfExecutions[lowestIndex] = numberOfExecutions[lowestIndex] + 1;
      lastRun = lowestIndex;
      p = &ptable.proc[lowestIndex];
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      //switchuvm(p);
      p->state = RUNNING;
      swtch(p);
      // p->state should not be running on return here.
      //switchkvm();
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    // release(&ptable.lock);

  }
  printf("No RUNNABLE process!\n");
}
