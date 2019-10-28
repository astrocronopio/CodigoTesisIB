

#include "TMinuit.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

const Double_t rho0 = 1.05236;
const Double_t P0 =861.729;

////////////////////////////////////////////
const int nbins = 71451;
const int initial_time= 1104550200;
const char* filename= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Old/Herald_old_sector_2_weather.dat"; 
////////////////////////////////////////////

const char* output_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/fitted_parameters.dat";


//Arrays with the data
Float_t pres[nbins],rho[nbins],rhod[nbins],hex6T5[nbins], rate[nbins];
Int_t ievents[nbins],iutc[nbins];

//________________________________________________________________________
///	function to calculate the natural logarithm of the factorial of N
Double_t logfact(Int_t N){
	int i;
	Double_t logf = 0.;
	if(N > 1){
		for (i = 2; i <= N; i++) logf += log((double) i); 
		}
		return logf; 	}


//______________________________________________________________________________
/// input function for minuit, structure required by Tminuit in order to minimize
void fcn(Int_t &npar, Double_t *gin, Double_t &f, Double_t *par, Int_t iflag){

//calculate log Likelihood
   Double_t flogL = 0.;
   Int_t isumn = 0;
   Double_t sumhex = 0.;
   Double_t ti,t0,C,R0,mu,ee;
  
   t0=(nbins*3600)/(365.25*24*3600);

//	calculate R0: average rate we would have observed if the atmospheric parameters were always the reference ones
	for (int j = 0; j < nbins; j++) 
		{
			isumn += ievents[j];
			C=1.+par[0]*(pres[j]-P0)+par[1]*(rhod[j]-rho0)+par[2]*(rho[j]-rhod[j]);

			sumhex += hex6T5[j]*C;
		}

		R0 = isumn/sumhex;

//Maximum Likehood Estimator
	for (int j = 0; j < nbins; j++) 
		{
			C=1.+par[0]*(pres[j]-P0)+par[1]*(rhod[j]-rho0)+par[2]*(rho[j]-rhod[j]);

			mu = R0*hex6T5[j]*C;
			if(mu == 0.0) continue;
			flogL -= 2*( ievents[j]*log(mu)-mu-logfact(ievents[j]) );
	   }

//F must be evaluated before exiting the FCN function
   f = flogL;
}

//______________________________________________________________________________
void fcn2(Double_t *par,Double_t *pchi2,Int_t *pndof)
{
//calculate log Likelihood
	int j;
	Double_t flogL = 0.;
	Int_t isumn = 0;
	Double_t sumhex = 0.;
	Double_t ti,t0,C,R0,mu,ee,chi2;
	Int_t ndof;
	chi2 = 0.;
	ndof = 0;
	t0=(nbins*3600)/(365.25*24*3600);

//	calculate R0: average rate we would have observed if the atmospheric 
//	parameters were always the reference ones
	for (j = 0; j < nbins; j++) {
			isumn += ievents[j];
			C=1.+par[0]*(pres[j]-P0)+par[1]*(rhod[j]-rho0)+par[2]*(rho[j]-rhod[j]);
			sumhex += hex6T5[j]*C;
	}
		R0 = isumn/sumhex;
	printf("\n EL RATE : %f", R0);

	for (j = 0; j < nbins; j++) {
			C=1.+par[0]*(pres[j]-P0)+par[1]*(rhod[j]-rho0)+par[2]*(rho[j]-rhod[j]);

			mu = R0*hex6T5[j]*C;

			if(mu == 0.0) continue;
			flogL -= 2*( ievents[j]*log(mu)-mu-logfact(ievents[j]) );
			ndof++;
			chi2 += ((double)ievents[j]-mu)*((double)ievents[j]-mu)/mu;
   }
   *pchi2 = chi2;
   *pndof = ndof;
}

