# Concurrent-Systems

This repo contains programs developed for the "Concurrent Systems and Operating Systems" module that is part of my ICS course. This module teaches about concurrent programming, modelling programs and OSes. The concurrent programming was completed in the C programming language, Modelling was done using Promela and SPIN and finally OSes was as competed in C.

Introduction : Simple program that starts a number of threads using the pthread library. Each thread accesses a global variable and alters it. This program is designed to demonstrate concurrency problems, the results from each run can vary due to the none deterministic nature of thread execution.

Practical2: This program uses Mutex locks from the pthread library to protect global variables, this stops concurrency problems.

Practical3: This is a model of the dining philosophers problem developed in Promela, then compiled and ran as a C program using SPIN

Practical4: Uses a cut down version of the xv6 operating system with the task being to develop a round-robin like scheduling policy.
