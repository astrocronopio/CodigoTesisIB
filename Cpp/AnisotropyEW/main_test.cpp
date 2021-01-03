#include <iostream>
#include "rtilde_bounds_v5.hpp"

#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <math.h>

int main(int argc, char const *argv[])
{
    // ref_EW=    np.array([0.0060 , 0.0050 , 0.0018])
    // ref_sigma= np.array([0.0048 , 0.0027, 0.0035])
    
    double rtilde=0.0060, r99;
    double sigma=0.0048;

    double error_plus, error_minus;
    error_rtilde(rtilde,sigma,&error_plus,&error_minus, &r99);
    

    std::cout<<"\ne+/100:"<<error_plus*100;
    std::cout<<"\ne-/100:"<<error_minus*100;
    
    // r99 = dperp_given_rtilde(r1,sigma1);
    std::cout<<"\nr99:"<<r99*100<<std::endl;

    // return 1;

    double delta_r = rtilde*0.01;
    double pdf, integral_pdf;
    const char* out_file = "barrido_pdf.txt";
    std::ofstream myfile (out_file);

    for (size_t i = 1; i < 500; i++)
    {   
        pdf = Probability_Function_Amplitude(i*delta_r);
        integral_pdf = integration_over_r(i*delta_r,rtilde,sigma,_normal_);
        myfile<<i<<"\t"<<i*delta_r<<"\t"<<pdf<<"\t"<<integral_pdf<<std::endl;
    }

    

    return 0;
}
