:- dynamic earlier/2.

earlier(t1,t2).
earlier(t3,t4).
earlier(t2,t5).
earlier(t3,t5).

block(oa).
openContainer(ob). 
openContainer(oc).
location(la).
location(lb). 

occurs(t1,t2,load(oa,ob)). 
occurs(t3,t4,carry(oc,la,lb)). 

% ?- infer(holds(t2, directContained(oa,ob))). should succeed
% ?- infer(holds(t4, outsideAt(oc,lb))). should succeed 