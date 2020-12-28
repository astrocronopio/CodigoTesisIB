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
#include <boost/math/quadrature/gauss.hpp> 

int nsteps=1000;
float epsilon=0.0001;

double fj=0.0, f0=0.0;
short flag=0;
double _rtilde_=0.0060, _sigma_=0.0038, _normal_=1.0;


// This is the funct x^1/2*e^-x*I_0(x), where I_0(x) is the
// modified Bessel funct.

double Bessel0(double x)
{
    return boost::math::cyl_bessel_k(0, x);
}


double Probability_Function_Amplitude(const double&  x)
{
	double  y=0.0, z=0.0;
	const double&  u = _rtilde_/_sigma_;
	const double&  v = x/_sigma_;

	z = -0.5*(u*u+v*v) + u*v;
	y = exp(z)*Bessel0(u*v)*u*sqrt(u*v)/(_sigma_*_normal_);
    
    if (y<fj && flag==1) y=0.0;
    if (flag==0) y = y - f0;

	return y;
}

double integration_over_r(double upper_rtilde, double rtilde, double sigma, double normal)
{	_rtilde_=rtilde, _sigma_=sigma, _normal_=normal;
    double result, error;

    boost::math::quadrature::gauss<double, 30> integrator;
    result = integrator.integrate(Probability_Function_Amplitude, (double) 0.0, upper_rtilde);
	return result;
}

double min(double rmin, double rmax, double rtilde, double sigma, double normalized_prob)
{   _rtilde_=rtilde, _sigma_=sigma, _normal_=normalized_prob;
    double dx=(rmax-rmin)/double(nsteps);
    
    double x=rmin, f_xdx;
    double f_x=Probability_Function_Amplitude(x);

    for (int i = 0; i < nsteps; i++)
    {
       f_xdx=Probability_Function_Amplitude(x+dx);

       if(f_x*f_xdx<0.0) 
            return x+dx/2. ;

       x+=dx;
       f_x=f_xdx;
    }
    return x+dx/2. ;
}

void error_rtilde(double rtilde, double sigma, double* e_rtilde_plus, double* e_rtilde_minus)
{   _rtilde_=rtilde, _sigma_=sigma;

    double zi,rmin,rmax,rsup=rtilde;
    double current_prob, normalized_prob=1.0;
    double limit_prob=0.683, smallest_prob=1E-6 ;

    /*This amplitude should give me a prob close to 1*/
    rmax = std::min(rtilde+10.*sigma,(double) 1.0);
    _normal_= integration_over_r(rmax, rtilde, sigma, normalized_prob);
    fj = Probability_Function_Amplitude(rtilde);

    flag=1;
    current_prob = integration_over_r(rmax, rtilde, sigma, normalized_prob);
    
    std::cout<<"_____Al inicio____\nNorm:"<<normalized_prob<<" Current: "<<current_prob<< " fj: "<<fj ;
    
    if (current_prob>limit_prob)
        {   flag=2;
            for (size_t i = 0; i < 1E6; i++)
            {
                rsup = rsup*1.01; //Step size 1%
                current_prob = integration_over_r(rsup,rtilde,sigma, normalized_prob);
                if(current_prob>limit_prob) break;
            }
        *e_rtilde_minus= rsup;
        *e_rtilde_plus = rsup-rtilde; 
        return;

        }
    
    do
    {
        fj=.99*fj;
        current_prob = integration_over_r(rmax,rtilde,sigma, normalized_prob);
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


double dperp_given_rtilde(double rtilde, double sigma)
{
    double rmax,rsup=rtilde;
    double current_prob, normalized_prob=1.0;
    double limit_prob=0.99;


    /*This amplitude should give me a prob close to 1*/
    rmax = rtilde+10.*sigma;
    normalized_prob= integration_over_r(rmax, rtilde, sigma, normalized_prob);
    
    current_prob = integration_over_r(rtilde, rtilde, sigma, normalized_prob);
    
    if (current_prob<limit_prob)
        {   flag=2;
            for (size_t i = 0; i < 1E6; i++)
            {
                rsup = rsup*1.01; //Step size 1%
                current_prob = integration_over_r(rsup,rtilde,sigma, normalized_prob);
                if(current_prob>limit_prob) break;
            }
        }
    
    return rsup;
}

#endif // !BOUNDS_V2