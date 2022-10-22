// Neural Simulation Pipeline
//
// Parameters:
// - Required
// $modName$ default RetNet40
// $simulationTime$ default 1
// $simulationTimeStepInSec$ default 0.00005
// $columnDepth$ default 25 (1000 neurons)
// $synapticProbability$ default 0.01
// $modName$ default RetNet40
// $retX$ default 5
// $retY$ default 8
// - Optional
// $parallelMode
// $numNodes

float dt = $simulationTimeStepInSec$ // simulation time step in sec
setclock  0  {dt}  // set the simulation clock

int array_minx =  1     // the smallest index x
int array_miny =  1     // the smallest index y
int array_minz =  1     // the smallest index z

float sep_x = 40e-6     // distance between neurons in the direction of x in meters
float sep_y = 40e-6     // distance between neurons in the direction of x in meters
float sep_z = 40e-6     // distance between neurons in the direction of z in meters

include functions.g
include protodefs.g

readcell cell.p /cell

randseed

make_circuit_2d /cell /retina_net $retX$ $retY$
make_circuit_2d_output /retina_net $retX$ $retY$ $modName$-0-retina

make_circuit_3d /cell /column_net_1 $retX$ $retY$ $columnDepth$
make_circuit_3d_output /column_net_1 $retX$ $retY$ $columnDepth$ $modName$-0-column

int i1,j1,k1,i2,j2,k2,ri,rj

for (i1=1; i1<=$retX$; i1={i1+1})
 for (j1=1; j1<=$retY$; j1={j1+1})
  for (k1=1; k1<=$columnDepth$; k1={k1+1})
   for (i2=1; i2<=$retX$; i2={i2+1})
     for (j2=1; j2<=$retY$; j2={j2+1})
       for (k2=1; k2<=$columnDepth$; k2={k2+1})

       if ( {rand 0 1} < {$synapticProbability$} )
        make_synapse /column_net_1_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_1_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end

    end
   end
  end
 end
 end
end

for (i1=1; i1<=$retX$; i1={i1+1})
 for (j1=1; j1<=$retY$; j1={j1+1})
  for (k1=1; k1<=$columnDepth$; k1={k1+1})

  // connecting retina to the column 1

       for (ri=1; ri<=$retX$; ri={ri+1})
        for (rj=1; rj<=$retY$; rj={rj+1})

         if ( {rand 0 1} < {$synapticProbability$} )
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
                       /column_net_1_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
         end
        end
       end

  end
 end
end

// generator of spikes set to 200Hz
create randomspike /input
setfield ^ min_amp 1 max_amp 1 rate 200 reset 1 reset_value 0

check
reset

// connecting impulses to stimulate retina

step $simulationTime$ -time

echo "statistics"
getstat -time -step -memory
showstat
showstat -element
showstat -process

exit