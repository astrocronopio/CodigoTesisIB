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
short flag=2;
double _rtilde_=0.0060, _sigma_=0.0038, _normal_=1.0;


// This is the funct x^1/2*e^-x*I_0(x), where I_0(x) is the
// modified Bessel funct.

double Bessel0(double x)
{   double C1=3.5156229,C2=3.0899424,C3=1.2067492;
    double C4=0.2659732,C5=0.0360768,C6=0.0045813;
    
    double C7=0.39894228,C8=0.01328592,C9=0.00225319;
    double C10=-0.00157565,C11=0.00916281,C12=-0.02057706;
    double C13=0.02635537,C14=-0.01647633,C15=0.00392377;

    double T,V;

    T=x/3.75;
    if (x < 3.75)
        return sqrt(x)*exp(-x)*(1.+C1*pow(T,2)+C2*pow(T,4)+C3*pow(T,6)+C4*pow(T,8)+C5*pow(T,10)+C6*pow(T,12));
    else
    {
        V=1./T;
        return C7+C8*V+C9*pow(V,2)+C10*pow(V,3)+C11*pow(V,4)+C12*pow(V,5)+C13*pow(V,6)+C14*pow(V,7)+C15*pow(V,8);
    }
    // return boost::math::cyl_bessel_k(0, x);
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
    double result;

    boost::math::quadrature::gauss<double, 10000> integrator;
    
    if (0.0<upper_rtilde)  result = integrator.integrate(Probability_Function_Amplitude, (double) 0.0, upper_rtilde);
    else if (0.0>upper_rtilde)
        {result = integrator.integrate(Probability_Function_Amplitude, upper_rtilde,(double) 0.0);}
	
    return result;
}

double min_between(double rmin, double rmax)
{   double dx=(rmax-rmin)/double(nsteps);
    double x=rmin, f_xdx;
    double f_x=Probability_Function_Amplitude(x);

    for (int i = 0; i < nsteps; i++)
    {
       f_xdx=Probability_Function_Amplitude(x+dx);

       if(f_x*f_xdx<0.0) return x+dx/2.;

       x+=dx;
       f_x=f_xdx;
    }
    return x+dx/2. ;
}

void error_rtilde(double rtilde, double sigma, double* e_rtilde_plus, double* e_rtilde_minus, double* r99)
{   
    _rtilde_=rtilde, _sigma_=sigma;

    double zi,rmin,rmax,rsup=rtilde;
    double current_prob;
    double limit_prob=0.683, smallest_prob=1E-6 ;

    /*This amplitude should give me a prob close to 1*/
    rmax = std::min(rtilde+10.*sigma,(double) 1.0);
    _normal_= integration_over_r(rmax, rtilde, sigma, 1.0);
    
    
    fj = Probability_Function_Amplitude(rtilde);

    flag=1;
    current_prob = integration_over_r(rmax, rtilde, sigma, _normal_);
    
    std::cout<<"\n_____Al inicio____\nNorm:"<<_normal_<<" Current: "<<current_prob<< " fj: "<<fj ;
    
    // if (current_prob>limit_prob)
    //     {   flag=2;
    //         for (size_t i = 0; i < 100000; i++)
    //         {
    //             rsup = rsup*1.01; //Step size 1%
    //             // std::cout<<i<<std::endl;
    //             current_prob = integration_over_r(rsup,rtilde,sigma, _normal_);
    //             if(current_prob>limit_prob) break;
    //         }
    //     *e_rtilde_minus= rsup;
    //     *e_rtilde_plus = rsup-rtilde; 
    //     return;
    //     }

    do
    {
        fj=.99*fj;
        current_prob = integration_over_r(rmax,rtilde,sigma, _normal_);
    }   while(current_prob<limit_prob && fj>smallest_prob);
    
    /*Calculates the errors*/
    f0=fj, flag=0; //inside of the pdf flags

    zi = min_between(0.0,rmax);
    *e_rtilde_minus=rtilde-zi;
    
    rmin=rtilde;
    zi= min_between(rmin,rmax);
    *e_rtilde_plus=zi-rtilde;   

    limit_prob=0.99;
    if (current_prob<limit_prob)
    {   flag=2;
        for (size_t i = 0; i < 100000; i++)
        {
            rsup = rsup*1.01; //Step size 1%
            // std::cout<<rsup<<std::endl;
            current_prob = integration_over_r(rsup,rtilde,sigma, _normal_);
            if(current_prob>limit_prob) break;
        }
    }
    
    *r99=rsup;

    // double delta_r = rtilde*0.01;
    // double pdf, integral_pdf;
    // const char* out_file = "barrido_pdf.txt";
    // std::ofstream myfile (out_file);

    // for (size_t i = 1; i < 500; i++)
    // {   
    //     pdf = Probability_Function_Amplitude(i*delta_r);
    //     integral_pdf = integration_over_r(i*delta_r,rtilde,sigma,_normal_);
    //     myfile<<i<<"\t"<<i*delta_r<<"\t"<<pdf<<"\t"<<integral_pdf<<std::endl;
    // }
    
}


#endif // !BOUNDS_V2