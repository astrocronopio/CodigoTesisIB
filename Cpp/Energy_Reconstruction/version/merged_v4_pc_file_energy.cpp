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
double A= 0.169;
double B= 1.073;
double y=3.29;
double By= B*(y-1.0);//2.36328;

double energy( double S38)
{
	return A*powf(S38, B);
}

//Reference
// double c07 = 0.0021 ;
// double c17 = -0.026 ;
// double c27 = 0.026  ;

//WeatherTool.cc CDAS_SD
double c07 = -0.00191081*By ;
double c17 = 0.0 ;
double c27 = 0.0  ;



// double c07   =-0.0053;//
// double c17   =0.0221;// 
// double c27   =-0.0298;//


double ap(double the2)
{
	return c07 + c17*the2 + c27*the2*the2;
}


//Reference

// double c05 = -2.7  ;
// double c15 = 1.5   ;
// double c25 = 2.2   ;


//WeatherTool.cc CDAS_SD
double c05 = -0.639877*By  ;
double c15 = 0.0   ;
double c25 = 0.0  ;


// double c05  = 0.77;// 
// double c15  = -1.196;// 
// double c25  = -0.483;// 

double arho(double the2)
{
	return c05 + c15*the2 + c25*the2*the2;
}

//Reference
// double c06 = -1.0   ;
// double c16 =  1.2    ;
// double c26 = -0.0 ;

//WeatherTool.cc CDAS_SD
double c06 =  -0.31413*By   ;
double c16 =  0.0   ;
double c26 =  0.0 ;

// double c06     = 0.39;//      
// double c16     = -1.210;//    
// double c26     = 0.5625;//    


double brho(double the2)
{
	return c06 + c16*the2 + c26*the2*the2;
}



double factor_energy(double p, double rho, double rhod, double the) 
{	
	double the2= sin(the*M_PI/180.)*(the*M_PI/180.);
	
	//Bien, se debe dividir porque  a =  By * alpha, y los parametros son de ap

	double factor = 1 + (ap(the2)*(p-p0) + arho(the2)*(rho -  rho0) + brho(the2)*(rhod - rho))/By; 
	return powf(factor, -B); //energy(S38);

	// double factor = 1 - B*(ap(the2)*(p-p0) + arho(the2)*(rho -  rho0) + brho(the2)*(rhod - rho))/By; 
	// return factor;
}


int main(int argc, char** argv)
{	
	std::cout<<"Corriendo!!";
	ifstream eventdata 	(argv[1]);
	ifstream utctprh 	("../../../Weather/utctprh_delay.dat");
	ofstream outfile 	(argv[2]);

	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		long i8,i2,iutc,i;		
		double x3,x4,x5,x6,x7;
		double i1,t,p,rho,rhod,h6,h5,iw,ib, ra;
		double the,	phi, S1000, S1000_raw, dS1000, Energy, factor, S38, rho2, rho24, tanks;
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
				if(utc <= iutc && utc > iutc-300 )
				{	
					if (the<60.0 && tanks==6 && ftr<3 && Ecor>1)
					{
					factor = factor_energy( p,  rho, rhod, the) ;
					
					outfile << utc<<"\t"<< Eraw <<"\t" << Ecor <<"\t"<< Eraw*factor <<"\t";
					outfile << factor <<"\t" << Ecor/Eraw << "\n" ;

					outfile.flush();
					break;
					}
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
