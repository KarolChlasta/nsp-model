//******************************************************************
//*                                                                *
//*                 Grzegorz M. Wojcik (c)2002 [Obidos]            *
//*                                                                *
//******************************************************************
//*                   Function Definitions                         *
//******************************************************************

function rmake_synapse(pre,post,weight,delay,npos)
 str pre,post
 float weight,delay
 int syn_num,npos

 addmsg {pre} {post} SPIKE
 syn_num = {getfield {post} nsynapses} - 1
 setfield {post} synapse[{syn_num}].weight {weight} \
	           synapse[{syn_num}].delay {delay} 
 // echo {pre} "--->" {post} {weight} {delay}	
 
	           
end
//--------------------------------------------------------------------

function intermake_synapse(pre,post,weight,delay,npos)
 str pre,post
 float weight,delay
 int syn_num,npos

if ( mynode == {0})
 raddmsg@{0} {pre} {post} SPIKE

 syn_num = {getfield{0} {post} nsynapses} - 1
 setfield@{0} {post} synapse[{syn_num}].weight {weight} \
	         synapse[{syn_num}].delay {delay} 
 
end

// echo {pre} "--->" {post} {weight} {delay}	
 
	           
end
//--------------------------------------------------------------------


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
//--------------------------------------------------------------------

function destroy_synapse(pre,post)
 str pre,post
 float weight,delay
 int syn_num
	
   deletemsg {post} 1 -incoming
   echo {pre} "--->" {post} connection destroyed...
	           
end
//--------------------------------------------------------------------

function rmake_retina(cell)
str cell
int npos,i,j

for (npos=1; npos<=NodesNumber; npos={npos+1})

if ({mynode}=={npos})

 for (i=1; i<={patchdim};i={i+1})
  for (j=1; j<={patchdim};j={j+1})
     
   copy retinal_cell retina_{i}_{j}@{npos}
 
   position retina_{i}_{j}@{npos} { {array_minx} + ({sep_x} * {i}) } \
                                  { {array_miny} + ({sep_y} * {j}) } \
                                  { 0 }
  end
 end

end //if

end
end
//--------------------------------------------------------------------


function rmake_readout(cell)
str cell
int npos,i,j

for (npos=1; npos<={NodesNumber}; npos={npos+1})

if ({mynode}=={npos})

 for (i=1; i<={patchdim};i={i+1})
  for (j=1; j<={patchdim};j={j+1})
  
   copy {cell} /readout_{i}_{j}@{npos}
 
   position /readout_{i}_{j}@{npos} { {array_minx} + ({sep_x} * {i}) } \
                                    { {array_miny} + ({sep_y} * {j}) } \
                                    { 0 } 
  end
 end

end //if
end
end
//--------------------------------------------------------------------

function rmake_brain (proto, net, lx,ly,lz, npos)
 str proto, net
 int lx,ly,lz, npos
 int i,j,k, npos

   if (lx>0)
    array_Nx={lx}
   end
   if (ly>0) 
    array_Ny={ly} 
   end
   if (lz>0)
    array_Nz={lz}
   end

   echo "Brain creation on the net:"  {array_Nx} "x" {array_Ny} "x" {array_Nz}

 for (npos=1; npos<=NodesNumber; npos={npos+1})
 
 if ({mynode}=={npos})
   for (i=1; i<={array_Nx} ; i={i+1})
     for (j=1; j<={array_Ny} ; j={j+1})
       for (k=1; k<={array_Nz}; k={k+1})
        copy {proto} {net}{npos}_{i}_{j}_{k}@{npos}
        position {net}{npos}_{i}_{j}_{k}@{npos}  { {array_minx} + ({sep_x} * {i}) } \
                                 { {array_miny} + ({sep_y} * {j}) } \
                                 { {array_minz} + ({sep_z} * {k}) }
      end
     end
   end
 
 echo "Brain" {npos} "creation process finished on node" {npos} "..."
  
 end //if
 
 end //npos
end
//--------------------------------------------------------------------

function connect_layers(net,i,i1)

