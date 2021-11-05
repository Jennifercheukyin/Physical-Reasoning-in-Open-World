% Scenario 6: test condEffect(dump(OC),notContained(OA,OC))
:- dynamic earlier/2.

earlier(t0,t1). 

% [oa,ob,oc] and [od,oe] are two clusters 
block(oa).
block(od). 
openContainer(ob).
openContainer(oc). 
closedContainer(oe).
location(la). 
location(lb). 

holds(t0,directContained(oa,ob)).
holds(t0,directContained(ob,oc)). 
holds(t0,outsideAt(oc,la)). 
holds(t0,directContained(od,oe)).
holds(t0,outsideAt(oe,lb)).

occurs(t0,t1,dump(oc)). 

% closedContainer(xc).
containerWithLid(xw).
lid(xl).

% ?- infer(holds(t1,notContained(oa,oc))). % should succeed. 
% ?- infer(holds(t1,notContained(od,oc))). % should succeed.
