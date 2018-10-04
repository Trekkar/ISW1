!classDefinition: #QueueTest category: #'Queue-Exercise'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test01QueueShouldBeEmptyWhenCreated

	| queue |

	queue _ Queue new.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test02EnqueueAddElementsToTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.

	self deny: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test03DequeueRemovesElementsFromTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test04DequeueReturnsFirstEnqueuedObject

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'Something1'.
	secondQueued _ 'Something2'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.
	
	self assert: queue dequeue equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'CGCM 9/27/2018 16:34:58'!
test05QueueBehavesFIFO

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'First'.
	secondQueued _ 'Second'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.

	self assert: queue dequeue equals: firstQueued.
	self assert: queue dequeue equals: secondQueued.
	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test06NextReturnsFirstEnqueuedObject

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	self assert: queue next equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test07NextDoesNotRemoveObjectFromQueue

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	queue next.
	self assert: queue size equals: 1.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test08CanNotDequeueWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.
	
	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test09CanNotDequeueWhenThereAreNoObjectsInTheQueueAndTheQueueHadObjects

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #Queue category: #'Queue-Exercise'!
Object subclass: #Queue
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!Queue methodsFor: 'initialization' stamp: 'EG 9/30/2018 18:04:23'!
initialize
	contents := OrderedCollection new.
	! !


!Queue methodsFor: 'operations public' stamp: 'EG 9/30/2018 19:35:19'!
dequeue
	|queueState|
	queueState  := QueueState StateForQueue: self.
	^queueState dequeue.
	

! !

!Queue methodsFor: 'operations public' stamp: 'EG 9/30/2018 18:10:03'!
enqueue: anObjetct 
	contents add:anObjetct .! !

!Queue methodsFor: 'operations public' stamp: 'EG 9/30/2018 18:08:08'!
isEmpty
	^contents isEmpty.! !

!Queue methodsFor: 'operations public' stamp: 'EG 9/30/2018 19:56:19'!
isNotEmpty
	^contents notEmpty.! !

!Queue methodsFor: 'operations public' stamp: 'EG 9/30/2018 20:02:24'!
next
	|queueState|
	queueState  := QueueState StateForQueue: self.
	^queueState next.
	! !

!Queue methodsFor: 'operations public' stamp: 'EG 9/30/2018 20:02:02'!
size
	^contents size.! !


!Queue methodsFor: 'operations private' stamp: 'EG 9/30/2018 19:40:13'!
dequeueWhenEmpty
	^self error: self class queueEmptyErrorDescription! !

!Queue methodsFor: 'operations private' stamp: 'EG 9/30/2018 19:57:40'!
dequeueWhenNotEmpty
	^contents removeFirst.! !

!Queue methodsFor: 'operations private' stamp: 'EG 9/30/2018 20:08:31'!
nextWhenEmpty
	^self error: self class queueEmptyErrorDescription! !

!Queue methodsFor: 'operations private' stamp: 'EG 9/30/2018 20:10:34'!
nextWhenNotEmpty
	^contents first.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-Exercise'!
Queue class
	instanceVariableNames: ''!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !


!classDefinition: #QueueState category: #'Queue-Exercise'!
Object subclass: #QueueState
	instanceVariableNames: 'queue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueState methodsFor: 'queue operations' stamp: 'EG 9/30/2018 19:14:05'!
dequeue
	self subclassResponsibility ! !

!QueueState methodsFor: 'queue operations' stamp: 'EG 9/30/2018 20:05:21'!
next
	self subclassResponsibility ! !


!QueueState methodsFor: 'initialize' stamp: 'EG 9/30/2018 19:29:59'!
initializeWith: aQueue
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'QueueState class' category: #'Queue-Exercise'!
QueueState class
	instanceVariableNames: 'unaLlamada'!

!QueueState class methodsFor: 'state searcher' stamp: 'EG 10/4/2018 00:05:20'!
StateForQueue: aQueue

	| QueueState |

	QueueState _ self subclasses detect: [ :QueueStates | QueueStates canHandle: aQueue ].
	
	^ QueueState for: aQueue.! !

!QueueState class methodsFor: 'state searcher' stamp: 'EG 10/4/2018 00:05:19'!
canHandle: aQueue
	self subclassResponsibility .! !


!QueueState class methodsFor: 'instance creator' stamp: 'EG 9/30/2018 19:33:02'!
for: aQueue
	^self new initializeWith: aQueue.
	! !


!classDefinition: #EmptyQueue category: #'Queue-Exercise'!
QueueState subclass: #EmptyQueue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!EmptyQueue methodsFor: 'initialize' stamp: 'EG 9/30/2018 19:07:00'!
initializeWith: aQueue
	queue:=aQueue ! !


!EmptyQueue methodsFor: 'queue operations' stamp: 'EG 9/30/2018 19:15:03'!
dequeue
	^queue dequeueWhenEmpty.! !

!EmptyQueue methodsFor: 'queue operations' stamp: 'EG 9/30/2018 20:07:41'!
next
	^queue nextWhenEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyQueue class' category: #'Queue-Exercise'!
EmptyQueue class
	instanceVariableNames: ''!

!EmptyQueue class methodsFor: 'state searcher' stamp: 'EG 10/4/2018 00:05:20'!
canHandle: aQueue
	^aQueue isEmpty.! !


!classDefinition: #NotEmptyQueue category: #'Queue-Exercise'!
QueueState subclass: #NotEmptyQueue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!NotEmptyQueue methodsFor: 'initialize' stamp: 'EG 9/30/2018 19:07:07'!
initializeWith: aQueue
	queue:=aQueue ! !


!NotEmptyQueue methodsFor: 'queue operations' stamp: 'EG 9/30/2018 19:19:29'!
dequeue
	^queue dequeueWhenNotEmpty.! !

!NotEmptyQueue methodsFor: 'queue operations' stamp: 'EG 9/30/2018 20:10:57'!
next
	^queue nextWhenNotEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyQueue class' category: #'Queue-Exercise'!
NotEmptyQueue class
	instanceVariableNames: ''!

!NotEmptyQueue class methodsFor: 'state searcher' stamp: 'EG 10/4/2018 00:05:19'!
canHandle: aQueue
	^aQueue isNotEmpty.! !