str net
int i,j,k,i1,j1,k1
float random_weight

      for (j=1; j<={array_Nx} ; j={j+1})
       for (k=1; k<={array_Ny} ; k={k+1})
          for (j1=1; j1<={array_Nx}; j1={j1+1})
          for (k1=1; k1<={array_Ny}; k1={k1+1})
  
             random_weight = {rand {min_weight} {max_weight}} 
             make_synapse {net}_{j}_{k}_{i}_/soma/spike {net}_{j1}_{k1}_{i1}_/dend1/Ex_channel \\
                          {random_weight} {delay}
             make_synapse {net}_{j}_{k}_{i}_/soma/spike {net}_{j1}_{k1}_{i1}_/dend1/Ex_channel \\
                          {random_weight} {delay}
           
         
        end
       end
      end
     end

    
end

//--------------------------------------------------------------------

function rconnect_layers(net,i,i1,npos)

str net
int i,j,k,i1,j1,k1,npos
float random_weight, random_prob

      for (j=1; j<={array_Nx} ; j={j+1})
       for (k=1; k<={array_Ny} ; k={k+1})
          for (j1=1; j1<={array_Nx}; j1={j1+1})
          for (k1=1; k1<={array_Ny}; k1={k1+1})
  
             random_weight = {rand {min_weight} {max_weight}} 
             
             random_prob = { rand 0 1}
             
             if (random_prob <= inter_layer_prob)
             
             rmake_synapse@{npos} {net}_{j}_{k}_{i}@{npos}/soma/spike \
                           {net}_{j1}_{k1}_{i1}@{npos}/dend1/Ex_channel \
                           {random_weight} {delay} {npos}
             else
             rmake_synapse@{npos} {net}_{j}_{k}_{i}@{npos}/soma/spike \
                           {net}_{j1}_{k1}_{i1}@{npos}/dend1/Inh_channel \
                           {random_weight} {delay} {npos}
             end //if
        end
       end
      end
     end
end

//--------------------------------------------------------------------

function interconnect_layers(net,i,i1,npos)

str net
int i,j,k,i1,j1,k1,npos
float random_weight, random_prob

      for (j=1; j<={array_Nx} ; j={j+1})
       for (k=1; k<={array_Ny} ; k={k+1})
          for (j1=1; j1<={array_Nx}; j1={j1+1})
          for (k1=1; k1<={array_Ny}; k1={k1+1})
  
             random_weight = {rand {min_weight} {max_weight}} 
             
             random_prob = { rand 0 1}
          
             if (random_prob <= inter_layer_prob)
             
             intermake_synapse {net}{npos}_{j}_{k}_{i}@{npos}/soma/spike \
                               {net}{npos+1}_{j1}_{k1}_{i1}@{npos+1}/dend2/Ex_channel \
                               {random_weight} {delay} {npos+1}
 
             
             //echo "Intercolumn excitation..."
             else
             intermake_synapse {net}{npos}_{j}_{k}_{i}@{npos}/soma/spike \
                               {net}{npos+1}_{j1}_{k1}_{i1}@{npos+1}/dend2/Inh_channel \
                               {random_weight} {delay} {npos+1}
             //echo "Intercolumn inhibition..." 
             end
        end
       end
      end
     end
end //interconnect_layers

//--------------------------------------------------------------------

function rmake_layers(net, npos)
str net
int i,npos

//especially for the real 6 layers

 for (i=2;i<=14;i={i+3})
  rconnect_layers {net} {i} {i+1} {npos}
  rconnect_layers {net} {i+1} {i+2} {npos}
 end
end

function rconnect_in_layers
// Paralell connection inside each node-brain

int i,j,k,i1,j1,k1, npos
float random_weight, random_prob

for (npos=1; npos<=NodesNumber; npos={npos+1})

