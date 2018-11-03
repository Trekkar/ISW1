!classDefinition: #TerniLapelliTest category: #'Terni-Lapelli'!
TestCase subclass: #TerniLapelliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 17:25:56'!
test01GameStartsWithAnEmptyBoardAndXTurn
	|tablero|
	
	tablero := Tablero new.
	
	self assert: tablero isEmpty. 
	self assert: tablero currentTurn = #X.
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 17:27:01'!
test02AfterPlacingXPositionIsOccupiedAndOHasntPlayed
	|tablero |
	tablero := Tablero new. 	
	tablero placeXAt: 1@1.
	
	self assert: tablero numberOfPiecesOnBoard = 1.
	self assert: tablero OHasntPlayed.
	self deny: tablero XHasntPlayed.
	self assert: (tablero at: 1@1) = #X.
	self assert: tablero currentTurn = #O.
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 17:28:42'!
test03OCannotStartFirst 
	|tablero |
	tablero := Tablero new. 
	
	[tablero placeOAt: 1@1]
	on:Error
	do:[
		:anError | self assert: anError messageText = 'No puede empezar O'.
		self assert: tablero numberOfPiecesOnBoard = 0.
		self assert: tablero OHasntPlayed .
		self assert: tablero currentTurn  = #X.
	 ] 
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 17:29:29'!
test04PiecesCannotBePlayedOnOccupiedSpots
	|tablero |
	tablero := Tablero new. 
	tablero placeXAt: 1@1. 
	
	[tablero placeOAt: 1@1.]
	on:Error
	do:[:anError | 
		self assert: tablero lastPlayerPlayed = #X. 
		self assert: tablero lastPositionPlaced = (1@1).
		self assert: tablero OHasntPlayed.
	     self assert: tablero currentTurn  = #O.
		self assert: anError messageText =  'Ya hay una ficha en esa posicion']
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 15:53:23'!
test05APlayerCannotPlayTwiceInARow
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 15:54:35'!
test06PiecesCannotBePlayedOutOfBounds
	|tablero |
	tablero := Tablero new.
	[tablero placeXAt: 4@4.]
	on:Error
	do:[:anError|
		self deny: tablero lastPositionPlaced = (4@4). 
		self assert: tablero  XHasntPlayed.	 
		self assert: anError messageText = 'Posicion invalida'.]
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 15:55:10'!
test07APlayerCannotHaveMoreThanThreePiecesOnBoard
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
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero lastPositionPlaced  = (3@3).
		self assert: tablero lastPlayerPlayed = #O.
		self assert: anError messageText = 'No se pueden jugar mas de tres fichas'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 16:35:33'!
test08PlayersCanOnlyMovePiecesTheyOwn
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 3@3 to:3@2] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero lastPlayerPlayed = #O.
		self assert: (tablero at:3@3) = #O.
		self assert: anError messageText = 'Movimiento invalido'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 16:36:10'!
test09PlayersCannotMovePiecesFromPositionsThatWasntMarked
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 3@1 to:3@2] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero lastPlayerPlayed = #O.
		self assert: (tablero at:3@1) = nil. 
		self assert: anError messageText = 'Movimiento invalido'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 16:36:56'!
test10PlayersCannotMovePiecesOutOfBounds
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 1@1 to:0@0] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero lastPlayerPlayed = #O.
		self assert: (tablero at:1@1) = #X.
		self assert: anError messageText = 'Movimiento invalido'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 16:39:31'!
test11PiecesCanOnlyBeMovedToDirectNeighbours
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 1@1 to:3@2] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero lastPlayerPlayed = #O.
		self assert: (tablero at:1@1) = #X.
		self assert: anError messageText = 'Movimiento invalido'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 18:40:47'!
test12PiecesCanBeMovedToAValidPosition
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	tablero moveXFrom: 2@2 to:2@1.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #O.
	self assert: (tablero at:2@1) = #X.
	self assert: (tablero at:2@2) = nil.
	self assert: tablero winner = nil.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 18:47:26'!
test13APlayerWinOnPlacingWhenCompletesFirstColumn
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 2@2.
	tablero placeXAt: 1@2.
	tablero placeOAt: 2@3.
	tablero placeXAt: 1@3.
	 
	self assert: tablero numberOfPiecesOnBoard = 5.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:32:43'!
test14APlayerWinOnPlacingWhenCompletesSecondColumn
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 2@2.
	tablero placeXAt: 1@2.
	tablero placeOAt: 2@3.
	tablero placeXAt: 3@1.
	tablero placeOAt: 2@1.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #X.
	self assert: tablero winner = #O.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:38:52'!
test15APlayerWinOnPlacingWhenCompletesThirdColumn
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 3@3.
	tablero placeXAt: 1@2.
	tablero placeOAt: 3@2.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@1.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #X.
	self assert: tablero winner = #O.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:39:58'!
