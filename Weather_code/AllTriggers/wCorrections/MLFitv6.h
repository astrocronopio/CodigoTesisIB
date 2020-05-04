/*=======================================================================================================
				v6 changes:
				Saque cosas que estaban comentadas y no entieno porque estan
==========================================================================================================*/

#ifndef __MLFit_H
#define __MLFit_H

#include <vector>

#include "Bindata.h"

using namespace std;

class TypeFitPars{
public:
	double alphaP;
	double alphaRho;
	double betaRho;
	double lambda;
	double cinf;
	double alphaP_err;
	double alphaRho_err;
	double betaRho_err;
	double lambda_err;
	double cinf_err;
	double chi2;
	int ndof;
	double redChi2;	
};

	const double krho0 = 1.055; /// mean density at the site of Malargüe
	const double kP0 = 861.89;  /// mean pressure at the site of Malargüe
	const double kgamma = 3.29;  /// spectral index ICRC 2015
	//const double kB = 1.023;    /// Energy calibration B parameter ICRC 2015 MA
	const double kB = 1.013;    /// Energy calibration B parameter ICRC 2015 Infill

	static TypeBinData fbinData;
	static int futcmin;
	static int futcmax;
	static int futcsdec;
	static int futcedec;
	static int fnbins;
	static double fpars[5];
	static double ferrors[5];
	
/// function to calculate the natural logarithm of the factorial of N
	double logfact(int N);
/// input function for minuit 
	static void fcn(int &npar, double *gin, double &f, double *par, int iflag);
/// function to calculate chi2,number of degrees of freedom and expected events from the minuit fit
	void fcn2(double *par,double *pchi2,int *pndof,TypeBinData *fitData=NULL);
/// Run minuit to get the Maximum Likelihood parameters
	void RunFit(TypeBinData binData,int utcmin,int utcmax,int utcsdec,int utcedec,int nbins);
/// Get the fit parameters given by minuit
	TypeFitPars GetFitPars();
/// Get vector with the expected number of events using current fit parameters 
	void GetExpev(TypeBinData *fitData);

#endif