if ({mynode}=={npos})
 
 for (i=1; i<={array_Nz} ; i={i+1}) // normally there are 16 layers   

      for (j=1; j<={array_Nx} ; j={j+1})
       for (k=1; k<={array_Ny} ; k={k+1})

         i1={i}

         for (j1=1; j1<={array_Nx}; j1={j1+1})
          for (k1=1; k1<={array_Ny}; k1={k1+1})
  
           if ({j}!={j1}||{k}!={k1})
             random_weight = {rand {min_weight} {max_weight}}
             random_prob = { rand 0 1}
             
             if (random_prob <= in_layer_prob)
             
             rmake_synapse brain{npos}_{j}_{k}_{i}@{npos}/soma/spike \
                           brain{npos}_{j1}_{k1}_{i1}@{npos}/dend1/Ex_channel \
                           {random_weight} {delay} {npos}
             
             else
             rmake_synapse brain{npos}_{j}_{k}_{i}@{npos}/soma/spike \
                           brain{npos}_{j1}_{k1}_{i1}@{npos}/dend1/Inh_channel \
                           {random_weight} {delay} {npos}
             end //if
           end

         end
        end
       end
      end
     end

echo "Brain" {npos} "connection process finished on node" {npos} "..."
end //if

end //npos
end

function connect_in_layers (net)   
// This function connects layers an all neurns in the column

str net
int i,j,k,i1,j1,k1
float random_weight

// We will connect the neurons in the layers first...
// Without self-cpnnections, first we count layers (i) and (j) and (k) are
// the counters of cells in each layer (usually there are 4 cells in the layer)
   
     for (i=1; i<={array_Nz} ; i={i+1}) // normally there are 6 layers   

      for (j=1; j<={array_Nx} ; j={j+1})
       for (k=1; k<={array_Ny} ; k={k+1})

         i1={i}

         for (j1=1; j1<={array_Nx}; j1={j1+1})
          for (k1=1; k1<={array_Ny}; k1={k1+1})
  
           if ({j}!={j1}||{k}!={k1})
             random_weight = {rand {min_weight} {max_weight}} 
             make_synapse {net}_{j}_{k}_{i}_/soma/spike {net}_{j1}_{k1}_{i1}_/dend1/Ex_channel \\
                          {random_weight} {delay}
           end

         end
        end
       end
      end
     end
    end


//--------------------------------------------------------------------

function rconnect_layers_in_columns

int npos

// 16 layers - 6 in reality. 1 for LGN, 3 for each else 1 + 5*3 = 16

  for (npos=1;npos<={NodesNumber};npos={npos+1})
   if ({mynode}=={npos})
    rmake_layers /brain{npos} {npos}
   end //if
  end
 
  echo "Layers made..."
	 
  for (npos=1;npos<={NodesNumber};npos={npos+1})

  if ({mynode}=={npos})
	  
    // Connect (LGN) with (L4)
       rconnect_layers /brain{npos} 1 2 {npos}
	       
    // Connect (L4) with (L3)
       rconnect_layers /brain{npos} 4 5 {npos}
		    
    // Connect (L3) with (L2)
       rconnect_layers /brain{npos} 7 8 {npos}
			 
    // Connect (L2) with (L5)
       rconnect_layers /brain{npos} 10 11 {npos}
			      
    // Connect (L5) with (L6)
       rconnect_layers /brain{npos} 13 14 {npos}
		   
    // Connect (L6) with (L1)
       rconnect_layers /brain{npos} 16 1 {npos}
					
      echo "Brain" {npos} "layers connection process finished..."

   end //if
  
  end //npos
end // function				  

function rconnect_columns (net)
// Connects column 1st with 2nd, 2nd with 3rd,..., 15th with 16th, etc
// Connects L6 with LGN
// (c) 2005 gmwojcik - Edinburgh

str net
int i;

for (npos=1; npos<={nnodes-1}; npos={npos+1})

if ({mynode}=={npos})
 interconnect_layers {net} 16 1 {npos}
end //if

echo "Columns connected..."
end

end //rconnect_columns


function connect_collumns (net)   
// This function connects HHLSM columns with one another
// Only to inhabitory channels among 2nd layers of HHLSMs
// Probability hhlsm of connection between columns is set here to be 20%

str net
int i,j,k,i1,j1,k1
float random_weight, prob_hhlsm