test16APlayerWinOnPlacingWhenCompletesFirstRow
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 3@3.
	tablero placeXAt: 2@1.
	tablero placeOAt: 3@2.
	tablero placeXAt: 3@1.

	 
	self assert: tablero numberOfPiecesOnBoard = 5.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:41:37'!
test17APlayerWinOnPlacingWhenCompletesSecondRow
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 2@1.
	tablero placeOAt: 2@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 3@2.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #X.
	self assert: tablero winner = #O.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:44:28'!
test18APlayerWinOnPlacingWhenCompletesThirdRow
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@3.
	tablero placeOAt: 1@2.
	tablero placeXAt: 2@3.
	tablero placeOAt: 2@2.
	tablero placeXAt: 3@3.
	
	 
	self assert: tablero numberOfPiecesOnBoard = 5.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:45:45'!
test19APlayerWinOnPlacingWhenCompletesUpDiagonal
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 2@2.
	tablero placeOAt: 2@3.
	tablero placeXAt: 3@3.
	
	 
	self assert: tablero numberOfPiecesOnBoard = 5.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:47:10'!
test20APlayerWinOnPlacingWhenCompletesDownDiagonal
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@3.
	tablero placeXAt: 1@2.
	tablero placeOAt: 2@2.
	tablero placeXAt: 3@2.
	tablero placeOAt: 3@1.
	
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #X.
	self assert: tablero winner = #O.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:50:41'!
test21APlayerWinOnMovingWhenCompletesFirstColumn
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 2@2.
	tablero placeXAt: 1@2.
	tablero placeOAt: 2@1.
	tablero placeXAt: 2@3.
	tablero placeOAt: 3@2.
	tablero moveXFrom: 2@3 to: 1@3.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:53:57'!
test22APlayerWinOnMovingWhenCompletesSecondColumn
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 2@2.
	tablero placeXAt: 1@2.
	tablero placeOAt: 2@1.
	tablero placeXAt: 3@1.
	tablero placeOAt: 3@3.
	
	tablero moveXFrom: 3@1 to: 3@2.
	tablero moveOFrom: 3@3 to: 2@3.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #X.
	self assert: tablero winner = #O.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:59:10'!
test23APlayerWinOnMovingWhenCompletesThirdColumn
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 3@1.
	tablero placeOAt: 1@1.
	tablero placeXAt: 3@2.
	tablero placeOAt: 2@2.
	tablero placeXAt: 2@3.
	tablero placeOAt: 1@3.
	
	tablero moveXFrom: 2@3 to: 3@3.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 20:00:36'!
test24APlayerWinOnMovingWhenCompleteFirstRow
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 2@1.
	tablero placeOAt: 1@3.
	tablero placeXAt: 3@2.
	tablero placeOAt: 2@3.
	
	tablero moveXFrom: 3@2 to: 3@1.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 20:01:55'!
test25APlayerWinOnMovingWhenCompleteSecondRow
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@2.
	tablero placeOAt: 1@1.
	tablero placeXAt: 2@2.
	tablero placeOAt: 1@3.
	tablero placeXAt: 3@3.
	tablero placeOAt: 2@3.
	
	tablero moveXFrom: 3@3 to: 3@2.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 20:13:39'!
test26APlayerWinOnMovingWhenCompleteThirdRow
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@3.
	tablero placeOAt: 1@1.
	tablero placeXAt: 2@3.
	tablero placeOAt: 1@2.
	tablero placeXAt: 2@2.
	tablero placeOAt: 2@1.
	
	tablero moveXFrom: 2@2 to: 3@3.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 20:15:02'!
test27APlayerWinOnMovingWhenCompleteUpDiagonal
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 2@2.
	tablero placeOAt: 1@3.
	tablero placeXAt: 3@2.
	tablero placeOAt: 2@3.
	
	tablero moveXFrom: 3@2 to: 3@3.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 20:16:55'!
test28APlayerWinOnMovingWhenCompleteDownDiagonal
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@2.
	tablero placeOAt: 1@3.
	tablero placeXAt: 1@1.
	tablero placeOAt: 3@1.
	tablero placeXAt: 3@3.
	tablero placeOAt: 2@3.
	
	tablero moveXFrom: 3@3 to: 3@2.
	tablero moveOFrom: 2@3 to: 2@2.
	 
	self assert: tablero numberOfPiecesOnBoard = 6.
	self assert: tablero currentTurn = #X.
	self assert: tablero winner = #O.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 20:19:53'!
