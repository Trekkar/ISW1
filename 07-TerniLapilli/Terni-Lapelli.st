!classDefinition: #TerniLapelliTest category: #'Terni-Lapelli'!
TestCase subclass: #TerniLapelliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:27:50'!
test01GameStartsWithAnEmptyBoardAndXTurn
	|game|
	
	game := TerniLapelli new.
	
	self assert: game isEmpty. 
	self assert: game currentTurn = #X.
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:30:56'!
test02AfterPlacingXPositionIsOccupiedAndOHasntPlayed
	|game |
	game := TerniLapelli new. 	
	game placeXAt: 1@1.
	
	self assert: game numberOfPiecesOnBoard = 1.
	self assert: (game aPlayerHasntPlayed:#O).
	self deny: (game  aPlayerHasntPlayed: #X).
	self assert: (game at: 1@1) = #X.
	self assert: game currentTurn = #O.
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:32:02'!
test03OCannotStartFirst 
	|game |
	game := TerniLapelli new. 
	
	[game placeOAt: 1@1]
	on:Error
	do:[
		:anError | self assert: anError messageText = 'No es el turno de O'.
		self assert: game numberOfPiecesOnBoard = 0.
		self assert: (game aPlayerHasntPlayed: #O).
		self assert: game currentTurn  = #X.
	 ] 
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test04PiecesCannotBePlayedOnOccupiedSpots
	|tablero |
	tablero := TerniLapelli new. 
	tablero placeXAt: 1@1. 
	
	[tablero placeOAt: 1@1.]
	on:Error
	do:[:anError | 
		self assert: (tablero at:1@1) = #X.
		self assert: tablero OHasntPlayed.
	     self assert: tablero currentTurn  = #O.
		self assert: anError messageText =  'Ya hay una ficha en esa posicion']
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test05APlayerCannotPlayTwiceInARow
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1. 	
	[tablero placeXAt: 1@2]
	on:Error
	do:[:anError | 
		self assert: (tablero at:1@1) = #X.
		self assert: tablero currentTurn = #O.
		self assert: anError messageText =  'No se puede jugar dos veces seguidas por un mismo jugador']
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:28:50'!
test06PiecesCannotBePlayedOutOfBounds
	|tablero |
	tablero := TerniLapelli new.
	[tablero placeXAt: 4@4.]
	on:Error
	do:[:anError|
		self assert: (tablero at:4@4) = nil.
		self assert: tablero  XHasntPlayed: #X.	 
		self assert: anError messageText = 'Posicion invalida'.]
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test07APlayerCannotHaveMoreThanThreePiecesOnBoard
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero placeXAt: 3@1] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: (tablero at:3@3) = #O.
		self assert: tablero currentTurn = #X.
		self assert: anError messageText = 'No se pueden jugar mas de tres fichas'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test08PlayersCanOnlyMovePiecesTheyOwn
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 3@3 to:3@2] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero currentTurn = #X.
		self assert: (tablero at:3@3) = #O.
		self assert: anError messageText = 'Movimiento invalido'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test09PlayersCannotMovePiecesFromPositionsThatWasntMarked
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 3@1 to:3@2] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero currentTurn = #X.
		self assert: (tablero at:3@1) = #NoOwner. 
		self assert: anError messageText = 'Movimiento invalido'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test10PlayersCannotMovePiecesOutOfBounds
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 1@1 to:0@0] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero currentTurn = #X.
		self assert: (tablero at:1@1) = #X.
		self assert: anError messageText = 'Movimiento invalido'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test11PiecesCanOnlyBeMovedToDirectNeighbours
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 1@1 to:3@2] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero currentTurn = #X.
		self assert: (tablero at:1@1) = #X.
		self assert: anError messageText = 'Movimiento invalido'.].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test12PiecesCanBeMovedToAValidPosition
	|tablero |
	tablero := TerniLapelli new.
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
	self assert: (tablero at:2@2) = #NoOwner.
	self assert: tablero winner = nil.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test13APlayerWinOnPlacingWhenCompletesFirstColumn
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 2@2.
	tablero placeXAt: 1@2.
	tablero placeOAt: 2@3.
	tablero placeXAt: 1@3.
	 
	self assert: tablero numberOfPiecesOnBoard = 5.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test14APlayerWinOnPlacingWhenCompletesSecondColumn
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test15APlayerWinOnPlacingWhenCompletesThirdColumn
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test16APlayerWinOnPlacingWhenCompletesFirstRow
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 3@3.
	tablero placeXAt: 2@1.
	tablero placeOAt: 3@2.
	tablero placeXAt: 3@1.

	 
	self assert: tablero numberOfPiecesOnBoard = 5.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test17APlayerWinOnPlacingWhenCompletesSecondRow
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test18APlayerWinOnPlacingWhenCompletesThirdRow
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@3.
	tablero placeOAt: 1@2.
	tablero placeXAt: 2@3.
	tablero placeOAt: 2@2.
	tablero placeXAt: 3@3.
	
	 
	self assert: tablero numberOfPiecesOnBoard = 5.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test19APlayerWinOnPlacingWhenCompletesUpDiagonal
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 2@2.
	tablero placeOAt: 2@3.
	tablero placeXAt: 3@3.
	
	 
	self assert: tablero numberOfPiecesOnBoard = 5.
	self assert: tablero currentTurn = #O.
	self assert: tablero winner = #X.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test20APlayerWinOnPlacingWhenCompletesDownDiagonal
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test21APlayerWinOnMovingWhenCompletesFirstColumn
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test22APlayerWinOnMovingWhenCompletesSecondColumn
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test23APlayerWinOnMovingWhenCompletesThirdColumn
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test24APlayerWinOnMovingWhenCompleteFirstRow
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test25APlayerWinOnMovingWhenCompleteSecondRow
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test26APlayerWinOnMovingWhenCompleteThirdRow
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test27APlayerWinOnMovingWhenCompleteUpDiagonal
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test28APlayerWinOnMovingWhenCompleteDownDiagonal
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test29APlayerCannotMoveToTheSamePosition
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:05:01'!
test30APlayerCannotPlayIfGameIsOver
	|tablero |
	tablero := TerniLapelli new.
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

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:20:13'!
test31APlayerCannotMakeAnInvalidMoveWithValidPositions
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	[tablero moveOFrom: 3@2 to: 3@1]
	on:Error
	do:[:anError | 
		self assert: anError messageText = 'No se puede mover hasta que se coloquen todas las fichas'.
		self assert: tablero numberOfPiecesOnBoard = 1.
		self assert: tablero OHasntPlayed .
		]
	
	
	
	! !

