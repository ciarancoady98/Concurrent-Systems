
#define NUM 5 /* Number of philosophers, and forks! */

/* We want to record which philosopher is holding which fork */
/*  fork[NUM][NUM] where fork[p][f] is true if 'p' holds 'f' */

bool Fork[NUM*NUM]; /* 2-d arrays not supported, so ... */
bool eating;
bool thinking;

#define FORK(p,f) Fork[NUM*p+f]
#define leftFork(p) (p%NUM)
#define rightFork(p) ((p+1)%NUM)
#define myForkOnly(p,f) !(    FORK(((p+1)%NUM),f) \
                           || FORK(((p+2)%NUM),f) \
                           || FORK(((p+3)%NUM),f) \
                           || FORK(((p+4)%NUM),f) )

active [NUM] proctype phil()
{ int p, lfork, rfork ;
  p = _pid;
  lfork = leftFork(p);
  rfork = rightFork(p);


  think: atomic {
    printf("P%d thinks..\n",_pid);
    thinking = true;
    }
  thinking = false;
  checkLeftFork: atomic {
    myForkOnly(p, lfork);
    firstfork:  FORK(p,lfork) = true;
  }

  checkRightFork: atomic {
    myForkOnly(p, rfork);
    secondfork: FORK(p,rfork) = true;
  }

  assert(myForkOnly(p,lfork));
  assert(myForkOnly(p,rfork));

  progress_eat: atomic {
    printf("P%d eats!\n",_pid);
    eating = true;
    }
  eating = false;
  
  dropfork1: FORK(p,lfork) = false;
  dropfork2: FORK(p,rfork) = false;
  goto think
}

ltl goodProperty { (thinking) -> eventually (eating) }
