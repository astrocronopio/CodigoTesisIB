#if !defined(recons)
#define recons
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>



double p0	= 862.0;
double rho0	= 1.06;
double A 	= 0.1856;//1./5.1172; //0.166 - ish
double B 	= 1.0315;//1./0.9694;
double y	= 3.29;

double Bgamma= B*(y-1.0);//2.36328;
double g1 = 4.1E-3;
double g2 = 2.8;
double phiB = 90.-2.6 ;
double thetaB = 90.-35.2;


double c07 = 0.0, c17 = 0.0 , c27 = 0.  ;
double c05 = 0.0, c15 = 0.0 , c25 = 0.  ;
double c06 = 0.0, c16 = 0.0 , c26 = 0.  ;

double energy( double S38){ return A*powf(S38, B);}

double ap  (double the2){	return c07 + c17*the2 + c27*the2*the2; }
double arho(double the2){	double dummy= c05 + c15*the2 + c25*the2*the2; 
							return dummy<0? dummy: 0.0;	}


double brho(double the2){	double dummy= c06 + c16*the2 + c26*the2*the2; 
							return dummy<0? dummy: 0.0;	}



double energy_reconstruction(double S38, double p, double rho24, double rhod, 
							 double the, double phi,double* factor) 
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
	/*aP*/ 		c07 = 0.0021 ;	c17 = -0.026 ;	c27 = 0.026  ;
	/*arho*/ 	c05 = -2.7  ; 	c15 = 1.5   ; 	c25 = 2.2   ;
	/*brho*/ 	c06 = -1.0   ;	c16 = 1.2    ; 	c26 = -0.0 ;
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
	double d2r=M_PI/180.;
	double the2 = sin(the*d2r)*sin(the*d2r);

	*factor =1.0 + 1.0*(ap(the2)*(p-p0) + arho(the2)*(rho24 -  rho0) + brho(the2)*(rhod - rho24))/Bgamma; 
	double  cosub=sin(the*d2r)*sin(thetaB*d2r)*cos((phi-phiB)*d2r)+ cos(the*d2r)*cos(thetaB*d2r);
    
	double factor_g= (1.0 - 1.0*g1*pow(cos(the*d2r), -g2)*(1.-pow(cosub,2)));
	
	double S38w = S38*factor_g/(*factor);   
	// S = S_0 * factor, pero S_0 es para calcular la energia
	// S es lo medido, S_0 es lo que se debería ver en condiciones normales
	// S_0 = S/factor

	return energy(S38w);
}


#endif // recons
