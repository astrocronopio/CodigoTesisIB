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
double A = 0.1856;//1./5.1172; //0.166 - ish
double B = 1.0316;//1./0.9694;
double y= 3.29;
double Bgamma= B*(y-1.0);//2.36328;


double c07 = 0.0, c17 = 0.0 , c27 = 0.  ;
double c05 = 0.0, c15 = 0.0 , c25 = 0.  ;
double c06 = 0.0, c16 = 0.0 , c26 = 0.  ;

double energy( double S38)
{
	return A*powf(S38, B);
}

double ap  (double the2){	return c07 + c17*the2 + c27*the2*the2; }
double arho(double the2){	return c05 + c15*the2 + c25*the2*the2; }
double brho(double the2){	return c06 + c16*the2 + c26*the2*the2; }


double energy_reconstruction(double S38, double p, double rho, double rhod, double the) 
{	double sinthe= sin(the*M_PI/180.);
	double the2 = sinthe*sinthe;
	
	//Bien, se debe dividir porque  a =  Bgamma * alpha, y los parametros son de ap
	double factor =1 + (ap(the2)*(p-p0) + arho(the2)*(rho -  rho0) + brho(the2)*(rhod - rho));///Bgamma; 
	
	double S38w = S38*factor;   // S = S_0 * factor, pero S_0 es para calcular la energia
								// S es lo medido, S_0 es lo que se debería ver en condiciones normales

	return energy(S38w);
}


int main(int argc, char** argv)
{	
	int flag = 2;

	//NAda
	if (flag==0)
	{
		cout<<"Without correction\n";
	}

	//Reference
	if (flag==1)
	{
	//aP
	c07 = 0.0021 ;
	c17 = -0.026 ;
	c27 = 0.026  ;

	//arho

	c05 = -2.7  ;
	c15 = 1.5   ;
	c25 = 2.2   ;

	//brho

	c06 = -1.0   ;
	c16 = 1.2    ;
	c26 = -0.0 ;

	}

	//CDAS SD
	if (flag==2)
	{
	//aP
	c07 = -0.00191081*Bgamma ;
	c17 = 0.0 ;
	c27 = 0.0  ;

	//arho

	c05 = -0.639877*Bgamma  ;
	c15 = 0.0   ;
	c25 = 0.0   ;

	//brho

	c06 = -0.31413*Bgamma   ;
	c16 = 0.0    ;
	c26 = 0.0 ;

	}

	//AllTriggers
	if (flag==3)
	{
	//aP
	c07  = -0.0025022   ;//
	c17  = -0.00792055  ;// 
	c27  =  0.00316981  ;//

	//arho

	c05  = -2.075  ;// 
	c15  = -0.0941  ;// 
	c25  = 3.268;// 

	//brho

	c06 =-0.725 ;//      
	c16 = -0.0724  ;//    
	c26 = 1.14 ;//    

	}


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
			cout<<lineev<<endl;
			
			while (!utctprh.eof() ){			
				if(utc <= iutc && utc+300 > iutc )
				{	if  (iutc<1388577500) break;
					//Importante fijarse si S38 esta corregida  o no

					// Analisis  S38: no corregida por el Herald
					//if (flag==0 || flag==3) 
						//energy_corr = energy_reconstruction(S38 , p,  rho, rhod, the) ;
					
					// Analisis Energia: S38 corregido por el Herald
					//if (flag==1 || flag==2) 
						energy_corr =energy_reconstruction(S38*(S1000/S1000_raw), p,  rho, rhod, the) ;

					//energy_corr=Energy;

					if (energy_corr < 1.0) break;
					if (energy_corr > 2.0) break;
					
					std::cout<<"Delta:  "<<energy_corr-Energy<<std::endl;
					outtest << utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) <<"\n" ;
				
					//outfile<< utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) <<"\n" ;

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