!TerniLapelliTest methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:20:46'!
test31APlayerCannotMoveIfPlacingStageHasntFinished
	|tablero |
	tablero := TerniLapelli new.
	tablero placeXAt: 1@1.
	tablero placeOAt: 1@2.
	tablero placeXAt: 1@3.
	tablero placeOAt: 2@3.
	tablero placeXAt: 2@2.
	tablero placeOAt: 3@3. 
	[tablero moveXFrom: 1@1 to:3@2] on:Error 
	do:[:anError | 
		self assert: tablero numberOfPiecesOnBoard = 6.
		self assert: tablero currentTurn = #X.
		self assert: (tablero at:1@1) = #X.
		self assert: anError messageText = 'Movimiento invalido'.].
	
	! !


!classDefinition: #GameState category: #'Terni-Lapelli'!
Object subclass: #GameState
	instanceVariableNames: 'board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!GameState methodsFor: 'initialization' stamp: 'if 11/5/2018 21:35:32'!
initializeWith: aGame 
	board := aGame .! !


!GameState methodsFor: 'actions' stamp: 'if 11/5/2018 21:04:53'!
moveOFrom: aOriginPoint to:aDestinyPoint 
	self subclassResponsibility ! !

!GameState methodsFor: 'actions' stamp: 'nacho 11/6/2018 18:52:05'!
moveXFrom: aOriginPoint to: aDestinyPoint 
	self subclassResponsibility ! !

