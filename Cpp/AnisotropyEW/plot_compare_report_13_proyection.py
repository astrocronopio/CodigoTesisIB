import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [10, 10],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np
##########################################################
# import matplotlib.pyplot as plt

plt.grid(alpha=0.15)

theta 	= 2*np.pi*(1./360.)*np.array([280,258,320])#np.linspace(0.0, 2 * np.pi, N, endpoint=False)
width 	= 2*np.pi*(1./360.)*np.array([88,23,30])#np.pi / 4 * np.random.rand(N)

ref_theta 	= 2*np.pi*(1./360.)*np.array([225,261,291])#np.linspace(0.0, 2 * np.pi, N, endpoint=False)
ref_width 	= 2*np.pi*(1./360.)*np.array([64,43,100])#np.pi / 4 * np.random.rand(N)

vec_EW=    np.array([0.0016 , 0.0056 , 0.0063])
vec_sigma= np.array([0.0024 , 0.0023 ,0.0038])
vec_prob=  np.array([0.81	, 0.06	 , 0.26 	])
vec_d99_EW=np.array([0.008 , 0.011 , 0.016 ])

ref_EW=    np.array([0.0060 , 0.0050 , 0.0018])
ref_sigma= np.array([0.0048 , 0.0027, 0.0035])
ref_prob=  np.array([0.45	 , 0.20	   , 0.87 	])
ref_d99_EW=np.array([0.018 , 0.011 , 0.011 ])



colors=['red', 'blue', 'green', 'red']
ref_colors=['black', 'black', 'black']

legend=["[0.25 - 0.5]", "[0.5 - 1]", "[1 - 2]"]
ref_legend=["Ref.:[0.25 - 0.5]", "Ref.:[0.5 - 1]", "Ref.:[1 - 2]"]
ref_lines =[":", "-.", "--"]

ticks=np.arange(-10, 10, 0.3)
plt.xticks(ticks)
plt.yticks(ticks)


def create_circle_ref(x=0,y=0,r=3, c='red', label="", ls="-"):
    circle= plt.Circle((x,y), radius= r, 
                       color=c, alpha=1.0,
                       fill=False,
                       ls=ls, lw=3,label=label)
    return circle

def create_circle(x=0,y=0,r=3, c='red', label=""):
    circle= plt.Circle((x,y), radius= r, 
                       color=c, alpha=.3,
                       label=label)
    return circle


def show_shape(patch):
    ax=plt.gca()
    ax.add_patch(patch)
    plt.axis('scaled')

	
if __name__== '__main__':
    
    plt.xlabel("$d_x$[%]")
    plt.ylabel("$d_y$[%]")
    
    
    for  i in range(len(ref_d99_EW)):
        
        c= create_circle(x=100*vec_d99_EW[i]*np.cos(theta[i]),
                         y=100*vec_d99_EW[i]*np.sin(theta[i]),
                         r=100*vec_sigma[i],
                         c=colors[i],
                         label=legend[i])
        
        
        plt.arrow(0,0, 
                    100*vec_d99_EW[i]*np.cos(theta[i]),
                    100*vec_d99_EW[i]*np.sin(theta[i]),
                    length_includes_head=True,
                    alpha = 1, width = 0.022,
	                edgecolor = 'black', facecolor = colors[i], lw = 0.1, zorder = 1)#, color=colors[i], arrowprops=dict(arrowstyle="->"))
	
        show_shape(c)
    
    galactic= 2.*np.pi*(1./360.)*266.4167

    plt.plot([0.0,2.50*np.cos(galactic)],[0,2.50*np.sin(galactic)],
               color='black', ls=":", alpha=0.8)#, color=colors[i], arrowprops=dict(arrowstyle="->"))


    for  i in range(len(ref_d99_EW)):
        c_ref= create_circle_ref(x=100*ref_d99_EW[i]*np.cos(ref_theta[i]),
                         y=100*ref_d99_EW[i]*np.sin(ref_theta[i]),
                         r=100*ref_sigma[i],
                         c=colors[i],
                         label=ref_legend[i],
                         ls=ref_lines[i])
        
        show_shape(c_ref)
    
    plt.xlim(left=-1.1)
    plt.ylim(bottom=-1.9)
    # plt.text( 0.45,-0.1, "Ref: Aab A. et al. 2020",bbox=dict(facecolor='white', alpha=0.5))
    plt.legend(loc='lower right', ncol=2, title="Ref: Aab A. et al. 2020")
    plt.show()