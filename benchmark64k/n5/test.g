//genesis script for a simple compartment simulation (Tutorial #1)
//batchtest.g

create neutral /cell
create compartment /cell/soma
setfield /cell/soma Rm 10 Cm 2 Em 25 inject 5

// send output to a file
    create asc_file /out
    setfield /out    flush 1    leave_open 1
    setclock 1 1.0
    useclock /out 1
    addmsg       /cell/soma     /out       SAVE Vm

setclock 0 0.001 // this is to make it run slowly
reset
step 100 -time
exit
