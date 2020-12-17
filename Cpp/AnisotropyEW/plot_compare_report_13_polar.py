import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 8],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np
##########################################################
#plot fases
# sns.set('whitegrid')

########################
#Select bin: 0,1,2
bin_sel=2

########################

plt.figure(3)
# Compute pie slices
theta 	= 2*np.pi*(1./360.)*np.array([280,258,320])#np.linspace(0.0, 2 * np.pi, N, endpoint=False)
width 	= 2*np.pi*(1./360.)*np.array([88,23,30])#np.pi / 4 * np.random.rand(N)

ref_theta 	= 2*np.pi*(1./360.)*np.array([225,261,291])#np.linspace(0.0, 2 * np.pi, N, endpoint=False)
ref_width 	= 2*np.pi*(1./360.)*np.array([64,43,100])#np.pi / 4 * np.random.rand(N)

ray_theta = 2*np.pi*(1./360.)*np.array([330])
ray_width = 2*np.pi*(1./360.)*np.array([20])

N = len(theta)
radii 	= 0.9*np.ones(len(theta))#np.linspace(0.85, 1, num=3) 
#colors 	= plt.cm.viridis( np.random.rand(N+5))
colors=['red', 'blue', 'blue', 'red']
ref_colors=['black', 'black', 'black']

legend=["[0.25 - 0.5]", "[0.5 - 1]", "[1 - 2]"]
ref_legend=["Ref.:[0.25 - 0.5]", " Ref.:[0.5 - 1]", "Ref.:[1 - 2]"]


ax = plt.subplot(111, projection='polar')

for i in [bin_sel]:
	ax.bar(theta[i], radii[i], width=width[i], bottom=0., color=colors[i], edgecolor=colors[i], alpha=0.15)
	ax.bar(theta[i], 0.005*radii[i], width=width[i], bottom=0.995*radii[i],  color=colors[i], edgecolor=colors[i], alpha=0.8)

	ax.bar(ref_theta[i], 0.9*radii[i], width=ref_width[i], bottom=0., color=ref_colors[i], edgecolor=ref_colors[i], alpha=0.15)
	ax.bar(ref_theta[i], 0.005*0.9*radii[i], width=ref_width[i], bottom=0.995*0.9*radii[i],  color=ref_colors[i], edgecolor=ref_colors[i], alpha=0.8)

	ax.plot([theta[i]], [radii[i]], color=colors[i], label=legend[i])
	ax.plot([ref_theta[i]], [0.9*radii[i]], color=ref_colors[i], label=ref_legend[i])

	plt.arrow(theta[i],0, 0,radii[i], alpha = 0.8, width = 0.022,
                 edgecolor = 'black', facecolor = colors[i], lw = 0.1, zorder = 1)#, color=colors[i], arrowprops=dict(arrowstyle="->"))
	
	plt.arrow(ref_theta[i],0, 0,0.9*radii[i], alpha = 0.8, width = 0.022,
	             edgecolor = 'black', facecolor = ref_colors[i], lw = 0.1, zorder = 1)#, color=colors[i], arrowprops=dict(arrowstyle="->"))
	
	if bin_sel==2:
		ax.bar(ray_theta[0], 0.98*radii[i], width=ray_width[0], bottom=0., color=colors[i+1], edgecolor=colors[i+1], alpha=0.15)
		ax.bar(ray_theta[0], 0.005*0.98*radii[i], width=ray_width[0], bottom=0.995*0.98*radii[i],  color=colors[i+1], edgecolor=colors[i+1], alpha=0.8)

		ax.plot([ray_theta[0]], [0.98*radii[i]], color=colors[i+1], label="Rayleigh")
		
		plt.arrow(ray_theta[0],0, 0,0.9*0.98*radii[i], alpha = 0.8, width = 0.022,
					edgecolor = 'black', facecolor = colors[i+1], lw = 0.1, zorder = 1)#, color=colors[i], arrowprops=dict(arrowstyle="->"))
		
		
 
	#ax.annotate("",xy=(0,theta[i]), xytext=(0,radii[i]), color=colors[i], arrowprops=dict(arrowstyle="->"))
	#ax.annotate("",xy=(0,ref_theta[i]), xytext=(0,radii[i]), color=ref_colors[i], arrowprops=dict(arrowstyle="->"))
	
 	
ax.set_ylim(top=1.1)


#  266.4167
galactic= 266.4167
ax.axvline(np.pi*galactic/180., ls=':', color='black', linewidth=2.5 )
#ax.errorbar(theta, radii, xerr=width,  fmt=".")
ax.yaxis.set_major_locator(plt.NullLocator())

plt.legend(loc='upper right', bbox_to_anchor=(1.45, 1), title="Rango (en EeV)")
ax.grid(linewidth=1.5, linestyle=':', alpha=0.51)
plt.show()