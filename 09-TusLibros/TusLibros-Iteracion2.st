!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'if 11/15/2018 19:46:38'!
defaultCatalog
	
	|dictonary|
	dictonary := Dictionary new.
	dictonary at:self itemSellByTheStore put:10.
	^ dictonary .! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 18:39:06'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 19:27:10'!
defaultCatalog
	
	|dictonary|
	dictonary := Dictionary new.
	dictonary at:self itemSellByTheStore put:10.
	^ dictonary .! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 18:40:06'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 18:39:47'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 20:44:54'!
test01CannotCheckoutAnEmptyCart
	|cashier cart card|
	
	cart:= self createCart .
	cashier := Cashier with: cart. 	
	card:= CreditCard withOwner: 'Ignacio Fernandez' andNumber:39988456 andExpirationDate: (GregorianMonthOfYear year:2010 month:January).
		
	[cashier checkoutWithCard: card ]
	on:Error
	do:[:anError | 
		self assert: anError messageText  = 'El carrito está vacío'.
		self assert: cart isEmpty .]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 20:45:07'!
test02CheckoutTicketOfOneItemCartShouldBeThePriceOfTheItem
	|cashier cart card finalPrice|
	
	cart:= self createCart .
	cart add:1 of:self itemSellByTheStore. 
	cashier := Cashier with: cart. 	
	card:= CreditCard withOwner: 'Ignacio Fernandez' andNumber:39988456 andExpirationDate: (GregorianMonthOfYear year:2010 month:January).
		
	finalPrice := cashier checkoutWithCard: card .
	
	self assert: finalPrice equals: 10.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 20:45:13'!
test03CheckoutTicketShouldBeTheSumOfTheItemsPrices
	|cashier cart card finalPrice|
	
	cart:= self createCart .
	cart add:3 of:self itemSellByTheStore. 
	cashier := Cashier with: cart. 	
	card:= CreditCard withOwner: 'Ignacio Fernandez' andNumber:39988456 andExpirationDate: (GregorianMonthOfYear year:2010 month:January).
		
	finalPrice := cashier checkoutWithCard: card .
	
	self assert: finalPrice equals: 30.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 21:03:55'!
test04CannotCheckoutWithAnExpiredCreditCard
	|cashier cart card|
	
	cart:= self createCart .
	cart add:1 of:self itemSellByTheStore. 
	cashier := Cashier with: cart. 	
	card:= CreditCard withOwner: 'Ignacio Fernandez' andNumber:39988456 andExpirationDate: (GregorianMonthOfYear year:2010 month:01).
		
	[cashier checkoutWithCard: card ]
	on:Error
	do:[:anError | 
		self assert: anError messageText equals: Cashier expiredCardErrorMessage.]! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'if 11/15/2018 19:45:33'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 19:42:11'!
summary
	^items inject: 0 into:[:finalPrice :anItem | finalPrice + catalog at:anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 19:11:07'!
assertCartIsNotEmpty
	cart isEmpty ifTrue:[^self error: self class cartIsEmptyError].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 21:02:55'!
assertValidCard: aCard 
	(aCard isExpiredOn: (FixedGregorianDate today)) ifTrue:[^self error: self class expiredCardErrorMessage]! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 20:30:44'!
checkoutWithCard: aCard
	self assertCartIsNotEmpty.
	self assertValidCard: aCard.
	
	^cart summary.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 18:44:08'!
initializeWith: aCart
	cart := aCart .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 19:11:42'!
cartIsEmptyError
	^'El carrito está vacío'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 21:03:15'!
expiredCardErrorMessage
	^'La tarjeta está vencida.'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 19:15:51'!
with: aCart
	^self new initializeWith:aCart.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 20:32:08'!
expirationDate 
	^expirationDate .! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 18:57:16'!
initializeWithOwner: anOwner andNumber: aNumber andExpirationDate: anExpirationDate 
	owner := anOwner .
	number := aNumber .
	expirationDate := anExpirationDate .! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 20:58:36'!
isExpiredOn: aGregorianDate 
	^ expirationDate < (GregorianMonthOfYear year: (aGregorianDate year number) month: (aGregorianDate month number))
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'if 11/15/2018 20:37:00'!
withOwner: anOwner andNumber: aNumber andExpirationDate: anExpirationDate
	^self new initializeWithOwner: anOwner andNumber: aNumber andExpirationDate: anExpirationDate .! !
