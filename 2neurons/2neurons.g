paron -parallel -nodes 3
int NodesNumber = 3
setclock 0 0.0001

include functions
include pfunctions
include protodefs

if ({mynode}==1)
readcell@1 cell.p /CellA
end

if ({mynode}==2)
readcell@2 cell.p /CellB
end

if ({mynode}==1)
create@1 randomspike /input
setfield@1 ^ min_amp 1 max_amp 1 rate 200 reset 1 \
             reset_value 0
end

barrier

if ({mynode}==1)
  make_synapse /input /CellA/dend/Ex_channel 2 0
  pmake_synapse /CellA/soma/spike 1 \
                /CellB/dend/Ex_channel 2 15 0
end

barrier

if ( {mynode}==1 )
  create spikehistory net-history
  setfield ^ filename CellA-at1-spike.dat append 0 ident_toggle 1
  addmsg /CellA/soma/spike net-history SPIKESAVE

  create asc_file /soma_potential
  setfield /soma_potential filename CellA-at1-potential.dat append 0
  addmsg /CellA/soma /soma_potential SAVE Vm
end

barrier

if ( {mynode}==2 )
  create spikehistory net-history
  setfield ^ filename CellB-at2-spike.dat append 0 ident_toggle 1
  addmsg /CellB/soma/spike net-history SPIKESAVE

  create asc_file /soma_potential
  setfield /soma_potential filename CellB-at2-potential.dat append 0
  addmsg /CellB/soma /soma_potential SAVE Vm
end

barrier

reset
step $simulationTime$ -time
paroff

echo "statistics" > 2neurons.sts
getstat -time -step -memory >> 2neurons.sts
showstat >> 2neurons.sts
showstat -element >> 2neurons.sts
showstat -process >> 2neurons.sts

exit
