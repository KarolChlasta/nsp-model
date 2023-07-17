//******************************************************************
//*                                                                *
//*                 Grzegorz M. Wojcik (c)2005 [LOMPND]            *
//*                                                                *
//******************************************************************
//*                            Main Script                         *           
//******************************************************************
//mpgenesis
// pgmwojcik.g

//--------------------------------------------------------------
include nessie1.g // rownoleglizacja
//create post /mpi
int mynode = {mytotalnode}
//int nnodes = 16 

//--------------------------------------------------------------



// set the prompt
setprompt "gmwojcik !"
// simulation time step in msec
setclock 0 0.00005  //  max size for reasonable accuracy - for spike plots, too
setclock 1 0.00005  // output interval for Vm plots
setclock 2 0.00005  // output interval for others
floatformat %.3g // do reasonable rounding for display

//----------------- Useful variables ----------------------------------

int i,j
int npos //podaje na ktorym nodzie tworzymy.


echo ===========================================
echo       GRZEGORZ M. WOJCIK presents...
echo ===========================================

   
include nessie2.g      // parametry ustawiane
//int spike_rate = 200
include pparameters.g  // Simulation parameters by gmwojcik
include pfunctions.g   // Function definitions by gmwojcik
include pimpulse.g     // Functions for impulse generations by gmwojcik
include neuron.g       // Making neuron
include protodefs.g

//=========================================================================

//                         MAIN SCRIPT

//=========================================================================

//==================================================
// check and initialize the simulation
//==================================================

// Lets initialize randseed

for (npos =0; npos<=NodesNumber; npos={npos+1})

if ({mynode} == {npos})
randseed@{npos}
end

end
 
// Lets make retina cells...

//  makeneuron /retinal_cell {soma_l} {soma_d} {dend_l} {dend_d}
  readcell cell.p /retinal_cell
//  setfield /retinal_cell/soma inject 0.0
  rmake_retina /retinal_cell
  echo "Retina cells just made..."

// Making neuron for column cells (one per node little brains :-) )
//  makeneuron /brain_cell {soma_l} {soma_d} {dend_l} {dend_d}// in cell.g
  readcell cell.p /brain_cell
//  setfield /brain_cell/soma inject 0.0  
  rmake_brain /brain_cell /brain {array_Nx} {array_Ny} {array_Nz} {i}
  echo "Brains completed!"
   
// Making the readout of 256 neurons
//  makeneuron /readout_cell {soma_l} {soma_d} {dend_l} {dend_d}
  readcell cell.p /readout_cell
//  setfield /readout_cell/soma inject 0.0
  rmake_readout /readout_cell
  echo "Readout cells just made..."

// Now we will connect cells inside layers.
  rconnect_in_layers /brain

// Now we will connect layers inside columns (little brains :-) )
  rconnect_layers_in_columns

// Now we will connect columns - WARNING!!! - inter-node connection
  rconnect_columns /brain

//****************************************************************************************
//-------------------------- OK ----------------------------------------------------------
//****************************************************************************************


// Lets connect the retina with LSMs (with their layer LTN 1)
  rconnect_retina_with_LSM /retina /brain
  echo "Retina connected with LSMs..."

// Lets connect the LSMs with readout (layer L3 with readout)


  rconnect_readout_with_LSM /readout /brain
  echo "Liquid connected with readout..."

echo "All connected and OK..."

//************************************************************************************************************
//-------------------------- OK -------- Till now we have everything connected as it ought to be...
//************************************************************************************************************


// Potential and spikes collecting from the retina
  rmake_retina_output /retinaout retina

// Potential and spikes collecting from the readout
  rmake_readout_output /readout readout

//and from brains...
  rmake_brain_output /brainout brain

//Making spike generators
  rmake_spike_generator /generator

  rmake_generator_output /generatorout generator

echo "My current node is mynode =" {mynode}
echo "The total number of nodes is nnodes =" {nnodes}

//  rmake_neuron_output brain1_1_1_1@1 1 rec-brain1_1_1_1.vm

echo ==================
echo Simulation loaded.
echo ==================

barrier

reset

//check@0

pmake_impulse_type_1 /generator {stimulation_time}

step {stimulation_time} -time

//step 100 -time

barrier

paroff

echo "****************** THE END ******************"

exit
