 /*
###############
###############
# 1   UTC
# 2   the
# 3   Eraw
# 4   Ecor
# 5   p
# 6   rho
# 7   rhod
# 8   iw
###############
###############
*/

/* No necesita el merged con el clima porque lee la informacion del
archivo de clima */

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
double A= 0.2190941;// 0.170;
double B= 0.9828054;//1.072;
double y=3.29;
double Bgamma= B*(y-1.0);//2.36328;

double g1 = 4.2E-3;
double g2 = 2.8;
double phiB = 90.-2.6 ;
double thetaB = 90.-35.2;

double c07 = 0.0, c17 = 0.0 , c27 = 0.  ;
double c05 = 0.0, c15 = 0.0 , c25 = 0.  ;
double c06 = 0.0, c16 = 0.0 , c26 = 0.  ;

double energy( double S38){	return A*powf(S38, B);}

double ap  (double the2){	return c07 + c17*the2 + c27*the2*the2; }

double arho(double the2){	double dummy= c05 + c15*the2 + c25*the2*the2; 
							return dummy<0? dummy: 0.0;	}

double brho(double the2){	double dummy= c06 + c16*the2 + c26*the2*the2; 
							return dummy<0? dummy: 0.0;	}


double factor_energy( double p, double rho24, double rho2, double the, double phi) 
{	
	double the2 = sin(the*M_PI/180.)*sin(the*M_PI/180.);
	double d2r=M_PI/180.;

	double factor =1 - (ap(the2)*(p-p0) + arho(the2)*(rho24 - rho0) + brho(the2)*(rho2 - rho24)); 
   // S = S_0 * factor, pero S_0 es para calcular la energia
								// S es lo medido, S_0 es lo que se debería ver en condiciones normales
	
	double  cosub=sin(the*d2r)*sin(thetaB*d2r)*cos((phi-phiB)*d2r)+ cos(the*d2r)*cos(thetaB*d2r);
    
	double factor_g= (1.0 - g1*pow(cos(the*d2r), -g2)*(1.-pow(cosub,2)));

	return factor;//factor_g;
}


int main(int argc, char** argv)
{	
		int flag = 1;
{
	//NAda
	if (flag==0)
	{
		//std::cout<<"Without correction\n";
	}

	//Reference
	if (flag==1)
	{
	/*aP*/ 		c07 = 0.0009 ;	c17 = -0.011 ;	c27 = 0.011  ;
	/*arho*/ 	c05 = -1.15  ; 	c15 =  0.6  ; 	c25 = 0.9  ;
	/*brho*/ 	c06 = -0.42   ;	c16 =  0.5    ; c26 = -0.001 ;
	}

	//CDAS SD
	if (flag==2)
	{
	/*aP*/		c07 = -0.00191081 ; 	c17 = 0.0 ; 	c27 = 0.0  ;
	/*arho*/	c05 = -0.639877  ;	c15 = 0.0   ; 	c25 = 0.0   ;
	/*brho*/	c06 = -0.31413   ; 	c16 = 0.0    ; 	c26 = 0.0 ;
	}

	//AllTriggers
	if (flag==3)
	{
	/*aP*/	c07  = -0.0025022   ; 	c17  = -0.00792055  ;	c27  =  0.00316981  ;//
	/*arho*/c05  = -2.075  ;	c15  = -0.0941  ;  	c25  = 3.268;// 
	/*brho*/c06  =-0.725 ;	c16 = -0.0724  ; 	c26 = 1.14 ;//    
	}

}
	std::cout<<"Corriendo!!";
	ifstream eventdata 	(argv[1]);
	ifstream utctprh 	("../../../Weather/utctprh_delay.dat");
	ofstream outfile 	(argv[2]);
	ofstream outtest	("test.data");

	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		long i8,i2,iutc,i;		
		double x3,x4,x5,x6,x7;
		double i1,t,p,rho,rhod,h6,h5,iw,ib, ra;
		double the,	phi, S1000, S1000_raw, dS1000, Energy, factor,factor_energia, S38, rho2, rho24, tanks;
		long utc;
		
		double AugId, Dec, Eraw, Ecor, t5,ftr;

		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		

		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			
			sevent >> AugId>>Dec>>ra>>Eraw>>Ecor>>utc>>the>>phi>>tanks>>ftr;
			
			while (!utctprh.eof() ){			
				if(utc <= iutc && utc < iutc+300 )
				{	
					if (the<60.0 && tanks==6) break;
					factor = factor_energy( p,  rho24, rho2, the, phi) ;
					factor_energia = powf(factor, B);
					
					outtest.precision(5);
					outtest<< utc				<<"\t";
					outtest<< 0 				<<"\t";
					outtest<< Ecor				<<"\t";
					outtest<< Eraw*factor_energia <<"\t";
					outtest<< Eraw - Ecor		<<"\t";
					outtest<< Eraw				<<"\t";
					outtest<< Ecor/Eraw 		<<"\t";
					outtest<< factor_energia 	<<"\n";

					outfile <<  AugId << "\t" <<Dec<< "\t" <<ra<< "\t" <<Eraw<< "\t" <<Eraw*factor_energia<< "\t";
					outfile <<    utc<< "\t" <<the<< "\t" <<phi<< "\t" <<tanks<< "\t" <<ftr << "\n";
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
