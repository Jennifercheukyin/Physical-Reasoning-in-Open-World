% Scenario 7: test condEffect for dump 
:- dynamic earlier/2.

earlier(t0,t1).
earlier(t1,t2).
earlier(t2,t3).

block(oa).
closedContainer(ob).
openContainer(oc).
closedContainer(od).
openContainer(oe). 
location(la). 

holds(t0,directContained(oa,ob)).
holds(t0,directContained(ob,oc)).
holds(t0,directContained(oc,od)).
holds(t0,directContained(od,oe)).
holds(t0,outsideAt(oe,la)).
holds(t0,effective(oc)). 
holds(t0,effective(oe)). 

occurs(t0,t1,dump(oe)). 
occurs(t2,t3,dump(od)). 

% Keep outsideAt 
notOccurs(t1,t2,carrySomewhere(oe)).
notOccurs(t1,t2,loadIntoSomething(oe)). 

lid(xl).
containerWithLid(xw). 

% After occurs(t0,t1,dump(oe)): 
% holds(t1,outsideAt(oe,la)).
% holds(t1,outsideAt(od,la)).
% holds(t1,directContained(oc,od)). 
% holds(t1,directContained(ob,od)).
% holds(t1,directContained(oa,ob)). 

% ?- infer(holds(t1,outsideAt(oe,la))). % should succeed 
% ?- infer(holds(t1,outsideAt(od,la))). % should succeed 
% ?- infer(holds(t1,directContained(ob,od))). % should succeed 

% ?- infer(holds(t2,outsideAt(oe,la))). % should succeed 
% ?- infer(holds(t2,outsideAt(od,la))). % should fail, since no notOccurs to satisfy persists 
% ?- infer(holds(t2,directContained(ob,od))). % should succeed 