//Loop over brains i and i1

    for (i=1; i<=25 ; i={i+1})
      for (i1=1; i1<=25; i1={i1+1})

         prob_hhlsm = {rand 0 1}
	 
         if ((i!=i1)&&{prob_hhlsm}<0.2) //no self-connections and proper probability
	 
	     random_weight = {rand {min_weight} {max_weight}}
	      
             make_synapse {net}{i}_{1}_{1}_{2}_/soma/spike \\
	     {net}{i1}_{1}_{1}_{2}_/dend2/Inh_channel {random_weight} {delay}
	     
	     make_synapse {net}{i}_{1}_{2}_{2}_/soma/spike \\
	     {net}{i1}_{1}_{2}_{2}_/dend2/Inh_channel {random_weight} {delay}
	     
	     make_synapse {net}{i}_{2}_{1}_{2}_/soma/spike \\
	     {net}{i1}_{2}_{1}_{2}_/dend2/Inh_channel {random_weight} {delay}
	     
	     make_synapse {net}{i}_{2}_{2}_{2}_/soma/spike \\
	     {net}{i1}_{2}_{2}_{2}_/dend2/Inh_channel {random_weight} {delay}
			  
	 end		  
	 
      end
     end
end

//--------------------------------------------------------------------

function rconnect_retina_with_LSM(ret, net)
// This function connects the retina patches to proper patches of the  neocortex LGNs...

 str ret, net
 int i,j,k,npos
 float random_weight
 
 
 for (npos=1; npos<=NodesNumber; npos={npos+1})
 
 if ({mynode}=={npos}) 
 
  for (i=1; i<={patchdim}; i={i+1})
   for (j=1; j<={patchdim}; j={j+1})
    
    random_weight = {rand {min_weight} {max_weight}}
  
    rmake_synapse {ret}_{i}_{j}@{npos}/soma/spike \
                  {net}{npos}_{i}_{j}_{1}@{npos}/dend1/Ex_channel \
                  {random_weight} {delay} {npos}
   end  
  end
  
 
 end //if 
 end //npos
  
end

//-------------------------------------------------------------------------------------------

function rconnect_readout_with_LSM (rea, net)
// This function connects the retina patches to proper patches of the  neocortex LGNs...

 str rea, net
 int i,j,k,npos,m,n
 float random_weight
 
 
 for (npos=1; npos<={NodesNumber}; npos={npos+1})
 
  if ({mynode}=={npos})
  
  for (i=1; i<={patchdim}; i={i+1})
   for (j=1; j<={patchdim}; j={j+1})
    
    random_weight = {rand {min_weight} {max_weight}}
  
    rmake_synapse {net}{npos}_{i}_{j}_{5}@{npos}/soma/spike \
                  {rea}_{i}_{j}@{npos}/dend1/Ex_channel \
                  {random_weight} {delay} {npos}
   end  
  end
  
 end //if 
 end //npos

end

//-------------------------------------------------------------------------------------------

function connect_retina_with_LSM (ret, net)
// This function connects the retina patches to proper patches of the  neocortex LGNs...

 str ret, net
 int i,j,k,j1,j2,j3,j4,k1,k2,k3,k4
 float random_weight

  
    i=1 // LSM column number
    
    for (j=1;j<=9;j={j+2})  // counting through retina patches
     for (k=1;k<=9;k={k+2}) 

          j1 = j            //counting coordinates
	  k1 = k
	  j2 = j+1
	  k2 = k
	  j3 = j
	  k3 = k+1
	  j4 = j+1
	  k4 = k+1  


          random_weight = {rand {min_weight} {max_weight}}
          make_synapse {ret}_{j1}_{k1}/soma/spike {net}{i}_{1}_{1}_{1}_/dend1/Ex_channel \\
                          {random_weight} {delay}
	  
	  random_weight = {rand {min_weight} {max_weight}}
          make_synapse {ret}_{j2}_{k2}/soma/spike {net}{i}_{2}_{1}_{1}_/dend1/Ex_channel \\
                          {random_weight} {delay}
          
	  random_weight = {rand {min_weight} {max_weight}}
          make_synapse {ret}_{j3}_{k3}/soma/spike {net}{i}_{1}_{2}_{1}_/dend1/Ex_channel \\
                          {random_weight} {delay}
			  
	  random_weight = {rand {min_weight} {max_weight}}  
          make_synapse {ret}_{j4}_{k4}/soma/spike {net}{i}_{2}_{2}_{1}_/dend1/Ex_channel \\
                          {random_weight} {delay}


          i=i+1

     end
    end

