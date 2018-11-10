!classDefinition: #TerniLapilliConsoleTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliConsoleTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'if 11/8/2018 20:59:42'!
test01ConsoleShowsWhenXMarks 
	|console lines| 
	game := TerniLapilli new. 
	console := TerniLapilliConsole on: game. 
	game putXAt: 2@2.
	
	lines := console lines. 

	self assert: lines next equals: 'X marcó en 2@2'.
	self assert: lines next equals: 'Estado: Jugando O'.
	self assert: lines atEnd.! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'if 11/8/2018 20:59:55'!
test02ConsoleShowsPlayingXAfterMarkingO
	|console lines| 
	game := TerniLapilli new. 
	console := TerniLapilliConsole on: game. 
	game putXAt: 2@2. 
	game putOAt: 1@1.
	
	lines := console lines. 

	self assert: lines next equals: 'X marcó en 2@2'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 1@1'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines atEnd.! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'if 11/8/2018 21:00:03'!
test03ConsoleShowsPlayingOAfterMarkingX
	|console lines| 
	game := TerniLapilli new. 
	console := TerniLapilliConsole on: game. 
	game putXAt: 2@2. 
	game putOAt: 1@1. 
	game putXAt: 3@2.
	
	lines := console lines. 

	self assert: lines next equals: 'X marcó en 2@2'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 1@1'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 3@2'.
	self assert: lines next equals: 'Estado: Jugando O'.
	self assert: lines atEnd. ! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'if 11/8/2018 21:00:12'!
test04ConsoleShowsWinnerX
	|console lines| 
	game := TerniLapilli new. 
	console := TerniLapilliConsole on: game. 
	game putXAt: 1@1. 
	game putOAt: 1@2. 
	game putXAt: 2@1.
	game putOAt: 3@2.
	game putXAt: 3@1.
	
	lines := console lines. 

	self assert: lines next equals: 'X marcó en 1@1'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 1@2'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 2@1'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 3@2'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 3@1'.
	self assert: lines next equals: 'Estado: Juego terminado - ¡Ganó X!!'.
	self assert: lines atEnd.
	
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'if 11/8/2018 21:01:17'!
test05ConsoleShowsWinnerO
	|console lines| 
	game := TerniLapilli new. 
	console := TerniLapilliConsole on: game. 
	game putXAt: 1@2. 
	game putOAt: 1@1. 
	game putXAt: 3@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	lines := console lines. 

	self assert: lines next equals: 'X marcó en 1@2'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 1@1'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 3@2'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 2@1'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 3@3'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 3@1'.
	self assert: lines next equals: 'Estado: Juego terminado - ¡Ganó O!!'.
	self assert: lines atEnd.
	
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'eg 11/9/2018 20:44:55'!
test06ConsoleShowsXSlides
	|console lines| 
	game := TerniLapilli new. 
	console := TerniLapilliConsole on: game. 
	game putXAt: 2@2. 
	game putOAt: 1@1. 
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game slideXFrom: 1@3 to: 1@2.

	lines := console lines. 

	self assert: lines next equals: 'X marcó en 2@2'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 1@1'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 1@3'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 3@1'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 2@1'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 2@3'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X deslizó desde 1@3 hasta 1@2'.
	self assert: lines next equals: 'Estado: Jugando O'.

	self assert: lines atEnd.
	
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'eg 11/9/2018 20:55:14'!
test07ConsoleShowsOSlides
	|console lines| 
	game := TerniLapilli new. 
	console := TerniLapilliConsole on: game. 
	game putXAt: 2@2. 
	game putOAt: 1@1. 
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game slideXFrom: 1@3 to: 1@2.
	game slideOFrom: 3@1 to: 3@2.

	lines := console lines. 

	self assert: lines next equals: 'X marcó en 2@2'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 1@1'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 1@3'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 3@1'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 2@1'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 2@3'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X deslizó desde 1@3 hasta 1@2'.
	self assert: lines next equals: 'Estado: Jugando O'.
	self assert: lines next equals: 'O deslizó desde 3@1 hasta 3@2'.
	self assert: lines next equals: 'Estado: Jugando X'.

	self assert: lines atEnd.
	
	! !


!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'assertions' stamp: 'HAW 11/8/2018 09:51:39'!
assertCanNotMarkAt: aPosition
	self assertCanNotMarkUsing: [ game putXAt: aPosition ].
	self assertCanNotMarkUsing: [ game putOAt: aPosition ].! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 20:12:53'!
assertCanNotMarkUsing: aMarkingClosure
	self
		should: aMarkingClosure 
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionOutsideBoardErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{}
				andOOn:
					{} ].! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:53:12'!
assertGameIsNotOver
	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'eg 11/10/2018 19:40:41'!
assertGameIsOver
	self assert: game isOver.
	self deny: game isPlayingX.
	self deny: game isPlayingO.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'eg 11/10/2018 19:40:41'!
assertIsPlayingO
	self assert: game isPlayingO.
	self deny: game isPlayingX.
	self assertGameIsNotOver.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'eg 11/10/2018 19:40:41'!
assertIsPlayingX
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:56:00'!
assertOIsMarkedOn: oPositions
	self
		assert: oPositions size
		equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions ) isEmpty.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:38:50'!
assertOWon
	self assertGameIsOver.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:50:53'!
assertXIsMarkedOn: xPositions
	self
		assert: xPositions size
		equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions ) isEmpty.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:48:39'!
