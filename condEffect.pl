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
% outsideAt 
inferDumpEffect(TA,dump(OC),outsideAt(OA,L)) :- 
    OA = OC; chainOfOpenContainersIncluding(TA,OA,OC). 

% Check that there is a chain of open containers from OA up to and including OC.
chainOfOpenContainersIncluding(TA,OA,OC) :- 
    openContainer(OC), 
    infer(holds(TA,effective(OC))), 
    chainOfOpenContainersUntil(TA,OA,OC).

% Check that there is a chain of open containers from OA up to but not including OC.
% Base case: null chain
chainOfOpenContainersUntil(T,OA,OC) :-
    infer(holds(T,directContained(OA,OC))).
    
% Recursive case
chainOfOpenContainersUntil(T,OA,OC) :-
    infer(holds(T,directContained(OA,OB))),
    OB \= OC,
    openContainer(OB),
    infer(holds(T,effective(OB))),
    chainOfOpenContainersUntil(T,OB,OC).

% directContained 
inferDumpEffect(TA,dump(OC),directContained(OA,OB)) :-
    (OB = OC; infer(holds(TA,contained(OB,OC)))), 
    workingClosedContainer(TA,OB),
    chainOfOpenContainersUntil(TA,OA,OB).

% OB works as a closed container at time T if either it is a permanently closed
% container or it is an effective lidded container at T
workingClosedContainer(_,OB) :- closedContainer(OB).

workingClosedContainer(T,OB) :-
    containerWithLid(OB).
    infer(T,effective(OB)).

% contained 
% (OA,OB) and OC belong to two clusters 
inferDumpEffect(TA,dump(OC),contained(OA,OB)) :-
    infer(holds(TA,notContained(OB,OC))), 
    infer(holds(TA,contained(OA,OB))). 

% (OA,OB,OC) is one cluster 
inferDumpEffect(TA,dump(OC),contained(OA,OB)) :-
    infer(holds(TA,contained(OB,OC))), 
    workingClosedContainer(T,OB).

% % notContained 
% inferDumpEffect(TA,dump(OC),notContained(OA,OC)) :-
%     infer(holds(TA,contained(OA,OC))),
%     openContainer(OC). 

% inferDumpEffect(TA,dump(OC),notContained(OA,OC)) :-
%     infer(holds(TA,notContained(OA,OC))). 
