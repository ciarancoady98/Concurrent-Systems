#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM goodProperty */
	case 3: // STATE 1 - _spin_nvr.tmp:4 - [((!(!(thinking))&&!(eating)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[1][1] = 1;
		if (!(( !( !(((int)now.thinking)))&& !(((int)now.eating)))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 6 - _spin_nvr.tmp:9 - [(!(eating))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[1][6] = 1;
		if (!( !(((int)now.eating))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 11 - _spin_nvr.tmp:11 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported11 = 0;
			if (verbose && !reported11)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported11 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported11 = 0;
			if (verbose && !reported11)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported11 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[1][11] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC phil */
	case 6: // STATE 1 - dphil_starve.pml:21 - [p = _pid] (0:6:3 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = ((P0 *)this)->p;
		((P0 *)this)->p = ((int)((P0 *)this)->_pid);
#ifdef VAR_RANGES
		logval("phil:p", ((P0 *)this)->p);
#endif
		;
		/* merge: lfork = (p%5)(6, 2, 6) */
		reached[0][2] = 1;
		(trpt+1)->bup.ovals[1] = ((P0 *)this)->lfork;
		((P0 *)this)->lfork = (((P0 *)this)->p%5);
#ifdef VAR_RANGES
		logval("phil:lfork", ((P0 *)this)->lfork);
#endif
		;
		/* merge: rfork = ((p+1)%5)(6, 3, 6) */
		reached[0][3] = 1;
		(trpt+1)->bup.ovals[2] = ((P0 *)this)->rfork;
		((P0 *)this)->rfork = ((((P0 *)this)->p+1)%5);
#ifdef VAR_RANGES
		logval("phil:rfork", ((P0 *)this)->rfork);
#endif
		;
		_m = 3; goto P999; /* 2 */
	case 7: // STATE 4 - dphil_starve.pml:27 - [printf('P%d thinks..\\n',_pid)] (0:7:1 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		Printf("P%d thinks..\n", ((int)((P0 *)this)->_pid));
		/* merge: thinking = 1(7, 5, 7) */
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.thinking);
		now.thinking = 1;
#ifdef VAR_RANGES
		logval("thinking", ((int)now.thinking));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 8: // STATE 7 - dphil_starve.pml:30 - [thinking = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		(trpt+1)->bup.oval = ((int)now.thinking);
		now.thinking = 0;
#ifdef VAR_RANGES
		logval("thinking", ((int)now.thinking));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 8 - dphil_starve.pml:32 - [(!((((Fork[((5*((p+1)%5))+lfork)]||Fork[((5*((p+2)%5))+lfork)])||Fork[((5*((p+3)%5))+lfork)])||Fork[((5*((p+4)%5))+lfork)])))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		if (!( !((((((int)now.Fork[ Index(((5*((((P0 *)this)->p+1)%5))+((P0 *)this)->lfork), 25) ])||((int)now.Fork[ Index(((5*((((P0 *)this)->p+2)%5))+((P0 *)this)->lfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+3)%5))+((P0 *)this)->lfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+4)%5))+((P0 *)this)->lfork), 25) ])))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 9 - dphil_starve.pml:33 - [Fork[((5*p)+lfork)] = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][9] = 1;
		(trpt+1)->bup.oval = ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ]);
		now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ] = 1;
#ifdef VAR_RANGES
		logval("Fork[((5*phil:p)+phil:lfork)]", ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 11 - dphil_starve.pml:37 - [(!((((Fork[((5*((p+1)%5))+rfork)]||Fork[((5*((p+2)%5))+rfork)])||Fork[((5*((p+3)%5))+rfork)])||Fork[((5*((p+4)%5))+rfork)])))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		if (!( !((((((int)now.Fork[ Index(((5*((((P0 *)this)->p+1)%5))+((P0 *)this)->rfork), 25) ])||((int)now.Fork[ Index(((5*((((P0 *)this)->p+2)%5))+((P0 *)this)->rfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+3)%5))+((P0 *)this)->rfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+4)%5))+((P0 *)this)->rfork), 25) ])))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 12 - dphil_starve.pml:38 - [Fork[((5*p)+rfork)] = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][12] = 1;
		(trpt+1)->bup.oval = ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ]);
		now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ] = 1;
#ifdef VAR_RANGES
		logval("Fork[((5*phil:p)+phil:rfork)]", ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 14 - dphil_starve.pml:41 - [assert(!((((Fork[((5*((p+1)%5))+lfork)]||Fork[((5*((p+2)%5))+lfork)])||Fork[((5*((p+3)%5))+lfork)])||Fork[((5*((p+4)%5))+lfork)])))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][14] = 1;
		spin_assert( !((((((int)now.Fork[ Index(((5*((((P0 *)this)->p+1)%5))+((P0 *)this)->lfork), 25) ])||((int)now.Fork[ Index(((5*((((P0 *)this)->p+2)%5))+((P0 *)this)->lfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+3)%5))+((P0 *)this)->lfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+4)%5))+((P0 *)this)->lfork), 25) ]))), " !((((Fork[((5*((p+1)%5))+lfork)]||Fork[((5*((p+2)%5))+lfork)])||Fork[((5*((p+3)%5))+lfork)])||Fork[((5*((p+4)%5))+lfork)]))", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 15 - dphil_starve.pml:42 - [assert(!((((Fork[((5*((p+1)%5))+rfork)]||Fork[((5*((p+2)%5))+rfork)])||Fork[((5*((p+3)%5))+rfork)])||Fork[((5*((p+4)%5))+rfork)])))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][15] = 1;
		spin_assert( !((((((int)now.Fork[ Index(((5*((((P0 *)this)->p+1)%5))+((P0 *)this)->rfork), 25) ])||((int)now.Fork[ Index(((5*((((P0 *)this)->p+2)%5))+((P0 *)this)->rfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+3)%5))+((P0 *)this)->rfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+4)%5))+((P0 *)this)->rfork), 25) ]))), " !((((Fork[((5*((p+1)%5))+rfork)]||Fork[((5*((p+2)%5))+rfork)])||Fork[((5*((p+3)%5))+rfork)])||Fork[((5*((p+4)%5))+rfork)]))", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 16 - dphil_starve.pml:45 - [printf('P%d eats!\\n',_pid)] (0:19:1 - 1)
		IfNotBlocked
		reached[0][16] = 1;
		Printf("P%d eats!\n", ((int)((P0 *)this)->_pid));
		/* merge: eating = 1(19, 17, 19) */
		reached[0][17] = 1;
		(trpt+1)->bup.oval = ((int)now.eating);
		now.eating = 1;
#ifdef VAR_RANGES
		logval("eating", ((int)now.eating));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 16: // STATE 19 - dphil_starve.pml:48 - [eating = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][19] = 1;
		(trpt+1)->bup.oval = ((int)now.eating);
		now.eating = 0;
#ifdef VAR_RANGES
		logval("eating", ((int)now.eating));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 20 - dphil_starve.pml:49 - [Fork[((5*p)+lfork)] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][20] = 1;
		(trpt+1)->bup.oval = ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ]);
		now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ] = 0;
#ifdef VAR_RANGES
		logval("Fork[((5*phil:p)+phil:lfork)]", ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 21 - dphil_starve.pml:50 - [Fork[((5*p)+rfork)] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][21] = 1;
		(trpt+1)->bup.oval = ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ]);
		now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ] = 0;
#ifdef VAR_RANGES
		logval("Fork[((5*phil:p)+phil:rfork)]", ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

