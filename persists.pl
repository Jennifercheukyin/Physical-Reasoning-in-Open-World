:- dynamic notOccurs/3.
:- multifile(notOccurs/3).
:- multifile(holds/2).

% persists for directContained
persists(T,TNEXT,directContained(OB,OC)) :-
    closedContainer(OC).

persists(T,TNEXT,directContained(OB,OC)) :-
    containerWithLid(OC),
    infer(holds(TNEXT,effective(OC))).

persists(T,TNEXT,directContained(OB,OC)) :-
    occurs(T,TNEXT,load(_,_));
    occurs(T,TNEXT,carry(_,_,_));
    occurs(T,TNEXT,seal(_,_,_)).

persists(T,TNEXT,directContained(OB,OC)) :-
    occurs(T,TNEXT,unload(OX,_)),
    OX \= OB.

persists(T,TNEXT,directContained(OB,OC)) :-
    occurs(T,TNEXT,unseal(OW,_,_)),
    OW \= OC. 

% Note: OB.OC means directContained(OB,OC), OC..OX means contained(OC,OX), comma means two groups that don't have contain relationship
% OC is an open container
% OB.OC..OX: since OC is open, whatever is inside OC will come out, so directContained(OB,OC) false. 
% OB.OC.., ..OX: directContained(OB,OC) is true 
persists(T,TNEXT,directContained(OB,OC)) :- % OC can be an open container or containerWithLid
    occurs(T,TNEXT,dump(OX)), % OX must be effective and outsideAt
    openContainer(OC),
    checkNotContained(T,notContained(OC,OX)).

% Note: OB.OC means directContained(OB,OC), OC..OX means contained(OC,OX), comma means two groups that don't have contain relationship
% OC is a containerWithLid
% OB.OC..OX: since OC is closed, directContained(OB,OC) is true. 
% OB.OC.., ..OX: directContained(OB,OC) is true 
persists(T,TNEXT,directContained(OB,OC)) :- % OC can be an open container or containerWithLid
    occurs(T,TNEXT,dump(OX)), % OX must be effective and outsideAt
    containerWithLid(OC),
    infer(holds(T,effective(OC))).

persists(T,TNEXT,directContained(OB,OC)) :-
    notOccurs(T,TNEXT,dumpAnything),
    notOccurs(T,TNEXT,unload(OB,OC)).


% persists for contained 
persists(T,TNEXT,contained(OB,OC)) :-
    closedContainer(OC).

persists(T,TNEXT,contained(OB,OC)) :-
    containerWithLid(OC),
    infer(holds(T,effective(OC))),
    notOccurs(T,TNEXT,unsealToAnything(OC)).

persists(T,TNEXT,contained(OB,OC)) :-
    notOccurs(T,TNEXT,dumpAnything),
    notOccurs(T,TNEXT,unload(OX,_)), 
    checkNotContained(T,notContained(OB,OX)).

% NOTE: OB..OC means contained(OB,OC), OX.OC means directContained(OX,OC)
% OB..OC..OX.OA: OX becomes outsideAt, but doesn't affect contained(OB,OC). contained(OB,OC) true 
% OB..OX.OC: contained(OB,OC) false 
% OX..OB..OC: cannot unload OX since it's not directContained in the outermost container 
% OB..OC, OX.OA: contained(OB,OC) is true. 
persists(T,TNEXT,contained(OB,OC)) :- 
    occurs(T,TNEXT,unload(OX,_)), % unload OX from some container, OX will become outsideAt after the unload 
    checkNotContained(T,notContained(OB,OX)).

persists(T,TNEXT,contained(OB,OC)) :-
    occurs(T,TNEXT,load(_,_));
    occurs(T,TNEXT,carry(_,_,_));
    occurs(T,TNEXT,seal(_,_,_)).

persists(T,TNEXT,contained(OB,OC)) :-
    occurs(T,TNEXT,unseal(OW,_,_)),
    OW \= OC. 