!GameState methodsFor: 'actions' stamp: 'if 11/5/2018 21:03:29'!
placeOAt: aPoint 
	self subclassResponsibility ! !

!GameState methodsFor: 'actions' stamp: 'if 11/5/2018 21:03:21'!
placeXAt: aPoint 
	self subclassResponsibility ! !


!GameState methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:01:46'!
currentTurn 
	self subclassResponsibility ! !

!GameState methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:10:46'!
winner 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameState class' category: #'Terni-Lapelli'!
GameState class
	instanceVariableNames: ''!

!GameState class methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 20:54:42'!
for: aGame
	^self new initializeWith: aGame.! !


!classDefinition: #Moving category: #'Terni-Lapelli'!
GameState subclass: #Moving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!Moving methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:02:01'!
currentTurn
	self subclassResponsibility ! !

!Moving methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:12:55'!
moveOFrom: aOriginPoint to: aDestinyPoint 
	self subclassResponsibility ! !

!Moving methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:52:13'!
moveXFrom: aOriginPoint to: aDestinyPoint 
	self subclassResponsibility ! !

!Moving methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 21:40:00'!
placeXAt: aPoint 
	^self error:'Movimiento invalido'.! !

!Moving methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:11:29'!
winner
	^self error: 'No hay ganador'! !


!classDefinition: #MovingO category: #'Terni-Lapelli'!
Moving subclass: #MovingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!MovingO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:02:12'!
currentTurn 
	^#O! !

!MovingO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:13:12'!
moveOFrom: aOriginPoint to: aDestinyPoint 
	^board moveOWhenPlayingOFrom: aOriginPoint to:aDestinyPoint .! !

!MovingO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:52:47'!
moveXFrom: aOriginPoint to: aDestinyPoint 
	^self error: 'No es el turno de X'.! !


!classDefinition: #MovingX category: #'Terni-Lapelli'!
Moving subclass: #MovingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!MovingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:02:23'!
currentTurn 
	^#X! !

!MovingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:54:19'!
moveOFrom: aOriginPoint to: aDestinyPoint 
	^self error: 'No es el turno de O'.! !

!MovingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:53:57'!
moveXFrom: aOriginPoint to: aDestinyPoint 
	^board moveXWhenPlayingXFrom: aOriginPoint to:aDestinyPoint! !


!classDefinition: #Placing category: #'Terni-Lapelli'!
GameState subclass: #Placing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:02:30'!
currentTurn 
	self subclassResponsibility ! !

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:16:36'!
moveOFrom: aOriginPoint to: aDestinyPoint 
	^self error: 'No se puede mover hasta que se coloquen todas las fichas'! !

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:16:32'!
moveXFrom: aOriginPoint to: aDestinyPoint 
	^self error: 'No se puede mover hasta que se coloquen todas las fichas'! !

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:13:22'!
placeOAt: aPoint 
	self subclassResponsibility ! !

!Placing methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 21:40:14'!
placeXAt: aPoint 
	self subclassResponsibility ! !

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:11:48'!
winner 
	^self error: 'No hay ganador'! !


!classDefinition: #PlacingO category: #'Terni-Lapelli'!
Placing subclass: #PlacingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!PlacingO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:02:42'!
currentTurn
	^#O! !

!PlacingO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:00:06'!
placeOAt: aPoint 
 	^board placeOWhenPlacingOAt: aPoint.! !

!PlacingO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:49:00'!
placeXAt: aPoint 
	^self error:'No es el turno de X'.! !


!classDefinition: #PlacingX category: #'Terni-Lapelli'!
Placing subclass: #PlacingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!PlacingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:02:52'!
currentTurn
	^#X! !

!PlacingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:49:05'!
placeOAt: aPoint 
	^self error:'No es el turno de O'.! !

