#include <iostream>
#include "rtilde_bounds_v5.hpp"
#include "phase_bounds_v2.hpp"

#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <math.h>

int main(int argc, char const *argv[])
{
    // ref_EW=    np.array([0.0060 , 0.0050 , 0.0018])
    // ref_sigma= np.array([0.0048 , 0.0027, 0.0035])
    
    double rtilde= 4.8E-03 ;
    double sigma= 4.9E-03;   
    double phase= -135*M_PI/180.;
    double canon_er= 45.*M_PI/180.;


    std::cout<<error_phase(rtilde, sigma, phase);

    // double delta_r = 2*M_PI/500;
    // double pdf, integral_pdf;
    // const char* out_file = "barrido_pdf+phase.txt";
    // std::ofstream myfile (out_file);

    // for (size_t i = 2; i < 500; i++)
    // {   
    //     pdf = Probability_Function_Phase(-M_PI+i*delta_r);
    //     integral_pdf = integration_over_phase(rtilde,sigma,-M_PI+i*delta_r);
    //     myfile<<i<<"\t"<<-M_PI+i*delta_r <<"\t"<<pdf<<"\t"<<integral_pdf<<std::endl;
    // }


    // // return 1;
    // double error_plus, error_minus, r99;
    // error_rtilde(rtilde,sigma,&error_plus,&error_minus, &r99);
    

    // double delta_r = rtilde*0.01;
    // double pdf, integral_pdf;
    // const char* out_file = "barrido_pdf+r.txt";
    // std::ofstream myfile (out_file);

    // for (size_t i = 1; i < 500; i++)
    // {   
    //     pdf = Probability_Function_Amplitude(i*delta_r);
    //     integral_pdf = integration_over_r(i*delta_r,rtilde,sigma,_normal_);
    //     myfile<<i<<"\t"<<i*delta_r<<"\t"<<pdf<<"\t"<<integral_pdf<<std::endl;
    // }

    

    return 0;
}
