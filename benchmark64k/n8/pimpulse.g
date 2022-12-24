//******************************************************************
//*                                                                *
//*                 Grzegorz M. Wojcik (c)2002 [Obidos]            *
//*                                                                *
//******************************************************************
//*                   Impulse Function Definitions                 *
//******************************************************************

function pmake_impulse_type_1 (gen, impulse_time)

int i,j, impulse_time, npos
float impulse_prob, random_prob
impulse_prob = 0.30

for (npos=1; npos<=NodesNumber; npos={npos+1})

if ({mynode}=={npos})
  
  for (i=1; i<={patchdim}; i={i+1})
   for (j=1; j<={patchdim}; j={j+1})

    random_prob = {rand {0} {1}}
    
    if ({random_prob} < {impulse_prob})
      rmake_synapse {gen}@{npos} retina_{i}_{j}@{npos}/dend1/Ex_channel 2  0.0 {npos}
    end 
  
   end
  end

// step {impulse_time} -time
 
end //if
end //npos

// step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_1 (gen, impulse_time)
// Diagonal - Upper Left to Lower Right
int i,impulse_time

  for (i=1; i<=10; i={i+1})

    make_synapse {gen} /retina_{i}_{i}/dend1/Ex_channel 2  0.0
    
  end
  
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_2 (gen, impulse_time)
// Diagonal - Upper Right to Lower Left
int i,impulse_time

  for (i=1; i<=10; i={i+1})

    make_synapse {gen} /retina_{10-i+1}_{i}/dend1/Ex_channel 2  0.0
    
  end
  
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_3 (gen, impulse_time)
// Diagonal - Cross
int i,impulse_time

  for (i=1; i<=10; i={i+1})

    make_synapse {gen} /retina_{i}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{10-i+1}_{i}/dend1/Ex_channel 2  0.0
    
  end
  
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_4 (gen, impulse_time)
// Vertical stripe
int i,impulse_time

  for (i=1; i<=10; i={i+1})

    make_synapse {gen} /retina_{5}_{i}/dend1/Ex_channel 2  0.0
    
  end
  
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_5 (gen, impulse_time)
// Horizontal Stripe
int i,impulse_time

  for (i=1; i<=10; i={i+1})

    make_synapse {gen} /retina_{i}_{5}/dend1/Ex_channel 2  0.0
    
  end
  
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_6 (gen, impulse_time)
// Stripe Cross
int i,impulse_time

  for (i=1; i<=10; i={i+1})

    make_synapse {gen} /retina_{5}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{5}/dend1/Ex_channel 2  0.0
    
    
  end
  
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_7 (gen, impulse_time)
// Square
int i,impulse_time


    make_synapse {gen} /retina_{2}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{3}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{4}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{6}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{7}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{8}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{3}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{4}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{6}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{7}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{8}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{3}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{4}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{5}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{6}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{7}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{8}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{3}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{4}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{5}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{6}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{7}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{8}_{9}/dend1/Ex_channel 2  0.0
    
     
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_8 (gen, impulse_time)
// Half Something
int i,impulse_time


    make_synapse {gen} /retina_{2}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{3}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{4}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{5}/dend1/Ex_channel 2  0.0
    
    make_synapse {gen} /retina_{3}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{4}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{5}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{6}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{7}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{8}_{5}/dend1/Ex_channel 2  0.0
    
    make_synapse {gen} /retina_{9}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{6}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{7}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{8}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{9}/dend1/Ex_channel 2  0.0
    
     
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_9 (gen, impulse_time)
// Triangle
int i,impulse_time


    make_synapse {gen} /retina_{2}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{3}_{4}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{4}_{4}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{5}_{3}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{6}_{3}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{7}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{8}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{3}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{4}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{6}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{7}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{8}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{8}_{8}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{7}_{8}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{6}_{7}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{5}_{7}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{4}_{6}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{3}_{6}/dend1/Ex_channel 2  0.0
    
    
     
  step {impulse_time} -time

end
//-------------------------------------------------------------------

function make_impulse_type_10 (gen, impulse_time)
// Movement of VERTICAL BAR from LEFT to RIGHT
int i,impulse_time

for (i=1; i<=10; i={i+1})

   if (i>1)
   
    destroy_synapse {gen} /retina_{1}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{2}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{3}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{4}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{5}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{6}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{7}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{8}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{9}_{i-1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{10}_{i-1}/dend1/Ex_channel
   
   end //if    

    make_synapse {gen} /retina_{1}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{3}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{4}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{5}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{6}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{7}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{8}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{10}_{i}/dend1/Ex_channel 2  0.0
    
  step {impulse_time} -time

end //for
  
end
//-------------------------------------------------------------------

function make_impulse_type_11 (gen, impulse_time)
// Movement of VERTICAL BAR from RIGHT to LEFT
int i,impulse_time

for (i=10; i>=1; i={i-1})

if (i<10)
   
    destroy_synapse {gen} /retina_{1}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{2}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{3}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{4}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{5}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{6}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{7}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{8}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{9}_{i+1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{10}_{i+1}/dend1/Ex_channel
   
   end //if    
    
    make_synapse {gen} /retina_{1}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{2}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{3}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{4}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{5}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{6}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{7}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{8}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{9}_{i}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{10}_{i}/dend1/Ex_channel 2  0.0
    
  step {impulse_time} -time

end //for
  
end
//-------------------------------------------------------------------

function make_impulse_type_12 (gen, impulse_time)
// Movement of VERTICAL BAR from TOP to BOTTOM
int i,impulse_time

for (i=1; i<=10; i={i+1})

   if (i>1)
   
    destroy_synapse {gen} /retina_{i-1}_{1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{2}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{3}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{4}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{5}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{6}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{7}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{8}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{9}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i-1}_{10}/dend1/Ex_channel
   
   end //if    

    
    make_synapse {gen} /retina_{i}_{1}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{3}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{4}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{6}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{7}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{8}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{10}/dend1/Ex_channel 2  0.0
    
  step {impulse_time} -time

end //for
  
end
//-------------------------------------------------------------------

function make_impulse_type_13 (gen, impulse_time)
// Movement of VERTICAL BAR from BOTTOM to TOP 
int i,impulse_time

for (i=10; i>=1; i={i-1})

  if (i<10)
   
    destroy_synapse {gen} /retina_{i+1}_{1}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{2}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{3}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{4}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{5}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{6}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{7}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{8}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{9}/dend1/Ex_channel
    destroy_synapse {gen} /retina_{i+1}_{10}/dend1/Ex_channel
   
   end //if    
 

    make_synapse {gen} /retina_{i}_{1}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{2}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{3}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{4}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{5}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{6}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{7}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{8}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{9}/dend1/Ex_channel 2  0.0
    make_synapse {gen} /retina_{i}_{10}/dend1/Ex_channel 2  0.0
    
  step {impulse_time} -time

end //for
  
end
//-------------------------------------------------------------------