## Script que calcula el valor del $\chi^2$ para el fit del rate por hora del día.
##
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmodhour3860.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmoddrhour3860.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmodhour038.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmoddrhour038.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmodhour_01012005_31072015.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmoddrhour_01012005_31072015.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmodhoura1_01012005_31122015.dat
awk 'BEGIN{chi2=0}{chi2+=($2-$1)^2/$1}END{print chi2,chi2/20.}' fitmoddrhoura1_01012005_31122015.dat
#awk 'BEGIN{chi2=0}{chi2+=($3-$2)^2/$2}END{print chi2,chi2/20.}' fitmodnewbdlayrhosummerhour.dat
#awk 'BEGIN{chi2=0}{chi2+=($3-$2)^2/$2}END{print chi2,chi2/22.}' fitmodwinterhour.dat
#awk 'BEGIN{chi2=0}{chi2+=($3-$2)^2/$2}END{print chi2,chi2/21.}' fitmodnewbwinterhour.dat
#awk 'BEGIN{chi2=0}{chi2+=($3-$2)^2/$2}END{print chi2,chi2/20.}' fitmodnewbdlayrhowinterhour.dat

