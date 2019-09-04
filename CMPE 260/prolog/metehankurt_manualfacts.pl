% Author: METE HAN KURT
% Date: 18.07.2019


%%%%%%%%%%%%%%% TASK 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using clues in description of the project, created at least one fact for each clue.
% Name can be ayse, fatma, hayriye, feride, nazan or naciye according to description.
% Each customer can have exactly one shipment, so I defined six shipment combinations.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

shipmentInfo(Name) :-
    Data = [
           shipment(ayse,Item1,Town1,Price1),
           shipment(fatma,Item2,Town2,Price2),
           shipment(hayriye,Item3,Town3,Price3),
           shipment(feride,Item4,Town4,Price4),
           shipment(nazan,Item5,Town5,Price5),
           shipment(naciye,Item6,Town6,Price6)],

           Item = ([basketball,computer,fruit_basket,rare_book,tea_set,tv]),
           permutation(Item,[Item1,Item2,Item3,Item4,Item5,Item6]),
           Town = ([sariyer,besiktas,uskudar,beykoz,beyoglu,kadikoy]),
           permutation(Town,[Town1,Town2,Town3,Town4,Town5,Town6]),
           Price = ([4,5,6,7,8,9]),
           permutation(Price,[Price1,Price2,Price3,Price4,Price5,Price6]),

           

%%%%%%%%%%%%%%% TASK 2 - Clue 8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, If the shipment goes to uskudar, it must be fatma's shipment.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   (

   member(shipment(fatma,_,uskudar,_),Data)


   ),
   
   
%%%%%%%%%%%%%%% TASK 2 - Clue 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, if the customer is naciye and item is basketball, cost can not be 4.
% Or, if the item is basketball and the cost is 4, the customer cannot be naciye.
% not member function provides us not to get shipments following condition.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       (
        (
       member(shipment(naciye,basketball,_,_),Data),
       
       not(member(shipment(_,basketball,_,4),Data)) );
       
       (
        member(shipment(_,basketball,_,4),Data),
        not(member(shipment(naciye,basketball,_,_),Data)) )
       ),
       
%%%%%%%%%%%%%%% TASK 2 - Clue 9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, if the customer is feride and cost is 8, customer can not be nazan with cost 8.
% Or, if the customer is nazan and the cost is 8, the customer cannot be feride with cost 8.
% not member function provides us not to get shipments following condition.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   (


         (
   member(shipment(feride,_,_,8),Data),

       not(member(shipment(nazan,_,_,8),Data)) );

       (
        member(shipment(nazan,_,_,8),Data),
        not(member(shipment(feride,_,_,8),Data)) )


   ),

%%%%%%%%%%%%%%% TASK 2 - Clue 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, if the item is basketball, then cost can not be 9.
% not member function provides us not to get shipments following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   (
         not(member(shipment(_,basketball,_,9),Data))

   ),
   
%%%%%%%%%%%%%%% TASK 2 - Clue 4  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, if the item is computer and cost is 6, customer can not be hayriye with item computer.
% Or, if the customer is hayriye and the item is computer, the cost cannot be 6 with item computer.
% not member function provides us not to get shipments following condition.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    (


   (
    member(shipment(_,computer,_,6),Data),

       not(member(shipment(hayriye,computer,_,_),Data))  );

       (
       member(shipment(hayriye,computer,_,_),Data),
        not(member(shipment(_,computer,_,6),Data)) )


   ),

%%%%%%%%%%%%%%% TASK 2 - Clue 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, if the item is tv, it can not go to beykoz.
% Or, if the customer is hayriye, it can not also go to beykoz.
% not member function provides us not to get shipments following condition.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   (


   not(member(shipment(_,tv,beykoz,_),Data)),(
               %member(shipment(hayriye,_,uskudar,_),Data);  %Because of clue 8
               member(shipment(hayriye,_,kadikoy,_),Data);
               member(shipment(hayriye,_,beyoglu,_),Data);
               member(shipment(hayriye,_,besiktas,_),Data);
               member(shipment(hayriye,_,sariyer,_),Data)

   )

   ),

%%%%%%%%%%%%%%% TASK 2 - Clue 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, if the customer is feride, item can not be rare_book.
% Or, if the customer is feride, the cost can not also be 9 (it can be 4,5,6,7,8).
% not member function provides us not to get shipments following condition.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   (


   not(member(shipment(feride,rare_book,_,_),Data)),(
               member(shipment(feride,_,_,4),Data);
               member(shipment(feride,_,_,5),Data);
               member(shipment(feride,_,_,6),Data);
               member(shipment(feride,_,_,7),Data);
               member(shipment(feride,_,_,8),Data)

   )


   ),
   
   
%%%%%%%%%%%%%%% TASK 2 - Clue 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows,
% if the customer is hayriye and the cost is 4, then the cost of the shipment goes to kadikoy must be 5.
% if the customer is hayriye and the cost is 5, then the cost of the shipment goes to kadikoy must be 6.
% if the customer is hayriye and the cost is 6, then the cost of the shipment goes to kadikoy must be 7.
% if the customer is hayriye and the cost is 7, then the cost of the shipment goes to kadikoy must be 8.
% if the customer is hayriye and the cost is 8, then the cost of the shipment goes to kadikoy must be 9.
% For each case, the condition with customer hayriye and town kadikoy must be prevented.
% not member function provides us not to get shipments following condition.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   (       (
          member(shipment(hayriye,_,_,4),Data),
          member(shipment(_,_,kadikoy,5),Data),
          not(member(shipment(hayriye,_,kadikoy,_),Data)));
           (
          member(shipment(hayriye,_,_,5),Data),
          member(shipment(_,_,kadikoy,6),Data),
          not(member(shipment(hayriye,_,kadikoy,_),Data)));
          (
          member(shipment(hayriye,_,_,6),Data),
          member(shipment(_,_,kadikoy,7),Data),
          not(member(shipment(hayriye,_,kadikoy,_),Data)));
          (
          member(shipment(hayriye,_,_,7),Data),
          member(shipment(_,_,kadikoy,8),Data),
          not(member(shipment(hayriye,_,kadikoy,_),Data)));
          (
          member(shipment(hayriye,_,_,8),Data),
          member(shipment(_,_,kadikoy,9),Data),
          not(member(shipment(hayriye,_,kadikoy,_),Data)))


   ),


