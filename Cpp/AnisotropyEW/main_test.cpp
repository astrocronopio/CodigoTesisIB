#include <iostream>
#include "rtilde_bounds_v4.hpp"

#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <math.h>

int main(int argc, char const *argv[])
{
    // ref_EW=    np.array([0.0060 , 0.0050 , 0.0018])
    // ref_sigma= np.array([0.0048 , 0.0027, 0.0035])
    
    double r1=0.0050, r99;
    double sigma1=0.0027;

    double error_plus, error_minus;
    error_rtilde(r1,sigma1,&error_plus,&error_minus, &r99);
    

    std::cout<<"\ne+/100:"<<error_plus*100;
    std::cout<<"\ne-/100:"<<error_minus*100;
    
    // r99 = dperp_given_rtilde(r1,sigma1);
    std::cout<<"\nr99:"<<r99*100<<std::endl;

    

    return 0;
}