assertXIsMarkedOn: xPositions andOOn: oPositions
	self assertXIsMarkedOn: xPositions .
	self assertOIsMarkedOn: oPositions .! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:20:00'!
assertXWon
	self assertGameIsOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !


!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 07:25:01'!
functionalException
	^ Error - MessageNotUnderstood.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 09:31:31'!
test01aGameStartsWithAnEmptyBoardAndPlayingX

	game _ TerniLapilli new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 09:33:14'!
test01bGameStartsWithAnEmptyBoardButOCanNotPlayFirst
	
	| oPosition |
	
	game _ TerniLapilli new.
	oPosition _ 2@2.
	
	self should: [ game putOAt: oPosition]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notOTurnErrorMessage 
				equals: anError messageText.
			self deny: (game isTaken: oPosition) ].			
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:54:38'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		assertXIsMarkedOn:
			{1 @ 1}
		andOOn:
			{}.
	self assertIsPlayingO.
	
	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:04:28'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		assertXIsMarkedOn:
			{1 @ 1}
		andOOn:
			{2 @ 2}.
	self assertIsPlayingX.	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:07:30'!
test04CanNotMarkWithXWhenLastMarkWasX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notXTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{} ].	
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:09:21'!
test05CanNotMarkWithOWhenLastMarkWasO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putOAt: 3 @ 3 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notOTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:11:07'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 1 @ 1. ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
				
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:13:58'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:16:06'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		should: [ game putOAt: 1 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{} ].	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:18:11'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 3 @ 3.
	self
		should: [ game putOAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1. 3 @ 3}
				andOOn:
					{2 @ 2} ].
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/8/2018 13:11:55'!
test10AssertThereIsNotWinner
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 2.
	
	self assertGameIsNotOver ! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:22:01'!
test11XWinsWhenCompletesRowNumber1
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self assertXWon.
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:30:21'!
test12XWinsWhenCompletesRowNumber2
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.
	self assertXWon.

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:31:38'!
test13XWinsWhenCompletesRowNumber3
	
	game _ TerniLapilli new.

	game putXAt: 3 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 3 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 3.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:35:10'!
test14XWinsWhenCompletesAColumn
	
	game _ TerniLapilli new.

	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 3.
	game putXAt: 3 @ 1.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:36:18'!
test15XWinsWhenCompletesDiagonalGoingDown
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 3.
	game putXAt: 3 @ 3.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:37:09'!
test16XWinsWhenCompletesDiagonalGoingUp
	game _ TerniLapilli new.

	game putXAt: 1 @ 3.
	game putOAt: 1 @ 2.
	game putXAt: 2 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 1.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:38:20'!
test17OWinsWhenCompletesARow
	
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 1 @ 3.
	self assertOWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 09:24:09'!
test18OCanNotMarkWhenXWon
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self
		should: [ game putOAt: 3 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self assertOIsMarkedOn:
				{2 @ 1. 3 @ 1} ].
			
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 19:29:18'!
test19XCanNotMarkWhenXWon
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.

	self 
		should: [ game  putXAt: 2 @ 3 ] 
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
				{2 @ 1. 2 @ 2. 2@3}
			 ]
		! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 19:29:30'!
