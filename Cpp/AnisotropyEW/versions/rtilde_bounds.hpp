#ifndef BOUNDS

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


double Probability_Function_Amplitude(double x, double rtilde, double sigma)
{
	double y=0.0, z=0.0;
	double u = rtilde/sigma;
	double v = x/sigma;

	z = -0.5*(u*u+v*v) + u*v;
	y = exp(z)*boost::math::cyl_bessel_k(0, u*v)*u*sqrt(u*v)/sigma;

	return y;
}

double f(double x, void * params) 
{
	double * params_ = (double *) params;
  	double rtilde = (double) params_[0];
  	double sigma = (double) params_[1];
  	double f = Probability_Function_Amplitude(x, rtilde, sigma);
  	return f;
}

double integration_over_r(double upper_rtilde,double rtilde, double sigma)
{	double result, error;
	gsl_integration_workspace* w = 
	gsl_integration_workspace_alloc (1000);
	
	double alpha[2] = {rtilde, sigma}; 
	gsl_function F;
	F.function = &f;
	F.params = &alpha;

	gsl_integration_qags (&F, 0, upper_rtilde, 0, 1e-7, 1000,w, &result, &error);

	gsl_integration_workspace_free (w);

	return result;
}

void error_rtilde(double rtilde, double sigma, double* rtilde_plus, double* rtilde_minus)
{
	double probability_limit  = 0.68;
	double lower_bound=0.0, upper_bound=0.0;
	int steps=1000;

	double upper_rtilde=0.0, lower_rtilde=0.0;
	double integral=0.0;

	double probability_rtilde = Probability_Function_Amplitude(rtilde,rt,sigma);
	
	upper_bound = (1+0.0008*0)*probability_rtilde;
	lower_bound = (1-0.0008*0)*probability_rtilde;

	if (upper_bound>.99)
	{
		for (size_t i = 0; i < steps; i++)
		{
			lower_rtilde = rtilde - i*0.01*sigma;
			lower_bound = integration_over_r(lower_rtilde, rtilde, sigma);
			
			if((lower_bound-(1-probability_limit))<0.001)
			{
				*rtilde_plus=rtilde + sigma;
				*rtilde_minus = rtilde - lower_rtilde;
				return;
			}
		}
	}

	for (size_t i = 0; i < steps; i++)
	{
		lower_rtilde = rtilde - i*0.01*sigma;
		lower_bound = integration_over_r(lower_rtilde, rtilde, sigma);



		
	}
	
}


#endif // !BOUNDS