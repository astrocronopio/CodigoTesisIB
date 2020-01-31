FS=365.25
f(t)= A*(cos(2*pi*(FS*t + phi1)) + B*0.5*cos(2*pi*((FS-1)*t + phi1 - phi2))) + B*0.5*cos(2*pi*((FS+1)*t + phi1 + phi2))
A=1
B=1
phi1=0
phi2=0

plot "../../Herald/Central/Modified/Energy_above_1EeV/Herald_8EeV.dat" u 1:4

plot f(x)