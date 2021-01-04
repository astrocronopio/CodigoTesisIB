// ######## O U T P U T ############################
// ################################################
// ####    1- ($8)   UTC                       ####
// ####    2- ($4)   Phi                       ####
// ####    3- ($3)   Theta                     ####
// ####    4- ($14)  Ra                        ####
// ####    5- ($12)  S1000 sin corregir        ####
// ####    6- ($47)  S38 / sin corrección      ####
// ####    7- ($38)  Energy                    ####
// ####    8- ($43)  Tanks                     ####
// ####    9- ($37)  S1000 con correccion      ####
// ################################################
// ################################################


/* 
No necesita el merged con el clima porque 
lee la informacion del archivo de clima 
*/

/// Program to assign the weather info for each event from the Herald Archive
///
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>


#include "recons.h"

using namespace std;


int main(int argc, char** argv)
{	

    int i8,i2,iutc,i;		
    double x3,x4,x5,x6,x7;
    double i1,t,p,rho,rhod,h6,h5,iw,ib, ra;
    double the,	phi, S1000, S1000_raw, dS1000, Energy, energy_corr, S38, rho2, rho24, tanks;
    int utc;
    
    double AugId, Dec, Eraw, Ecor, t5,ftr, factor;

    iutc = ; t = ; p = ; rho = ; rhod = ; h6 = ; h5 = ; iw = ; ib = ; rho2= ; rho24;
    
    // 1537962112 -21.39 47.02 170.81 -37.85 5.2 6.45 1.271 6 5.15
    utc = 1537962112; phi = -21.39 ; the = ; ra = ; Dec= ; S1000 = ; S38 = ; Energy = ; tanks = ; S1000_raw ;
        
    energy_corr =energy_reconstruction(S38*(S1000_raw/S1000), p,  rho, rhod, the, phi, &factor);

    std::cout <<"Delta:  "<<energy_corr-Energy<<std::endl;
    std::cout << utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) << "\t";
    std::cout << energy(S38*(S1000_raw/S1000))<< "\t" << S1000/S1000_raw << "\t" <<factor<<"\n" ;
    std::cout << utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) <<"\n" ;
    std::cout << utc<<"\t"<< phi <<"\t" << the <<"\t"<< ra <<"\t";
    std::cout << S1000<<"\t" << S38 << "\t" <<energy_corr <<"\t";
    std::cout << tanks << "\t" << S1000_raw << "\n" ;

}
