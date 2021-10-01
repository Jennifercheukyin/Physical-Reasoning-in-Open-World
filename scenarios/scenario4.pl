% Scenario 4: test condEffect(dump(OC),outsideAt(OA,L))
:- dynamic earlier/2.

earlier(t0,t1).

block(oa).
openContainer(ob). 
openContainer(oc).
location(la). 

holds(t0,directContained(oa,ob)).
holds(t0,directContained(ob,oc)).
holds(t0,outsideAt(oc,la)).

occurs(t0,t1,dump(oc)). 

closedContainer(xc).
containerWithLid(xw).
lid(xl).

% ?- infer(holds(t1,outsideAt(oa,la))). % should succeed. 