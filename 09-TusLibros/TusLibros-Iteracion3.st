!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosSystemTest category: #TusLibros!
TestCase subclass: #TusLibrosSystemTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemTest methodsFor: 'setUp' stamp: 'if 11/22/2018 19:52:38'!
setUp
	testObjectsFactory := StoreTestObjectsFactory new.! !


!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test01TusLibrosSystemCannotCreateCartOnInvalidClientId 
	|tusLibros cartId cartBase cartByUserBase| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	[cartId := tusLibros createCartWithClientID:9999 andPassword:'papa'.] 
	on:Error 
	do: [:anError | 
			self assert: anError messageText = 'Client does not exist.'].
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test02TusLibrosSystemCannotCreateCartOnInvalidPassword
	|tusLibros cartId cartBase cartByUserBase| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	[cartId := tusLibros createCartWithClientID:1 andPassword:'papa'.] 
	on:Error 
	do: [:anError | 
			self assert: anError messageText = 'Invalid password.'].
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test03TusLibrosSystemCanCreateCartOnValidUserAndPassword
	|tusLibros cartId cartBase cartByUserBase| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	cartId := tusLibros createCartWithClientID:1 andPassword:'1234'. 
	
	self assert: (tusLibros listCart: cartId) isEmpty! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test04TusLibrosSystemCannotAddItemsToNotCreatedCart
	|tusLibros cartBase cartByUserBase| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	[tusLibros add: 1 of: 'validBook' toCart: -1]
	on: Error 
	do:[:anError | 
		anError messageText = 'Cannot add items to an invalid cart'].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test05TusLibrosSystemCanAddItemsCreatedCart
	|tusLibros cartId cartBase cartByUserBase| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	cartId := tusLibros createCartWithClientID:1 andPassword:'1234'. 
	tusLibros add: 1 of: 'validBook' toCart: cartId.
	
	self assert: ((tusLibros listCart: cartId) occurrencesOf: 'validBook') equals: 1.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test06TusLibrosSystemCannotAddItemNotSellByTheStoreToCreatedCart
	|tusLibros cartId cartBase cartByUserBase| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	cartId := tusLibros createCartWithClientID:1 andPassword:'1234'. 
	[tusLibros add: 1 of: 'invalidBook' toCart: cartId] 
	on: Error 
	do:[:anError | 
		self assert: anError messageText = 'Item is not in catalog'. 
		"self assert: tusLibros listCart: cartId isEmpty"].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test07TusLibrosSystemCannotListCartOfNotCreatedCart
	|tusLibros cartBase cartByUserBase| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	[tusLibros listCart: 1] 
	on: Error 
	do:[:anError | 
		self assert: anError messageText = 'Cannot list cart of invalid cart id'.].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test08TusLibrosSystemListCartOfEmptyCartIsEmpty
	|tusLibros cartBase cartByUserBase cartId| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	cartId := tusLibros createCartWithClientID:1 andPassword:'1234'. 
	tusLibros listCart: 1.
	
	self assert: (tusLibros listCart: 1) isEmpty .
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 19:22:30'!
test09TusLibrosSystemListCartReturnsTheRightNumberOfItems
	|tusLibros cartBase cartByUserBase cartId| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) andCartBase: cartBase andCartByUserBase: cartByUserBase acceptingItemsOf: (testObjectsFactory defaultCatalog) debitFrom: MerchantProcessor new registeringOn: OrderedCollection new.
	cartId := tusLibros createCartWithClientID:1 andPassword:'1234'. 
	tusLibros add: 1 of: 'validBook' toCart: cartId.
	tusLibros add: 2 of: 'validBook' toCart: cartId.
	tusLibros listCart: 1.
	self assert: ((tusLibros listCart: 1) occurrencesOf: 'validBook') equals: 3.
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 20:42:03'!
test10TusLibrosSystemCanCheckoutCart
	|tusLibros cartBase cartByUserBase cartId| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) 
	andCartBase: cartBase 
	andCartByUserBase: cartByUserBase 
	acceptingItemsOf: (testObjectsFactory defaultCatalog) 
	debitFrom: (MerchantProcessor withDebitBehavior: [ :anAmount :aCreditCard | ])
	registeringOn: OrderedCollection new.
	cartId := tusLibros createCartWithClientID:1 andPassword:'1234'. 
	tusLibros add: 1 of: 'validBook' toCart: cartId.
	tusLibros checkOutACart: cartId 
				withCreditCardNumber: testObjectsFactory notExpiredCreditCardNumber
				ownedBy: testObjectsFactory notExpiredCreditCardOwner
				expiringOn: testObjectsFactory notExpiredMonthOfYear. 
	
	"self assert: (tusLibros listPurchases: cartId) isNotEmpty"
	
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 20:51:08'!
test11TusLibrosSystemCannotCheckoutWithInvalidCart
	|tusLibros cartBase cartByUserBase| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) 
	andCartBase: cartBase 
	andCartByUserBase: cartByUserBase 
	acceptingItemsOf: (testObjectsFactory defaultCatalog) 
	debitFrom: (MerchantProcessor withDebitBehavior: [ :anAmount :aCreditCard | ])
	registeringOn: OrderedCollection new.
	[tusLibros checkOutACart: 1 
				withCreditCardNumber: testObjectsFactory notExpiredCreditCardNumber
				ownedBy: testObjectsFactory notExpiredCreditCardOwner
				expiringOn: testObjectsFactory notExpiredMonthOfYear.]
	on:Error 
	do:[:anError | 
		self assert: anError messageText = 'Cannot checkout with invalid cart']
	
	
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 20:56:37'!
test12TusLibrosSystemCannotCheckoutWithEmptyCart
	|tusLibros cartBase cartByUserBase cartId| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) 
	andCartBase: cartBase 
	andCartByUserBase: cartByUserBase 
	acceptingItemsOf: (testObjectsFactory defaultCatalog) 
	debitFrom: (MerchantProcessor withDebitBehavior: [ :anAmount :aCreditCard | ])
	registeringOn: OrderedCollection new.
	
	cartId := tusLibros createCartWithClientID:1 andPassword:'1234'. 
	
	[tusLibros checkOutACart: 1 
				withCreditCardNumber: testObjectsFactory notExpiredCreditCardNumber
				ownedBy: testObjectsFactory notExpiredCreditCardOwner
				expiringOn: testObjectsFactory notExpiredMonthOfYear.]
	on:Error 
	do:[:anError | 
		self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage . 
		"self assert: (tusLibros listPurchases: clientId) isEmpty."]
	
	
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'nacho 11/23/2018 20:57:00'!
test13TusLibrosSystemCannotCheckoutWithExpiredCard
	|tusLibros cartBase cartByUserBase cartId| 
	cartBase := Dictionary  new.
	cartByUserBase := Dictionary new.
	tusLibros := TusLibrosSystem usingUserBase: (testObjectsFactory defaultUserBase) 
	andCartBase: cartBase 
	andCartByUserBase: cartByUserBase 
	acceptingItemsOf: (testObjectsFactory defaultCatalog) 
	debitFrom: (MerchantProcessor withDebitBehavior: [ :anAmount :aCreditCard | ])
	registeringOn: OrderedCollection new.
	
	cartId := tusLibros createCartWithClientID:1 andPassword:'1234'. 
	tusLibros add: 1 of: 'validBook' toCart: cartId.
	
	[tusLibros checkOutACart: 1 
				withCreditCardNumber: testObjectsFactory notExpiredCreditCardNumber
				ownedBy: testObjectsFactory notExpiredCreditCardOwner
				expiringOn: testObjectsFactory ExpiredMonthOfYear.]
	on:Error 
	do:[:anError | 
		self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage . 
		"self assert: (tusLibros listPurchases: clientId) isEmpty."]
	
	
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'nacho 11/23/2018 18:43:53'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'nacho 11/23/2018 18:44:15'!
occurrencesOf: anItem

	^items occurrencesOf: anItem! !


