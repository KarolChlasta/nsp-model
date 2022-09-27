#!/bin/bash
date > RetNet40-09PJATK-time.out

#screen -d -m 'genesis RetNet40-0.g 1> RetNet40-0.out 2> RetNet40-0.out'
nxgenesis -batch -notty RetNet40-0.g 1> RetNet40-0.out 2> RetNet40-0.out
nxgenesis -batch -notty RetNet40-1.g 1> RetNet40-1.out 2> RetNet40-1.out
nxgenesis -batch -notty RetNet40-2.g 1> RetNet40-2.out 2> RetNet40-2.out
nxgenesis -batch -notty RetNet40-3.g 1> RetNet40-3.out 2> RetNet40-3.out
nxgenesis -batch -notty RetNet40-4.g 1> RetNet40-4.out 2> RetNet40-4.out
nxgenesis -batch -notty RetNet40-5.g 1> RetNet40-5.out 2> RetNet40-5.out
nxgenesis -batch -notty RetNet40-6.g 1> RetNet40-6.out 2> RetNet40-6.out
nxgenesis -batch -notty RetNet40-7.g 1> RetNet40-7.out 2> RetNet40-7.out
nxgenesis -batch -notty RetNet40-8.g 1> RetNet40-8.out 2> RetNet40-8.out
nxgenesis -batch -notty RetNet40-9.g 1> RetNet40-9.out 2> RetNet40-9.out
nxgenesis -batch -notty RetNet40-P.g 1> RetNet40-P.out 2> RetNet40-P.out
nxgenesis -batch -notty RetNet40-J.g 1> RetNet40-J.out 2> RetNet40-J.out
nxgenesis -batch -notty RetNet40-A.g 1> RetNet40-A.out 2> RetNet40-A.out
nxgenesis -batch -notty RetNet40-T.g 1> RetNet40-T.out 2> RetNet40-T.out
nxgenesis -batch -notty RetNet40-K.g 1> RetNet40-K.out 2> RetNet40-K.out

date >> RetNet40-09PJATK-time.out
