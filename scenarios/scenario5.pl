% Scenario 5: test condEffect(dump(OC),directContained(OA,OC))
:- dynamic earlier/2.

earlier(t0,t1). 

block(oa).
openContainer(ob).
openContainer(oc). 
closedContainer(od). 
containerWithLid(ow).
location(la). 

holds(t0,directContained(oa,ob)).
holds(t0,directContained(ob,oc)).
% holds(t0,directContained(oc,od)). 
% holds(t0,outsideAt(od,la)). 
holds(t0,directContained(oc,ow)). 
holds(t0,outsideAt(ow,la)). 

% occurs(t0,t1,dump(od)). 
occurs(t0,t1,dump(ow)).

lid(xl).
% containerWithLid(xw). 

% ?- infer(holds(t1,directContained(oa,od))). % should succeed. 
% ?- infer(holds(t1,directContained(oa,ow))). % should succeed. 