test20XCanNotPlaceMoreThanThreePieces
	game _ TerniLapilli new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 2 @ 3.
	self
		should: [ game putXAt: 3 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli playerXHasPlacedThreePieces
				equals: anError messageText.
			self assertXIsMarkedOn:
				{2 @ 2. 2 @ 1. 3 @ 1} ].
			
			! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test21XCanSlideWhenAllXPiecesWerePlaced
	game _ TerniLapilli new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 2 @ 3.
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	
	self assertXIsMarkedOn: {1 @ 2. 1 @ 3. 2 @ 1}.
	self assertIsPlayingO.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test22OCanSlideWhenAllOPiecesWerePlaced
	
	game _ TerniLapilli new.
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.


	self assertXIsMarkedOn: {1 @ 2. 2 @ 1. 1 @ 3}.
	self assertOIsMarkedOn: {2 @ 2. 3 @ 1. 2 @ 3}.
	self assertIsPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test23CanNotSlideWithXToAnAlreadyMarkedPositionWithX

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.
				
	self 
		should: [ game slideXFrom: 1@2 to: 1@3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{2@2. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test24CanNotSlideWithXToAnAlreadyMarkedPositionWithO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.
				
	self 
		should: [ game slideXFrom: 2@1 to: 3@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{2@2. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test25CanNotSlideWithOToAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
					
	self 
		should: [ game slideOFrom: 1@1 to: 2@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 3@1. 1@3}
				andOOn:
					{1@1. 2@2. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test26CanNotSlideWithOToAnAlreadyMarkedPositionWithX
	
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
					
	self 
		should: [ game slideOFrom: 1@1 to: 2@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test27XWinsSliding

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 2@2 to: 3@3.
	game slideXFrom: 1@2 to: 2@2.
					
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test28OWinsSliding

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 1@1 to: 2@1.
					
	self assertOWon.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test29XCanNotSlideWhenOWon
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 1@1 to: 2@1.
					
	self 
		should: [ game slideXFrom: 3@1 to: 3@2. ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2.     3@1. 1@3}
				andOOn:
					{2@1. 2@2. 2@3}  ]
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test30OCanNotSlideWhenXWon
	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	game slideOFrom: 3 @ 1 to: 2 @ 2.
	game slideXFrom: 2 @ 1 to: 3 @ 1.
	game slideOFrom: 2 @ 2 to: 3 @ 3.
	game slideXFrom: 1 @ 2 to: 2 @ 2.
	
	self should: [game slideOFrom: 1 @ 1 to: 2 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError | self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
		self assertXIsMarkedOn:
					{2@2.     3@1. 1@3}
				andOOn:
					{1@1. 3@3. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test30_01CanNotSlideXToAnInvalidPosition

	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	self 
		should: [game slideXFrom: 1 @ 3 to: 0 @ 3]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli illegalMovement.
			self assertXIsMarkedOn: { 2@2. 2@1. 1@3 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test30_02CanNotSlideOToAnInvalidPosition

	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	game slideXFrom: 1 @ 3 to: 1@ 2.
	self 
		should: [ game slideOFrom: 1@1 to: 0@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli illegalMovement.
			self assertOIsMarkedOn: { 1@1. 3@1. 2@3 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test31DifferenceBetweenPositionsShouldNotBeGreaterThanOneWhenSliding
	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 2@3.

	self 
		should: [ game slideXFrom: 3@1 to: 3@3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 3@1}
				andOOn:
					{1@1. 1@2. 2@3}  ]
			
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test32OnlyPermittedXSlidingsBetweenAdjacentsPositions

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 2@2 to: 3@3.	
					
		self 
		should: [ game slideXFrom: 1@2 to: 3@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 3@1. 1@3}
				andOOn:
					{1@1. 3@3. 2@3}   ]
			
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test33OnlyPermittedOSlidingsBetweenAdjacentsPositions
game _ TerniLapilli new.	

	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 2@3.
	
	game slideXFrom: 3@1 to: 3@2.

	self 
		should: [ game slideOFrom: 2@3 to: 3@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 3@2}
				andOOn:
					{1@1. 1@2. 2@3}  ]
			
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 20:34:51'!
test34CanNotMarkOutsideBoard
	game _ TerniLapilli new.
	#(0 4 ) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test35CanNotSlideWithXFromAPositionMarkedWithO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
			
	self 
		should: [ game slideXFrom: 3@1 to: 3@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli playersCanOnlySlideTheirOwnPieces equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test36CanNotSlideWithOFromAPositionMarkedWithX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.

	game slideXFrom: 2@2 to: 1@2.
			
	self 
		should: [ game slideOFrom: 2@1 to: 2@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli playersCanOnlySlideTheirOwnPieces equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:16'!
test37CanNotSlideXWhenPutingX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	

	self 
		should: [ game slideXFrom: 2@2 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  playerXHasPiecesToPlace.
			self assertXIsMarkedOn: { 2@2 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:30'!
test38CanNotSlideOWhenPuttingO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.

	self 
		should: [ game slideOFrom: 1@1 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  playerOHasPiecesToPlace.
			self assertOIsMarkedOn: { 1@1 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:49'!
test39CanNotSlideXWhenPlayingO

	game _ TerniLapilli new.	
	game putXAt: 2@2.

	self 
		should: [ game slideXFrom: 2@2 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  notXTurnErrorMessage.
			self assertXIsMarkedOn: { 2@2 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:50:01'!
test40CanNotSlideOWhenPlayingX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.

	self 
		should: [ game slideOFrom: 1@1 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  notOTurnErrorMessage.
			self assertOIsMarkedOn: { 1@1 } ]
	! !


!classDefinition: #TerniLapilliViewTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliViewTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:08:40'!
test01BoardStartsEmptyAndPlayingX
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	
	board := view board .
	
	self assert: board equals: #(
' | | '
'-----'
' | | '
'-----'
' | | '
'Playing X').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:08:46'!
test02XPlaysAndMarksBoard
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	game putXAt: 2@2.
	
	board := view board .
	
	self assert: board equals: #(
' | | ' 
'-----'
' |X| ' 
'-----'
' | | ' 
'Playing O').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:08:53'!
test03OPlaysAndMarksBoard
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	board := view board .
	
	self assert: board equals: #(
' | | ' 
'-----'
' |X| ' 
'-----'
'O| | ' 
'Playing X').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:09:00'!
test04XPlaysAfterOandMarksBoard
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	
	board := view board .
	
	self assert: board equals: #(
' | | ' 
'-----'
'X|X| ' 
'-----'
'O| | ' 
'Playing O').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:09:06'!
test05XMovesAndMarksBoard
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 1@3.
	game putOAt: 3@3.
	
	game slideXFrom:2@2 to:3@1. 
	
	board := view board .
	
	self assert: board equals: #(
'X| |O' 
'-----'
'X| |O' 
'-----'
'O| |X' 
'Playing O').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:09:15'!
test06OMovesAndMarksBoard
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 1@3.
	game putOAt: 3@3.
	
	game slideXFrom:2@2 to:3@1. 
	game slideOFrom:1@1 to:2@2.
	
	board := view board .
	
	self assert: board equals: #(
'X| |O' 
'-----'
'X|O|O' 
'-----'
' | |X' 
'Playing X').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:09:30'!
test07ViewShowOWins
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 1@3.
	game putOAt: 3@3.
	
	game slideXFrom:2@2 to:3@1. 
	game slideOFrom:1@1 to:2@2.
	game slideXFrom:3@1 to:2@1.
	game slideOFrom:2@2 to:3@1.
	board := view board .
	
	self assert: board equals: #(
'X| |O' 
'-----'
'X| |O' 
'-----'
' |X|O' 
'O Won!!').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:09:39'!
test08ViewShowXWins
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 1@3.
	game putOAt: 3@3.
	
	game slideXFrom:2@2 to:3@1. 
	game slideOFrom:1@1 to:2@2.
	game slideXFrom:3@1 to:2@1.
	game slideOFrom:2@2 to:2@3.
	game slideXFrom:2@1 to:1@1.
	board := view board .
	
	self assert: board equals: #(
'X|O|O' 
'-----'
'X| |O' 
'-----'
'X| | ' 
'X Won!!').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:09:46'!
test09ViewShowXWinsWhenStillPlacing
	|view board| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 1@1.
	game putOAt: 3@2.
	game putXAt: 3@3.

	
	board := view board .
	
	self assert: board equals: #(
' | |X' 
'-----'
'O|X|O' 
'-----'
'X| | ' 
'X Won!!').
! !

!TerniLapilliViewTest methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:09:54'!
test10ViewAndConsoleCanBeObserversAtTheSameTime
	|view board console lines| 
	game := TerniLapilli new. 
	view := TerniLapilliView on: game.
	console := TerniLapilliConsole on: game. 
	
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 1@1.
	game putOAt: 3@2.
	game putXAt: 3@3.

	
	board := view board .
	lines := console lines .
	
	self assert: lines next equals: 'X marcó en 2@2'.
	self assert: lines next equals: 'Estado: Jugando O'. 
	self assert: lines next equals: 'O marcó en 1@2'.
	self assert: lines next equals: 'Estado: Jugando X'. 
	self assert: lines next equals: 'X marcó en 1@1'.
	self assert: lines next equals: 'Estado: Jugando O'.
	self assert: lines next equals: 'O marcó en 3@2'.
	self assert: lines next equals: 'Estado: Jugando X'.
	self assert: lines next equals: 'X marcó en 3@3'.
	self assert: lines next equals: 'Estado: Juego terminado - ¡Ganó X!!'. 
	self assert: lines atEnd. 
	
	self assert: board equals: #(
' | |X' 
'-----'
'O|X|O' 
'-----'
'X| | ' 
'X Won!!').



! !


!classDefinition: #ActiveVariable category: #TerniLapilli!
Object subclass: #ActiveVariable
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ActiveVariable methodsFor: 'initialization' stamp: 'eg 11/10/2018 17:40:37'!
initialize
	observers := OrderedCollection new.! !


!ActiveVariable methodsFor: 'observer' stamp: 'eg 11/10/2018 17:38:38'!
addObserver: anObserver
	observers add: anObserver .! !


!ActiveVariable methodsFor: 'value' stamp: 'eg 11/10/2018 17:39:40'!
value: newValue
	value:= newValue.
	observers do:[:anObserver | anObserver value:value]! !


!ActiveVariable methodsFor: 'message forwarding' stamp: 'eg 11/10/2018 18:28:21'!
doesNotUnderstand: aMessage
	^aMessage sendTo: value.! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state playerOPositions playerXPositions lastPlace lastSlide'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 10/28/2018 15:11:39'!
assertAllPiecesOPlaced

	(self playerOPositions size = 3 ) ifFalse: [ self error: self class playerOHasPiecesToPlace ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 10/28/2018 15:11:20'!
assertAllPiecesXPlaced

	(self playerXPositions size = 3 ) ifFalse: [ self error: self class playerXHasPiecesToPlace ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 11/8/2018 10:47:35'!
assertIsInBoardBounds: aPosition

	(self isInBoardBounds: aPosition) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 11/8/2018 09:55:12'!
assertIsLegalMovementFrom: aPosition to: anotherPosition

	(self moveLegalFrom: aPosition to: anotherPosition) ifFalse: [ self error: self class illegalMovement ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 11/6/2018 22:31:24'!
assertThereIsAnOPieceIn: aPosition

	(self playerOPositions includes: aPosition) ifFalse: [ self error: self class playersCanOnlySlideTheirOwnPieces ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 11/6/2018 22:30:17'!
assertThereIsAnXPieceIn: aPosition

	(self playerXPositions includes: aPosition) ifFalse: [ self error: self class playersCanOnlySlideTheirOwnPieces ]! !


!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:30'!
has: positions threeOf: aPositionComponent

	^positions size >= 3 and: [ (positions collect: aPositionComponent) asBag contents values includes: 3 ]
	! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 11/8/2018 10:58:20'!
hasCompletedColumn: positions

	^ self has: positions threeOf: [ :aPosition | aPosition y ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 11/8/2018 10:58:36'!
hasCompletedRow: positions
	
	^ self has: positions threeOf: [ :aPosition | aPosition x ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:15:47'!
hasDownDiagonal: positions

	^ (1 to: 3) allSatisfy: [ :n | positions includes: n @ (4-n) ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:15:59'!
hasUpDiagonal: positions

	^ (1 to: 3) allSatisfy: [ :n | positions includes: n @ n ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:16:26'!
hasWin: positions

	^ (self hasCompletedRow: positions) 
		or: [ (self hasCompletedColumn: positions) 
		or: [ (self hasUpDiagonal: positions) 
		or: [ self hasDownDiagonal: positions ]]].! !


!TerniLapilli methodsFor: 'initialization' stamp: 'eg 11/10/2018 19:10:39'!
initialize
	
	playerXPositions := OrderedCollection new.
	playerOPositions := OrderedCollection new.
	
	lastPlace := ActiveVariable new.
	lastSlide := ActiveVariable new.
	state := ActiveVariable new.
	
	
	state value: (PlacingX new initializeFor: self).! !


!TerniLapilli methodsFor: 'marking board' stamp: 'eg 11/10/2018 17:55:22'!
putOAt: aPosition

	self assertIsInBoardBounds: aPosition .
	state putOAt: aPosition. 
	! !

!TerniLapilli methodsFor: 'marking board' stamp: 'eg 11/10/2018 18:46:05'!
putXAt: aPosition

	self assertIsInBoardBounds: aPosition .
	state putXAt: aPosition. 
	! !


!TerniLapilli methodsFor: 'marking board - private' stamp: 'eg 11/10/2018 18:20:58'!
changeStateAfterAdding: aPosition to: positions  

	positions add: aPosition.
	
	state value: (TerniLapilliState for: self)
	
	! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'eg 11/10/2018 18:17:27'!
putOWhenPlacingOAt: aPosition

	self playerOHasPiecesToPlace.
	self assertIsFree: aPosition.
	
	lastPlace value: $O->aPosition.

	self changeStateAfterAdding: aPosition to: playerOPositions
		! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:39:41'!
putOWhenPlacingXAt: aPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:08:31'!
putOWhenSlidingOAt: aPoint 
	
	self error: self class eachPlayerOnlyHasThreePieces ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:38:11'!
putOWhenSlidingXAt: aPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:39:23'!
putXWhenPlacingOAt: aPoint 
	
	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'eg 11/10/2018 18:17:36'!
putXWhenPlacingXAt: aPosition

	self playerXHasPiecesToPlace.
	self assertIsFree: aPosition.
	
	lastPlace value: $X->aPosition.
	
	self changeStateAfterAdding: aPosition to: playerXPositions	! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:38:49'!
putXWhenSlidingOAt: aPoint 
	
	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 11:59:44'!
putXWhenSlidingXAt: aPoint 
	
	self error: self class eachPlayerOnlyHasThreePieces ! !


!TerniLapilli methodsFor: 'pieces' stamp: 'HAW 11/8/2018 09:58:58'!
playerOHasPiecesToPlace

	 self playerOPositions size < 3 ifFalse: [ self error: self class playerXHasPlacedThreePieces ].
	! !

!TerniLapilli methodsFor: 'pieces' stamp: 'HAW 11/8/2018 09:59:05'!
playerXHasPiecesToPlace

	 self playerXPositions size < 3 ifFalse: [ self error: self class playerXHasPlacedThreePieces ].
	! !


!TerniLapilli methodsFor: 'positions' stamp: 'HAW 11/8/2018 10:49:00'!
moveLegalFrom: aPosition to: anotherPosition
	
	^ (self is: aPosition adjacentTo: anotherPosition) and: [ self isInBoardBounds: anotherPosition ]! !

!TerniLapilli methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TerniLapilli methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TerniLapilli methodsFor: 'sliding' stamp: 'eg 11/10/2018 18:46:18'!
slideOFrom: aPosition to: anotherPosition

	self assertThereIsAnOPieceIn: aPosition.
	state slideOFrom: aPosition to: anotherPosition.
	
! !

!TerniLapilli methodsFor: 'sliding' stamp: 'eg 11/10/2018 18:46:22'!
slideXFrom: aPosition to: anotherPosition


	self assertThereIsAnXPieceIn: aPosition.
	
	state slideXFrom: aPosition to: anotherPosition.
	
! !


!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:41:03'!
slideOWhenPlacingOFrom: aPosition to: anotherPosition

	self error: self class playerOHasPiecesToPlace ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:46:55'!
slideOWhenPlayingXFrom: aPosition to: anotherPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'eg 11/10/2018 18:19:34'!
slideOWhenSlidingOFrom: aPosition to: anotherPosition
	
	self assertIsFree: anotherPosition .
	self assertIsLegalMovementFrom: aPosition to: anotherPosition.
	
	playerOPositions remove: aPosition.
	
	
	lastSlide value: $O -> {aPosition . anotherPosition}.
	
	self changeStateAfterAdding: anotherPosition to: playerOPositions
	 ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:16:01'!
slideXWhenPlacingXFrom: aPosition to: anotherPosition

	self error: self class playerXHasPiecesToPlace ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:44:53'!
slideXWhenPlayingOFrom: aPosition to: anotherPosition

	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'eg 11/10/2018 18:20:06'!
slideXWhenSlidingXFrom: aPosition to: anotherPosition


	self assertIsFree: anotherPosition .
	self assertIsLegalMovementFrom: aPosition to: anotherPosition.
	playerXPositions remove: aPosition.


	lastSlide value: $X -> {aPosition . anotherPosition}.
	
	self changeStateAfterAdding: anotherPosition to: playerXPositions! !


!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 12:19:28'!
does: aNumber distanceOneTo: anotherNumber

	^ (aNumber - anotherNumber) abs < 2 ! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 11:30:51'!
hasXMorePiecesToPlace
	
	^playerXPositions size < 3! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 12:19:28'!
is: aPosition adjacentTo: anotherPosition

	^ (self does: aPosition x distanceOneTo: anotherPosition x) and: [ self does: aPosition y distanceOneTo: anotherPosition y ]
	! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 10:47:53'!
isInBoardBounds: aPosition

	^aPosition between: 1@1 and: 3@3! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 5/31/2018 00:16:45'!
isTaken: aPosition

	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 11:56:45'!
hasPlayerOWon

	^self hasWin: playerOPositions ! !

!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 11:56:55'!
hasPlayerXWon
	
	^self hasWin: playerXPositions ! !

!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !


!TerniLapilli methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:41:03'!
isPlacingX
	
	^state isPlacingX ! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:40:17'!
isPlayingO
	
	^state isPlayingO! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:40:41'!
isPlayingX
	
	^state isPlayingX ! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:41:16'!
isSlidingX
	
	^state isSlidingX ! !


!TerniLapilli methodsFor: 'console' stamp: 'if 11/8/2018 20:16:17'!
attachConsole: aTerniLapelliConsole 
	console := aTerniLapelliConsole .! !

!TerniLapilli methodsFor: 'console' stamp: 'eg 11/10/2018 13:20:45'!
attachView: aTerniLapelliView
	view := aTerniLapelliView .! !


!TerniLapilli methodsFor: 'observers' stamp: 'eg 11/10/2018 18:07:52'!
addLastPlaceObserver: anObserver
	lastPlace addObserver: anObserver .! !

!TerniLapilli methodsFor: 'observers' stamp: 'eg 11/10/2018 18:08:02'!
addLastSlideObserver: anObserver
	lastSlide addObserver: anObserver .! !

!TerniLapilli methodsFor: 'observers' stamp: 'eg 11/10/2018 18:08:22'!
addStateObserver: anObserver
	state addObserver: anObserver .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 11:12:02'!
eachPlayerOnlyHasThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 11/8/2018 09:55:12'!
illegalMovement
	
	^'Movement is not legal'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:50:08'!
playerOHasPiecesToPlace

	^ 'Must place all pieces to slide'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 15:02:06'!
playerOHasPlacedThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:50:16'!
playerXHasPiecesToPlace

	^ 'Must place all pieces to slide'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 15:01:23'!
playerXHasPlacedThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:21:33'!
playersCanOnlySlideTheirOwnPieces

	^ 'Players can only slide their own pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 20:07:12'!
positionOutsideBoardErrorMessage
	^ 'Position is outside board'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TerniLapilliState category: #TerniLapilli!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:13:16'!
areAllXsOnTheBoard
	
	^false! !

!TerniLapilliState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:13:10'!
isOver
	
	^false! !


!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:42:28'!
isPlacingX
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:40:16'!
isPlayingO
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:40:41'!
isPlayingX
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:42:45'!
isSlidingX
	
	^false! !


!TerniLapilliState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:03:55'!
putOAt: aPosition
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'marking board' stamp: 'eg 11/10/2018 18:50:07'!
putXAt: aPosition
	game putXWhenPlacingXAt: aPosition ! !


!TerniLapilliState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPosition
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'sliding' stamp: 'eg 11/9/2018 20:33:01'!
slideXFrom: aPosition to: anotherPosition

	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !


!TerniLapilliState methodsFor: 'name' stamp: 'if 11/8/2018 20:20:38'!
stateName
	^'Jugando O'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #TerniLapilli!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'eg 11/10/2018 17:45:20'!
for: aTerniLapilli 
	| stateClass |
	stateClass := self allSubclasses detect: [:anStateClass | anStateClass isFor: aTerniLapilli ].	
	^stateClass new initializeFor: aTerniLapilli ! !


!TerniLapilliState class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:21:46'!
isFor: aTerniLapilli 

	^self subclassResponsibility ! !


!classDefinition: #GameOverState category: #TerniLapilli!
TerniLapilliState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:15:43'!
isOver

	^ true.! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:08:57'!
putOAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:09:02'!
putXAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !


!GameOverState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

!GameOverState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !


!GameOverState methodsFor: 'name' stamp: 'eg 11/10/2018 20:02:28'!
accept:aVisitor
	game hasPlayerXWon ifTrue:[
		aVisitor visitWinnerX ] ifFalse:[aVisitor visitWinnerO]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOverState class' category: #TerniLapilli!
GameOverState class
	instanceVariableNames: ''!

!GameOverState class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 12:02:20'!
isFor: aTerniLapilli 

	^ aTerniLapilli hasPlayerXWon or: [ aTerniLapilli hasPlayerOWon ]! !


!classDefinition: #PlayingO category: #TerniLapilli!
TerniLapilliState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:40:16'!
isPlayingO
	^true! !


!PlayingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game slideXWhenPlayingOFrom: aPosition to: anotherPostion .! !


!PlayingO methodsFor: 'name' stamp: 'eg 11/10/2018 20:04:40'!
accept:aVisitor
	aVisitor visitPlayingO.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingO class' category: #TerniLapilli!
PlayingO class
	instanceVariableNames: ''!

!PlayingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:23:04'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #PlacingO category: #TerniLapilli!
PlayingO subclass: #PlacingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlacingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:10:45'!
putOAt: aPosition

	game putOWhenPlacingOAt: aPosition ! !

!PlacingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 13:05:38'!
putXAt: aPosition

	game putXWhenPlacingOAt: aPosition ! !


!PlacingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion

	game slideOWhenPlacingOFrom: aPosition to: anotherPostion .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingO class' category: #TerniLapilli!
PlacingO class
	instanceVariableNames: ''!

!PlacingO class methodsFor: 'state selection' stamp: 'eg 11/10/2018 19:38:53'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlacingX and: [ aTerniLapilli hasPlayerXWon not ] ! !


!classDefinition: #SlidingO category: #TerniLapilli!
PlayingO subclass: #SlidingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!SlidingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:11:14'!
putOAt: aPosition

	game putOWhenSlidingOAt: aPosition ! !

!SlidingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:04:38'!
putXAt: aPosition

	game putXWhenSlidingXAt: aPosition ! !


!SlidingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion
 
	game slideOWhenSlidingOFrom: aPosition to: anotherPostion .! !


!SlidingO methodsFor: 'testing pieces placed' stamp: 'JG 10/28/2018 12:04:38'!
areAllXsOnTheBoard
	
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingO class' category: #TerniLapilli!
SlidingO class
	instanceVariableNames: ''!

!SlidingO class methodsFor: 'state selection' stamp: 'eg 11/10/2018 19:39:23'!
isFor: aTerniLapilli 

	^aTerniLapilli isSlidingX and: [ aTerniLapilli hasPlayerXWon not ]! !


!classDefinition: #PlayingX category: #TerniLapilli!
TerniLapilliState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:40:41'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion
 
	game slideOWhenPlayingXFrom: aPosition to: anotherPostion .! !


!PlayingX methodsFor: 'name' stamp: 'eg 11/10/2018 20:05:08'!
accept:aVisitor
	aVisitor visitPlayingX ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingX class' category: #TerniLapilli!
PlayingX class
	instanceVariableNames: ''!

!PlayingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:25:23'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #PlacingX category: #TerniLapilli!
PlayingX subclass: #PlacingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlacingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 13:52:28'!
putOAt: aPosition

	game putOWhenPlacingXAt: aPosition ! !

!PlacingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 11:58:08'!
putXAt: aPosition

	game putXWhenPlacingXAt: aPosition ! !


!PlacingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game slideXWhenPlacingXFrom: aPosition to: anotherPostion .! !


!PlacingX methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:42:28'!
isPlacingX

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingX class' category: #TerniLapilli!
PlacingX class
	instanceVariableNames: ''!

!PlacingX class methodsFor: 'state selection' stamp: 'eg 11/10/2018 19:39:33'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlayingO and: [ aTerniLapilli hasXMorePiecesToPlace]! !


!classDefinition: #SlidingX category: #TerniLapilli!
PlayingX subclass: #SlidingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!SlidingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 14:51:46'!
putOAt: aPosition

	game putOWhenSlidingXAt: aPosition ! !

!SlidingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:00:12'!
putXAt: aPosition

	game putXWhenSlidingXAt: aPosition ! !


!SlidingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion
 
	game slideXWhenSlidingXFrom: aPosition to: anotherPostion .! !


!SlidingX methodsFor: 'testing pieces placed' stamp: 'JG 10/28/2018 11:30:43'!
areAllXsOnTheBoard
	
	^true! !


!SlidingX methodsFor: 'testing playing turn' stamp: 'eg 11/10/2018 19:42:45'!
isSlidingX

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingX class' category: #TerniLapilli!
SlidingX class
	instanceVariableNames: ''!

!SlidingX class methodsFor: 'state selection' stamp: 'eg 11/10/2018 19:39:39'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlayingO and: [ aTerniLapilli hasXMorePiecesToPlace not and: [ aTerniLapilli hasPlayerOWon not ]]! !


!classDefinition: #TerniLapilliVisitors category: #TerniLapilli!
Object subclass: #TerniLapilliVisitors
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliVisitors methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:04:40'!
visitPlayingO
	self subclassResponsibility .! !

!TerniLapilliVisitors methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:05:08'!
visitPlayingX
	self subclassResponsibility .! !

!TerniLapilliVisitors methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 19:58:56'!
visitWinnerO
	self subclassResponsibility .! !

!TerniLapilliVisitors methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 19:58:52'!
visitWinnerX
	self subclassResponsibility .! !


!classDefinition: #TerniLapilliConsole category: #TerniLapilli!
TerniLapilliVisitors subclass: #TerniLapilliConsole
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'eg 11/10/2018 18:05:26'!
initializeWith: aTerniLapelliGame 
	
	aTerniLapelliGame addLastPlaceObserver:[:aPlace | self newPlace:aPlace].
	aTerniLapelliGame addLastSlideObserver:[:aSlide | self newSlide:aSlide].
	aTerniLapelliGame addStateObserver:[:newState | self stateChanged:newState].
	
	lines := OrderedCollection new.
	
	! !


!TerniLapilliConsole methodsFor: 'game' stamp: 'eg 11/10/2018 19:12:15'!
newPlace:aPlace
	lines add: (aPlace key asString), ' marcó en ', aPlace value printString . 

	! !

!TerniLapilliConsole methodsFor: 'game' stamp: 'eg 11/10/2018 19:12:21'!
newSlide:aSlide
	lines add: (aSlide key asString ), ' deslizó desde ', (aSlide value first) printString, ' hasta ', (aSlide value second) printString.

	! !

!TerniLapilliConsole methodsFor: 'game' stamp: 'eg 11/10/2018 20:11:44'!
stateChanged:aState
	aState accept: self.


	! !


!TerniLapilliConsole methodsFor: 'lines' stamp: 'if 11/8/2018 20:18:47'!
lines 	
	^ReadStream on: lines.! !


!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:04:40'!
visitPlayingO
	lines add: 'Estado: Jugando O' ! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 20:05:08'!
visitPlayingX
	lines add: 'Estado: Jugando X' ! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 19:59:41'!
visitWinnerO
	lines add: 'Estado: Juego terminado - ¡Ganó O!!' ! !

!TerniLapilliConsole methodsFor: 'as yet unclassified' stamp: 'eg 11/10/2018 19:59:48'!
visitWinnerX
	lines add: 'Estado: Juego terminado - ¡Ganó X!!' ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsole class' category: #TerniLapilli!
TerniLapilliConsole class
	instanceVariableNames: ''!

!TerniLapilliConsole class methodsFor: 'class initialization' stamp: 'if 11/8/2018 20:11:50'!
on: aTerniLapelliGame 
	^self new initializeWith: aTerniLapelliGame .! !


!classDefinition: #TerniLapilliView category: #TerniLapilli!
TerniLapilliVisitors subclass: #TerniLapilliView
	instanceVariableNames: 'board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliView methodsFor: 'board' stamp: 'eg 11/10/2018 14:20:39'!
board
	^board.! !


!TerniLapilliView methodsFor: 'board - private' stamp: 'eg 11/10/2018 13:31:28'!
indexAtPoint: aPoint
	|arrayIndex|
	arrayIndex := ((aPoint y)  -1) * 3 + (aPoint  x).
	^arrayIndex.
! !

!TerniLapilliView methodsFor: 'board - private' stamp: 'eg 11/10/2018 14:11:47'!
indexForX: aXPosition
	aXPosition = 1 ifTrue: [^1].
	aXPosition  = 2 ifTrue: [^3].
	aXPosition  = 3 ifTrue: [^5].
	
	self error: 'Invalid index'
	! !

!TerniLapilliView methodsFor: 'board - private' stamp: 'eg 11/10/2018 14:11:25'!
indexForY: aYPosition
	aYPosition = 1 ifTrue: [^5].
	aYPosition  = 2 ifTrue: [^3].
	aYPosition  = 3 ifTrue: [^1].
	
	self error: 'Invalid index'
	! !


!TerniLapilliView methodsFor: 'initialization' stamp: 'eg 11/10/2018 20:10:23'!
initializeBoard
	
"	|initialSlots totalSlots |
	
	totalSlots := (1 to: 9) asOrderedCollection .
	
	initialSlots  := OrderedCollection new.

	totalSlots do:[ :aSlotIndex |
			initialSlots add:' '. 
			].
	
	board := initialSlots ."
	
	
	
board := Array withAll: #(
' | | '
'-----'
' | | '
'-----'
' | | '
'Playing X')! !

!TerniLapilliView methodsFor: 'initialization' stamp: 'eg 11/10/2018 18:06:56'!
initializeOn: aTerniLapelliGame
	self initializeBoard.
	aTerniLapelliGame addLastPlaceObserver:[:aPlace | self newPlace:aPlace].
	aTerniLapelliGame addLastSlideObserver:[:aSlide | self newSlide:aSlide].
	aTerniLapelliGame addStateObserver:[:newState | self stateChanged:newState].
	
	
	! !


!TerniLapilliView methodsFor: 'observating' stamp: 'eg 11/10/2018 19:19:08'!
newPlace:aPlace
	|lineIndex newLine aPosition aChar|
	
	aChar := aPlace key.
	aPosition := aPlace value.
	
	lineIndex := self indexForY: aPosition y.
	newLine := (board at: lineIndex) copy.
	newLine at:(self indexForX: aPosition x) put:aChar.
	board at:lineIndex put: newLine .
	
	"board at: 6 put: aStateName ."! !

!TerniLapilliView methodsFor: 'observating' stamp: 'eg 11/10/2018 19:22:20'!
newSlide:aSlide

	|lineIndexFrom newLineFrom newLineTo lineIndexTo aChar aPosition anotherPosition|
	
	aChar := aSlide key.
	aPosition:= aSlide value first.
	anotherPosition:= aSlide value second.
	
	lineIndexFrom := self indexForY: aPosition y.
	newLineFrom := (board at: lineIndexFrom) copy.
	newLineFrom at:(self indexForX: aPosition x) put: Character space.

	
	lineIndexTo := self indexForY: anotherPosition y.
	lineIndexFrom = lineIndexTo ifTrue:[ newLineTo := newLineFrom ] ifFalse:[newLineTo := (board at: lineIndexTo) copy].
	newLineTo at:(self indexForX: anotherPosition x) put:aChar.	
	
	board at:lineIndexFrom put: newLineFrom .
	board at:lineIndexTo put: newLineTo .
! !

!TerniLapilliView methodsFor: 'observating' stamp: 'eg 11/10/2018 20:11:35'!
stateChanged: aState
	aState accept: self.
	! !

!TerniLapilliView methodsFor: 'observating' stamp: 'eg 11/10/2018 20:12:34'!
visitPlayingO
	board at: 6 put: 'Playing O'  .! !

!TerniLapilliView methodsFor: 'observating' stamp: 'eg 11/10/2018 20:12:41'!
visitPlayingX
	board at: 6 put: 'Playing X'  .! !

!TerniLapilliView methodsFor: 'observating' stamp: 'eg 11/10/2018 20:08:29'!
visitWinnerO
	board at: 6 put: 'O Won!!'  .! !

!TerniLapilliView methodsFor: 'observating' stamp: 'eg 11/10/2018 20:08:24'!
visitWinnerX
	board at: 6 put: 'X Won!!'  .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliView class' category: #TerniLapilli!
TerniLapilliView class
	instanceVariableNames: ''!

!TerniLapilliView class methodsFor: 'as yet unclassified' stamp: 'eg 11/9/2018 21:02:02'!
on: aTerniLapelli
	^self new initializeOn: aTerniLapelli .! !