% NOTE: OB..OC means contained(OB,OC), OX.OC means directContained(OX,OC), comma means they don't have contained relationship
% OC is open container 
% OB..OC..OX: whatever is inside OC will come out of OC, contained(OB,OC) false. 
% OB..OC.., ..OX: contained(OB,OC) true whatever the type of OC
persists(T,TNEXT,contained(OB,OC)) :- % OC can be open container or containerWithLid
    occurs(T,TNEXT,dump(OX)), % OX must be outsideAt, can be open or closed/withLid
    openContainer(OC), 
    checkNotContained(T,notContained(OC,OX)).  

% NOTE: OB..OC means contained(OB,OC), OX.OC means directContained(OX,OC), comma means they don't have contained relationship
% OC is containerWithLid
% OB..OC..OX: whatever is inside OC will stay inside, contained(OB,OC) true. 
% OB..OC.., ..OX: contained(OB,OC) true whatever the type of OC
persists(T,TNEXT,contained(OB,OC)) :- % OC can be open container or containerWithLid
    occurs(T,TNEXT,dump(OX)), % OX must be outsideAt, can be open or closed/withLid
    containerWithLid(OC),
    infer(holds(T,effective(OC))). 

% persists for notContained
% holds(T,notContained(OB,OC))
% ..OB.., ..OC..
persists(T,TNEXT,notContained(OB,OC)) :-
    holds(T,outsideAt(OB,L)), 
    persists(T,TNEXT,outsideAt(OB,L)).

persists(T,TNEXT,notContained(OB,OC)) :-
    occurs(T,TNEXT,carry(_,_,_));
    occurs(T,TNEXT,dump(_));
    occurs(T,TNEXT,unload(_,_));
    occurs(T,TNEXT,seal(_,_,_)).

% persists(T,TNEXT,notContained(OB,OC)) :-
%     occurs(T,TNEXT,load())

% persists for effective 
persists(T,TNEXT,effective(O)) :-
    occurs(T,TNEXT,load(_,_));
    occurs(T,TNEXT,unload(_,_));
    occurs(T,TNEXT,carry(_,_,_));
    occurs(T,TNEXT,dump(_)). 

persists(T,TNEXT,effective(O)) :-
    occurs(T,TNEXT,seal(OC,OL,_)),
    OC \= O,
    OL \= O. 

persists(T,TNEXT,effective(O)) :-
    occurs(T,TNEXT,unseal(OW,_,_)),
    OW \= O. 

persists(T,TNEXT,effective(O)) :-
    notOccurs(T,TNEXT,sealWithAnything(O)),
    notOccurs(T,TNEXT,unsealToAnything(O)).

% persists for ineffective 
persists(T,TNEXT,ineffective(O)) :-
    occurs(T,TNEXT,load(_,_)); 
    occurs(T,TNEXT,unload(_,_)); 
    occurs(T,TNEXT, carry(_,_,_));
    occurs(T,TNEXT, dump(_)). 

persists(T,TNEXT,ineffective(O)) :-
    occurs(T,TNEXT,seal(_,_,OW)),
    OW \= O. 

persists(T,TNEXT,ineffective(O)) :-
    occurs(T,TNEXT,unseal(OW,OL,OC)),
    OC \= O,
    OL \= O. 

persists(T,TNEXT,ineffective(O)) :-
    notOccurs(T,TNEXT,unsealToAnything(O)),
    notOccurs(T,TNEXT,seal(_,_,O)).

% persists for outsideAt
persists(T,TNEXT,outsideAt(O,L)) :-
    occurs(T,TNEXT,seal(_,_,_));
    occurs(T,TNEXT,unseal(_,_,_)); 
    occurs(T,TNEXT,dump(_));
    occurs(T,TNEXT,unload(_,_)).

persists(T,TNEXT,outsideAt(O,L)) :-
    occurs(T,TNEXT,carry(OX,_,_)),
    OX \= O. 

persists(T,TNEXT,outsideAt(O,L)) :-
    occurs(T,TNEXT,load(OX,_)),
    OX \= O. 
   
persists(T,TNEXT,outsideAt(O,L)) :-
    notOccurs(T,TNEXT,carrySomewhere(O)), 
    notOccurs(T,TNEXT,loadIntoSomething(O)).

