!classDefinition: #TerniLapelliTest category: #'Terni-Lapelli'!
TestCase subclass: #TerniLapelliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 19:27:50'!
test01GameStartsWithAnEmptyBoardAndXTurn
	|game|
	
	game := TerniLapelli new.
	
	self assert: game isEmpty. 
	self assert: game currentTurn = #X.
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 19:30:56'!
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

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:29:20'!
test03OCannotStartFirst 
	|game |
	game := TerniLapelli new. 
	
	[game placeOAt: 1@1]
	on:Error
	do:[
		:anError | self assert: anError messageText = game class noOTurnErrorMessage.
		self assert: game numberOfPiecesOnBoard = 0.
		self assert: (game aPlayerHasntPlayed: #O).
		self assert: game currentTurn  = #X.
	 ] 
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:29:14'!
test04PiecesCannotBePlayedOnOccupiedSpots
	|game |
	game := TerniLapelli new. 
	game placeXAt: 1@1. 
	
	[game placeOAt: 1@1.]
	on:Error
	do:[:anError | 
		self assert: (game at:1@1) = #X.
		self assert: (game aPlayerHasntPlayed: #O).
	     self assert: game currentTurn  = #O.
		self assert: anError messageText =  game class positionAlreadyTakenErrorMessage ]
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:29:39'!
test05APlayerCannotPlayTwiceInARow
	|game |
	game := TerniLapelli new.
	game placeXAt: 1@1. 	
	[game placeXAt: 1@2]
	on:Error
	do:[:anError | 
		self assert: (game at:1@1) = #X.
		self assert: game currentTurn = #O.
		self assert: anError messageText =  game class noXTurnErrorMessage ]
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:29:57'!
test06PiecesCannotBePlayedOutOfBounds
	|game |
	game := TerniLapelli new.
	[game placeXAt: 4@4.]
	on:Error
	do:[:anError|
		self assert: (game at:4@4) = nil.
		self assert: (game  aPlayerHasntPlayed: #X).	 
		self assert: anError messageText = game class invalidPositionErrorMessage ]
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:44:08'!
test07APlayerCannotHaveMoreThanThreePiecesOnBoard
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 1@3. 2@3. 2@2. 3@3} inGame: game.
	[game placeXAt: 3@1] on:Error 
	do:[:anError | 
		self assert: game numberOfPiecesOnBoard = 6.
		self assert: (game at:3@3) = #O.
		self assert: game currentTurn = #X.
		self assert: anError messageText = game class cantPlaceMoreThanThreePiecesMessageError ].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:44:28'!
test08PlayersCanOnlyMovePiecesTheyOwn
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 1@3. 2@3. 2@2. 3@3} inGame: game.
	[game moveXFrom: 3@3 to:3@2] on:Error 
	do:[:anError | 
		self assert: game numberOfPiecesOnBoard = 6.
		self assert: game currentTurn = #X.
		self assert: (game at:3@3) = #O.
		self assert: anError messageText = game class pieceDoesntBelongToPlayerErrorMessage ].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:44:37'!
test09PlayersCannotMovePiecesFromPositionsThatWasntMarked
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 1@3. 2@3. 2@2. 3@3} inGame: game.
	[game moveXFrom: 3@1 to:3@2] on:Error 
	do:[:anError | 
		self assert: game numberOfPiecesOnBoard = 6.
		self assert: game currentTurn = #X.
		self assert: (game at:3@1) = #NoOwner. 
		self assert: anError messageText = game class pieceDoesntBelongToPlayerErrorMessage ].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:44:54'!
test10PlayersCannotMovePiecesOutOfBounds
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 1@3. 2@3. 2@2. 3@3} inGame: game.
	[game moveXFrom: 1@1 to:0@0] on:Error 
	do:[:anError | 
		self assert: game numberOfPiecesOnBoard = 6.
		self assert: game currentTurn = #X.
		self assert: (game at:1@1) = #X.
		self assert: anError messageText = game class invalidPositionErrorMessage ].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:45:07'!
