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


double p0	= 862.0;
double rho0	= 1.06;
double A 	= 0.1856;//1./5.1172; //0.166 - ish
double B 	= 1.0315;//1./0.9694;
double y	= 3.29;
double Bgamma= B*(y-1.0);//2.36328;


double c07 = 0.0, c17 = 0.0 , c27 = 0.  ;
double c05 = 0.0, c15 = 0.0 , c25 = 0.  ;
double c06 = 0.0, c16 = 0.0 , c26 = 0.  ;

double energy( double S38){	return A*powf(S38, B);}

double ap  (double the2){	return c07 + c17*the2 + c27*the2*the2; }
double arho(double the2){	return c05 + c15*the2 + c25*the2*the2; }
double brho(double the2){	return c06 + c16*the2 + c26*the2*the2; }


double energy_reconstruction(double S38, double p, double rho, double rhod, double the, double* factor) 
{	
	double the2 = sin(the*M_PI/180.)*sin(the*M_PI/180.);

	*factor =1 + (ap(the2)*(p-p0) + arho(the2)*(rho -  rho0) + brho(the2)*(rhod - rho)); 
	
	double S38w = S38/(*factor);   // S = S_0 * factor, pero S_0 es para calcular la energia
								// S es lo medido, S_0 es lo que se debería ver en condiciones normales

	return energy(S38w);
}


int main(int argc, char** argv)
{	
	int flag = 1;
//Bien, se debe dividir porque  a =  Bgamma * alpha, y los parametros son de ap
	
	//NAda
	{if (flag==0)
	{
		cout<<"Without correction\n";
	}

	//Reference
	if (flag==1)
	{
	//aP
	c07 = 0.0009 ;
	c17 = -0.011 ;
	c27 = 0.011  ;

	//arho

	c05 = -1.15  ;
	c15 = 0.6  ;
	c25 = 0.9   ;

	//brho

	c06 =-0.42   ;
	c16 = 0.5  ;
	c26 = -0.001;

	}

	//CDAS SD
	if (flag==2)
	{
	//aP
	c07 = -0.00191081 ;
	c17 = 0.0 ;
	c27 = 0.0  ;

	//arho

	c05 = -0.639877  ;
	c15 = 0.0   ;
	c25 = 0.0   ;

	//brho

	c06 = -0.31413   ;
	c16 = 0.0    ;
	c26 = 0.0 ;

	}

	//AllTriggers
	if (flag==3)
	{
	//aP
	c07  = -0.0025022 /Bgamma  ;//
	c17  = -0.00792055/Bgamma  ;// 
	c27  =  0.00316981/Bgamma  ;//

	//arho

	c05  = -2.075  /Bgamma ;// 
	c15  = -0.0941  /Bgamma ;// 
	c25  = 3.268/Bgamma ;// 

	//brho

	c06 =-0.725 /Bgamma ;//
	c16 = -0.0724 /Bgamma ;//
	c26 = 1.14 /Bgamma;//

	}
}

	ifstream eventdata 	(argv[1]);
	ofstream outfile 	(argv[2]);
	ofstream outtest	("test.data");

	string lineev;

	if(eventdata.is_open())	
	{
		int i8,i2,iutc,i;		
		double x3,x4,x5,x6,x7;
		double i1,t,p,rho,rhod,h6,h5,iw,ib, ra;
		double the,	phi, S1000, S1000_raw, dS1000, Energy, energy_corr, S38, rho2, rho24, tanks;
		int utc;
		
		double AugId, Dec, Eraw, Ecor, t5,ftr, factor;
		
		while (!eventdata.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			sevent >> utc >> phi >> the >> ra >> S1000 >> S38 >> Energy >> tanks >> S1000_raw >> p >>  rho >> rhod>>iw;
			//sevent >>AugId>>Dec>>ra>>Eraw>>Ecor>>utc>>the>>phi>>t5>>ftr;
			//cout<<lineev<<endl;
						
			if  (utc<1388577500 ) continue;

			//if (flag==0) 
			energy_corr =energy_reconstruction(S38, p,  rho, rhod, the, &factor) ;
			//else 
			//energy_corr =energy_reconstruction(S38*(S1000_raw/S1000), p,  rho, rhod, the, &factor) ;

			energy_corr=Energy;

			if (energy_corr < 1.0) continue;
			if (energy_corr > 2.0) continue;
			
			outtest.precision(3);
			std::cout.precision(3);
			std::cout<<"Delta:  "<<energy_corr-Energy<<std::endl;
			outtest << utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) << "\t";
			outtest << energy(S38*(S1000_raw/S1000))<< "\t" << S1000/S1000_raw << "\t" <<factor<<"\n" ;
		
			//outfile<< utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) <<"\n" ;
			//outfile.precision(3);
			outfile << utc<<"\t"<< phi <<"\t" << the <<"\t"<< ra <<"\t";
			outfile << S1000<<"\t" << S38 << "\t" <<energy_corr <<"\t";
			outfile << tanks << "\t" << S1000_raw << "\n" ;

			//outfile.flush();
					
		}
		eventdata.close();
		outfile.close();
	}
	else cout << "Unable to open file"; 
	return 0;
}
