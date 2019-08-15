#awk '{if ($1>1104537601 && $1<1370044800) {n++; avgP+=$3; avgr+=$4}}END{print avgP/n,avgr/n,n}' utctprh2.dat 
#awk 'BEGIN{P0=861.89;rho0=1.055}{if ($1>1104537601 && $1<1370044800) {n++; avgP+=$3-P0; avgr+=$5-rho0; avgra+=$4-$5}}END{print avgP/n,avgr/n,avgra/n,n}' utctprh2.dat 	if($1>=1104537600)	&& $8<4 && $9==1
#awk '{if($1>=1104537600 && $1<=1370044800 && $8<4 && $9==1) print $0,strftime("%H",$1,1)}' utctprhcavg.dat >tmp.dat
#awk 'BEGIN{h6=0;i=0}{i++;if($8<4 && $9==1){h6+=$6}; if(i==12) {print $1,h6,$10;i=0;h6=0}}' tmp.dat > tmp2.dat

awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmodhour3860.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmoddrhour3860.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmodhour038.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmoddrhour038.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmodhour_01012005_31072015.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmoddrhour_01012005_31072015.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmodhoura1_01012005_31072015.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmoddrhoura1_01012005_31072015.dat
#awk 'BEGIN{chi2=0}{chi2+=($3-$2)^2/$2}END{print chi2,chi2/20.}' fitmodnewbdlayrhosummerhour.dat
#awk 'BEGIN{chi2=0}{chi2+=($3-$2)^2/$2}END{print chi2,chi2/22.}' fitmodwinterhour.dat
#awk 'BEGIN{chi2=0}{chi2+=($3-$2)^2/$2}END{print chi2,chi2/21.}' fitmodnewbwinterhour.dat
#awk 'BEGIN{chi2=0}{chi2+=($3-$2)^2/$2}END{print chi2,chi2/20.}' fitmodnewbdlayrhowinterhour.dat

#awk '{if($1<1333310000 || $1>1333490000)print}' HeraldData060weatherdlayrho.dat > HeraldData060weatherdrno.dat
#awk '{if($1<1333310000 || $1>1333490000)print}' HeraldDatasec1weatherdlayrho.dat > HeraldDatasec1weatherdrno.dat
#awk '{if($1<1333310000 || $1>1333490000)print}' HeraldDatasec2weatherdlayrho.dat > HeraldDatasec2weatherdrno.dat
#awk '{if($1<1333310000 || $1>1333490000)print}' HeraldDatasec3weatherdlayrho.dat > HeraldDatasec3weatherdrno.dat
#awk '{if($1<1333310000 || $1>1333490000)print}' HeraldDatasec4weatherdlayrho.dat > HeraldDatasec4weatherdrno.dat
#awk '{if($1<1333310000 || $1>1333490000)print}' HeraldDatasec5weatherdlayrho.dat > HeraldDatasec5weatherdrno.dat
