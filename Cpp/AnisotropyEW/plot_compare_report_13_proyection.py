import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 10],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.serif': ['STIXGeneral']})

import numpy as np
##########################################################
# import matplotlib.pyplot as plt
cmap = plt.get_cmap('gnuplot',9)

plt.grid(alpha=0.2)


theta 	= np.array([357,0.1*280,280,258,320])
width 	= np.array([35, 0.1*124,124,34,50])

ref_theta 	= np.array([225,261,291])
ref_width 	= np.array([64,43,100])

theta 	= 2*np.pi*(1./360.)*theta 	#np.linspace(0.0, 2 * np.pi, N, endpoint=False)
width 	= 2*np.pi*(1./360.)*width 	#np.pi / 4 * np.random.rand(N)

ref_theta 	= 2*np.pi*(1./360.)*ref_theta 	
ref_width 	= 2*np.pi*(1./360.)*ref_width 	


vec_EW=    np.array([0.0041 ,2.*0.0016  ,0.0016 , 0.0056 , 0.006])
vec_sigma= np.array([0.0014 ,.2*0.0024  ,0.0024 , 0.0023 ,0.0038])
vec_prob=  np.array([0.063	,2.*0.80    ,0.80	, 0.055	 , 0.26 	])
# vec_d99_EW=np.array([0.0053  ,2.*0.008   ,0.008  , 0.011 , 0.016 ])

ref_EW=    np.array([0.0060 , 0.0050 , 0.0018])
ref_sigma= np.array([0.0048 , 0.0021, 0.0035])
ref_prob=  np.array([0.45	, 0.20	   , 0.87 	])
ref_d99_EW=np.array([0.018  , 0.011 , 0.011 ])



# colors=['red', 'blue', 'green', 'red']
colors = ['blue','red',cmap(1),cmap(7),cmap(0)]
ref_colors=[cmap(1),cmap(7),cmap(0)]

legend=["[1 - 2] Ray","[1 - 2] Ray,mod","[0.25 - 0.5] EW", "[0.5 - 1] EW", "[1 - 2] EW"]
ref_legend=["[0.25 - 0.5] EW,Ref.", "[0.5 - 1] EW,Ref.", "[1 - 2] EW,Ref."]
ref_lines =[":", "-.", "--"]

ticks=np.arange(-1.6, 1.6, 0.2)
plt.xticks(ticks)
plt.yticks(ticks)


def create_circle_ref(x=0,y=0,r=3, c='red', label="", ls="-"):
    circle= plt.Circle((x,y), radius= r, 
                       color=c, alpha=0.6,
                       fill=False,
                       ls=ls, lw=3,label=label)
    return circle

def create_circle(x=0,y=0,r=3, c='red', label=""):
    circle= plt.Circle((x,y), radius= r, 
                       color=c, alpha=.2,
                       label=label)
    return circle


def show_shape(patch):
    ax=plt.gca()
    ax.add_patch(patch)
    plt.axis('scaled')

	
if __name__== '__main__':
    
    plt.xlabel("$d_x$[%]")
    plt.ylabel("$d_y$[%]")
    
    
    for  i in range(len(vec_EW)):
        
        c= create_circle(x=100*vec_EW[i]*np.cos(theta[i]),
                         y=100*vec_EW[i]*np.sin(theta[i]),
                         r=100*vec_sigma[i],
                         c=colors[i],
                         label=legend[i])
        
        
        plt.arrow(0,0, 
                    100*vec_EW[i]*np.cos(theta[i]),
                    100*vec_EW[i]*np.sin(theta[i]),
                    length_includes_head=True,
                    alpha = 1, width = 0.01,
	                edgecolor = 'black', facecolor = colors[i], lw = 0.05, zorder = 0.5)#, color=colors[i], arrowprops=dict(arrowstyle="->"))
	
        show_shape(c)
    
    galactic= 2.*np.pi*(1./360.)*266.4167

    plt.plot([0.0,2.50*np.cos(galactic)],[0,2.50*np.sin(galactic)],
               color='black', ls=":", lw=3,alpha=0.8, label="Centro Galáctico")#, color=colors[i], arrowprops=dict(arrowstyle="->"))


    for  i in range(len(ref_EW)):
        c_ref= create_circle_ref(x=100*ref_EW[i]*np.cos(ref_theta[i]),
                         y=100*ref_EW[i]*np.sin(ref_theta[i]),
                         r=100*ref_sigma[i],
                         c=ref_colors[i],
                         label=ref_legend[i],
                         ls=ref_lines[i])
        
        show_shape(c_ref)
    
    plt.xlim(left=-1.,right=1.)
    plt.ylim(bottom=-1., top=0.4)
    plt.scatter([0],[0], marker="x", color="black", lw=3, s=330)
    # plt.text( 0.45,-0.1, "Ref: Aab A. et al. 2020",bbox=dict(facecolor='white', alpha=0.5))
    plt.legend(loc='lower right', ncol=3, 
               bbox_to_anchor=(0.95, 1.02),
               fontsize=16,
               title="Ref: Aab A. et al. 2020"
               )
    plt.show()