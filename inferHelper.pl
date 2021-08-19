:- dynamic notOccurs/3.
:- multifile(notOccurs/3).
:- multifile(holds/2).

% notOccurs is to check if E doesn't occur in the superinterval
notOccurs(TA,TB,E) :-
    earlier(TX,TA), 
    notOccurs(TX,TB,E). 

notOccurs(TA,TB,E) :-
    earlier(TB,TY),
    notOccurs(TA,TY,E).

notOccurs(TA,TB,E) :-
    earlier(TX,TA),
    earlier(TB,TY),
    notOccurs(TX,TY,E). 

notOccurs(TA,TB,carrySomewhere(_)) :- 
    notOccurs(TX,TY,carrySomethingSomewhere).

notOccurs(TA,TB,loadIntoSomething(_)) :- 
    notOccurs(TX,TY,load).

holds(T,notContained(OB,OC)) :-
    OB \= OC,
    infer(holds(T,outsideAt(OB,_))).

holds(T,notContained(OB,OC)) :-
    infer(holds(T,directContained(OB,OM))), 
    OM \= OC,
    infer(holds(T,notContained(OM,OC))).

holds(T,contained(OA,OC)) :- 
    infer(holds(T,directContained(OA,OC))). 

holds(T,contained(OA,OC)) :-
    infer(holds(T,directContained(OA,OB))),
    infer(holds(T,contained(OB,OC))).

holds(_,effective(O)) :- 
    block(O);
    closedContainer(O).