%%%%%%%%%%%%%%% TASK 2 - Clue 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows,
% if the item is tv and the cost is 9, then the cost of the shipment goes to uskudar must be 8.
% if the item is tv and the cost is 8, then the cost of the shipment goes to uskudar must be 7.
% if the item is tv and the cost is 7, then the cost of the shipment goes to uskudar must be 6.
% if the item is tv and the cost is 6, then the cost of the shipment goes to uskudar must be 5.
% if the item is tv and the cost is 5, then the cost of the shipment goes to uskudar must be 4.
% For each case, the condition with item tv and town uskudar must be prevented.
% not member function provides us not to get shipments following condition.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   (

          (
          (
          member(shipment(_,tv,_,9),Data),
          member(shipment(_,_,uskudar,8),Data),
          not(member(shipment(_,tv,uskudar,_),Data))
          );
                  (
          member(shipment(_,tv,_,8),Data),
          member(shipment(_,_,uskudar,7),Data),
          not(member(shipment(_,tv,uskudar,_),Data))
          );
                  (
          member(shipment(_,tv,_,7),Data),
          member(shipment(_,_,uskudar,6),Data),
          not(member(shipment(_,tv,uskudar,_),Data))
          );
                  (
          member(shipment(_,tv,_,6),Data),
          member(shipment(_,_,uskudar,5),Data),
          not(member(shipment(_,tv,uskudar,_),Data))
          );
                    (
          member(shipment(_,tv,_,5),Data),
          member(shipment(_,_,uskudar,4),Data),
          not(member(shipment(_,tv,uskudar,_),Data))
           ) )


   ),


%%%%%%%%%%%%%%% TASK 2 - Clue 10 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, there may be two possibilites so i created two conditions and I combined them with or(;) operation.
% First one is that if shipment with item fruit_basket and cost 9, then other shipment must be ayse's and go to beyoglu.
% Second one is that if shipment goes to beyoglu and cost 9, then other shipment must be ayse's and item must be fruit_basket.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   (
          (
          member(shipment(_,fruit_basket,_,9),Data),
          member(shipment(ayse,_,beyoglu,_),Data) );

          (
          member(shipment(_,_,beyoglu,9),Data),
          member(shipment(ayse,fruit_basket,_,_),Data))


   ),


%%%%%%%%%%%%%%% TASK 2 - Clue 11 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function works as follows, there may be two possibilites so i created two conditions and I combined them with or(;) operation.
% First one is that if shipment with customer fatma and cost 6, then other shipment must be with item tv and go to besiktas.
% Second one is that if shipment with customer fatma and item tv, then other shipment must go to besiktas with cost 6.
% member function provides us to get shipments with following condition.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   (
          (
          member(shipment(fatma,_,_,6),Data),
          member(shipment(_,tv,besiktas,_),Data) );

          (
          member(shipment(fatma,tv,_,_),Data),
          member(shipment(_,_,besiktas,6),Data))


   ),


%%%%%%%%%%%%%%% TASK 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All possible values of the Items are defined.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

member(Item1,[basketball,computer,fruit_basket,rare_book,tea_set,tv]),
member(Item2,[basketball,computer,fruit_basket,rare_book,tea_set,tv]),
member(Item3,[basketball,computer,fruit_basket,rare_book,tea_set,tv]),
member(Item4,[basketball,computer,fruit_basket,rare_book,tea_set,tv]),
member(Item5,[basketball,computer,fruit_basket,rare_book,tea_set,tv]),
member(Item6,[basketball,computer,fruit_basket,rare_book,tea_set,tv]),


%%%%%%%%%%%%%%% TASK 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All possible values of the Prices are defined.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

member(Price1,[4,5,6,7,8,9]),
member(Price2,[4,5,6,7,8,9]),
member(Price3,[4,5,6,7,8,9]),
member(Price4,[4,5,6,7,8,9]),
member(Price5,[4,5,6,7,8,9]),
member(Price6,[4,5,6,7,8,9]),


%%%%%%%%%%%%%%% TASK 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All possible values of the Towns are defined.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

member(Town1, [beykoz,besiktas,sariyer,uskudar,kadikoy,beyoglu]),
member(Town2, [beykoz,besiktas,sariyer,uskudar,kadikoy,beyoglu]),
member(Town3, [beykoz,besiktas,sariyer,uskudar,kadikoy,beyoglu]),
member(Town4, [beykoz,besiktas,sariyer,uskudar,kadikoy,beyoglu]),
member(Town5, [beykoz,besiktas,sariyer,uskudar,kadikoy,beyoglu]),
member(Town6, [beykoz,besiktas,sariyer,uskudar,kadikoy,beyoglu]),
writeanswers(Name,Data), !.   % I used cut(!) in order to show only one of all possible solutions.





    
    
    
    