test11PiecesCanOnlyBeMovedToDirectNeighbours
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 1@3. 2@3. 2@2. 3@3} inGame: game.
	[game moveXFrom: 1@1 to:3@2] on:Error 
	do:[:anError | 
		self assert: game numberOfPiecesOnBoard = 6.
		self assert: game currentTurn = #X.
		self assert: (game at:1@1) = #X.
		self assert: anError messageText = game class invalidMoveErrorMessage ].
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:45:26'!
test12PiecesCanBeMovedToAValidPosition
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 1@3. 2@3. 2@2. 3@3} inGame: game.
	game moveXFrom: 2@2 to:2@1.
	
	[(game winner)] on: Error do:[:anError | 
	self assert: game numberOfPiecesOnBoard = 6.
	self assert: game currentTurn = #O.
	self assert: (game at:2@1) = #X.
	self assert: (game at:2@2) = #NoOwner. 
	self assert: anError messageText = game class noWinnerErrorMessage 
	]
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:49:41'!
test13APlayerWinOnPlacingWhenCompletesFirstColumn
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  2@2. 1@2. 2@3. 1@3} inGame: game.
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 5 inGame: game.	 
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:51:13'!
test14APlayerWinOnPlacingWhenCompletesSecondColumn
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  2@2. 1@2. 2@3. 3@1. 2@1} inGame: game.
	self assertThatPlayer: #O WonWithNumberOfPiecesOnBoard: 6 inGame: game.	 

	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:51:45'!
test15APlayerWinOnPlacingWhenCompletesThirdColumn
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  3@3. 1@2. 3@2. 2@2. 3@1} inGame: game.
	self assertThatPlayer: #O WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:52:04'!
test16APlayerWinOnPlacingWhenCompletesFirstRow
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  3@3. 2@1. 3@2. 3@1} inGame: game.
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 5 inGame: game.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:52:16'!
test17APlayerWinOnPlacingWhenCompletesSecondRow
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 2@1. 2@2. 1@3. 3@2} inGame: game.
	self assertThatPlayer: #O WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:52:28'!
test18APlayerWinOnPlacingWhenCompletesThirdRow
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@3.  1@2. 2@3. 2@2. 3@3} inGame: game.
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 5 inGame: game.	 
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:52:36'!
test19APlayerWinOnPlacingWhenCompletesUpDiagonal
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 2@2. 2@3. 3@3} inGame: game.
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 5 inGame: game.	 
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:52:47'!
test20APlayerWinOnPlacingWhenCompletesDownDiagonal
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@3. 1@2. 2@2. 3@2. 3@1} inGame: game.
	self assertThatPlayer: #O WonWithNumberOfPiecesOnBoard: 6 inGame: game.		
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:53:01'!
test21APlayerWinOnMovingWhenCompletesFirstColumn
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  2@2. 1@2. 2@1. 2@3. 3@2} inGame: game.
	game moveXFrom: 2@3 to: 1@3.
	 
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:53:17'!
test22APlayerWinOnMovingWhenCompletesSecondColumn
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  2@2. 1@2. 2@1. 3@1. 3@3} inGame: game.	
	game moveXFrom: 3@1 to: 3@2.
	game moveOFrom: 3@3 to: 2@3.
	
	self assertThatPlayer: #O WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:53:26'!
test23APlayerWinOnMovingWhenCompletesThirdColumn
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {3@1.  1@1. 3@2. 2@2. 2@3. 1@3} inGame: game.
	game moveXFrom: 2@3 to: 3@3.
	 
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:53:35'!
test24APlayerWinOnMovingWhenCompleteFirstRow
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 2@1. 1@3. 3@2. 2@3} inGame: game.	
	game moveXFrom: 3@2 to: 3@1.
	 
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:53:47'!
test25APlayerWinOnMovingWhenCompleteSecondRow
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@2.  1@1. 2@2. 1@3. 3@3. 2@3} inGame: game.	
	game moveXFrom: 3@3 to: 3@2.
	 
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:53:55'!
test26APlayerWinOnMovingWhenCompleteThirdRow
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@3.  1@1. 2@3. 1@2. 2@2. 2@1} inGame: game.
	game moveXFrom: 2@2 to: 3@3.
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:54:07'!
test27APlayerWinOnMovingWhenCompleteUpDiagonal
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 2@2. 1@3. 3@2. 2@3} inGame: game.	
	game moveXFrom: 3@2 to: 3@3.
	self assertThatPlayer: #X WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:54:18'!
