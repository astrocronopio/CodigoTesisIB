import matplotlib.pyplot as plt

import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 22,
	'figure.figsize': [12, 8],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.serif': ['STIXGeneral']})

import numpy as np

#Todo para el grafico#
vec=[0.25, 0.5, 1, 2]
vec_log=np.log2(vec)
vec_mid=[2**(0.5*(vec_log[0]+vec_log[1])), 2**(0.5*(vec_log[2]+vec_log[1])), 2**(0.5*(vec_log[3]+vec_log[2]))]
vec_mean=[0.25+ np.log2(0.25),0.75,1.5]
######################

plt.ylabel("$d_\perp$ [\%]")
plt.xlabel("Energía [EeV]")
bbox_args = dict(boxstyle="round", fc="1.0")
arrow_args = dict(arrowstyle="]-")


theta 	= np.array([280,258,320])
width 	= np.array([124,34,50])

ref_theta 	= np.array([225,261,291])
ref_width 	= np.array([64,43,100])

theta 	= 2*np.pi*(1./360.)*theta 	#np.linspace(0.0, 2 * np.pi, N, endpoint=False)
width 	= 2*np.pi*(1./360.)*width 	#np.pi / 4 * np.random.rand(N)

ref_theta 	= 2*np.pi*(1./360.)*ref_theta 	
ref_width 	= 2*np.pi*(1./360.)*ref_width 	


vec_EW=    np.array([0.0016 , 0.0056 , 0.006])
vec_sigma= np.array([0.0024 , 0.0023 ,0.0038])
vec_prob=  np.array([0.80	, 0.055	 , 0.26 	])
vec_d99_EW=np.array([0.0073  ,0.0071 , 0.011 ])

ref_EW=    np.array([0.0060 , 0.0050 , 0.0018])
ref_sigma= np.array([0.0048 , 0.0027, 0.0035])
ref_prob=  np.array([0.45	, 0.20	   , 0.87 	])
ref_d99_EW=np.array([0.015  , 0.008 , 0.011 ])



for i in range(len(vec)):
    plt.axvline(x=vec[i], ls=':')
    
for i in  range(len(vec_EW)):
	# plt.scatter(vec_mid[i], vec_EW[i],      c='blue', alpha=0.6, label="$d_\perp$")
	# plt.scatter(vec_mid[i], vec_d99_EW[i],  c='red',alpha=0.6, label="$d_{\perp,99}$")
	plt.annotate("$_{"+str(vec_EW[i])+"}$\n$^{P:"+str(vec_prob[i])+"}$", 
              (vec_mid[i], 100*vec_EW[i]), 
			  xytext=(1.05*vec_mid[i], 100*vec_EW[i]), ha="left", va="center",
     			arrowprops=arrow_args)#, bbox=bbox_args,)

	plt.annotate("$_{P:"+str(ref_prob[i])+"}$\n$^{"+str(ref_EW[i])+"}$", (vec_mid[i], 100*ref_EW[i]),  
			xytext=(0.95*vec_mid[i], 100*ref_EW[i]), ha="right", va="center", arrowprops=arrow_args)
			#, bbox=bbox_args)
 
	# plt.annotate("$_{"+str(vec_d99_EW[i])+"}$", 
    #           (1.1*vec_mid[i], vec_d99_EW[i]), ha="left", va="center"
    #           , bbox=dict(boxstyle="square", pad=0.01,fc="1.0"))
	
	# plt.annotate("$_{"+str(ref_d99_EW[i])+"}$", 
    #           (0.9*vec_mid[i], ref_d99_EW[i]), ha="right", va="center"
    #           , bbox=dict(boxstyle="square", pad=0.01, fc="1.0"))


	plt.plot([vec[i], vec[i+1]], [100*vec_d99_EW[i],100*vec_d99_EW[i]], c='red',alpha=0.6)
	plt.plot([vec[i], vec[i+1]], [100*ref_d99_EW[i],100*ref_d99_EW[i]], c='orange',alpha=0.6)

plt.scatter(vec_mid, 100*vec_EW,     marker='o', s=220,  c='blue', alpha=0.6, label="$d_\perp$")
plt.scatter(vec_mid, 100*vec_d99_EW, marker='o', s=220,  c='red',alpha=0.6, label="$d_{\perp,99}$")

plt.scatter(vec_mid, 100*ref_EW      , marker='s', s=220, c='green', alpha=0.6, label="$d_\perp$ Ref.")
plt.scatter(vec_mid, 100*ref_d99_EW, marker='s', s=220,  c='orange',alpha=0.6, label="$d_{\perp,99}$ Ref.")


plt.xscale('log', base=2)
plt.legend(loc=0, ncol=2,  bbox_to_anchor=(0.39, 0.81), columnspacing=0.1, fontsize='small')
# plt.show()
# exit()