!Cart methodsFor: 'testing' stamp: 'nacho 11/23/2018 18:44:24'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'nacho 11/23/2018 18:44:21'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'nacho 11/23/2018 18:44:28'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'nacho 11/23/2018 18:44:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	items add:anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'items and quantity' stamp: 'nacho 11/23/2018 18:47:00'!
itemsAndQuanties 
	^items copy
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total client ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'nacho 11/23/2018 20:30:58'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'nacho 11/23/2018 21:05:00'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'nacho 11/23/2018 20:37:40'!
createSaleBy: aCustomer

	^ Sale by: aCustomer of: ticket.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'nacho 11/23/2018 20:37:06'!
createTicket

	ticket:= Ticket withItemsAnQuantities: (cart itemsAndQuanties) andTotal: (cart total).
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'nacho 11/23/2018 20:24:53'!
registerSaleBy: aClientId 

	salesBook add: (self createSaleBy: aClientId)! !


!Cashier methodsFor: 'checkout' stamp: 'nacho 11/23/2018 20:59:32'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !

!Cashier methodsFor: 'checkout' stamp: 'nacho 11/23/2018 20:36:43'!
checkOutWithClient
	
	self createTicket.
	self debitTotal.
	self registerSaleBy: client.
	^ticket! !


!Cashier methodsFor: 'initialization' stamp: 'nacho 11/23/2018 20:23:42'!
initializeToCheckout: aCart byClientId: clientId charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	client := clientId .
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'nacho 11/23/2018 20:23:21'!
toCheckout: aCart byClientId: clientId charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart byClientId: clientId charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit ' stamp: 'if 11/22/2018 20:16:36'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!MerchantProcessor methodsFor: 'initialization' stamp: 'if 11/22/2018 20:18:01'!
initializeWithDebitBehavior: aClosure 
	debitBehavior := aClosure .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #TusLibros!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'initialization' stamp: 'if 11/22/2018 20:17:32'!