//______________________________________________________________________________
void MLE()
{	
// data input  
	FILE *in_data = fopen(filename,"r"); 

	if (! in_data ) // equivalent to saying if ( in_data == NULL ) 
    	{  
		printf("Error! File can't be read\n"); 
        	exit(-1); 
    	}	
//Read from datafile
    for (int i=0; i < nbins; i++) {
    	fscanf(in_data, "%d %d %g %g %g %g %g",&iutc[i], &ievents[i],&pres[i],&rho[i], &rhod[i], &hex6T5[i]), &rate[i];}
	
	TMinuit *gMinuit = new TMinuit(4);  //initialize TMinuit with a maximum of 4 params
	gMinuit->SetFCN(fcn);				//Set the function to be minimized

	Double_t arglist[10];
	Int_t ierflg = 0;

	arglist[0] = 1;
	gMinuit->mnexcm("SET ERR", arglist ,1,ierflg);

// Set starting values and step sizes for parameters

	printf("\n\n\n\nSet starting values and step sizes for parameters\n" );
	
	static Double_t vstart[4] 	= {0.0 , 0.0 , 0.0 , 0.0};
	static Double_t step[4] 	= {0.1 , 0.1 , 0.1 , 0.1};	

	gMinuit->mnparm(0, "aP", 		vstart[0], step[0], 0,	0,	ierflg);
	gMinuit->mnparm(1, "arho", 		vstart[1], step[1], 0,	0,	ierflg);
	gMinuit->mnparm(2, "brho", 		vstart[2], step[2], 0,	0,	ierflg);
	gMinuit->mnparm(3, "Lambda",	vstart[3], step[3], 0,	0,	ierflg);

// Now ready for minimization step

	printf("\n\n\n\nNow ready for minimization step\n" );
	arglist[0] = 500;
	arglist[1] = 1.;
	gMinuit->mnexcm("MIGRAD", arglist ,2,ierflg);
	
	Double_t amin,edm,errdef;
	Int_t nvpar,nparx,icstat;
	gMinuit->mnstat(amin,edm,errdef,nvpar,nparx,icstat);
   	gMinuit->mnprin(3,amin);

   	in_data = fopen(filename,"r"); 
	if (! in_data ) // equivalent to saying if ( in_data == NULL ) 
    	{  
		printf("Error! File can't be read\n"); 
        	exit(-1); 
    	}	
	for (int i=0; i < nbins; i++){
		fscanf(in_data, "%d %d %g %g %g %g",&iutc[i], &ievents[i],&pres[i],&rho[i],
			&rhod[i],&hex6T5[i]);
	}

	arglist[0] = 4;
	gMinuit->mnexcm("FIX", arglist ,1,ierflg);
	arglist[0] = 500;
	arglist[1] = 1.;
	gMinuit->mnexcm("MIGRAD", arglist ,2,ierflg);

// Get parameter results

	Double_t pars[4],errors[4],bnd1,bnd2,chi2,fval;
	Int_t ndof,ivar;
	char* pname;
	TString parn(pname);
	gMinuit->mnpout(0, parn, pars[0], errors[0], bnd1,	bnd2,	ivar);
	gMinuit->mnpout(1, parn, pars[1], errors[1], bnd1,	bnd2,	ivar);
	gMinuit->mnpout(2, parn, pars[2], errors[2], bnd1,	bnd2,	ivar);
	gMinuit->mnpout(3, parn, pars[3], errors[3], bnd1,	bnd2,	ivar);


// Print results         
	fcn2(pars,&chi2,&ndof);

	Double_t gamma = 3.23;
	Double_t B = 1.02;
	Double_t pf = B*(gamma-1.);

	pf=1;

	printf("\naP	= %g +/- %g \n",pars[0]/pf,	errors[0]/pf);
	printf("arho	= %g +/- %g \n",pars[1]/pf,	errors[1]/pf);
	printf("brho	= %g +/- %g \n",pars[2]/pf,	errors[2]/pf);
	printf("Lambda	= %g +/- %g \n",pars[3],	errors[3]);

	printf("chi2	= %f  ndof= %d  chi2/ndof= %f\n",chi2,ndof,chi2/ndof);

		FILE *out_data= fopen(output_file, "a+");

	fprintf(out_data, "Data file: %s 	\n", filename);
	fprintf(out_data, "aP		= %g +/- %g \n",pars[0]/pf,	errors[0]/pf);
	fprintf(out_data, "arho		= %g +/- %g \n",pars[1]/pf,	errors[1]/pf);
	fprintf(out_data, "brho		= %g +/- %g \n",pars[2]/pf,	errors[2]/pf);

	printf("chi2	= %f  ndof= %d  chi2/ndof= %f\n",chi2,ndof,chi2/ndof);

	fclose(out_data);

}

//______________________________________________________________________________
#ifndef __CINT__
int main(int argc, char** argv) {

MLE();
return 0;
}
#endif
