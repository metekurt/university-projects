*Change the project directories accordingly.
Sets
j customers /
$include "C:\Users\Mete\Desktop\gams\customers.txt"
/
k truck_type /small, large/
n truck_number /1*6/
*n can be increased but optimal is achieved at n=6
alias(j,jp)
;

Parameters
a(j,jp) clusterability /
$include "C:\Users\Mete\Desktop\gams\clusterability.txt"
/

dv(j) demand-volume/
$include "C:\Users\Mete\Desktop\gams\demand-volume.txt"
/
dw(j) demand-weight/
$include "C:\Users\Mete\Desktop\gams\demand-weight.txt"
/
CM(k) cost_multiplier
/small 125
 large 250
/
u(j) trans_cost/
$include "C:\Users\Mete\Desktop\gams\trans_cost.txt"
/
q(k) truck_capacity/
small 18
large 33
/
;
Table c(j,k) direct-shipment-cost
$include "C:\Users\Mete\Desktop\gams\direct-shipment-cost.txt";

Variables
obj total cost
*objective function
x(j,k,n)
*x=1 if customer j is served by direct transs. using truck type k and truck number n.
*x=0 otherwise
y(j)
*y=1 if cumstomer j is served by indirect transs.
*y=0 otherwise.
z(k,n) maximum cost of shipment in the nth truck type k
V(k,n) other shipment number
*V gets a value if the shipment is direct.
*The value V = (# of customers by truck n in type k are served)-1
Binary Variables x,y
Integer Variables V
positive variable z;
;

Equations
cost
one(j)
*Each customer should be served either by direct or indirect transshipment.
two(n,k)
*capacity constraint for direct transs.
three(n,k,j)
*max of the direct cost of a shipment for a given truck
four(k,n)
*maksimum of 3 customers can be served by a given truck
five(j,jp,k,n)
*clusterability conservation
six(k,n)
*Equation of V which gets a value if the shipment is direct.
*The value V = (# of customers by truck n in type k are served)-1
;

cost .. obj =e= sum((k,n),z(k,n)+ CM(k)*V(k,n)) + sum(j, y(j)*dw(j)*u(j));
one(j) .. sum((k,n),x(j,k,n))+y(j)=e=1;
two(n,k) .. sum(j, x(j,k,n)*dv(j))=l=q(k);
three(n,k,j).. x(j,k,n)*c(j,k)=l=z(k,n);
four(k,n) .. sum(j,x(j,k,n))=l=3;
five(j,jp,k,n).. x(j,k,n)+x(jp,k,n)=l=a(j,jp)+1;
six(k,n).. (sum(j,x(j,k,n)))-1 =l= V(k,n);

Model transportation /all/;
Solve transportation using  MIP minimizing obj;