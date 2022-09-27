float dt = 0.00005 // simulation time step in sec
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

make_circuit_2d /cell /retina_net 5 8
make_circuit_2d_output /retina_net 5 8 RetNet40-6-retina

make_circuit_3d /cell /column_net_1 5 8 25
make_circuit_3d_output /column_net_1 5 8 25 RetNet40-6-column

int i1,j1,k1,i2,j2,k2,ri,rj

float probability = 0.01

for (i1=1; i1<=5; i1={i1+1})
 for (j1=1; j1<=8; j1={j1+1})
  for (k1=1; k1<=25; k1={k1+1})
   for (i2=1; i2<=5; i2={i2+1})
     for (j2=1; j2<=8; j2={j2+1})
       for (k2=1; k2<=25; k2={k2+1})

       if ( {rand 0 1} < {probability} )
        make_synapse /column_net_1_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_1_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end

    end
   end
  end
 end
 end
end

for (i1=1; i1<=5; i1={i1+1})
 for (j1=1; j1<=8; j1={j1+1})
  for (k1=1; k1<=25; k1={k1+1})

  // connecting retina to the column 1

       for (ri=1; ri<=5; ri={ri+1})
        for (rj=1; rj<=8; rj={rj+1})

         if ( {rand 0 1} < {probability} )
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

step 1 -time

getstat -time -step -memory
showstat
showstat -element
showstat -process
