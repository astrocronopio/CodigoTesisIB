#ifndef PHASE

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>

/*Bessels Functions*/
#include <math.h>
#include <cmath>

/*Numerical Integration*/
#include <gsl/gsl_integration.h>
#include <boost/math/quadrature/gauss.hpp> 


double _rtilde_phase_=0.0060, _sigma_phase_=0.0038, _normal_phase_=2.0*M_PI;


double L(double x)
{
    if (-M_PI*0.5 <= x && x<=M_PI*0.5) return 1;
    else return -1;
}

double Probability_Function_Phase(const double&  x)
{
	double  y=0.0, z=0.0;
    double k = _rtilde_phase_*_rtilde_phase_/(_sigma_phase_*_sigma_phase_);

    double baseline= -sqrt(M_PI*k)*exp(k)*(1 + erf(-sqrt(k)));

    z = sqrt(M_PI*k)*cos(x)*exp(k*cos(x)*cos(x));
    y = 1. + L(x)*erf(L(x)*sqrt(k)*cos(x));

	return exp(-k)*(1+z*y )/_normal_phase_  ;
}

double integration_over_phase(double rtilde, double sigma, double phase)
{	_rtilde_phase_=rtilde, _sigma_phase_=sigma;
    double result;

    boost::math::quadrature::gauss<double, 10000> integrator;
    
    // if (phase < 0)
        result = integrator.integrate(Probability_Function_Phase, -phase, phase);
    // else
        // result = integrator.integrate(Probability_Function_Phase, -M_PI , phase);

    return result;
}



double error_phase(double rtilde, double sigma, double phase)
{   
    _rtilde_phase_=rtilde, _sigma_phase_=sigma;
    double current_prob =0.0, limit_prob=.68;
    double init_error = 0.01*abs(phase);
    // std::cout<<init_error<<std::endl;
    // current_prob = integration_over_phase(rtilde,sigma, init_error);
    // std::cout<<current_prob<<std::endl;
    
    do
    {
        init_error=1.01*init_error;
        // std::cout<<"_____"<<current_prob<<std::endl;
        current_prob = integration_over_phase(rtilde,sigma, init_error);
    }   while(current_prob<limit_prob);
    
    return init_error*180./M_PI;
    // *e_phase = Probability_Function_Phase(phase);
}


#endif // !PHASE