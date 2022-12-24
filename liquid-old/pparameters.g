//******************************************************************
//*                                                                *
//*                 Grzegorz M. Wojcik (c)2002 [Obidos]            *
//*                                                                *
//******************************************************************
//*                     Simulation Parameters                      *
//******************************************************************

float connect_prob = 0.8        // probability of intra-brain connections

float stimulation_time = 50    // czas podawania jednego impulsu
int pdim = 8                     // wymiar rownoleglizacji w poziomie i w pionie (na ile nodow)
float spike_rate = 200           // rate generatora
int NodesNumber = {pdim}*{pdim}  // liczba nodow
int patchdim = {16/{pdim}}       // wymiar latki na siatkowce i readoutach

float probability = 0.8
float delay       = 1e-4       // opoznienie synaptyczne w sekundach
float weight      = 2.0        // 1/2
float min_weight  = 0          // minimum weight in column
float max_weight  = 5          // maximum weight in column

int array_Nx      = 8          // liczba neuronow wzdluz ox
int array_Ny      = 8          // liczba neuronow wzdluz oy
int array_Nz      = 16          // liczba neuronow wzdluz oz
int readout_Nx    = 10         // liczba neuronow readout wzdluz osi ox
int readout_Ny    = 10         // liczba neuronow readout wzdluz osi oy

int no_of_neurons = { {array_Nx} * {array_Ny} * {array_Nz} }  // liczba wszystkich neuronow

float prawdop     = 0.7        // prawdopodobienstwo utworzenia synapsy
float time        = 0.1        // czas czastki symulacji
float dt          = 0.00001    // krok symulacji
int max_cntr      = 10         // ilosc obrotow petli o czasie time
float in_layer_prob = {connect_prob}    // prawdopodobienstwo polaczen wewnatrz warstwy
float inter_layer_prob = {connect_prob}   // prawdopodobienstwo polaczen miedzy warstwami

int array_minx =  1     // najmniejszy indeks x
int array_miny =  1     // najmniejszy indeks y
int array_minz =  1     // najmniejszy indeks z

float sep_x = 40e-6     // odleglosc miedzy neuronami w kierunku x w metrach
float sep_y = 40e-6     // odleglosc miedzy neuronami w kierunku y w metrach
float sep_z = 40e-6

float lambda = 0.2          // jeden z parametrow Maassa 
float C      = 0.2          // jeden z parametrow Maassa
float impulse_rate = 0.003  // do pobudzania oka

//************************** END ********************************
