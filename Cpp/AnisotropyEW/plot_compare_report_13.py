import matplotlib.pyplot as plt

import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 8],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np

#Todo para el grafico#
vec=[0.25, 0.5, 1, 2]
vec_log=np.log2(vec)
vec_mid=[2**(0.5*(vec_log[0]+vec_log[1])), 2**(0.5*(vec_log[2]+vec_log[1])), 2**(0.5*(vec_log[3]+vec_log[2]))]
vec_mean=[0.25+ np.log2(0.25),0.75,1.5]
######################

plt.ylabel("$d_\perp$")
plt.xlabel("Energía [EeV]")
bbox_args = dict(boxstyle="round", fc="1.0")
arrow_args = dict(arrowstyle="]-")

vec_EW=    np.array([0.00156 , 0.00561 , 0.00631])
vec_prob=  np.array([0.81	 , 0.06	   , 0.26 	])
vec_r99_EW=np.array([0.00732 , 0.00706 , 0.0117 ])

ref_EW=    np.array([0.00609 , 0.00481 , 0.00182])
ref_prob=  np.array([0.45	 , 0.20	   , 0.87 	])
ref_r99_EW=np.array([0.0147 , 0.00809 , 0.0107 ])


plt.scatter(vec_mid, vec_EW,      c='blue', alpha=0.6, label="$d_\perp$")
plt.scatter(vec_mid, vec_r99_EW,  c='red',alpha=0.6, label="$d_{\perp,99}$")

plt.scatter(vec_mid, ref_EW      , marker='s', s=50, c='green', alpha=0.6, label="$d_\perp$ Ref.")
plt.scatter(vec_mid, ref_r99_EW, marker='s', s=50,  c='orange',alpha=0.6, label="$d_{\perp,99}$ Ref.")

for i in range(len(vec)):
    plt.axvline(x=vec[i], ls=':')
    
for i in  range(len(vec_EW)):
	# plt.scatter(vec_mid[i], vec_EW[i],      c='blue', alpha=0.6, label="$d_\perp$")
	# plt.scatter(vec_mid[i], vec_r99_EW[i],  c='red',alpha=0.6, label="$d_{\perp,99}$")
	plt.annotate("$_{"+str(vec_EW[i])+"}$\n$^{P:"+str(vec_prob[i])+"}$", 
              (vec_mid[i], vec_EW[i]), 
			  xytext=(1.05*vec_mid[i], vec_EW[i]), ha="left", va="center",
     			arrowprops=arrow_args)#, bbox=bbox_args,)

	plt.annotate("$_{P:"+str(ref_prob[i])+"}$\n$^{"+str(ref_EW[i])+"}$", (vec_mid[i], ref_EW[i]),  
			xytext=(0.95*vec_mid[i], ref_EW[i]), ha="right", va="center", arrowprops=arrow_args)
			#, bbox=bbox_args)
 
	plt.annotate("$_{"+str(vec_r99_EW[i])+"}$", 
              (1.1*vec_mid[i], vec_r99_EW[i]), ha="left", va="center"
              , bbox=dict(boxstyle="square", pad=0.01,fc="1.0"))
	
	plt.annotate("$_{"+str(ref_r99_EW[i])+"}$", 
              (0.9*vec_mid[i], ref_r99_EW[i]), ha="right", va="center"
              , bbox=dict(boxstyle="square", pad=0.01, fc="1.0"))


	plt.plot([vec[i], vec[i+1]], [vec_r99_EW[i],vec_r99_EW[i]], c='red',alpha=0.6)
	plt.plot([vec[i], vec[i+1]], [ref_r99_EW[i],ref_r99_EW[i]], c='orange',alpha=0.6)

plt.xscale('log', base=2)
plt.legend(loc=0, ncol=2)
# plt.show()
# exit()


#######################################


plt.figure(2)
plt.ylabel("$d_\perp / d_{\perp,99}$")
plt.xlabel("Energía [EeV]")
plt.scatter(vec_mid, vec_EW/vec_r99_EW,      c='blue', alpha=0.6, label="$d_\perp$")
plt.scatter(vec_mid, vec_r99_EW/vec_r99_EW,  c='red',alpha=0.6)
plt.scatter(vec_mid, ref_EW/ref_r99_EW      , marker='s', s=50, c='green', alpha=0.6, label="$d_\perp$ Ref.")

for i in range(len(vec)):
    plt.axvline(x=vec[i], ls=':')
    
for i in  range(len(vec_EW)):
	plt.annotate("$_{"+str(vec_EW[i])+"}$\n$^{P:"+str(vec_prob[i])+"}$", 
              (vec_mid[i], vec_EW[i]/vec_r99_EW[i]), 
			  xytext=(1.05*vec_mid[i], vec_EW[i]/vec_r99_EW[i]),  ha="left", va="center",arrowprops=arrow_args
     			)#, bbox=bbox_args,arrowprops=arrow_args)
 
	plt.annotate("$d_{\perp,99}$\n"+"$_{EW:"+str(vec_r99_EW[i])+"}$\n$^{Ref: "+str(ref_r99_EW[i])+"}$", 
              (vec_mid[i], vec_r99_EW[i]*.99/vec_r99_EW[i]), ha="center",va="top"
              )#, bbox=dict(boxstyle="square", fc="1.0"))

	plt.annotate("$_{P:"+str(ref_prob[i])+"}$\n$^{"+str(ref_EW[i])+"}$", (vec_mid[i], ref_EW[i]/ref_r99_EW[i]),  
		xytext=(0.95*vec_mid[i], ref_EW[i]/ref_r99_EW[i]), ha="right", va="center", arrowprops=arrow_args)

	plt.plot([vec[i], vec[i+1]], [vec_r99_EW[i],vec_r99_EW[i]]/vec_r99_EW[i], c='red',alpha=0.6)
    
plt.xscale('log', base=2)
plt.legend(loc=0)

plt.show()