withDebitBehavior: aClosure 
	^self new initializeWithDebitBehavior: aClosure.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'clientId ticket total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'nacho 11/23/2018 21:01:56'!
total
	
	^total! !


!Sale methodsFor: 'initialization' stamp: 'nacho 11/23/2018 20:26:58'!
initializeBy: aCustomer of: aTotal 
	clientId := aCustomer . 
	ticket  := aTotal .! !

!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !


!Sale methodsFor: 'customer' stamp: 'nacho 11/23/2018 19:34:05'!
by: aClientId
	^clientId = aClientId ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!Sale class methodsFor: 'as yet unclassified' stamp: 'nacho 11/23/2018 20:26:43'!
by: aCustomer of: aTicket 
	^self new initializeBy: aCustomer of: aTicket ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'if 11/22/2018 20:27:01'!
createCartWithItems
	|cart|
	cart:= Cart acceptingItemsOf: self defaultCatalog. 
	cart add: self itemSellByTheStore. 
	^cart! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'nacho 11/23/2018 20:53:31'!
ExpiredMonthOfYear 
	^(Month month: today monthIndex year: today yearNumber - 1)
	
	! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'nacho 11/23/2018 19:08:48'!
notExpiredCreditCardNumber
	
	^'123456789101112'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'nacho 11/23/2018 19:05:23'!
notExpiredCreditCardOwner
	
	^'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'nacho 11/23/2018 19:07:42'!
notExpiredMonthOfYear 
	^(Month month: today monthIndex year: today yearNumber + 1)
	
	! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'cashier' stamp: 'if 11/22/2018 20:29:01'!
createCashierWithDebitBehaviour: aClosure
	
	^Cashier 
		toCheckout: self createCartWithItems
		charging: self notExpiredCreditCard
		throught: (self merchantProcessorWithDebitBehavior: aClosure)
		on: self today
		registeringOn: self createSalesBook.! !


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'if 11/22/2018 20:28:21'!
merchantProcessorWithDebitBehavior: aClosure 
	^MerchantProcessor withDebitBehavior: aClosure .! !


!StoreTestObjectsFactory methodsFor: 'salesBook' stamp: 'if 11/22/2018 20:29:32'!
createSalesBook 
	^OrderedCollection new.! !


!StoreTestObjectsFactory methodsFor: 'userBase' stamp: 'if 11/22/2018 21:34:27'!
defaultUserBase 
	^ Dictionary new
		at: 1 put: '1234' ;
		yourself ! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'as yet unclassified' stamp: 'nacho 11/23/2018 20:34:03'!
initializeWithItemsAnQuantities: aBag  andTotal: aTotal 
	items := aBag . 
	total := aTotal .! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'nacho 11/23/2018 20:34:30'!
items
	^items! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'nacho 11/23/2018 20:34:22'!
total 
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'as yet unclassified' stamp: 'nacho 11/23/2018 20:33:41'!
withItemsAnQuantities: aBag andTotal: aTotal
	^self new initializeWithItemsAnQuantities: aBag  andTotal: aTotal.! !


!classDefinition: #TusLibrosSystem category: #TusLibros!
Object subclass: #TusLibrosSystem
	instanceVariableNames: 'userBase cartBase cartByUserBase catalog lastCartId merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystem methodsFor: 'cart creation' stamp: 'nacho 11/23/2018 17:09:38'!
createCartId 
	lastCartId  := lastCartId +1. 
	^lastCartId.! !