!PlacingX methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 21:42:20'!
placeXAt: aPoint 
 	^board placeXWhenPlacingXAt: aPoint.! !


!classDefinition: #Winner category: #'Terni-Lapelli'!
GameState subclass: #Winner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:03:42'!
currentTurn
	^ self error: 'Juego terminado'.! !

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:17:12'!
moveOFrom: aOriginPoint to: aDestinyPoint
	^self error:'Juego terminado'.! !

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:17:09'!
moveXFrom: aOriginPoint to: aDestinyPoint
	^self error:'Juego terminado'.! !

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:16:53'!
placeOAt: aPoint 
	^self error:'Juego terminado'.! !

!Winner methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 21:40:58'!
placeXAt: aPoint 
	^self error:'Juego terminado'.! !

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:11:58'!
winner 
	self subclassResponsibility ! !


!classDefinition: #WinnerO category: #'Terni-Lapelli'!
Winner subclass: #WinnerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!WinnerO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:12:11'!
winner 
	^#O! !


!classDefinition: #WinnerX category: #'Terni-Lapelli'!
Winner subclass: #WinnerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!WinnerX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:12:20'!
winner 
	^#X! !


!classDefinition: #Position category: #'Terni-Lapelli'!
Object subclass: #Position
	instanceVariableNames: 'owner coordinate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!Position methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 17:09:42'!
coordinate
	^coordinate.! !

!Position methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 17:13:15'!
initializeWith:aPlayer With:aPoint
	owner := aPlayer .
	coordinate  := aPoint .
	! !

!Position methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 17:09:28'!
owner
	^owner.! !

!Position methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 17:15:36'!
owner: aPlayer
	owner := aPlayer .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Position class' category: #'Terni-Lapelli'!
Position class
	instanceVariableNames: ''!

!Position class methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 17:11:57'!
withOwner: aPlayer withCoordinate: aPoint
	^self new initializeWith:aPlayer With:aPoint.! !


!classDefinition: #TerniLapelli category: #'Terni-Lapelli'!
Object subclass: #TerniLapelli
	instanceVariableNames: 'positions state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:08:05'!
assertIsValidMoveFrom: aOriginPoint to: aDestinyPoint 
	|distanciaPunto distanciaCorrecta|
	
	distanciaPunto := (aDestinyPoint) - (aOriginPoint).

	(aDestinyPoint x < 1 or: aDestinyPoint x > 3) ifTrue:[^self error:'Movimiento invalido'].
	(aDestinyPoint y < 1 or: aDestinyPoint y > 3) ifTrue:[^self error:'Movimiento invalido'].
	
	distanciaCorrecta := ((distanciaPunto x) * (distanciaPunto x) ~= 1) and:[(distanciaPunto x) * (distanciaPunto x) ~= 0].
	distanciaCorrecta ifTrue:[^self error:'Movimiento invalido'].
	distanciaCorrecta := ((distanciaPunto y) * (distanciaPunto y) ~= 1) and:[(distanciaPunto y) * (distanciaPunto y) ~= 0].
	distanciaCorrecta ifTrue:[^self error:'Movimiento invalido'].
	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:05:07'!
assertPosition: positionOrigin isFrom: aPlayer 
	((self at: positionOrigin) owner = aPlayer)  ifFalse:[^self error: 'La ficha no le pertenece al jugador']
	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 17:53:34'!
