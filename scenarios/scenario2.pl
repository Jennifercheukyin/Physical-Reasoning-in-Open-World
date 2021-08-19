% Scenario 2
:- dynamic earlier/2.

earlier(t0,t1).
earlier(t1,t2).
earlier(t2,t3).
block(oa).
block(ob).
openContainer(oc).
openContainer(od). 
lid(ol).
containerWithLid(ow).
components(od,ol,ow).

location(la).
location(lb).

holds(t0,directContained(oa,oc)).
holds(t0,directContained(ob,ow)).
holds(t0,outsideAt(oc,la)).
holds(t0,outsideAt(ow,la)).
holds(t0,effective(oc)).
holds(t0,ineffective(od)).
holds(t0,ineffective(ol)).
holds(t0,effective(ow)).

occurs(t0,t1,unload(oa,oc)).
occurs(t2,t3,unseal(ow,ol,od)).

% the notOccurs are to gurantee directContained(ob,ow) between [t1,t2]
notOccurs(t0,t2,unload(ob,ow)).
notOccurs(t1,t2,dumpAnything).

closedContainer(xd).

% ?- infer(holds(t3,directContained(ob,od))).  % should succeed. 
% ?- infer(holds(t3,outsideAt(ob,la))).  % should fail.
% ?- infer(holds(t3,directContained(ob,ow))).  % should fail. infer(holds(t3,directContained(ob,ow))) -> infer(holds(t2,directContained(ob,ow))) -> infer(holds(t1,directContained(ob,ow))).
% ?- infer(holds(t3,ineffective(ow))). % should succeed
% ?- infer(holds(t3,effective(od))). % should succeed 
% ?- infer(holds(t3,effective(oa))). % should succeed 


