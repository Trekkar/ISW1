!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:53:46'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:53:58'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectFactory createCart.
	
	self 
		should: [ cart add: testObjectFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:54:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectFactory createCart.
	
	cart add: testObjectFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:54:17'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:54:24'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:54:33'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectFactory createCart.
	
	cart add: testObjectFactory itemSellByTheStore.
	self assert: (cart includes: testObjectFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:54:44'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectFactory createCart.
	
	self deny: (cart includes: testObjectFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:54:53'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectFactory createCart.
	
	cart add: 2 of: testObjectFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setUp' stamp: 'nacho 11/17/2018 16:53:13'!
setUp 
	testObjectFactory := TestObjectFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'transaction testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp' stamp: 'nacho 11/17/2018 17:01:41'!
setUp 
	testObjectFactory := TestObjectFactory new.
	transaction := [:aDebitedAmount :aDebitedCreditCard].! !


!CashierTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:56:06'!
test01CannotCheckoutAnEmptyCart
	|cashier cart card salesBook|
	
	cart:= testObjectFactory createCart .
	salesBook := OrderedCollection new.
	card:= testObjectFactory createNotExpiredCreditCard.
	
	cashier := Cashier ToCheckout: cart
				 withCreditCard: card 
				through: self 
				onSalesBook: salesBook. 
				
	[cashier checkoutWithCard: card ]
	on:Error
	do:[:anError | 
		self assert: anError messageText  = 'El carrito está vacío'.
		self assert: salesBook isEmpty.]! !

!CashierTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:56:34'!
test02CheckoutTicketOfOneItemCartShouldBeThePriceOfTheItem
	|cashier cart card finalPrice salesBook|
	
	cart:= testObjectFactory createCart .
	cart add:1 of: testObjectFactory itemSellByTheStore. 
	salesBook := OrderedCollection new.	
	card:= testObjectFactory createNotExpiredCreditCard .
	cashier := Cashier ToCheckout: cart
				 withCreditCard: card 
				through: self 
				onSalesBook: salesBook. 
		
	finalPrice := cashier checkoutWithCard: card .
	
	self assert: finalPrice equals: 10.
	self deny: salesBook isEmpty .! !

!CashierTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:57:43'!
test03CheckoutTicketShouldBeTheSumOfTheItemsPrices
	|cashier cart card finalPrice salesBook|
	
	cart:= testObjectFactory createCart .
	cart add:3 of:testObjectFactory itemSellByTheStore. 
	salesBook := OrderedCollection new.
	card:= testObjectFactory createNotExpiredCreditCard .
	cashier := Cashier ToCheckout: cart
				 withCreditCard: card 
				through: self 
				onSalesBook: salesBook. 
		
	finalPrice := cashier checkoutWithCard: card .
	
	self assert: finalPrice equals: 30. 
	self deny: salesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:58:01'!
test04CannotCheckoutWithAnExpiredCreditCard
	|cashier cart card salesBook|
	
	cart:= testObjectFactory createCart .
	cart add:1 of: testObjectFactory itemSellByTheStore. 
	salesBook := OrderedCollection new.	
	card:= testObjectFactory createExpiredCreditCard .
	cashier := Cashier ToCheckout: cart
				 withCreditCard: card 
				through: self 
				onSalesBook: salesBook. 
		
	[cashier checkoutWithCard: card ]
	on:Error
	do:[:anError | 
		self assert: anError messageText equals: Cashier expiredCardErrorMessage.
		self assert: salesBook isEmpty. 
		self assert: cashier interactedWithMerchantProcessor equals: false]! !

!CashierTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:58:20'!
test05CheckoutRegistersASale
	|cashier cart card finalPrice salesBook|
	
	cart:= testObjectFactory createCart .
	cart add:3 of:testObjectFactory itemSellByTheStore. 
	salesBook := OrderedCollection new.
	card:= testObjectFactory createNotExpiredCreditCard .
	cashier := Cashier ToCheckout: cart
				 withCreditCard: card 
				through: self 
				onSalesBook: salesBook. 
		
	finalPrice := cashier checkoutWithCard: card .
	
	self assert: finalPrice equals: cashier lastSale.
	self assert: cashier interactedWithMerchantProcessor equals: true! !

!CashierTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 17:07:22'!
test06CannotCheckoutWithCreditCardWithInsufficientFunds
	|cashier cart card salesBook|
	
	cart:= testObjectFactory createCart .
	cart add:1 of:testObjectFactory itemSellByTheStore. 
	salesBook := OrderedCollection new.	
	card:= testObjectFactory createNotExpiredCreditCard .
	cashier := Cashier ToCheckout: cart
				 withCreditCard: card 
				through: self 
				onSalesBook: salesBook. 
	transaction := [:aDebitedAmount :aDebitedCreditCard |  self error: 'La tarjeta no tiene fondos'.].
		
	[cashier checkoutWithCard: card ]
	on:Error
	do:[:anError | 
		self assert: anError messageText equals: Cashier creditCardWithInsufficientFundsErrorMessage.
		self assert: salesBook isEmpty.
		self assert: cashier interactedWithMerchantProcessor equals: true ]! !

!CashierTest methodsFor: 'tests' stamp: 'nacho 11/17/2018 16:59:07'!
test07CashierDebitsFromCardUsingMerchantProcessor
	|cashier cart card finalPrice salesBook debitedAmount debitedCreditCard |
	
	cart:= testObjectFactory createCart .
	cart add:3 of:testObjectFactory itemSellByTheStore. 
	salesBook := OrderedCollection new.
	card:= testObjectFactory createNotExpiredCreditCard .
	cashier := Cashier ToCheckout: cart
				 withCreditCard: card 
				through: self 
				onSalesBook: salesBook. 
	
	transaction := [:aDebitedAmount :aDebitedCreditCard | debitedAmount := aDebitedAmount . debitedCreditCard  := aDebitedCreditCard ].	
	
	finalPrice := cashier checkoutWithCard: card .
	
	self assert: cashier lastSale = finalPrice .
	self assert: cashier interactedWithMerchantProcessor equals: true.
	self assert: debitedAmount = finalPrice. 
	self assert: debitedCreditCard = card .! !


!CashierTest methodsFor: 'merchantProcessor simulation' stamp: 'nacho 11/17/2018 16:34:39'!
debit: summary from: aCard  
	transaction value: summary value: aCard.
	! !


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
	instanceVariableNames: 'cart creditcard salesBook merchantProcessor interactedWithMerchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'if 11/15/2018 19:11:07'!
assertCartIsNotEmpty
	cart isEmpty ifTrue:[^self error: self class cartIsEmptyError].! !

!Cashier methodsFor: 'assertions' stamp: 'if 11/15/2018 21:02:55'!
assertValidCard: aCard 
	(aCard isExpiredOn: (FixedGregorianDate today)) ifTrue:[^self error: self class expiredCardErrorMessage]! !


!Cashier methodsFor: 'private operations' stamp: 'nacho 11/17/2018 16:17:46'!
interactedWithMerchantProcessor 
	^interactedWithMerchantProcessor ! !

!Cashier methodsFor: 'private operations' stamp: 'nacho 11/17/2018 15:17:27'!
lastSale 
	^salesBook last total.! !

!Cashier methodsFor: 'private operations' stamp: 'nacho 11/17/2018 13:15:34'!
registerSaleWith: aSummary
	salesBook add: (Sale with: aSummary).! !


!Cashier methodsFor: 'initialization' stamp: 'nacho 11/17/2018 16:07:15'!
initializeToCheckout: aCart withCreditCard: aCreditCard through: aMerchantProcessor onSalesBook: aSalesBook 
	cart := aCart . 
	creditcard := aCreditCard . 
	merchantProcessor := aMerchantProcessor . 
	salesBook := aSalesBook. 
	interactedWithMerchantProcessor := false.
	! !


!Cashier methodsFor: 'public operations' stamp: 'nacho 11/17/2018 16:24:16'!
checkoutWithCard: aCard
	|summary|
	self assertCartIsNotEmpty.
	self assertValidCard: aCard.
	summary := cart summary .
	interactedWithMerchantProcessor := true.
	merchantProcessor debit: summary from: aCard.
	self registerSaleWith: summary .
	^summary.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'nacho 11/17/2018 15:11:17'!
ToCheckout: aCart withCreditCard: aCreditCard through: aMerchantProcessor onSalesBook: aSalesBook 
	^self new initializeToCheckout: aCart withCreditCard: aCreditCard through: aMerchantProcessor onSalesBook: aSalesBook.! !


!Cashier class methodsFor: 'error messages' stamp: 'if 11/15/2018 19:11:42'!
cartIsEmptyError
	^'El carrito está vacío'! !

!Cashier class methodsFor: 'error messages' stamp: 'nacho 11/17/2018 15:40:38'!
creditCardWithInsufficientFundsErrorMessage
	^'La tarjeta no tiene fondos'! !

!Cashier class methodsFor: 'error messages' stamp: 'if 11/15/2018 21:03:15'!
expiredCardErrorMessage
	^'La tarjeta está vencida.'! !


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

!CreditCard class methodsFor: 'assertions' stamp: 'nacho 11/17/2018 15:57:36'!
assertValidCreditCardNumber: aCreditCardNumber 
	(aCreditCardNumber numberOfDigitsInBase: 10) = 16 ifFalse:[^self error: self invalidCreditCardNumber]! !

!CreditCard class methodsFor: 'assertions' stamp: 'nacho 11/17/2018 15:32:02'!
assertValidExpitationDate: anExpirationDate
	(anExpirationDate isKindOf: GregorianMonthOfYear ) ifFalse:[^self error: self invalidExpirationDateErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'nacho 11/17/2018 15:32:34'!
assertValidOwner: anOwner 
	anOwner isEmpty ifTrue:[^self error: self invalidOwnerErrorMessage.]! !


!CreditCard class methodsFor: 'instance creation' stamp: 'nacho 11/17/2018 15:34:59'!
withOwner: anOwner andNumber: aNumber andExpirationDate: anExpirationDate
	self assertValidOwner: anOwner. 
	self assertValidCreditCardNumber: aNumber .
	self assertValidExpitationDate: anExpirationDate .
	^self new initializeWithOwner: anOwner andNumber: aNumber andExpirationDate: anExpirationDate .! !


!CreditCard class methodsFor: 'message errors' stamp: 'nacho 11/17/2018 15:33:55'!
invalidCreditCardNumber 
	^'Credit card number is invalid'! !

!CreditCard class methodsFor: 'message errors' stamp: 'nacho 11/17/2018 15:33:15'!
invalidExpirationDateErrorMessage 
	^'ExpirationDate format is invalid'! !

!CreditCard class methodsFor: 'message errors' stamp: 'nacho 11/17/2018 15:32:56'!
invalidOwnerErrorMessage 
	^'Owner cannot be empty'! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'as yet unclassified' stamp: 'nacho 11/17/2018 13:16:55'!
initializeWith: aSummary 
	total := aSummary ! !

!Sale methodsFor: 'as yet unclassified' stamp: 'nacho 11/17/2018 15:17:36'!
total 
	^total ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'as yet unclassified' stamp: 'nacho 11/17/2018 13:16:34'!
with: aSummary 
	^self new initializeWith: aSummary.! !


!classDefinition: #TestObjectFactory category: #TusLibros!
Object subclass: #TestObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectFactory methodsFor: 'cart' stamp: 'nacho 11/17/2018 16:46:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!TestObjectFactory methodsFor: 'items' stamp: 'nacho 11/17/2018 16:47:32'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestObjectFactory methodsFor: 'items' stamp: 'nacho 11/17/2018 16:47:51'!
itemSellByTheStore
	
	^ 'validBook'! !


!TestObjectFactory methodsFor: 'credit card' stamp: 'nacho 11/17/2018 16:49:22'!
createExpiredCreditCard

	^CreditCard withOwner: 'Ignacio Fernandez' andNumber:3998845612345678 andExpirationDate: (GregorianMonthOfYear year:2010 month:January).! !

!TestObjectFactory methodsFor: 'credit card' stamp: 'nacho 11/17/2018 16:48:48'!
createNotExpiredCreditCard

	^CreditCard withOwner: 'Ignacio Fernandez' andNumber:3998845612345678 andExpirationDate: (GregorianMonthOfYear year:2020month:January).! !


!TestObjectFactory methodsFor: 'catalog' stamp: 'nacho 11/17/2018 16:47:19'!
defaultCatalog
	
	|dictonary|
	dictonary := Dictionary new.
	dictonary at:self itemSellByTheStore put:10.
	^ dictonary .! !
