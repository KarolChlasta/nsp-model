// Neural Simulation Pipeline
//
// Parameters:
// - Required
// $modelName$ default RetNet40
// $simulationTime$ default 1
// $simulationTimeStepInSec$ default 0.00005
// $columnDepth$ default 25 (1000 neurons)
// $synapticProbability$ default 0.01
// $modelName$ default RetNet40
// $retX$ default 5
// $retY$ default 8
// - Optional
// $parallelMode
// $numNodes
// $modelInput

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
make_circuit_2d_output /retina_net $retX$ $retY$ $modelName$-0-retina

make_circuit_3d /cell /column_net_1 $retX$ $retY$ $columnDepth$
make_circuit_3d_output /column_net_1 $retX$ $retY$ $columnDepth$ $modelName$-0-column

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

if ( $modelInput$ == 0 )
  make_synapse /input /retina_net_2_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_6_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_6_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_7_3/dend/Ex_channel 2 0
  echo Pattern 0
elif ( $modelInput$ == 1 )
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_8/dend/Ex_channel 2 0
  echo Pattern 1
elif ( $modelInput$ == 2 )
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_8/dend/Ex_channel 2 0
  echo Pattern 2
elif ( $modelInput$ == 3 )
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  echo Pattern 3
elif ( $modelInput$ == 4 )
  make_synapse /input /retina_net_1_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_8/dend/Ex_channel 2 0
  echo Pattern 4
elif ( $modelInput$ == 5 )
  make_synapse /input /retina_net_1_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  echo Pattern 5
elif ( $modelInput$ == 6 )
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_8/dend/Ex_channel 2 0
  echo Pattern 6
elif ( $modelInput$ == 7 )
  make_synapse /input /retina_net_1_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
  echo Pattern 7
elif ( $modelInput$ == 8 )
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_8/dend/Ex_channel 2 0
  echo Pattern 8
elif ( $modelInput$ == 9 )
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_8/dend/Ex_channel 2 0
  echo Pattern 9
elif ( $modelInput$ == P )
  make_synapse /input /retina_net_1_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_8/dend/Ex_channel 2 0
  echo Pattern P
elif ( $modelInput$ == J )
  make_synapse /input /retina_net_1_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  echo Pattern J
elif ( $modelInput$ == A )
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_8/dend/Ex_channel 2 0
  echo Pattern A
elif ( $modelInput$ == T )
  make_synapse /input /retina_net_1_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_8/dend/Ex_channel 2 0
  echo Pattern T
elif ( $modelInput$ == K )
  make_synapse /input /retina_net_1_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_1/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_2/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_4/dend/Ex_channel 2 0
  make_synapse /input /retina_net_2_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_5/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_3_6/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_4_7/dend/Ex_channel 2 0
  make_synapse /input /retina_net_1_8/dend/Ex_channel 2 0
  make_synapse /input /retina_net_5_8/dend/Ex_channel 2 0
  echo Pattern K
else
  echo Unrecognized pattern
end

// start simulation
step $simulationTime$ -time

echo "statistics"
getstat -time -step -memory
showstat
showstat -element
showstat -process

exit