#######################################


plt.figure(2)
plt.ylabel("$d_\perp / d_{\perp,99}$")
plt.xlabel("Energía [EeV]")

for i in range(len(vec)):
    plt.axvline(x=vec[i], ls=':')
    
for i in  range(len(vec_EW)):
	plt.annotate("$_{"+str(vec_EW[i])+"}$\n$^{P:"+str(vec_prob[i])+"}$", 
              (vec_mid[i], vec_EW[i]/vec_d99_EW[i]), 
			  xytext=(1.05*vec_mid[i], vec_EW[i]/vec_d99_EW[i]),  ha="left", va="center",arrowprops=arrow_args
     			)#, bbox=bbox_args,arrowprops=arrow_args)
 
	plt.annotate("$d_{\perp,99}$\n"+"$_{EW:"+str(vec_d99_EW[i])+"}$\n$^{Ref: "+str(ref_d99_EW[i])+"}$", 
              (vec_mid[i], vec_d99_EW[i]*.99/vec_d99_EW[i]), ha="center",va="top"
              )#, bbox=dict(boxstyle="square", fc="1.0"))

	plt.annotate("$_{P:"+str(ref_prob[i])+"}$\n$^{"+str(ref_EW[i])+"}$", (vec_mid[i], ref_EW[i]/ref_d99_EW[i]),  
		xytext=(0.95*vec_mid[i], ref_EW[i]/ref_d99_EW[i]), ha="right", va="center", arrowprops=arrow_args)

	plt.plot([vec[i], vec[i+1]], [vec_d99_EW[i],vec_d99_EW[i]]/vec_d99_EW[i], c='red',alpha=0.6)

plt.scatter(vec_mid, vec_EW/vec_d99_EW,      marker='o', s=220,c='blue', alpha=0.6, label="$d_\perp$")
plt.scatter(vec_mid, vec_d99_EW/vec_d99_EW,  marker='o', s=220,c='red',alpha=0.6)
plt.scatter(vec_mid, ref_EW/ref_d99_EW      , marker='s', s=220, c='green', alpha=0.6, label="$d_\perp$ Ref.")

    
plt.xscale('log', base=2)
plt.legend(loc=0)

#######################################


plt.figure(3)
plt.ylabel("$d_\perp / \sigma_{x,y}$")
plt.xlabel("Energía [EeV]")

for i in range(len(vec)):
    plt.axvline(x=vec[i], ls=':')
    
for i in  range(len(vec_EW)):
	# plt.scatter(vec_mid[i], vec_EW[i],      c='blue', alpha=0.6, label="$d_\perp$")
	# plt.scatter(vec_mid[i], vec_d99_EW[i],  c='red',alpha=0.6, label="$d_{\perp,99}$")
	plt.annotate("$_{"+str(vec_EW[i])+"}$\n$^{P:"+str(vec_prob[i])+"}$", 
              (vec_mid[i], vec_EW[i]/vec_sigma[i]), 
			  xytext=(1.05*vec_mid[i], vec_EW[i]/vec_sigma[i]), ha="left", va="center",
     			arrowprops=arrow_args)#, bbox=bbox_args,)

	plt.annotate("$_{P:"+str(ref_prob[i])+"}$\n$^{"+str(ref_EW[i])+"}$", (vec_mid[i], ref_EW[i]/ref_sigma[i]),  
			xytext=(0.95*vec_mid[i], ref_EW[i]/ref_sigma[i]), ha="right", va="center", arrowprops=arrow_args)


	plt.plot([vec[i], vec[i+1]], [vec_d99_EW[i]/vec_sigma[i],vec_d99_EW[i]/vec_sigma[i]], c='red',alpha=0.6)
	plt.plot([vec[i], vec[i+1]], [ref_d99_EW[i]/ref_sigma[i],ref_d99_EW[i]/ref_sigma[i]], c='orange',alpha=0.6)

plt.scatter(vec_mid, vec_EW/vec_sigma,     marker='o', s=220,  c='blue', alpha=0.6, label="$d_\perp$")
plt.scatter(vec_mid, vec_d99_EW/vec_sigma, marker='o', s=220,  c='red',alpha=0.6, label="$d_{\perp,99}$")

plt.scatter(vec_mid, ref_EW/ref_sigma      , marker='s', s=220, c='green', alpha=0.6, label="$d_\perp$ Ref.")
plt.scatter(vec_mid, ref_d99_EW/ref_sigma, marker='s', s=220,  c='orange',alpha=0.6, label="$d_{\perp,99}$ Ref.")


plt.xscale('log', base=2)
plt.legend(loc='lower center', ncol=2, columnspacing=0.1, fontsize='small')


plt.show()