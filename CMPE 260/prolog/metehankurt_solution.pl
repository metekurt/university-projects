% Author: METE HAN KURT
% Date: 18.07.2019
% Expected time is about 20 seconds.

:- [metehankurt_manualfacts].


%%%%%%%%%%%%%%% TASK 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Using the write function, this code shows any shipment of customers
%  providing the 11 rules in second task according to the input value entered by the user.
%  The name(input)can be selected as ayse, fatma, hayriye, feride, nazan or naciye.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

writeanswers(_,[]).
writeanswers(Name,[H|T]):-
    (shipment(Name,_,_,_) = H ->
        shipment(A,B,C,D)=H,
        write("Shipment :"), write(" "),write(A),write(", "),write(B),write(", "),write(C),write(", "),write(D),write(".");
        writeanswers(Name,T)
    ).