test29APlayerCannotMoveToTheSamePosition
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@2.
	tablero placeOAt: 1@3.
	tablero placeXAt: 1@1.
	tablero placeOAt: 3@1.
	tablero placeXAt: 3@3.
	tablero placeOAt: 2@3.
	
	[tablero moveXFrom: 3@3 to: 3@3.]
	on:Error
	do:[:anError |
		anError messageText  = 'Movimiento invalido'.
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero currentTurn = #X.
		self assert: tablero winner = nil.
	].
	 
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 20:24:25'!
test30APlayerCannotPlayIfGameIsOver
	|tablero |
	tablero := Tablero new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 2@2.
	tablero placeXAt: 1@2.
	tablero placeOAt: 2@1.
	tablero placeXAt: 2@3.
	tablero placeOAt: 3@2.
	tablero moveXFrom: 2@3 to: 1@3.
	[tablero moveOFrom: 3@2 to: 3@1]
	on:Error
	do:[:anError | 
		self assert: anError messageText = 'Juego terminado'.
		self deny:(tablero at:3@1) = #O. 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero currentTurn = #O.
		self assert: tablero winner = #X.
		]
	
	
	
	! !


!classDefinition: #Tablero category: #'Terni-Lapelli'!
Object subclass: #Tablero
	instanceVariableNames: 'positions turn winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!Tablero methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:29:24'!
