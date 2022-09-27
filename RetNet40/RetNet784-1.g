float dt = 0.00005 // simulation time step in sec
setclock  0  {dt}  // set the simulation clock

int array_minx =  1     // najmniejszy indeks x
int array_miny =  1     // najmniejszy indeks y
int array_minz =  1     // najmniejszy indeks z

float sep_x = 40e-6     // odleglosc miedzy neuronami w kierunku x w metrach
float sep_y = 40e-6     // odleglosc miedzy neuronami w kierunku y w metrach
float sep_z = 40e-6     // odleglosc miedzy neuronami w kierunku z w metrach


include functions.g
include protodefs.g

readcell cell.p /cell

randseed

make_circuit_2d /cell /retina_net 28 28
make_circuit_2d_output /retina_net 28 28 rec-netRet784

make_circuit_3d /cell /column_net_1 8 8 16
make_circuit_3d_output /column_net_1 8 8 16 rec-netRet784-column1

make_circuit_3d /cell /column_net_2 8 8 16
make_circuit_3d_output /column_net_2 8 8 16 rec-netRet784-column2

make_circuit_3d /cell /column_net_3 8 8 16
make_circuit_3d_output /column_net_3 8 8 16 rec-netRet784-column3

make_circuit_3d /cell /column_net_4 8 8 16
make_circuit_3d_output /column_net_4 8 8 16 rec-netRet784-column4

int i1,j1,k1,i2,j2,k2,ri,rj

float probability = 0.01

for (i1=1; i1<=8; i1={i1+1})
 for (j1=1; j1<=8; j1={j1+1})
  for (k1=1; k1<=16; k1={k1+1})
   for (i2=1; i2<=8; i2={i2+1})
     for (j2=1; j2<=8; j2={j2+1})
       for (k2=1; k2<=16; k2={k2+1})

       if ( {rand 0 1} < {probability} )            
        make_synapse /column_net_1_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_1_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end

       if ( {rand 0 1} < {probability} )            
        make_synapse /column_net_2_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_2_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end

       if ( {rand 0 1} < {probability} )            
        make_synapse /column_net_3_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_3_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end

       if ( {rand 0 1} < {probability} )            
        make_synapse /column_net_4_{i1}_{j1}_{k1}/soma/spike \
                     /column_net_4_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0                     
       end
           
    end
   end
  end
 end
 end
end

for (i1=1; i1<=8; i1={i1+1})
 for (j1=1; j1<=8; j1={j1+1})
  for (k1=1; k1<=16; k1={k1+1})

  // połaczenie pola recepcyjnego nr 1 z kolumną kory nr 1

       for (ri=1; ri<=14; ri={ri+1})
       	for (rj=1; rj<=14; rj={rj+1})

         if ( {rand 0 1} < {probability} )            
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
                       /column_net_1_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
       	 end
       	end
       end

  // połaczenie pola recepcyjnego nr 2 z kolumną kory nr 2

       for (ri=15; ri<=28; ri={ri+1})
       	for (rj=1; rj<=14; rj={rj+1})

         if ( {rand 0 1} < {probability} )            
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
                       /column_net_2_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
       	 end
       	end
       end

  // połaczenia pola recepcyjnego nr 3 z kolumną kory nr 3

       for (ri=1; ri<=14; ri={ri+1})
       	for (rj=15; rj<=28; rj={rj+1})

         if ( {rand 0 1} < {probability} )            
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
    		      /column_net_3_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
       	 end
       	end
       end

  // połączenie pola recepcyjnego nr 4 z kolumną kory nr 4
  
       for (ri=15; ri<=28; ri={ri+1})
       	for (rj=15; rj<=28; rj={rj+1})

         if ( {rand 0 1} < {probability} )            
          make_synapse /retina_net_{ri}_{rj}/soma/spike \
                       /column_net_4_{i1}_{j1}_{k1}/dend/Ex_channel 3.8 0
       	 end
       	end
       end

  end
 end
end

// zmieniłem średnią częstość generatora pików potencjałów czynnościowych komórek układu wzrokowego na 200Hz
create randomspike /input
setfield ^ min_amp 1 max_amp 1 rate 200 reset 1 reset_value 0

reset
check

// podłączenie generatora impulsów do kanałów wzbudzających siatkówki
make_synapse /input /retina_net_08_14/dend/Ex_channel 2 0
make_synapse /input /retina_net_09_13/dend/Ex_channel 2 0
make_synapse /input /retina_net_10_12/dend/Ex_channel 2 0
make_synapse /input /retina_net_11_11/dend/Ex_channel 2 0
make_synapse /input /retina_net_12_10/dend/Ex_channel 2 0
make_synapse /input /retina_net_13_9/dend/Ex_channel 2 0
make_synapse /input /retina_net_14_8/dend/Ex_channel 2 0
make_synapse /input /retina_net_15_7/dend/Ex_channel 2 0
make_synapse /input /retina_net_16_6/dend/Ex_channel 2 0
make_synapse /input /retina_net_17_5/dend/Ex_channel 2 0
make_synapse /input /retina_net_18_4/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_3/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_4/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_5/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_6/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_7/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_8/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_9/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_10/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_11/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_12/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_13/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_14/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_15/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_16/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_17/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_18/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_19/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_20/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_21/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_22/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_23/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_24/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_25/dend/Ex_channel 2 0
make_synapse /input /retina_net_19_26/dend/Ex_channel 2 0

step 1 -time

getstat -time -step -memory
showstat
showstat -element
showstat -process
