ZKit
====

ZKit is a set of utility codes for make iPhone programmer's life easier.
Many of them could have been provided by Apple Inc, bu somehow not
implemented.


LICENSE
-------
The MIT License (MIT)

Copyright (c) 2013 Electricwoods LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


CLASSES AND CATEGORIES
----------------------

### NSArray+Z

* Create an array by removing an object from immutable array
	e.g. NSArray *array2 = [array1 arrayByRemovingObject:anObject];

* Create an array by removing objects in another array from immutable array

	e.g. NSArray *array3 = [array1 arrayByRemovingObjectsFromArray:array2];

* Create an array by removing objects in set from immutable array

	e.g. NSArray *array2 = [array1 arrayByRemovingObjectsFromSet:set1];

* Adding Objects in set from immutable array

	e.g. NSArray *array2 = [array1 arrayByAddingObjectsFromSet:set1];

* Inserting objects at given index from

	e.g. NSArray *array3 = [array1 arrayByInsertingObjects:array2  atIndex:index];
	
* Sort array without creating an extra array to wrap sort descriptor

	e.g. NSArray *array2 = [array1 sortedArrayUsingSortDescriptor:sortDescriptor];

* Sort array without specifying sort descriptors

	e.g. NSArray *array2 = [array1 sortedArrayUsingKey:@"name" ascending:YES];


### NSMutableArray+Z

* Move object from an index to the other index from mutable array

	e.g. [array1 moveObjectFromIndex:fromIndex toIndex:toIndex];

* Remove objects in a set from mutable array

	e.g. [array1 removeObjectsInSet:set1];

* Insert objects at given index into mutable array

	e.g. [array1 insertObjects:array2 atIndex:givenIndex];

* Add an object if given object is not nil, 'addObject:' crashes if you give it nil

	e.g. [array1 addObject:anObjectOrNil];


### TO BE CONTINUED...
