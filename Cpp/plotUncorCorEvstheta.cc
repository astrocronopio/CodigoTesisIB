/*
* 
*/
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#include <TStyle.h>
#include "TCanvas.h" 
#include "TGraph.h"
#include "TAxis.h"
#include "TROOT.h"
#include "TLegend.h"

using namespace std;

void plotUncorCorEvstheta()
{
	/// Reads data from file and fills vectors with it
	double the,Ecor,Eraw,Scor,Sraw;
	int utc;
	vector<double> x,y;
	int n = 0;	
	string line;
	ifstream infile ("UncorCorE2015.dat");
	if(infile.is_open())
	{		
		while (!infile.eof() ){			
			getline(infile,line);			
			stringstream liness(line);
			liness >> utc >> the >> Eraw >> Ecor >> Sraw >> Scor;
			if(Ecor>=3){
				x.push_back(the);
				y.push_back(Scor/Sraw);
				n++;
			}			
		}
	}
	else{
		cout << "Unable to open file";
		return;
	}
	
	/// copy vector's content to arrays 
	double x2[n],y2[n];
	copy(x.begin(), x.end(), x2);
	copy(y.begin(), y.end(), y2);
	
	/// ROOT lines to plot data
	TCanvas *c = new TCanvas("Canvas","plot",850,600);
    TGraph *ge = new TGraph(n,x2,y2);
    TGraph *ge2 = new TGraph("UncorCorS_cont90.dat","%lg %lg");
    TGraph *ge3 = new TGraph("UncorCorS_cont90.dat","%lg %*lg %lg");
    TGraph *ge4 = new TGraph("UncorCorS_cont68.dat","%lg %lg");
    TGraph *ge5 = new TGraph("UncorCorS_cont68.dat","%lg %*lg %lg");
    
	gPad->SetLeftMargin(0.17);
	gPad->SetRightMargin(0.1);
	gPad->SetBottomMargin(0.17);
	//c->SetGrid();
	ge->SetTitle("");	   		
	ge->GetXaxis()->SetTitle("#theta [deg]");
	ge->GetXaxis()->SetLimits(0,60);
	ge->GetXaxis()->SetNdivisions(8,2,0);
	ge->GetXaxis()->CenterTitle();
	ge->GetXaxis()->SetTitleOffset(1.2);
	ge->GetXaxis()->SetLabelSize(0.05);
	ge->GetXaxis()->SetTitleSize(0.07);
	//
	ge->GetYaxis()->SetTitle("S_{0}/S");
	ge->GetYaxis()->CenterTitle();
	ge->GetYaxis()->SetTitleOffset(1.1);
	ge->GetYaxis()->SetLabelSize(0.05);
	ge->GetYaxis()->SetTitleSize(0.07);
		
	ge2->SetLineColor(1);
	ge2->SetLineWidth(2);
	ge3->SetLineColor(1);
	ge3->SetLineWidth(2);
	ge4->SetLineStyle(2);
	ge4->SetLineWidth(2);
	ge5->SetLineStyle(2);
	ge5->SetLineWidth(2);
	//ge->SetMarkerColor(2);	
	ge->SetMarkerStyle(8);
	ge->SetMarkerSize(1);
	ge->SetMarkerColorAlpha(2,0.35);
    
	gStyle->SetOptFit(0000);
	gPad->SetTicks();
	
	ge->Draw("AP");
	ge2->Draw("SAME L");
	ge3->Draw("SAME L");
	ge4->Draw("SAME L");
	ge5->Draw("SAME L");
	
	TLegend*leg1 = new TLegend(0.75,0.75,0.88,0.88);
	leg1->AddEntry(ge2,"90%","L");
	leg1->AddEntry(ge4,"68%","L");
	leg1->Draw("SAME");
	
	c->SaveAs("UncorCorSvstheta2015_mainv4.pdf");
}
