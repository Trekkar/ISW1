!classDefinition: #TerniLapelliTest category: #'Terni-Lapelli'!
TestCase subclass: #TerniLapelliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 19:23:25'!
test01
	self assert: Tablero new isEmpty. ! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 19:34:24'!
test02
	|tablero players|
	tablero := Tablero new.
	players := OrderedCollection new.
	players add: #X.
	players add: #O.
	
	
	self assert: tablero players = players.
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 20:01:52'!
test03 
	|tablero |
	tablero := Tablero new. 
	tablero placeXAt: 1@1. 
	
	
	self assert: (tablero at: 1@1) = #X
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 21:15:25'!
test04
	|tablero |
	tablero := Tablero new. 
	tablero placeXAt: 1@1. 
	
	[tablero placeOAt: 1@1.]
	on:Error
	do:[:anError | 
		self assert: tablero lastPlayerPlayed = #X. 
		self assert: tablero lastPositionPlaced = (1@1).
		self assert: tablero OHasntPlayed.
		self assert: anError messageText =  'Ya hay una ficha en esa posicion']
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 21:15:40'!
test05
	|tablero |
	tablero := Tablero new. 	
	[tablero placeOAt: 1@1]
	on:Error
	do:[:anError | 
		self assert: tablero positions isEmpty .
		self assert: tablero OHasntPlayed .
		self assert: anError messageText =  'No puede empezar O']
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 21:16:37'!
test06
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1. 	
	[tablero placeXAt: 1@2]
	on:Error
	do:[:anError | 
		self assert: tablero lastPlayerPlayed = #X. 
		self assert: tablero lastPositionPlaced = (1@1).
		self assert: anError messageText =  'No se puede jugar dos veces seguidas por un mismo jugador']
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 20:33:27'!
test07
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1. 	
	self deny: tablero isEmpty 
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 21:17:03'!
test08
	|tablero |
	tablero := Tablero new.
	[tablero placeXAt: 4@4.]
	on:Error
	do:[:anError|
		self deny: tablero lastPositionPlaced = (4@4). 
		self assert: tablero  XHasntPlayed.	 
		self assert: anError messageText = 'Posicion invalida'.]
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 21:11:16'!
test09
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero placeXAt: 3@1] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPieces = 6.
		self assert: tablero lastPositionPlaced  = (3@3).
		self assert: tablero lastPlayerPlayed = #O.
		self assert: anError messageText = 'No se pueden jugar mas de tres fichas'.].
	
	
	
	! !


!classDefinition: #Tablero category: #'Terni-Lapelli'!
Object subclass: #Tablero
	instanceVariableNames: 'positions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!Tablero methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 19:48:06'!
initialize 
	positions := OrderedCollection new.! !

!Tablero methodsFor: 'as yet unclassified' stamp: 'if 11/1/2018 20:34:15'!
isEmpty
	^positions isEmpty .! !


!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 21:15:07'!
OHasntPlayed 
	^(self positions anySatisfy: [:aPosition | aPosition first = #O]) not.! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 21:14:57'!
XHasntPlayed 
	^(self positions anySatisfy: [:aPosition | aPosition first = #X]) not.! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 19:51:48'!
at: aPoint 
	positions detect: [:aPosition| aPosition last = aPoint ] ifFound:[:aPosition| ^aPosition first]  ifNone: [^nil] ! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 21:08:36'!
lastPlayerPlayed 
	^self positions last first! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 21:08:42'!
lastPositionPlaced 
	positions ifNotEmpty: [^self positions last second]. 
	^nil! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 20:49:13'!
numberOfPieces 
	^positions size! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 20:51:25'!
placeOAt: aPoint 
	(positions isEmpty) ifTrue:[^self error:'No puede empezar O'].
	(aPoint x < 0 or: aPoint x > 3) ifTrue:[^self error:'Posicion invalida'].
	(aPoint y < 0 or: aPoint y > 3) ifTrue:[^self error:'Posicion invalida'].
		positions isEmpty 
	ifFalse:[
	(positions last) first = #O ifTrue:['No se puede jugar dos veces seguidas por un mismo jugador'].].
	positions detect:[:aPosition | aPosition last = aPoint ]  ifFound:[:aPostion | ^self error: 'Ya hay una ficha en esa posicion']  
	ifNone:[
		|aNewPosition|
		aNewPosition := OrderedCollection new.
		aNewPosition add: #O.
		aNewPosition  add: aPoint .
		positions add:aNewPosition .] ! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 20:40:02'!
placeXAt: aPoint 
	|aPosition|
	(aPoint x < 0 or: aPoint x > 3) ifTrue:[^self error:'Posicion invalida'].
	(aPoint y < 0 or: aPoint y > 3) ifTrue:[^self error:'Posicion invalida'].
	positions isEmpty 
	ifFalse:[
	(positions last) first = #X ifTrue:[^self error:'No se puede jugar dos veces seguidas por un mismo jugador']].
	
	aPosition := OrderedCollection new.
	aPosition add:#X.
	aPosition add:1@1.
	positions add: aPosition.! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 19:37:39'!
players
	|players|
	players:= OrderedCollection new.  
	players add: #X. 
	players add: #O. 
	^players.! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 20:48:22'!
positions 
	^positions ! !
