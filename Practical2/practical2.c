
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include "cond.c"


int pnum;  // number updated when producer runs.
int csum;  // sum computed using pnum when consumer runs.
int contents; // if the buffer is busy
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER; // the mutex variable
pthread_cond_t ready_for_consumer; // condition for consumer
pthread_cond_t ready_for_producer; // condition for producer



int (*pred)(int); // predicate indicating number to be consumed

int produceT() {
  //aquire the mutex lock
  pthread_mutex_lock(&mutex);
  printf("Producer got Mutex");
  //if the buffer isnt ready for production wait
  while(contents >= 1){
    //wait for signal to produce
    pthread_cond_wait(&ready_for_producer, &mutex);
  }
  //ensure that we are still ready for production
  assert(contents < 1);
  //produce and save to pnum
  scanf("%d",&pnum);
  //update the status
  contents++;
  //signal the waiting consumers
  pthread_cond_signal(&ready_for_consumer);
  //release the mutex
  pthread_mutex_unlock(&mutex);
  return pnum;
}

void *Produce(void *a) {
  int p;

  p=1;
  while (p) {
    printf("producer thinking...\n");
    sleep(1);
    printf("..done!\n");
    p = produceT();
    printf("PRODUCED %d\n",p);
  }
  printf("EXIT-P\n");
}


int consumeT() {
  //aquire the mutex lock
  pthread_mutex_lock(&mutex);
  printf("Consumer got Mutex");
  //if the buffer isnt ready for consumption wait
  while(contents <= 0){
    pthread_cond_wait(&ready_for_consumer, &mutex);
  }
  //ensure that we are still ready for consumption
  assert(contents >= 1);
  //consumer from pnum
  if ( pred(pnum) ) { csum += pnum; }
  //update the status
  contents--;
  //signal the waiting consumers
  pthread_cond_signal(&ready_for_producer);
  //release the mutex
  pthread_mutex_unlock(&mutex);
  return pnum;
}

void *Consume(void *a) {
  int p;

  p=1;
  while (p) {
    printf("consumer thinking...\n");
    sleep(rand()%3);
    printf("..done!\n");
    p = consumeT();
    printf("CONSUMED %d\n",csum);
  }
  printf("EXIT-C\n");
}


int main (int argc, const char * argv[]) {
  // the current number predicate
  static pthread_t prod,cons;
	long rc;

  pred = &cond1;
  if (argc>1) {
    if      (!strncmp(argv[1],"2",10)) { pred = &cond2; }
    else if (!strncmp(argv[1],"3",10)) { pred = &cond3; }
  }


  pnum = 999;
  csum=0;
  contents = 0;

  srand(time(0));

  printf("Creating Producer:\n");
 	rc = pthread_create(&prod,NULL,Produce,(void *)0);
	if (rc) {
			printf("ERROR return code from pthread_create(prod): %ld\n",rc);
			exit(-1);
		}
  printf("Creating Consumer:\n");
 	rc = pthread_create(&cons,NULL,Consume,(void *)0);
	if (rc) {
			printf("ERROR return code from pthread_create(cons): %ld\n",rc);
			exit(-1);
		}

	pthread_join( prod, NULL);
	pthread_join( cons, NULL);


  printf("csum=%d.\n",csum);

  return 0;
}