test28APlayerWinOnMovingWhenCompleteDownDiagonal
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@2.  1@3. 1@1. 3@1. 3@3. 2@3} inGame: game.
	game moveXFrom: 3@3 to: 3@2.
	game moveOFrom: 2@3 to: 2@2.
	self assertThatPlayer: #O WonWithNumberOfPiecesOnBoard: 6 inGame: game.
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:53:25'!
test29APlayerCannotMoveToTheSamePosition
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@2.  1@3. 1@1. 3@1. 3@3. 2@3} inGame: game.	
	[game moveXFrom: 3@3 to: 3@3.]
	on:Error
	do:[:anError |
		anError messageText  = game class positionAlreadyTakenErrorMessage.
		self assert: game numberOfPiecesOnBoard = 6.
		self assert: game currentTurn = #X
	].
	 
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 20:53:49'!
test30APlayerCannotPlayIfGameIsOver
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  2@2. 1@2. 2@1. 2@3. 3@2} inGame: game.
	game moveXFrom: 2@3 to: 1@3.
	[game moveOFrom: 3@2 to: 3@1]
	on:Error
	do:[:anError | 
		self assert: anError messageText = game class gameHasEndedErrorMessage .
		self deny:(game at:3@1) = #O. 
		self assert: game numberOfPiecesOnBoard = 6.
		]
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:07:12'!
test31APlayerCannotMakeAMoveIfPlayersHaveNotFinishPlacing
	|game |
	game := TerniLapelli new.
	game placeXAt: 1@1.
	[game moveOFrom: 3@2 to: 3@1]
	on:Error
	do:[:anError | 
		self assert: anError messageText = game class cantMoveUntilAllPiecesArePlacedErrorMessage .
		self assert: game numberOfPiecesOnBoard = 1.
		self assert: (game aPlayerHasntPlayed: #O).
		]
	
	
	
	! !

!TerniLapelliTest methodsFor: 'tests' stamp: 'nacho 11/6/2018 21:06:32'!
test32APlayerCannotMakeAnInvalidMoveWithValidPositions
	|game |
	game := TerniLapelli new.
	self playersPlaceAlternatively: {1@1.  1@2. 2@3. 2@1. 2@2. 3@3} inGame: game.
	[game moveXFrom: 2@3 to:3@2] on:Error 
	do:[:anError | 
		self assert: game numberOfPiecesOnBoard = 6.
		self assert: game currentTurn = #X.
		self assert: (game at:1@1) = #X.
		self assert: anError messageText = game class invalidMoveErrorMessage].
	
	! !


!TerniLapelliTest methodsFor: 'placing' stamp: 'nacho 11/6/2018 20:43:58'!
playersPlaceAlternatively: aCollectionOfPoints inGame: game

	aCollectionOfPoints withIndexDo: [:aPoint :anIndex | anIndex odd ifTrue:[ game placeXAt: aPoint ] ifFalse:[game placeOAt: aPoint]].! !


!TerniLapelliTest methodsFor: 'assertions' stamp: 'nacho 11/6/2018 21:48:59'!
assertThatPlayer: aPlayer WonWithNumberOfPiecesOnBoard: aNumberOfPiecesOnBoard inGame: aGame
	self assert: aGame numberOfPiecesOnBoard = aNumberOfPiecesOnBoard . 
	self assert: aGame winner = aPlayer .! !


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

!Moving methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:26:35'!
placeOAt: aPoint 
	^self error: board class cantPlaceMoreThanThreePiecesMessageError ! !

!Moving methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:26:40'!
placeXAt: aPoint 
	^self error: board class cantPlaceMoreThanThreePiecesMessageError ! !

!Moving methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:26:46'!
winner
	^self error: board class noWinnerErrorMessage ! !


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

!MovingO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:26:53'!
moveXFrom: aOriginPoint to: aDestinyPoint 
	^self error: board class noXTurnErrorMessage ! !


!classDefinition: #MovingX category: #'Terni-Lapelli'!
Moving subclass: #MovingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!MovingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:02:23'!
currentTurn 
	^#X! !

!MovingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:27:01'!
moveOFrom: aOriginPoint to: aDestinyPoint 
	^self error: board class noOTurnErrorMessage ! !

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

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:27:07'!
moveOFrom: aOriginPoint to: aDestinyPoint 
	^self error: board class cantMoveUntilAllPiecesArePlacedErrorMessage ! !

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:27:13'!
moveXFrom: aOriginPoint to: aDestinyPoint 
	^self error: board class cantMoveUntilAllPiecesArePlacedErrorMessage ! !

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 19:13:22'!
placeOAt: aPoint 
	self subclassResponsibility ! !

!Placing methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 21:40:14'!
placeXAt: aPoint 
	self subclassResponsibility ! !

!Placing methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:27:29'!
winner 
	^self error: board class noWinnerErrorMessage ! !


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

!PlacingO methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:27:39'!
placeXAt: aPoint 
	^self error: board class noXTurnErrorMessage ! !


!classDefinition: #PlacingX category: #'Terni-Lapelli'!
Placing subclass: #PlacingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!PlacingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 18:02:52'!
currentTurn
	^#X! !

!PlacingX methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:27:44'!
placeOAt: aPoint 
	^self error: board class noOTurnErrorMessage ! !

!PlacingX methodsFor: 'as yet unclassified' stamp: 'if 11/5/2018 21:42:20'!
placeXAt: aPoint 
 	^board placeXWhenPlacingXAt: aPoint.! !


!classDefinition: #Winner category: #'Terni-Lapelli'!
GameState subclass: #Winner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapelli'!

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:27:54'!
currentTurn
	^ self error: board class gameHasEndedErrorMessage ! !

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:27:58'!
moveOFrom: aOriginPoint to: aDestinyPoint
	^self error: board class gameHasEndedErrorMessage ! !

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:28:02'!
moveXFrom: aOriginPoint to: aDestinyPoint
	^self error: board class gameHasEndedErrorMessage! !

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:28:06'!
placeOAt: aPoint 
	^self error: board class gameHasEndedErrorMessage! !

!Winner methodsFor: 'as yet unclassified' stamp: 'nacho 11/6/2018 20:28:10'!
placeXAt: aPoint 
	^self error: board class gameHasEndedErrorMessage! !

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

!TerniLapelli methodsFor: 'assertions' stamp: 'if 11/7/2018 17:39:29'!
assertDistanceBetweenPointsIsValid: aPoint 
	|distanciaCorrecta |
	distanciaCorrecta := ((aPoint x) * (aPoint x) ~= 1) and:[(aPoint x) * (aPoint x) ~= 0].
	distanciaCorrecta ifTrue:[^self error:self class invalidMoveErrorMessage].
	distanciaCorrecta := ((aPoint y) * (aPoint y) ~= 1) and:[(aPoint y) * (aPoint y) ~= 0].
	distanciaCorrecta ifTrue:[^self error: self class invalidMoveErrorMessage]. ! !

!TerniLapelli methodsFor: 'assertions' stamp: 'if 11/7/2018 17:43:14'!
assertIsValidMoveFrom: aOriginPoint to: aDestinyPoint
	|distanciaPunto |
	
	self assertPositionIsValid: aDestinyPoint. 
	self assertPositionIsValid: aOriginPoint.
	
	
	distanciaPunto := (aDestinyPoint) - (aOriginPoint).
	
	self assertDistanceBetweenPointsIsValid: distanciaPunto.
	self assertMoveCannotBeInDiamondFrom: aOriginPoint to:aDestinyPoint.
	
	
	
	

	! !

!TerniLapelli methodsFor: 'assertions' stamp: 'if 11/7/2018 17:43:36'!
assertMoveCannotBeInDiamondFrom: aOriginPoint to:aDestinyPoint 
	((aOriginPoint  x) = (aDestinyPoint y) and:[ (aOriginPoint y) = (aDestinyPoint x)]) ifTrue:[^self error: self class invalidMoveErrorMessage ].
	! !

!TerniLapelli methodsFor: 'assertions' stamp: 'nacho 11/6/2018 20:17:23'!
assertPosition: positionOrigin isFrom: aPlayer 
	( (self at: positionOrigin) = aPlayer)  ifFalse:[^self error: self class pieceDoesntBelongToPlayerErrorMessage ]
	! !

!TerniLapelli methodsFor: 'assertions' stamp: 'nacho 11/6/2018 20:31:52'!
assertPositionIsFree: aPosition 
	(aPosition owner ~= #NoOwner) ifTrue:[ ^self error: (self class positionAlreadyTakenErrorMessage) ].
	! !

!TerniLapelli methodsFor: 'assertions' stamp: 'nacho 11/6/2018 17:56:51'!
assertPositionIsValid: aPoint
	
	self checkValidCoordinate: aPoint x.
	self checkValidCoordinate: aPoint y.! !


!TerniLapelli methodsFor: 'initialize' stamp: 'nacho 11/6/2018 18:50:40'!
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


!TerniLapelli methodsFor: 'moving' stamp: 'nacho 11/6/2018 19:52:55'!
moveOFrom: aOriginPoint to:aDestinyPoint
		
	^state moveOFrom: aOriginPoint to: aDestinyPoint.! !

!TerniLapelli methodsFor: 'moving' stamp: 'nacho 11/6/2018 19:09:08'!
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

!TerniLapelli methodsFor: 'moving' stamp: 'nacho 11/6/2018 19:52:37'!
moveXFrom: aOriginPoint to:aDestinyPoint
	^state moveXFrom: aOriginPoint to: aDestinyPoint.
	! !

!TerniLapelli methodsFor: 'moving' stamp: 'nacho 11/6/2018 19:08:28'!
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


!TerniLapelli methodsFor: 'placing' stamp: 'nacho 11/6/2018 18:47:59'!
placeOAt: aPoint 
	^state placeOAt: aPoint.! !

!TerniLapelli methodsFor: 'placing' stamp: 'nacho 11/6/2018 18:59:51'!
placeOWhenPlacingOAt: aPoint 
	| position |
	self assertPositionIsValid: aPoint.
	position := self atPoint: aPoint.
	self assertPositionIsFree: position.
	position owner: #O.
	state := (self stateAfterPlacing: #O nextPlacingState: PlacingX nextMovingState: MovingX nextWinnerState: WinnerO) for: self.

	
	! !

!TerniLapelli methodsFor: 'placing' stamp: 'nacho 11/6/2018 18:47:36'!
placeXAt: aPoint 
	^state placeXAt: aPoint.! !

!TerniLapelli methodsFor: 'placing' stamp: 'nacho 11/6/2018 18:59:51'!
placeXWhenPlacingXAt: aPoint 
	| position |
	self assertPositionIsValid: aPoint.
	position := self atPoint: aPoint.
	self assertPositionIsFree: position.
	position owner: #X.
	state := (self stateAfterPlacing: #X nextPlacingState: PlacingO nextMovingState: MovingO nextWinnerState: WinnerX) for: self.

	
	! !


!TerniLapelli methodsFor: 'win conditions' stamp: 'if 11/7/2018 17:45:59'!
checkWinner: aPlayerPiece 
	|pieces|	
	pieces := self getPiecesOf: aPlayerPiece .	
	^	(pieces size) = 3 and:[(self hasCompleteALine: pieces) or:[ self hasCompletedADiagonal: pieces]] .
	! !

!TerniLapelli methodsFor: 'win conditions' stamp: 'eg 11/3/2018 19:25:12'!
hasCompleteAColumnOrRow: aCollectionOfIndexes
	|aSample|
	aSample := aCollectionOfIndexes first.
	
	^aCollectionOfIndexes allSatisfy: [:anIndex |  (aSample = anIndex)].

	! !

!TerniLapelli methodsFor: 'win conditions' stamp: 'if 11/5/2018 18:28:55'!
hasCompleteALine: aCollectionOfPositions
	|columns rows|
	columns := aCollectionOfPositions collect:[:aPosition | (aPosition coordinate) y].
	
	rows := aCollectionOfPositions collect:[:aPosition | (aPosition coordinate) x ].
	
	^ (self hasCompleteAColumnOrRow: columns) or:[ self hasCompleteAColumnOrRow: rows].! !

!TerniLapelli methodsFor: 'win conditions' stamp: 'eg 11/3/2018 19:21:54'!
hasCompletedADiagonal: aCollectionOfPositions

	^ (self hasUpDiagonal: aCollectionOfPositions) or:[ self hasDownDiagonal: aCollectionOfPositions].! !

!TerniLapelli methodsFor: 'win conditions' stamp: 'if 11/5/2018 18:29:20'!
hasDownDiagonal: aCollectionOfPositions

	^aCollectionOfPositions allSatisfy: [:aPosition |  ((aPosition coordinate) x + (aPosition coordinate) y) = 4].
	
	! !

!TerniLapelli methodsFor: 'win conditions' stamp: 'if 11/5/2018 18:29:35'!
hasUpDiagonal: aCollectionOfPositions

	^aCollectionOfPositions allSatisfy: [:aPosition |  (aPosition coordinate )x  = (aPosition coordinate ) y].
	
	! !


!TerniLapelli methodsFor: 'winner' stamp: 'nacho 11/6/2018 19:10:35'!
winner
	^state winner! !


!TerniLapelli methodsFor: 'turn' stamp: 'nacho 11/6/2018 18:01:34'!
currentTurn
	^state currentTurn! !


!TerniLapelli methodsFor: 'board' stamp: 'nacho 11/6/2018 19:30:13'!
aPlayerHasntPlayed: aPlayer 
	^(self positions anySatisfy: [:aPosition | aPosition owner = aPlayer]) not.! !

!TerniLapelli methodsFor: 'board' stamp: 'if 11/5/2018 17:39:26'!
at: aPoint 
	positions detect: [:aPosition| aPosition coordinate = aPoint ] ifFound:[:aPosition| ^aPosition owner ]  ifNone: [^nil] ! !

!TerniLapelli methodsFor: 'board' stamp: 'if 11/5/2018 18:07:53'!
atPoint: aPoint
	|arrayIndex|
	arrayIndex := ((aPoint y)  -1) * 3 + (aPoint  x).
	^positions at:arrayIndex.! !

!TerniLapelli methodsFor: 'board' stamp: 'nacho 11/6/2018 17:47:59'!
checkPlayersHaveFinishedPlacing 
	^self numberOfPiecesOnBoard = 6
! !

!TerniLapelli methodsFor: 'board' stamp: 'nacho 11/6/2018 20:18:21'!
checkValidCoordinate: aCoordinate
	(aCoordinate < 1 or: aCoordinate > 3) ifTrue:[^self error: self class invalidPositionErrorMessage ].! !

!TerniLapelli methodsFor: 'board' stamp: 'nacho 11/6/2018 17:43:19'!
getPiecesOf: aPlayer
	^positions select:[:aPosition | (aPosition owner) = aPlayer]! !

!TerniLapelli methodsFor: 'board' stamp: 'if 11/5/2018 18:40:17'!
isEmpty
	^self numberOfPiecesOnBoard = 0.! !

!TerniLapelli methodsFor: 'board' stamp: 'if 11/5/2018 18:53:08'!
numberOfPiecesOnBoard 
	^positions inject:0 into:[:numberOfPieces :aPosition |  (aPosition owner ~= #NoOwner) ifTrue:[ numberOfPieces +1] ifFalse:[numberOfPieces]].! !

!TerniLapelli methodsFor: 'board' stamp: 'if 11/1/2018 20:48:22'!
positions 
	^positions ! !


!TerniLapelli methodsFor: 'change state' stamp: 'nacho 11/6/2018 19:01:29'!
stateAfterMoving: aPlayerPiece nextMovingState: aMovingState nextWinnerState: aWinnerState
	
	(self checkWinner: aPlayerPiece) ifTrue: [ ^aWinnerState]. 
		
	^aMovingState.! !

!TerniLapelli methodsFor: 'change state' stamp: 'nacho 11/6/2018 18:59:51'!
stateAfterPlacing: aPlayerPiece nextPlacingState: aPlacingState nextMovingState: aMovingState nextWinnerState: aWinnerState 
	
	(self checkWinner: aPlayerPiece) ifTrue: [ ^aWinnerState]. 
	
	(self checkPlayersHaveFinishedPlacing ) ifTrue:[^aMovingState]. 
	
	^aPlacingState.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapelli class' category: #'Terni-Lapelli'!
TerniLapelli class
	instanceVariableNames: ''!

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:13:23'!
cantMoveUntilAllPiecesArePlacedErrorMessage
 	^'No se puede mover hasta que se coloquen todas las fichas'! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:12:03'!
cantPlaceMoreThanThreePiecesMessageError
	^'No se pueden jugar mas de tres fichas'.! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:13:57'!
gameHasEndedErrorMessage 
	^'Juego terminado'.! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:14:46'!
invalidMoveErrorMessage
	^'Movimiento invalido'! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:14:30'!
invalidPositionErrorMessage 
	^'Posicion invalida'! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:12:42'!
noOTurnErrorMessage 
	^'No es el turno de O'.! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:11:00'!
noWinnerErrorMessage 
	^'No hay ganador'! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:12:37'!
noXTurnErrorMessage 
	^'No es el turno de X'.! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:17:06'!
pieceDoesntBelongToPlayerErrorMessage
 	^'La ficha no le pertenece al jugador'! !

!TerniLapelli class methodsFor: 'message errors' stamp: 'nacho 11/6/2018 20:16:23'!
positionAlreadyTakenErrorMessage 
	^'Ya hay una ficha en esa posicion'! !
