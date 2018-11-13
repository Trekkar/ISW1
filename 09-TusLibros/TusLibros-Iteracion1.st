!classDefinition: #CartTest category: #'TusLibros-Iteracion1'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!CartTest methodsFor: 'Testing' stamp: 'if 11/12/2018 21:07:00'!
test01CartHasNoItemsWhenCreated
	|cart|
	
	cart:= self createCartWithCatalog: self createCatalog .
	
	self assert: cart items isEmpty.! !

!CartTest methodsFor: 'Testing' stamp: 'if 11/12/2018 21:10:22'!
test02CartCannotHaveBooksOutOfCatalog
	|cart |
	
	cart:= self createCartWithCatalog: self createCatalog .
	
	
	[cart addAnAmount: 1 ofABook: 'Know Your Meme']
	on: Error
	do:[:anError | 
			self assert: anError messageText = Cart ItemOutOfCatalogMessageError.
			self assert: cart items isEmpty .]! !

!CartTest methodsFor: 'Testing' stamp: 'if 11/12/2018 21:07:31'!
test03CartRemembersBookAfterAddingOneFromCatalog
	|cart |
	
	cart:= self createCartWithCatalog: self createCatalog .
	cart addAnAmount: 1 ofABook: '1984'. 
	
	self assert: cart items size equals: 1.
	self assert: (cart items includes: '1984').! !

!CartTest methodsFor: 'Testing' stamp: 'if 11/12/2018 21:07:42'!
test04CannotAddToCartZeroAmountOfABooks
	|cart|
	
	cart:= self createCartWithCatalog: self createCatalog .
	
	[cart addAnAmount: 0 ofABook: '1984'.] 
	on: Error 
	do: [:anError| 
		self assert: anError messageText = Cart ZeroAmountOfBooksMessageError. 
		self assert: cart items isEmpty.]
	! !

!CartTest methodsFor: 'Testing' stamp: 'if 11/12/2018 21:07:53'!
test05CannotAddToCartANegativeAmountOfABooks
	|cart |
	
	cart:= self createCartWithCatalog: self createCatalog .
	
	[cart addAnAmount: -1 ofABook: '1984'.] 
	on: Error 
	do: [:anError| 
		self assert: anError messageText = Cart NegativeAmountOfBooksMessageError . 
		self assert: cart items isEmpty.]
	! !

!CartTest methodsFor: 'Testing' stamp: 'if 11/12/2018 21:08:12'!
test06BooksInCartIsEqualTheSumOfTheAmountOfTheBooksAdded 
	|cart |
	
	cart:= self createCartWithCatalog: self createCatalog.
	cart addAnAmount: 20 ofABook: '1984'. 
	cart addAnAmount: 1 ofABook: 'Game of Thrones'. 
	
	
	self assert: cart items size equals: (cart items occurrencesOf: '1984') + (cart items occurrencesOf: 'Game of Thrones') . 
	self assert: (cart items includes: '1984').
	self assert: (cart items includes: 'Game of Thrones').
		
	! !

!CartTest methodsFor: 'Testing' stamp: 'if 11/12/2018 21:08:28'!
test07OcurrencesOfBookInCartAreEqualToTheSumOfAddsOfTheBook
	|cart |
	
	cart:= self createCartWithCatalog: self createCatalog .
	cart addAnAmount: 20 ofABook: '1984'. 
	cart addAnAmount: 1 ofABook: '1984'. 
	
	
	self assert: 21 equals: (cart items occurrencesOf: '1984') . 
	self assert: (cart items includes: '1984'). 
	self assert: 21 equals: cart items size.
		
	! !


!CartTest methodsFor: 'support' stamp: 'if 11/12/2018 21:04:03'!
createCartWithCatalog: aCatalog. 

	^Cart newWithCatalog:aCatalog .! !

!CartTest methodsFor: 'support' stamp: 'if 11/12/2018 21:10:49'!
createCatalog
	|catalog| 
	catalog := OrderedCollection new. 
	catalog add: '1984'.  
	catalog add: 'Game of Thrones'.
	^catalog .	! !


!classDefinition: #Cart category: #'TusLibros-Iteracion1'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!Cart methodsFor: 'as yet unclassified' stamp: 'if 11/12/2018 20:39:34'!
addAnAmount: anAmount ofABook: aBook  
	
	self assertAmountOfBooks:anAmount.
	
	catalog detect:[:aBookInCatalog|  aBookInCatalog = aBook] 
		ifFound:[:aBookInCatalog | items add:aBookInCatalog withOccurrences: anAmount] 
		ifNone:[^self error: self class ItemOutOfCatalogMessageError.]
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'if 11/12/2018 19:57:59'!
items
	^items.! !


!Cart methodsFor: 'initialization' stamp: 'if 11/12/2018 20:12:06'!
initializeWith: aCatalog 
	catalog := aCatalog .
	items := Bag new.! !


!Cart methodsFor: 'assertions' stamp: 'if 11/12/2018 20:41:02'!
assertAmountOfBooks:anAmount 
	anAmount = 0 ifTrue:[^self error: self class ZeroAmountOfBooksMessageError .]. 
	anAmount < 0 ifTrue:[self error: self class NegativeAmountOfBooksMessageError]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Iteracion1'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'if 11/12/2018 20:27:29'!
newWithCatalog: aCatalog 
	^self new initializeWith: aCatalog.
	! !


!Cart class methodsFor: 'error messages' stamp: 'if 11/12/2018 20:24:48'!
ItemOutOfCatalogMessageError 
	^'The book does not belong to the catalog'.! !

!Cart class methodsFor: 'error messages' stamp: 'if 11/12/2018 20:41:36'!
NegativeAmountOfBooksMessageError 
	^'Cannot add a negative amount of books to cart'.! !

!Cart class methodsFor: 'error messages' stamp: 'if 11/12/2018 20:37:23'!
ZeroAmountOfBooksMessageError 
	^'Cannot add a zero amount of books to cart'.! !
