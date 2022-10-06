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
