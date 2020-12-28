#ifndef BOUNDS_V2

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>

/*Bessels Functions*/
#include <boost/math/special_functions/bessel.hpp> 
#include <math.h>
#include <cmath>

/*Numerical Integration*/
#include <gsl/gsl_integration.h>

int nsteps=1000;
float epsilon=0.0001;

double fj=0.0, f0=0.0;
short flag=0;



double Probability_Function_Amplitude(double x, double rtilde, double sigma, double normal)
{
	double y=0.0, z=0.0;
	double u = rtilde/sigma;
	double v = x/sigma;

	z = -0.5*(u*u+v*v);
	y = exp(z)*boost::math::cyl_bessel_k(0, u*v)*u*sqrt(u*v)/(sigma*normal);
    
    if (y<fj && flag==1){
        std::cout<<"\nValor: "<<y<<" fj: "<<fj ;
         y=0.0;}
    if (flag==0) y = y - f0;

	return y;
}

double f(double x, void * params) 
{
	double * params_ = (double *) params;
  	
    double rtilde   = (double) params_[0];
  	double sigma    = (double) params_[1];
    double normal   = (double) params_[2];

  	double f = Probability_Function_Amplitude(x, rtilde, sigma, normal);
  	return f;
}

double integration_over_r(double upper_rtilde, double rtilde, double sigma, double normal)
{	double result, error;
    gsl_integration_workspace* w = gsl_integration_workspace_alloc (5000);
	
	double alpha[3] = {rtilde, sigma, normal}; 
	gsl_function F;
	F.function = &f;
	F.params = &alpha;

	gsl_integration_qags (&F, 0, upper_rtilde, 0, epsilon, 5000,w, &result, &error);
    std::cout<<"\nResult: "<<result<<std::endl;
	gsl_integration_workspace_free (w);

	return result;
}

double min(double rmin, double rmax, double rtilde, double sigma, double normalized_prob)
{   
    double dx=(rmax-rmin)/double(nsteps);
    
    double x=rmin, f_xdx;
    double f_x=Probability_Function_Amplitude(x,rtilde,sigma, normalized_prob);

    for (int i = 0; i < nsteps; i++)
    {
       f_xdx=Probability_Function_Amplitude(x+dx, rtilde,sigma, normalized_prob);

       if(f_x*f_xdx<0.0) 
            return x+dx/2. ;

       x+=dx;
       f_x=f_xdx;
    }
    return x+dx/2. ;
}

void error_rtilde(double rtilde, double sigma, double* e_rtilde_plus, double* e_rtilde_minus)
{   
    double zi,rmin,rmax,rsup=rtilde;
    double current_prob, normalized_prob=1.0;
    double limit_prob=0.683, smallest_prob=1E-6 ;


    /*This amplitude should give me a prob close to 1*/
    rmax = rtilde+10.*sigma;
    normalized_prob= integration_over_r(rmax, rtilde, sigma, normalized_prob);
    fj = Probability_Function_Amplitude(rtilde,rtilde,sigma,normalized_prob);
    
    flag=1;
    current_prob = integration_over_r(rtilde, rtilde, sigma, normalized_prob);
    

    std::cout<<"\nNorm:"<<normalized_prob<<" Current: "<<current_prob<< " fj: "<<fj ;
    
    if (current_prob>limit_prob)
        {   flag=2;
            for (size_t i = 0; i < 1E6; i++)
            {
                rsup = rsup*1.01; //Step size 1%
                current_prob = integration_over_r(rsup,rtilde,sigma, normalized_prob);
                std::cout<<"\nCurrent:"<<current_prob<<std::endl;
                if(current_prob>limit_prob) break;
            }
        *e_rtilde_minus= rsup;
        *e_rtilde_plus = rsup-rtilde; 
        return;

        }
    
    do
    {
        fj=.99*fj;
        current_prob = integration_over_r(rsup,rtilde,sigma, normalized_prob);
        current_prob = current_prob<fj? 0 : current_prob;
        
    }   while(current_prob<limit_prob && fj>smallest_prob);
    
    f0=fj;
    flag=0;
    zi = min(0.0,rmax,rtilde,sigma, normalized_prob);
    *e_rtilde_minus=rtilde-zi;
    rmin=rtilde;
    zi= min(rmin,rmax,rtilde,sigma, normalized_prob);
    *e_rtilde_plus=zi-rtilde;   
}




#endif // !BOUNDS_V2