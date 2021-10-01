:- dynamic notOccurs/3.
:- multifile(notOccurs/3).
:- multifile(holds/2).

% possible goal states: 
% directContained, contained, notContained, outsideAt, effective, ineffective

% load 
condEffect(load(OB,OC),directContained(OB,OC),[]).
condEffect(load(OB,OC),contained(OB,OC),[]).
condEffect(load(OB,OC),contained(OA,OC),[contained(OA,OB)]).

% unload 
condEffect(unload(OB,OC),notContained(OB,OC),[]).
condEffect(unload(OB,OC),outsideAt(OB,L),[]).

% seal 
condEffect(seal(OC,OL,OW),directContained(OA,OW),[directContained(OA,OC)]).
condEffect(seal(OC,OL,OW),contained(OA,OW),[contained(OA,OC)]).
condEffect(seal(OC,OL,OW),effective(OW),[]).
condEffect(seal(OC,OL,OW),ineffective(OC),[]).
condEffect(seal(OC,OL,OW),ineffective(OL),[]).

% unseal 
condEffect(unseal(OW,OL,OC),directContained(OA,OC),[directContained(OA,OW)]).
condEffect(unseal(OW,OL,OC),contained(OA,OC),[contained(OA,OW)]).
condEffect(unseal(OW,OL,OC),notContained(OA,OW),[contained(OA,OW)]). % not sure about this one, since OW is ineffective
condEffect(unseal(OW,OL,OC),effective(OC),[]).
condEffect(unseal(OW,OL,OC),effective(OL),[]).
condEffect(unseal(OW,OL,OC),ineffective(OW),[]).

% carry 
condEffect(carry(O,LFROM,LTO),outsideAt(O,LTO),[]).

% dump
% condEffect(dump(OC),contained(OA,OC),[contained(OA,OC),closedContainer(OC)]).
% condEffect(dump(OC),contained(OA,OC),[contained(OA,OC),containerWithLid(OC)]).
% condEffect(dump(OC),notContained(OA,OC),[contained(OA,OC),openContainer(OC)]).
% condEffect(dump(OC),notContained(OA,OC),[notContained(OA,OC)]).

condEffect(TA,T,dump(OC),outsideAt(OA,L)) :- 
    checkContainersInBetweenAreOpen(TA,T,OA,OC). 

checkContainersInBetweenAreOpen(TA,T,OA,OC) :- 
    infer(holds(TA,directContained(OA,OC))),
    openContainer(OC). 

checkContainersInBetweenAreOpen(TA,T,OA,OC) :-
    infer(holds(TA,directContained(OA,OB))), 
    openContainer(OB),
    checkContainersInBetweenAreOpen(TA,T,OB,OC).

condEffect(TA,T,dump(OC),directContained(OA,OC)) :-
    (closedContainer(OC); containerWithLid(OC)),
    infer(holds(TA,directContained(OB,OC))), 
    OA = OB.

condEffect(TA,T,dump(OC),directContained(OA,OC)) :-
    (closedContainer(OC); containerWithLid(OC)),
    infer(holds(TA,directContained(OB,OC))), 
    OA \= OB, 
    checkContainersInBetweenAreOpen(TA,T,OA,OB). 