end

//--------------------------------------------------------------------

function connect_readout(net, file)
// This function connects neurons in specialised readout for the movement detection
// file = 1 - verticallly
// file = 2 - horizontally

str net
int file, i, j, k, min_w, max_w
float random_weight

if (file == 1)

 for (i=1; i<={readout_Nx}; i={i+1})
          
       //   min_w = 10*i
       //   max_w = (10.2)*i
       
            min_w = 0.9*{exp{ i/4}}
	    max_w = 1.1*{exp {i/4}}
          
          for (j=1; j<={readout_Ny}; j={j+1})
           for (k=1; k<={readout_Ny}; k={k+1})
           if ({j}!={k})
             random_weight = {rand {min_w} {max_w}} 
             make_synapse {net}_{j}_{i}_/soma/spike {net}_{k}_{i}_/dend1/Ex_channel \\
                          {random_weight} {delay}
           end //if
           end //for

         end //for
        end //for

end //if

if (file == 2)

      for (i=1; i<={readout_Ny}; i={i+1})
          
       //   min_w = 10*i
       //   max_w = (10.2)*i
       
            min_w = 0.9*{exp{ i/4}}
	    max_w = 1.1*{exp {i/4}}
          
          for (j=1; j<={readout_Nx}; j={j+1})
           for (k=1; k<={readout_Nx}; k={k+1})
           if ({j}!={k})
             random_weight = {rand {min_w} {max_w}} 
             make_synapse {net}_{i}_{j}_/soma/spike {net}_{i}_{k}_/dend1/Ex_channel \\
                          {random_weight} {delay}
           end //if
           end //for

         end //for
        end //for


end //if

end //connect_readout

function connect_readout_with_LSM (net, rea, file)
// This function connects the retina patches to proper patches of the  neocortex LGNs...

 str rea, net
 int i,j,k,j1,j2,j3,j4,k1,k2,k3,k4,file,random_column
 float random_weight


 if (file == 0) //it means that we choose predefined network connection of patches architecture.


    i=1 // LSM column number
    
    for (j=1;j<=9;j={j+2})  // counting through retina patches
     for (k=1;k<=9;k={k+2}) 

          j1 = j            //counting coordinates
	  k1 = k
	  j2 = j+1
	  k2 = k
	  j3 = j
	  k3 = k+1
	  j4 = j+1
	  k4 = k+1  


//---------------------------------------------------------------------------------------------------------
// Now estimating which patch to which LSM... Sorry for such a coding. Dedicated to Mr. Lee.       
//---------------------------------------------------------------------------------------------------------
    
    if (i==1) 
      random_column = 15 
    end

    if (i==2) 
      random_column = 20 
    end

    if (i==3) 
      random_column = 11 
    end

    if (i==4) 
      random_column = 22 
    end

    if (i==5) 
      random_column = 2 
    end

    if (i==6) 
      random_column = 17 
    end

    if (i==7) 
      random_column = 5 
    end

    if (i==8) 
      random_column = 12 
    end

    if (i==9) 
      random_column = 6 
    end

    if (i==10) 
      random_column = 18 
    end
    
    if (i==11) 
      random_column = 8 
    end

    if (i==12) 
      random_column = 16 
    end

    if (i==13) 
      random_column = 1 
    end

    if (i==14) 
      random_column = 7 
    end

    if (i==15) 
      random_column = 13 
    end
    
    if (i==16) 
      random_column = 3 
    end

    if (i==17) 
      random_column = 4 
    end

    if (i==18) 
      random_column = 21 
    end

    if (i==19) 
      random_column = 19 
    end

    if (i==20) 
      random_column = 23 
    end
    
    if (i==21) 
      random_column = 10 
    end

    if (i==22) 
      random_column = 24 
    end

    if (i==23) 
      random_column = 14 
    end

    if (i==24) 
      random_column = 9 
    end

    if (i==25) 
      random_column = 25 
    end

