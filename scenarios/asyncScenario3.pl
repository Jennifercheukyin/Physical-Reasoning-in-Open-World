% This is to test prolog inference time when the number of objects and events increases 

:- dynamic earlier/2.

block(o1).
openContainer(o2). 
openContainer(o3). 
openContainer(o4). 
openContainer(o5). 
openContainer(o6). 
openContainer(o7). 
openContainer(o8). 
openContainer(o9). 
openContainer(o10). 
openContainer(o11).
openContainer(o12). 
openContainer(o13). 
openContainer(o14). 
openContainer(o15). 
openContainer(o16). 
openContainer(o17). 
openContainer(o18). 
openContainer(o19). 
openContainer(o20). 
openContainer(o21). 

location(l).
holds(t0,outsideAt(o1,l)).
holds(t0,outsideAt(o2,l)).
holds(t0,outsideAt(o3,l)).
holds(t0,outsideAt(o4,l)).
holds(t0,outsideAt(o5,l)).
holds(t0,outsideAt(o6,l)).
holds(t0,outsideAt(o7,l)).
holds(t0,outsideAt(o8,l)).
holds(t0,outsideAt(o9,l)).
holds(t0,outsideAt(o10,l)).
holds(t0,outsideAt(o11,l)).
holds(t0,outsideAt(o12,l)).
holds(t0,outsideAt(o13,l)).
holds(t0,outsideAt(o14,l)).
holds(t0,outsideAt(o15,l)).
holds(t0,outsideAt(o16,l)).
holds(t0,outsideAt(o17,l)).
holds(t0,outsideAt(o18,l)).
holds(t0,outsideAt(o19,l)).
holds(t0,outsideAt(o20,l)).
holds(t0,outsideAt(o21,l)).

earlier(t0,t1).
earlier(t0,t3).
earlier(t1,t2).
earlier(t3,t4).
earlier(t2,t5).
earlier(t4,t5).
earlier(t5,t6).

earlier(t6,t7).
earlier(t6,t9).
earlier(t7,t8).
earlier(t9,t10).
earlier(t8,t11).
earlier(t10,t11).
earlier(t11,t12).

earlier(t12,t13).
earlier(t12,t15).
earlier(t13,t14).
earlier(t15,t16).
earlier(t14,t17).
earlier(t16,t17).
earlier(t17,t18).

earlier(t18,t19).
earlier(t18,t21).
earlier(t19,t20).
earlier(t21,t22).
earlier(t20,t23).
earlier(t22,t23).
earlier(t23,t24).

earlier(t24,t25).
earlier(t24,t27).
earlier(t25,t26).
earlier(t27,t28).
earlier(t26,t29).
earlier(t28,t29).
earlier(t29,t30).

earlier(t30,t31).
earlier(t30,t33). 
earlier(t31,t32).
earlier(t33,t34).
earlier(t32,t35).
earlier(t34,t35).
earlier(t35,t36).

occurs(t1,t2,load(o1,o2)).
occurs(t3,t4,load(o2,o3)).
occurs(t5,t6,load(o3,o4)).
occurs(t7,t8,load(o4,o5)).
occurs(t9,t10,load(o5,o6)).
occurs(t10,t11,load(o6,o7)).
occurs(t11,t12,load(o7,o8)).
occurs(t12,t13,load(o8,o9)).
occurs(t13,t14,load(o9,o10)).
occurs(t15,t16,load(o10,o11)).
occurs(t17,t18,load(o11,o12)).
occurs(t19,t20,load(o12,o13)).
occurs(t21,t22,load(o13,o14)).
occurs(t23,t24,load(o14,o15)).
occurs(t25,t26,load(o15,o16)).
occurs(t27,t28,load(o16,o17)).
occurs(t29,t30,load(o17,o18)).
occurs(t31,t32,load(o18,o19)).
occurs(t33,t34,load(o19,o20)).
occurs(t35,t36,load(o20,o21)).

notOccurs(t0,t36,dumpAnything).
notOccurs(t0,t36,unload(o1,o2)).
notOccurs(t0,t36,unload(o2,o3)).
notOccurs(t0,t36,unload(o3,o4)).
notOccurs(t0,t36,unload(o4,o5)).
notOccurs(t0,t36,unload(o5,o6)).
notOccurs(t0,t36,unload(o6,o7)).
notOccurs(t0,t36,unload(o7,o8)).
notOccurs(t0,t36,unload(o8,o9)).
notOccurs(t0,t36,unload(o9,o10)).
notOccurs(t0,t36,unload(o10,o11)).
notOccurs(t0,t36,unload(o11,o12)).
notOccurs(t0,t36,unload(o12,o13)).
notOccurs(t0,t36,unload(o13,o14)).
notOccurs(t0,t36,unload(o14,o15)).
notOccurs(t0,t36,unload(o15,o16)).
notOccurs(t0,t36,unload(o16,o17)).
notOccurs(t0,t36,unload(o17,o18)).
notOccurs(t0,t36,unload(o18,o19)).
notOccurs(t0,t36,unload(o19,o20)).
notOccurs(t0,t36,unload(o20,o21)).

closedContainer(xc). 
containerWithLid(xw).
lid(xl).