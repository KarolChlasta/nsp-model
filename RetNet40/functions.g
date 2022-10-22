function make_synapse(pre,post,weight,delay)
 str pre,post
 float weight,delay
 int syn_num
   addmsg {pre} {post} SPIKE
   syn_num = {getfield {post} nsynapses} - 1
   setfield {post} synapse[{syn_num}].weight {weight} \
                   synapse[{syn_num}].delay {delay}
   echo {pre} "--->" {post} {weight} {delay}
end

function make_circuit_2d(protocell, net, nx, ny)
  str protocell
  int i,j
    for (i=1; i<={nx};i={i+1})
      for (j=1; j<={ny};j={j+1})
        copy {protocell} {net}_{i}_{j} 
        position {net}_{i}_{j} { {array_minx} + ({sep_x} * {i}) } \
                               { {array_miny} + ({sep_y} * {j}) } \
                               { 0 }
      end
    end
end

function make_circuit_2d_output(net, nx, ny, filename)
 int i,j
 create spikehistory {net}-history
 setfield ^ filename {filename}.dat append 0 ident_toggle 1
 for (i=1; i<={nx}; i={i+1})
  for (j=1; j<={ny}; j={j+1})

             addmsg {net}_{i}_{j}/soma/spike {net}-history SPIKESAVE

        end
    end

echo {net} spike activity saved to file {filename}.dat
end

function make_circuit_3d(protocell, net, nx, ny, nz)
str protocell
int i,j,k

 for (i=1; i<={nx};i={i+1})
  for (j=1; j<={ny};j={j+1})
    for (k=1; k<={nz};k={k+1})

      copy {protocell} {net}_{i}_{j}_{k}

      position {net}_{i}_{j}_{k} { {array_minx} + ({sep_x} * {i}) } \
                                 { {array_miny} + ({sep_y} * {j}) } \
                                 { {array_minz} + ({sep_z} * {k}) }
    end
  end
 end
end


function make_circuit_3d_output(net, nx, ny, nz, filename)
int i,j,k

    create spikehistory {net}-history

    setfield ^ filename {filename}.dat append 0 ident_toggle 1

    for (i=1; i<={nx}; i={i+1})
        for (j=1; j<={ny}; j={j+1})
            for (k=1; k<={nz};k={k+1})

             addmsg {net}_{i}_{j}_{k}/soma/spike {net}-history SPIKESAVE

            end
        end
    end

echo {net} spike activity saved to file {filename}.dat
end

function generate_pattern_RetNet40(code)
  if ( code == 0 )
    make_synapse /input /retina_net_1_1/dend/Ex_channel 2 0
    make_synapse /input /retina_net_1_2/dend/Ex_channel 2 0
    make_synapse /input /retina_net_1_3/dend/Ex_channel 2 0
    make_synapse /input /retina_net_1_4/dend/Ex_channel 2 0
    make_synapse /input /retina_net_1_5/dend/Ex_channel 2 0
    make_synapse /input /retina_net_1_6/dend/Ex_channel 2 0
    make_synapse /input /retina_net_1_7/dend/Ex_channel 2 0
    make_synapse /input /retina_net_1_8/dend/Ex_channel 2 0
    make_synapse /input /retina_net_2_8/dend/Ex_channel 2 0
    make_synapse /input /retina_net_3_8/dend/Ex_channel 2 0
    make_synapse /input /retina_net_4_8/dend/Ex_channel 2 0
    make_synapse /input /retina_net_5_8/dend/Ex_channel 2 0
    make_synapse /input /retina_net_5_7/dend/Ex_channel 2 0
    make_synapse /input /retina_net_5_6/dend/Ex_channel 2 0
    make_synapse /input /retina_net_5_5/dend/Ex_channel 2 0
    make_synapse /input /retina_net_5_4/dend/Ex_channel 2 0
    make_synapse /input /retina_net_5_3/dend/Ex_channel 2 0
    make_synapse /input /retina_net_5_2/dend/Ex_channel 2 0
    make_synapse /input /retina_net_5_1/dend/Ex_channel 2 0
    make_synapse /input /retina_net_4_1/dend/Ex_channel 2 0
    make_synapse /input /retina_net_3_1/dend/Ex_channel 2 0
    make_synapse /input /retina_net_2_1/dend/Ex_channel 2 0
    echo Pattern 0
  elif ( code == 1 )
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
  elif ( code == 2 )
    echo Pattern 2
  elif ( code == 3 )
    echo Pattern 3
  elif ( code == 4 )
    echo Pattern 4
  elif ( code == 5 )
    echo Pattern 5
  elif ( code == 6 )
    echo Pattern 6
  elif ( code == 7 )
    echo Pattern 7
  elif ( code == 8 )
    echo Pattern 8
  elif ( code == 9 )
    echo Pattern 9
  elif ( code == P )
    echo Pattern P  
  elif ( code == J )
    echo Pattern J  
  elif ( code == A )
    echo Pattern A  
  elif ( code == T )
    echo Pattern T
  elif ( code == K )
    echo Pattern K
  else
    echo Unrecognized pattern
  end
end