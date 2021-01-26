import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [9, 9],
	# 'figure.autolayout': True,
	'font.family': 'serif',
	'font.serif': ['STIXGeneral']})

import numpy as np
##########################################################
#plot fases
# sns.set('whitegrid')

########################
#Select bin: 0,1,2
bin_sel=2
# Compute pie slices
theta 	= np.array([280,258,320])
width 	= 2*np.array([90,34,48])

ref_theta 	= np.array([225,261,291])
ref_width 	= 2*np.array([64,43,100])

ray_theta = np.array([359])
ray_width = 2*np.array([35])


########################

plt.figure(3)
# Compute pie slices
theta 	= 2*np.pi*(1./360.)*theta 	#np.linspace(0.0, 2 * np.pi, N, endpoint=False)
width 	= 2*np.pi*(1./360.)*width 	#np.pi / 4 * np.random.rand(N)

ref_theta 	= 2*np.pi*(1./360.)*ref_theta 	
ref_width 	= 2*np.pi*(1./360.)*ref_width 	

ray_theta = 2*np.pi*(1./360.)*ray_theta 
ray_width = 2*np.pi*(1./360.)*ray_width 

N = len(theta)
radii 	= 0.9*np.ones(len(theta))#np.linspace(0.85, 1, num=3) 
#colors 	= plt.cm.viridis( np.random.rand(N+5))
colors=['red', 'blue', 'blue', 'red']
ref_colors=['black', 'black', 'black']

legend_=["0.25 EeV - 0.5 EeV", "0.5 EeV - 1  EeV", "1 EeV - 2 EeV"]
legend=["EW","EW","EW"] 
ref_legend=["EW Ref.", "EW Ref.", "EW Ref."]


ax = plt.subplot(111, projection='polar')

# if bin_sel==2:
#     ax.set_thetamin(180)
#     ax.set_thetamax(380)
#     ax.set_xticks(np.pi/180. * np.linspace(180,  380, 5, endpoint=True))
#     ax.set_xticklabels(["180°","230°","280°","330°", "20°"])
# else:
#     ax.set_thetamin(180)
#     ax.set_thetamax(400)    
#     ax.set_xticks(np.pi/180. * np.linspace(180,  360, 5, endpoint=True))
#     ax.set_xticklabels(["180°","225°","270°","315°", "0°"])

ax.tick_params(direction='out', pad= 20)


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
	
 	
ax.set_ylim(top=1.2)


#  266.4167
galactic= 266.4167
ax.axvline(np.pi*galactic/180., ls='-.', color='black', linewidth=2.5, label="Centro Galáctico" )
#ax.errorbar(theta, radii, xerr=width,  fmt=".")
ax.yaxis.set_major_locator(plt.NullLocator())
# pos : [left, bottom, width, height] or Bbox
# ax.set_position( [0.0, 0.05, 1, 1])

# plt.text( -50,0.9, "Ref: Aab A. et al. 2020", bbox=dict(facecolor='white', alpha=0.5))
plt.legend(loc='upper left', 
           framealpha =1, 
           bbox_to_anchor=(0.2, 1.02), 
           title="  Rango "+legend_[bin_sel]+"\n  Ref: Aab A. et al. 2020")
ax.grid(linewidth=1.5, linestyle=':', alpha=0.51)
plt.show()