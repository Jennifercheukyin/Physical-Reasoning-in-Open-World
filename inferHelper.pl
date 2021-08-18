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

checkNotContained(T,notContained(OB,OC)) :-
    OB \= OC,
    holds(T,outsideAt(OB,_)).

checkNotContained(T,notContained(OB,OC)) :-
    holds(T,directContained(OB,OM)), 
    OM \= OC,
    checkNotContained(T,notContained(OM,OC)).

checkContained(T,contained(OA,OC)) :- 
    holds(T,directContained(OA,OC)). 

checkContained(T,contained(OA,OC)) :-
    holds(T,directContained(OB,OC)),
    checkContained(T,contained(OA,OB)).

