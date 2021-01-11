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

int nsteps=1000;
float epsilon=0.0001;

double fj=0.0, f0=0.0;
short flag=2;
double _rtilde_=0.0060, _sigma_=0.0038, _normal_=1.0;


double L(double x)
{
    if (-M_PI*0.5 <= x && x<=M_PI*0.5) return 1;
    else return -1;
}

double Probability_Function_Phase(const double&  x)
{
	double  y=0.0, z=0.0;
    double k = _rtilde_*_rtilde_/(_sigma_*_sigma_);

    z = sqrt(M_PI*k)*cos(x)*exp(k*cos(x)*cos(x));
    y = 1. + L(x)*erf(L(x)*sqrt(k)*cos(x));

	return exp(-k)*(1+z*y)/_normal_;
}

double integration_over_phase(double rtilde, double sigma, double phase, double normal)
{	_rtilde_=rtilde, _sigma_=sigma, _normal_=normal;
    double result;

    boost::math::quadrature::gauss<double, 10000> integrator;
    
    result = integrator.integrate(Probability_Function_Phase, -M_PI , phase);

    return result;
}



void error_phase(double rtilde, double sigma, double phase, double* e_phase)
{   
    _rtilde_=rtilde, _sigma_=sigma;

    *e_phase = integration_over_phase(rtilde,sigma, phase, 1.0);
    // *e_phase = Probability_Function_Phase(phase);
}


#endif // !PHASE