!TusLibrosSystem methodsFor: 'cart creation' stamp: 'nacho 11/23/2018 18:05:05'!
createCartWithClientID: aClientId andPassword: aPassword 
	|cart cartId|
	self assertClientId:aClientId. 
	self assertClient: aClientId hasPassword: aPassword. 
	cart := Cart acceptingItemsOf: catalog .
	cartId := self createCartId.
	cartByUserBase at: aClientId put: cartId.
	cartBase at: cartId put: cart. 
	^cartId .
	
	
! !


!TusLibrosSystem methodsFor: 'initialization' stamp: 'nacho 11/23/2018 19:24:54'!
initializeWithUserBase: aUserBase andCartBase: aCartBase andCartByUserBase: aCartByUserBase acceptingItemsOf: aCatalog debitFrom: aMerchantProcessor registeringOn: aSalesBook 
	userBase := aUserBase .
	cartBase := aCartBase. 
	cartByUserBase := aCartByUserBase .  
	catalog := aCatalog .
	merchantProcessor := aMerchantProcessor .
	salesBook := aSalesBook .
	lastCartId := 0.! !


!TusLibrosSystem methodsFor: 'assertions' stamp: 'if 11/22/2018 21:45:27'!
assertClient: aClientId hasPassword: aPassword 
	(userBase at: aClientId) = aPassword  ifFalse:[^self error: 'Invalid password.']! !

!TusLibrosSystem methodsFor: 'assertions' stamp: 'if 11/22/2018 21:45:03'!
assertClientId: aClientId 
	userBase at:aClientId ifAbsent:[^self error: 'Client does not exist.']! !


!TusLibrosSystem methodsFor: 'catalog' stamp: 'if 11/22/2018 21:14:09'!
defaultCatalog	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself 
	! !


!TusLibrosSystem methodsFor: 'items' stamp: 'if 11/22/2018 21:14:37'!
itemSellByTheStore 
	^'valid book'! !

!TusLibrosSystem methodsFor: 'items' stamp: 'if 11/22/2018 21:14:51'!
itemSellByTheStorePrice 
	^10.! !


!TusLibrosSystem methodsFor: 'user base' stamp: 'if 11/22/2018 21:30:22'!
defaultUserBase 
	^ Dictionary new
		at: 99 put: '1234' ;
		yourself ! !


!TusLibrosSystem methodsFor: 'add items' stamp: 'nacho 11/23/2018 18:04:14'!
add: aQuantity of: aBook toCart: cartId 
	|cart|
	cart := cartBase at: cartId ifAbsent:[^self error:'Cannot add items to invalid cart.']. 
	cart add: aQuantity of: aBook.
! !


!TusLibrosSystem methodsFor: 'list cart' stamp: 'nacho 11/23/2018 18:33:59'!
listCart: aCartId 
	|cart|
	cart := cartBase at: aCartId ifAbsent:[^self error: 'Cannot list cart of invalid cart id'].
	^cart itemsAndQuanties .
	! !


!TusLibrosSystem methodsFor: 'checkout' stamp: 'nacho 11/23/2018 20:54:46'!
checkOutACart: cartId withCreditCardNumber: aCreditCardNumber ownedBy: aCreditCardOwner expiringOn: aMonthOfYear 
	|cashier cart clientId|
	
	cart:= cartBase at: cartId ifAbsent:[^self error: 'Cannot checkout with invalid cart' ].
	clientId := cartByUserBase at: cartId ifAbsent:[^self error: 'Cannot checkout with invalid cart' ].	
	cashier := Cashier toCheckout: cart
				byClientId: clientId 
				charging: (CreditCard expiringOn: aMonthOfYear) 
				throught: merchantProcessor 
				on: Date today 
				registeringOn: salesBook.
	cashier checkOutWithClient.
				
	

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystem class' category: #TusLibros!
TusLibrosSystem class
	instanceVariableNames: ''!

!TusLibrosSystem class methodsFor: 'initialization' stamp: 'nacho 11/23/2018 19:23:44'!
usingUserBase: userBase andCartBase: aCartBase andCartByUserBase: aCartByUserBase acceptingItemsOf: aCatalog debitFrom: aMerchantProcessor registeringOn: salesBook 
	^self new initializeWithUserBase: userBase andCartBase: aCartBase andCartByUserBase: aCartByUserBase acceptingItemsOf: aCatalog debitFrom: aMerchantProcessor registeringOn: salesBook! !