checkWinnerO
	|oPieces win|
	
	oPieces := self oPieces.
	
	win := (oPieces size) = 3 and:[
		(self hasCompleteALine: oPieces) or:[ self hasCompletedADiagonal: oPieces]
		].
	
	 win ifTrue:[self hasWon: #O]! !

!Tablero methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:28:54'!
checkWinnerX
	|xPieces win|
	
	xPieces := self xPieces.
	
	win := (xPieces size) = 3 and:[
		(self hasCompleteALine: xPieces) or:[ self hasCompletedADiagonal: xPieces]
		] .
	win ifTrue:[self hasWon: #X]
	 ! !

!Tablero methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:25:12'!
hasCompleteAColumnOrRow: aCollectionOfIndexes
	|aSample|
	aSample := aCollectionOfIndexes first.
	
	^aCollectionOfIndexes allSatisfy: [:anIndex |  (aSample = anIndex)].

	! !

!Tablero methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:16:15'!
hasCompleteALine: aCollectionOfPositions
	|columns rows|
	columns := aCollectionOfPositions collect:[:aPosition | (aPosition at:2) y ].
	
	rows := aCollectionOfPositions collect:[:aPosition | (aPosition at:2) x ].
	
	^ (self hasCompleteAColumnOrRow: columns) or:[ self hasCompleteAColumnOrRow: rows].! !

!Tablero methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:21:54'!
hasCompletedADiagonal: aCollectionOfPositions

	^ (self hasUpDiagonal: aCollectionOfPositions) or:[ self hasDownDiagonal: aCollectionOfPositions].! !

!Tablero methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:37:15'!
hasDownDiagonal: aCollectionOfPositions

	^aCollectionOfPositions allSatisfy: [:aPosition |  ((aPosition at:2) x + (aPosition at:2) y) = 4].
	
	! !

!Tablero methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:36:13'!
hasUpDiagonal: aCollectionOfPositions

	^aCollectionOfPositions allSatisfy: [:aPosition |  (aPosition at:2)x  = (aPosition at:2) y].
	
	! !

!Tablero methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 17:54:05'!
initialize 
	positions := OrderedCollection new.
	turn := #X.
	winner := nil.! !

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

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 17:28:18'!
changeTurn
	turn = #O ifTrue:[turn := #X] ifFalse:[turn := #O]! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 16:53:57'!
currentTurn
	^turn.! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 18:39:10'!
hasWon: aPlayer.
	winner := aPlayer .! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 21:08:36'!
lastPlayerPlayed 
	^self positions last first! !

!Tablero methodsFor: 'private' stamp: 'if 11/1/2018 21:08:42'!
lastPositionPlaced 
	positions ifNotEmpty: [^self positions last second]. 
	^nil! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 20:27:08'!
moveOFrom: aOriginPoint to:aDestinyPoint
		
	|distancia distanciaPunto|
	
	self winner ~= nil ifTrue:[^self error: 'Juego terminado'].
	
	distanciaPunto := (aDestinyPoint) - (aOriginPoint).
	distancia := distanciaPunto x + distanciaPunto y.
	(aOriginPoint x < 1 or: aOriginPoint x > 3) ifTrue:[^self error:'Movimiento invalido'].
	(aOriginPoint y < 1 or: aOriginPoint y > 3) ifTrue:[^self error:'Movimiento invalido'].
	
	(aDestinyPoint x < 1 or: aDestinyPoint x > 3) ifTrue:[^self error:'Movimiento invalido'].
	(aDestinyPoint y < 1 or: aDestinyPoint y > 3) ifTrue:[^self error:'Movimiento invalido'].
	
	(distancia * distancia ~= 1) ifTrue:[^self error:'Movimiento invalido'].
	
	(self at:aDestinyPoint) ~= nil ifTrue:[^self error:'Movimiento invalido'].
	
	self positions detect: [:aPosition | aPosition last = aOriginPoint ] 
	ifFound:[
		:aPosition | aPosition first = #X ifTrue:[^self error: 'Movimiento invalido'].
		aPosition at: 2 put:aDestinyPoint .
		self changeTurn .
		self checkWinnerO .
		]  
	ifNone:[
		^self error: 'Movimiento invalido'.
		] ! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 20:27:04'!
moveXFrom: aOriginPoint to:aDestinyPoint
		
	|distanciaCorrecta distanciaPunto |
	
	self winner ~= nil ifTrue:[^self error: 'Juego terminado'].

	aOriginPoint = aDestinyPoint ifTrue:[^self error:'Movimiento invalido'].
	
	distanciaPunto := (aDestinyPoint) - (aOriginPoint).
	(aOriginPoint x < 1 or: aOriginPoint x > 3) ifTrue:[^self error:'Movimiento invalido'].
	(aOriginPoint y < 1 or: aOriginPoint y > 3) ifTrue:[^self error:'Movimiento invalido'].
	
	(aDestinyPoint x < 1 or: aDestinyPoint x > 3) ifTrue:[^self error:'Movimiento invalido'].
	(aDestinyPoint y < 1 or: aDestinyPoint y > 3) ifTrue:[^self error:'Movimiento invalido'].
	
	distanciaCorrecta := ((distanciaPunto x) * (distanciaPunto x) ~= 1) and:[(distanciaPunto x) * (distanciaPunto x) ~= 0].
	distanciaCorrecta ifTrue:[^self error:'Movimiento invalido'].
	distanciaCorrecta := ((distanciaPunto y) * (distanciaPunto y) ~= 1) and:[(distanciaPunto y) * (distanciaPunto y) ~= 0].
	distanciaCorrecta ifTrue:[^self error:'Movimiento invalido'].
	
	
	(self at:aDestinyPoint) ~= nil ifTrue:[^self error:'Movimiento invalido'].
	
	self positions detect: [:aPosition | aPosition last = aOriginPoint ] 
	ifFound:[
		:aPosition | aPosition first = #O ifTrue:[^self error: 'Movimiento invalido'].
		aPosition at: 2 put:aDestinyPoint .
		self changeTurn .
		self checkWinnerX .
		]  
	ifNone:[
		^self error: 'Movimiento invalido'.
		] ! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 15:52:46'!
numberOfPiecesOnBoard 
	^positions size! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 19:27:50'!
oPieces
	^positions select:[:aPosition | (aPosition at:1) = #O]! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 19:26:48'!
placeOAt: aPoint 
	(positions isEmpty) ifTrue:[^self error:'No puede empezar O'].
	(aPoint x < 1 or: aPoint x > 3) ifTrue:[^self error:'Posicion invalida'].
	(aPoint y < 1 or: aPoint y > 3) ifTrue:[^self error:'Posicion invalida'].
		positions isEmpty 
	ifFalse:[
	self currentTurn = #X ifTrue:['No se puede jugar dos veces seguidas por un mismo jugador'].
	].
	positions detect:[:aPosition | aPosition last = aPoint ]  ifFound:[:aPostion | ^self error: 'Ya hay una ficha en esa posicion']  
	ifNone:[
		|aNewPosition|
		aNewPosition := OrderedCollection new.
		aNewPosition add: #O.
		aNewPosition  add: aPoint .
		self changeTurn.
		positions add:aNewPosition.
		self checkWinnerO .
		] ! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 19:26:32'!
placeXAt: aPoint 
	
	(aPoint x < 1 or: aPoint x > 3) ifTrue:[^self error:'Posicion invalida'].
	(aPoint y < 1 or: aPoint y > 3) ifTrue:[^self error:'Posicion invalida'].
	positions isEmpty 
	ifFalse:[
	self currentTurn = #O ifTrue:[^self error:'No se puede jugar dos veces seguidas por un mismo jugador']].
	positions detect:[:aPosition | aPosition last = aPoint ]  ifFound:[:aPostion | ^self error: 'Ya hay una ficha en esa posicion']  
	ifNone:[
		|aNewPosition|
		aNewPosition := OrderedCollection new.
		aNewPosition add: #X.
		aNewPosition  add: aPoint .
		self changeTurn.
		positions add:aNewPosition.
		self checkWinnerX .
		] ! !

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

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 18:38:41'!
winner
	^winner.! !

!Tablero methodsFor: 'private' stamp: 'eg 11/3/2018 19:27:29'!
xPieces
	^positions select:[:aPosition | (aPosition at:1) = #X]! !