//---------------------------------------------------------------------------------------------------------        
/*
    random_weight = {rand {min_weight} {max_weight}} 
    make_synapse {net}{random_column}_{j}_{k}_{3}_/soma/spike  {rea}_{j1}_{k1}_/dend1/Ex_channel \\
                          {random_weight} {delay}    
   end
  end  
*/   

          random_weight = {rand {min_weight} {max_weight}}
          make_synapse  {net}{random_column}_{1}_{1}_{3}_/soma/spike {rea}_{j1}_{k1}_/dend1/Ex_channel\\
                          {random_weight} {delay}
	  
	  random_weight = {rand {min_weight} {max_weight}}
          make_synapse  {net}{random_column}_{2}_{1}_{3}_/soma/spike {rea}_{j2}_{k2}_/dend1/Ex_channel\\
                          {random_weight} {delay}
          
	  random_weight = {rand {min_weight} {max_weight}}
          make_synapse  {net}{random_column}_{1}_{2}_{3}_/soma/spike {rea}_{j3}_{k3}_/dend1/Ex_channel\\
                          {random_weight} {delay}
			  
	  random_weight = {rand {min_weight} {max_weight}}  
          make_synapse  {net}{random_column}_{2}_{2}_{3}_/soma/spike {rea}_{j4}_{k4}_/dend1/Ex_channel\\
                          {random_weight} {delay}


          i=i+1

    end //for
   end  //for
 
 
 end // if
 
 if (file == 1) //it means that we choose network connection of patches architecture from the file patches.inp.
 
 end // if
 
 if (file == 2) // it means that we have the readout for movement detection (c) 2005
 
 i=1 // LSM column number
    
    for (j=1;j<=9;j={j+2})  // counting through retina patches
     for (k=1;k<=9;k={k+2}) 

          j1 = j            //counting coordinates
	  k1 = k
	  j2 = j+1
	  k2 = k
	  j3 = j
	  k3 = k+1
	  j4 = j+1
	  k4 = k+1  


          random_column = i   //simply from LSM to coresponding readout patches

          random_weight = {rand {min_weight} {max_weight}}
          make_synapse  {net}{random_column}_{1}_{1}_{3}_/soma/spike {rea}_{j1}_{k1}_/dend1/Ex_channel\\
                          {random_weight} {delay}
	  
	  random_weight = {rand {min_weight} {max_weight}}
          make_synapse  {net}{random_column}_{2}_{1}_{3}_/soma/spike {rea}_{j2}_{k2}_/dend1/Ex_channel\\
                          {random_weight} {delay}
          
	  random_weight = {rand {min_weight} {max_weight}}
          make_synapse  {net}{random_column}_{1}_{2}_{3}_/soma/spike {rea}_{j3}_{k3}_/dend1/Ex_channel\\
                          {random_weight} {delay}
			  
	  random_weight = {rand {min_weight} {max_weight}}  
          make_synapse  {net}{random_column}_{2}_{2}_{3}_/soma/spike {rea}_{j4}_{k4}_/dend1/Ex_channel\\
                          {random_weight} {delay}


          i=i+1

    end //for
   end  //for
 
 
 
 end //if

end

//--------------------------------------------------------------------


function make_brain_output (object,outobject, filename)
str object,filename,outobject
int i,j,k

    create spikehistory {outobject}
    setfield ^ filename {filename} append 0 ident_toggle 1
    for (i=1; i<={array_Nx}; i={i+1})
	for (j=1; j<={array_Ny}; j={j+1})
            for (k=1; k<={array_Nz}; k={k+1})
    	     addmsg {object}_{i}_{j}_{k}_/soma/spike {outobject} SPIKESAVE
	    end
        end
    end
    
    echo "***  LSM" {object} "work saved to file:" {filename}
    
end

//--------------------------------------------------------------------

function make_readout_output (object,outobject, filename)
str object,filename,outobject
int i,j

    create spikehistory {outobject}
    setfield ^ filename {filename} append 0 ident_toggle 1
    for (i=1; i<={readout_Nx}; i={i+1})
	for (j=1; j<={readout_Ny}; j={j+1})
            
    	     addmsg {object}_{i}_{j}_/soma/spike {outobject} SPIKESAVE
	    
        end
    end
    
    echo "***  Readout work saved to file:" {filename}
    
