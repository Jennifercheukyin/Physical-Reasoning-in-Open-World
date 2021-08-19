% Scenario 3
:- dynamic earlier/2.

earlier(t0,t1).
block(oa1).
block(oa2).
openContainer(ob1).
openContainer(ob2).
openContainer(oc).
location(la).
location(lb).

holds(t0,effective(ob1)).
holds(t0,effective(ob2)).
holds(t0,effective(oc)).
holds(t0,directContained(oa1,ob1)).
holds(t0,directContained(oa2,ob2)).
holds(t0,directContained(ob1,oc)).
holds(t0,directContained(ob2,oc)).
holds(t0,outsideAt(oc,la)). 

occurs(t0,t1,carry(oc,la,lb)). 

closedContainer(xc).
containerWithLid(xw).
% ?- infer(holds(t0,contained(oa1,ob1))). % should succeed.
% ?- infer(holds(t0,contained(oa1,ob2))). % should fail.
% ?- infer(holds(t0,contained(oa1,oc))). % should succeed.
% ?- infer(holds(t1,contained(oa1,oc))). % should succeed. 
