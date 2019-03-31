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
  int runnableFound; // DO NOT MODIFY/DELETw
  c->proc = 0;
  runnableFound = 1 ; // force one pass over ptable
  int numberOfExecutions[NPROC];
  int toBeExecuted[NPROC];
  for(int i = 0; i < NPROC; i++){
    numberOfExecutions[i] = 0;
  }
  while(runnableFound){ // DO NOT MODIFY
    // Enable interrupts on this processor.
    // sti();
    runnableFound = 0; // DO NOT MODIFY
    // Loop over process table looking for process to run.
    // acquire(&ptable.lock);
    int lastRan = -1;
    int count = 0;
    int outputIndex = 0;
    int lowestFrequency = INT_MAX;
    int searchIndex = count + 1;
    int leastRun = -1;
    int numberOfElements = 0;
    while(count < NPROC){
      //start looking for runnable process
      struct proc *temp = &ptable.proc[searchIndex];
      if(temp->state != RUNNABLE)
        continue;
      //rejoice we have found a runnable process
      runnableFound = 1;
      //keep track of the least run process
      if(numberOfExecutions[searchIndex] <= lowestFrequency){
        leastRun = searchIndex;
        lowestFrequency = numberOfExecutions[searchIndex];
        outputIndex = 0;
        toBeExecuted[outputIndex] = searchIndex;
        outputIndex = outputIndex + 1;
        numberOfElements = 1;
      }
      //we have to call for back up, they all look the same
      else if (numberOfExecutions[searchIndex] == lowestFrequency){
          toBeExecuted[outputIndex] = searchIndex;
          outputIndex = outputIndex + 1;
          numberOfElements = numberOfElements + 1;
      }
      count = count + 1;
      searchIndex = count % NPROC;
    }

    //at this point we should have an array of processes in the order
    //we want to execute them in. So we just need to loop through the
    //array and run them accordingly
    for(int i = 0; i < outputIndex; i++){
      p = &ptable.proc[i];
      numberOfExecutions[i] = numberOfExecutions[i] + 1;
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
      lastRan = i;
    }
    // release(&ptable.lock);

  }
  printf("No RUNNABLE process!\n");
}