end

//--------------------------------------------------------------------

function rmake_retina_output (outobject, filename)
str filename,outobject
int i,j,npos

for (npos=1;npos<=NodesNumber;npos={npos+1})

if ({mynode}=={npos})

    create spikehistory {outobject}@{npos}
    setfield ^ filename {filename}{npos}.spike append 0 ident_toggle 1
    for (i=1; i<={patchdim}; i={i+1})
	for (j=1; j<={patchdim}; j={j+1})
            
    	     addmsg retina_{i}_{j}@{npos}/soma/spike {outobject}@{npos} SPIKESAVE
	    
        end
    end
    
    echo "***  Retina " {npos} "work saved to file:" {filename}{npos}.spike

end //if
end //npos    
end

//--------------------------------------------------------------------

function rmake_readout_output (outobject, filename)
str filename,outobject
int i,j, npos

for (npos=1;npos<=NodesNumber;npos={npos+1})

if ({mynode}=={npos})

    create spikehistory {outobject}@{npos}
    setfield ^ filename {filename}{npos}.spike append 0 ident_toggle 1
    
    for (i=1; i<={patchdim}; i={i+1})
	for (j=1; j<={patchdim}; j={j+1})
            
    	     addmsg readout_{i}_{j}@{npos}/soma/spike {outobject}@{npos} SPIKESAVE
	    
        end
    end
            
    echo "***  Readout " {npos} "work saved to file:" {filename}{npos}.spike

end //if
end //npos    
end

//--------------------------------------------------------------------

function rmake_brain_output (outobject, filename)
str filename,outobject
int i,j,k

for (npos=1;npos<=NodesNumber;npos={npos+1})

if ({mynode}=={npos})

    create spikehistory {outobject}@{npos}
    setfield ^ filename {filename}{npos}.spike append 0 ident_toggle 1
    for (i=1; i<={patchdim}; i={i+1})
	for (j=1; j<={patchdim}; j={j+1})
            for (k=1; k<={array_Nz}; k={k+1})
    	     addmsg brain{npos}_{i}_{j}_{k}@{npos}/soma/spike {outobject}@{npos} SPIKESAVE
	    end
        end
    end
    
    echo "*** LSM" {npos} "work saved to file:" {filename}{npos}.spike

end //if
end //npos    
end

//--------------------------------------------------------------------

function rmake_generator_output (outobject, filename)
str filename,outobject
int i,j, npos

for (npos=1;npos<=NodesNumber;npos={npos+1})

if ({mynode}=={npos})

    create spikehistory {outobject}@{npos}
    setfield ^ filename {filename}{npos}.spike append 0 ident_toggle 1
    
    for (i=1; i<={patchdim}; i={i+1})
	for (j=1; j<={patchdim}; j={j+1})
            
    	     addmsg generator@{npos} {outobject}@{npos} SPIKESAVE
	    
        end
    end
            
    echo "***  Generator " {npos} "work saved to file:" {filename}{npos}.spike

end //if
end //npos    
end

//--------------------------------------------------------------------


function make_retina_output (object,outobject, filename)
str object,filename,outobject
int i,j

    create spikehistory {outobject}
    setfield ^ filename {filename} append 0 ident_toggle 1
    for (i=1; i<=10; i={i+1})
	for (j=1; j<=10; j={j+1})
            
    	     addmsg {object}_{i}_{j}/soma/spike {outobject} SPIKESAVE
	    
        end
    end
    
    echo "***  Retina work saved to file:" {filename}
    
end

//--------------------------------------------------------------------


function get_brain_potentials (net)
 str net
 int i,j,k

   echo "Taking potentials from the brain guarranteed..."

   
   for (i=1; i<={array_Nx}; i={i+1})
    for (j=1; j<={array_Ny}; j={j+1})
     for (k=1; k<={array_Nz}; k={k+1}) 
      create asc_file {net}_potencjaly_{i}_{j}_{k}
      useclock {net}_potencjaly_{i}_{j}_{k} 2
      setfield {net}_potencjaly_{i}_{j}_{k} filename Vm_{i}_{j}_{k}.vm append 0
      addmsg {net}_{i}_{j}_{k}_/soma {net}_potencjaly_{i}_{j}_{k} SAVE Vm
     end
    end
   end
   