assertPositionIsFree: aPosition 
	(aPosition owner ~= #NoOwner) ifTrue:[ ^self error: 'Ya hay una ficha en esa posicion' ].
	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 17:56:51'!
assertPositionIsValid: aPoint
	
	self checkValidCoordinate: aPoint x.
	self checkValidCoordinate: aPoint y.! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 18:07:53'!
atPoint: aPoint
	|arrayIndex|
	arrayIndex := ((aPoint y)  -1) * 3 + (aPoint  x).
	^positions at:arrayIndex.! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 17:47:59'!
checkPlayersHaveFinishedPlacing 
	^self numberOfPiecesOnBoard = 6
! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 17:56:19'!
checkValidCoordinate: aCoordinate
	(aCoordinate < 1 or: aCoordinate > 3) ifTrue:[^self error:'Posicion invalida'].! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 17:42:43'!
checkWinner: aPlayerPiece 
	|pieces win|	
	pieces := self getPiecesOf: aPlayerPiece .	
	^win := (pieces size) = 3 and:[
		(self hasCompleteALine: pieces) or:[ self hasCompletedADiagonal: pieces]
		] .
	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:29:24'!
checkWinnerO
	|oPieces win|
	
	oPieces := self oPieces.
	
	win := (oPieces size) = 3 and:[
		(self hasCompleteALine: oPieces) or:[ self hasCompletedADiagonal: oPieces]
		].
	
	 win ifTrue:[self hasWon: #O]! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:28:54'!
checkWinnerX
	|xPieces win|
	
	xPieces := self xPieces.
	
	win := (xPieces size) = 3 and:[
		(self hasCompleteALine: xPieces) or:[ self hasCompletedADiagonal: xPieces]
		] .
	win ifTrue:[self hasWon: #X]
	 ! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:25:12'!
hasCompleteAColumnOrRow: aCollectionOfIndexes
	|aSample|
	aSample := aCollectionOfIndexes first.
	
	^aCollectionOfIndexes allSatisfy: [:anIndex |  (aSample = anIndex)].

	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 18:28:55'!
hasCompleteALine: aCollectionOfPositions
	|columns rows|
	columns := aCollectionOfPositions collect:[:aPosition | (aPosition coordinate) y].
	
	rows := aCollectionOfPositions collect:[:aPosition | (aPosition coordinate) x ].
	
	^ (self hasCompleteAColumnOrRow: columns) or:[ self hasCompleteAColumnOrRow: rows].! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'eg 11/3/2018 19:21:54'!
hasCompletedADiagonal: aCollectionOfPositions

	^ (self hasUpDiagonal: aCollectionOfPositions) or:[ self hasDownDiagonal: aCollectionOfPositions].! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 18:29:20'!
hasDownDiagonal: aCollectionOfPositions

	^aCollectionOfPositions allSatisfy: [:aPosition |  ((aPosition coordinate) x + (aPosition coordinate) y) = 4].
	
	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 18:29:35'!
hasUpDiagonal: aCollectionOfPositions

	^aCollectionOfPositions allSatisfy: [:aPosition |  (aPosition coordinate )x  = (aPosition coordinate ) y].
	
	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:50:40'!
initialize 
	|initialPositions rangeColumns rangeRows|
	
	rangeColumns  := (1 to: 3) asOrderedCollection .
	rangeRows  := (1 to: 3) asOrderedCollection .
	initialPositions  := OrderedCollection new.
	
	rangeColumns do:[:aColumnIndex |
		rangeRows do:[ :aRowIndex |
 			|position|
			position := Position withOwner:#NoOwner withCoordinate:(aRowIndex @aColumnIndex).
			initialPositions add:position. 
			].].
	
	positions := initialPositions .
	state := PlacingX for: self.! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 18:40:17'!
isEmpty
	^self numberOfPiecesOnBoard = 0.! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:09:08'!
moveOWhenPlayingOFrom: aOriginPoint to:aDestinyPoint 
	| positionDestiny positionOrigin|
	
	self assertPositionIsValid: aDestinyPoint.
	self assertPositionIsValid: aOriginPoint .
	
	positionDestiny := self atPoint: aDestinyPoint .
	positionOrigin := self atPoint: aOriginPoint .
	self assertPositionIsFree: positionDestiny.
	self assertPosition: aOriginPoint isFrom: #O.
	self assertIsValidMoveFrom: aOriginPoint to: aDestinyPoint .

	positionDestiny owner: #O.
	positionOrigin  owner: #NoOwner.
	
	state := (self stateAfterMoving: #O nextMovingState: MovingX nextWinnerState: WinnerO) for: self.

	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:08:28'!
moveXWhenPlayingXFrom: aOriginPoint to:aDestinyPoint 
	| positionDestiny positionOrigin|
	
	self assertPositionIsValid: aDestinyPoint.
	self assertPositionIsValid: aOriginPoint .
	
	positionDestiny := self atPoint: aDestinyPoint .
	positionOrigin := self atPoint: aOriginPoint .
	self assertPositionIsFree: positionDestiny.
	self assertPosition: aOriginPoint isFrom: #X.
	self assertIsValidMoveFrom: aOriginPoint to: aDestinyPoint .

	positionDestiny owner: #X.
	positionOrigin  owner: #NoOwner.
	
	state := (self stateAfterMoving: #X nextMovingState: MovingO nextWinnerState: WinnerX) for: self.

	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:59:51'!
placeOWhenPlacingOAt: aPoint 
	| position |
	self assertPositionIsValid: aPoint.
	position := self atPoint: aPoint.
	self assertPositionIsFree: position.
	position owner: #O.
	state := (self stateAfterPlacing: #O nextPlacingState: PlacingX nextMovingState: MovingX nextWinnerState: WinnerO) for: self.

	
	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:59:51'!
placeXWhenPlacingXAt: aPoint 
	| position |
	self assertPositionIsValid: aPoint.
	position := self atPoint: aPoint.
	self assertPositionIsFree: position.
	position owner: #X.
	state := (self stateAfterPlacing: #X nextPlacingState: PlacingO nextMovingState: MovingO nextWinnerState: WinnerX) for: self.

	
	! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:01:29'!
stateAfterMoving: aPlayerPiece nextMovingState: aMovingState nextWinnerState: aWinnerState
	
	(self checkWinner: aPlayerPiece) ifTrue: [ ^aWinnerState]. 
		
	^aMovingState.! !

!TerniLapelli methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:59:51'!
stateAfterPlacing: aPlayerPiece nextPlacingState: aPlacingState nextMovingState: aMovingState nextWinnerState: aWinnerState 
	
	(self checkWinner: aPlayerPiece) ifTrue: [ ^aWinnerState]. 
	
	(self checkPlayersHaveFinishedPlacing ) ifTrue:[^aMovingState]. 
	
	^aPlacingState.! !


!TerniLapelli methodsFor: 'private' stamp: 'nacho 11/6/2018 19:30:13'!
aPlayerHasntPlayed: aPlayer 
	^(self positions anySatisfy: [:aPosition | aPosition owner = aPlayer]) not.! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/5/2018 17:39:26'!
at: aPoint 
	positions detect: [:aPosition| aPosition coordinate = aPoint ] ifFound:[:aPosition| ^aPosition owner ]  ifNone: [^nil] ! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/5/2018 19:19:09'!
changeTurn
	
	^(TurnState stateForGame: self) nextTurn .! !

!TerniLapelli methodsFor: 'private' stamp: 'nacho 11/6/2018 18:01:34'!
currentTurn
	^state currentTurn! !

!TerniLapelli methodsFor: 'private' stamp: 'nacho 11/6/2018 17:43:19'!
getPiecesOf: aPlayer
	^positions select:[:aPosition | (aPosition owner) = aPlayer]! !

!TerniLapelli methodsFor: 'private' stamp: 'eg 11/3/2018 18:39:10'!
hasWon: aPlayer.
	winner := aPlayer .! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/5/2018 18:54:48'!
moveOFrom: aOriginPoint to:aDestinyPoint
		
	|distancia distanciaPunto positionDestiny positionOrigin|
	
	self winner ~= nil ifTrue:[^self error: 'Juego terminado'].
	
	distanciaPunto := (aDestinyPoint) - (aOriginPoint).
	distancia := distanciaPunto x + distanciaPunto y.
	(aOriginPoint x < 1 or: aOriginPoint x > 3) ifTrue:[^self error:'Movimiento invalido'].
	(aOriginPoint y < 1 or: aOriginPoint y > 3) ifTrue:[^self error:'Movimiento invalido'].
	
	(aDestinyPoint x < 1 or: aDestinyPoint x > 3) ifTrue:[^self error:'Movimiento invalido'].
	(aDestinyPoint y < 1 or: aDestinyPoint y > 3) ifTrue:[^self error:'Movimiento invalido'].
	
	(distancia * distancia ~= 1) ifTrue:[^self error:'Movimiento invalido'].
	
	(self at:aDestinyPoint) ~= #NoOwner ifTrue:[^self error:'Movimiento invalido'].
	(self at:aOriginPoint ) ~= #O ifTrue:[^self error:'Movimiento invalido'].

	
	positionDestiny := self atPoint: aDestinyPoint .
	positionOrigin := self atPoint: aOriginPoint .
	
	positionDestiny owner: #O.
	positionOrigin owner: #NoOwner.	  
	self changeTurn.
	self checkWinnerO.
	! !

!TerniLapelli methodsFor: 'private' stamp: 'nacho 11/6/2018 18:51:50'!
moveXFrom: aOriginPoint to:aDestinyPoint
	^state moveXFrom: aOriginPoint to: aDestinyPoint.
	"|distanciaCorrecta distanciaPunto positionDestiny positionOrigin|
	
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
	
	
	(self at:aDestinyPoint) ~= #NoOwner ifTrue:[^self error:'Movimiento invalido'].
	(self at:aOriginPoint ) ~= #X ifTrue:[^self error:'Movimiento invalido'].

	
	positionDestiny := self atPoint: aDestinyPoint .
	positionOrigin := self atPoint: aOriginPoint .
	
	positionDestiny owner: #X.
	positionOrigin owner: #NoOwner.	  
	self changeTurn.
	self checkWinnerX."
	
	! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/5/2018 19:17:39'!
nextTurnIsO
	turn := #O.! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/5/2018 19:17:44'!
nextTurnIsX
	turn := #X.! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/5/2018 18:53:08'!
numberOfPiecesOnBoard 
	^positions inject:0 into:[:numberOfPieces :aPosition |  (aPosition owner ~= #NoOwner) ifTrue:[ numberOfPieces +1] ifFalse:[numberOfPieces]].! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/5/2018 18:35:46'!
oPieces
	^positions select:[:aPosition | (aPosition owner) = #O]! !

!TerniLapelli methodsFor: 'private' stamp: 'nacho 11/6/2018 18:47:59'!
placeOAt: aPoint 
	^state placeOAt: aPoint.! !

!TerniLapelli methodsFor: 'private' stamp: 'nacho 11/6/2018 18:47:36'!
placeXAt: aPoint 
	^state placeXAt: aPoint.! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/1/2018 20:48:22'!
positions 
	^positions ! !

!TerniLapelli methodsFor: 'private' stamp: 'nacho 11/6/2018 19:10:35'!
winner
	^state winner! !

!TerniLapelli methodsFor: 'private' stamp: 'if 11/5/2018 18:33:05'!
xPieces
	^positions select:[:aPosition | (aPosition owner) = #X]! !


!classDefinition: #TurnState category: #'Terni-Lapelli'!
Object subclass: #TurnState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!TurnState methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 19:11:18'!
initializeWith: aGame
	game := aGame.! !

!TurnState methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 19:15:22'!
nextTurn
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnState class' category: #'Terni-Lapelli'!
TurnState class
	instanceVariableNames: ''!

!TurnState class methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 19:09:07'!
canHandle: aGame
	self subclassResponsibility .! !

!TurnState class methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 19:08:47'!
for: aGame
	^self new initializeWith: aGame.
	! !

!TurnState class methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 19:07:37'!
stateForGame: aGame
	
	| TurnState |

	TurnState _ self subclasses detect: [ :TurnStates | TurnStates canHandle: aGame ].
	
	^ TurnState for: aGame.! !
