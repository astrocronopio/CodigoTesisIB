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

using namespace std;


double p0= 862;
double rho0=1.06;
double A = 0.20;//1./5.1172; //0.166 - ish
double B = 1.03;//1./0.9694;
double y=3.29;
double Bgamma= B*(y-1.0);//2.36328;


double energy( double S38)
{
	return A*powf(S38, B);
}

//Reference
// double c07 = 0.00159376 ;
// double c17 = -0.0265173 ;
// double c27 = 0.0263584  ;

//AllTriggers
double c07  = -0.0025022   ;//
double c17  = -0.00792055  ;// 
double c27  =  0.00316981  ;//


double ap(double the2)
{
	return c07 + c17*the2 + c27*the2*the2;
}


//Reference
// double c05 = -2.57342  ;
// double c15 = 1.53895   ;
// double c25 = 2.00658   ;


// //AllTriggers
double c05  = -2.07455  ;// 
double c15  = -0.0941469  ;// 
double c25  = 3.26793;// 

double arho(double the2)
{
	return c05 + c15*the2 + c25*the2*the2;
}

//Reference
// double c06 = -1.02068   ;
// double c16 = 1.27225    ;
// double c26 = -0.0414128 ;

//AllTriggers
double c06 =-0.724809 ;//      
double c16 = -0.0723714  ;//    
double c26 = 1.13565 ;//    


double brho(double the2)
{
	return c06 + c16*the2 + c26*the2*the2;
}



double energy_reconstruction(double S38, double p, double rho, double rhod, double the) 
{	double the2= sin(the*M_PI/180.)*(the*M_PI/180.);
	
	//Bien, se debe dividir porque  a =  Bgamma * alpha, y los parametros son de ap
	double factor =1 + (ap(the2)*(p-p0) + arho(the2)*(rho -  rho0) + brho(the2)*(rhod - rho))/Bgamma; 
	
	//cout << factor << endl;
	double S38w = S38/factor;   // S = S_0 * factor, pero S_0 es para calcular la energia

	return energy(S38w);

	// double factor = 1 + (ap(the2)*(p-p0) + arho(the2)*(rho -  rho0) + brho(the2)*(rhod - rho))/Bgamma; 
	// return powf(factor, -B); //energy(S38);
}


int main(int argc, char** argv)
{
	ifstream eventdata 	(argv[1]);
	ifstream utctprh 	("../../../Weather/utctprh_delay.dat");
	ofstream outfile 	(argv[2]);
	ofstream outtest	("test.data");

	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		int i8,i2,iutc,i;		
		double x3,x4,x5,x6,x7;
		double i1,t,p,rho,rhod,h6,h5,iw,ib, ra;
		double the,	phi, S1000, S1000_raw, dS1000, Energy, energy_corr, S38, rho2, rho24, tanks;
		int utc;
		
		double AugId, Dec, Eraw, Ecor, t5,ftr;

		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		

		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			sevent >> utc >> phi >> the >> ra >> S1000 >> S38 >> Energy >> tanks >> S1000_raw ;
			//sevent >>AugId>>Dec>>ra>>Eraw>>Ecor>>utc>>the>>phi>>t5>>ftr;

			while (!utctprh.eof() ){			
				if(utc <= iutc && utc > iutc-300 )
				{	
					//Importante fijarse si S38 essta corregida  o no
					// Analisis  S38: no corregida por el Herald
					//energy_corr = energy_reconstruction(S38 , p,  rho, rhod, the) ;

					// Analisis Energia: corregida por el Herald
					energy_corr = energy_reconstruction(S38 *(S1000_raw/S1000), p,  rho, rhod, the) ;

					if (energy_corr < 1.0) break;
					if (energy_corr > 2.0) break;

					//outfile<< utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) <<"\n" ;
					std::cout<<"Delta:  "<<energy_corr-Energy<<std::endl;
					outtest << utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) <<"\n" ;
					
					outfile << utc<<"\t"<< phi <<"\t" << the <<"\t"<< ra <<"\t";
					outfile << S1000<<"\t" << S38 << "\t" <<energy_corr <<"\t";
					outfile << tanks << "\t" << S1000_raw << "\n" ;

					outfile.flush();
					break;
				}

				else{
					getline(utctprh,lineatm);
					stringstream satm(lineatm);
					satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
					continue;
				}
			}			
		}
		eventdata.close();
		utctprh.close();
		outfile.close();
	}
	else cout << "Unable to open file"; 
	return 0;
}