end
//--------------------------------------------------------------------

function get_readout_potentials (net)
 str net
 int i,j

   echo "Taking potentials from the readout guarranteed..."
   
   for (i=1; i<={readout_Nx}; i={i+1})
    for (j=1; j<={readout_Ny}; j={j+1})
      
      create asc_file /rea_potencjaly_{i}_{j}
      useclock /rea_potencjaly_{i}_{j} 2
      setfield /rea_potencjaly_{i}_{j} filename readout_Vm_{i}_{j}.vm append 0
      addmsg {net}_{i}_{j}_/soma /rea_potencjaly_{i}_{j} SAVE Vm
    end
   end
    
end
//--------------------------------------------------------------------

function get_retina_potentials (net)
 str net
 int i,j

   echo "Taking potentials from the retina guarranteed..."
   
   for (i=1; i<=10; i={i+1})
    for (j=1; j<=10; j={j+1})
      
      create asc_file /ret_potencjaly_{i}_{j}
      useclock /ret_potencjaly_{i}_{j} 2
      setfield /ret_potencjaly_{i}_{j} filename retina_Vm_{i}_{j}.vm append 0
      addmsg {net}_{i}_{j}_/soma /ret_potencjaly_{i}_{j} SAVE Vm
    end
   end
    
end
//--------------------------------------------------------------------

function make_readout(proto, net, rx, ry)
 str proto, net
 int rx,ry
 int i,j
 float minweight, maxweight,waga

   if (rx>0) 
    readout_Nx={rx}
   end
   if (ry>0) 
    readout_Ny={ry} 
   end

   echo "Readout creation on the net:"  {readout_Nx} "x" {readout_Ny}


   for (i=1 ; i<={readout_Nx} ; i={i+1})
    for (j=1 ; j<={readout_Ny} ; j={j+1}) 
        copy {proto} {net}_{i}_{j}_
        position {net}_{i}_{j}_  { {array_minx} + ({sep_x} * {i}) } \
                                 { {array_miny} + ({sep_y} * {j}) } 0 
    end
   end

end

function make_spike_generator(net)

  create randomspike {net} 
  setfield ^ min_amp 1 max_amp 1 rate {1/{getclock 1}} abs_refract 0
  useclock {net} 1
  echo "Random spike generator is made now..."

end
//--------------------------------------------------------------------

function rmake_spike_generator(net)

int npos
str net

for (npos=1;npos<=NodesNumber;npos={npos+1})

if ({mynode}=={npos})

  create randomspike {net}@{npos}
  setfield ^ min_amp 1 max_amp 1 rate {spike_rate} abs_refract 0
  useclock {net} 1
  echo "Random spike generator at node" {npos} "is made now..."

end //if
end //npos

end
//--------------------------------------------------------------------

function synapse_info(path, ii, jj, cntr, net)

  str path, src, net
  int i, ii, jj, cntr
  float weight, delay
  floatformat %.3g
  for (i=0; i < {getsyncount {path} }; i={i+1})
   weight = {getfield {path} synapse[{i}].weight}
   delay =  {getfield {path} synapse[{i}].delay }
   echo {ii} {jj} {weight} >> wagi_{net}.out
   end
end

//--------------------------------------------------------------------------

function skanuj_synapsy(net, cntr)
 
 int i,j, cntr
 str net
 
 for (i=1; i<={readout_Nx}; i={i+1})
  for (j=1; j<={readout_Ny}; j={j+1})
   synapse_info {net}_{i}_{j}_/dend1/Ex_channel {i} {j} {cntr} {net}
  end
 end

end

//--------------------------------------------------------------------------

function barrier_all(n)
int n

if (n<=32)

 for (i=1; i<={n+1}; i={i+1})
  barrier {i} 60
 end

else
 
 for (i=1; i<=32; i={i+1})
  barrier {i} 60
 end

end

end

//--------------------------------------------------------------------------

//*********************************************************************************

//************************** The End *********************************
