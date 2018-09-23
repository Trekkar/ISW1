!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'imf 9/23/2018 14:10:40'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self AssertThatABlock: [customerBook addCustomerNamed: 'John Lennon'] isExecutedInLessThanMilliseconds: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'if 9/20/2018 20:48:19'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	 
	self AssertThatABlock: [customerBook removeCustomerNamed: paulMcCartney] isExecutedInLessThanMilliseconds: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'if 9/20/2018 21:30:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self aSetOfFailureCollaborations: [ customerBook addCustomerNamed: '' ] 
	OnFailure: Error 
	CheckASetOfAssertions:  [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'if 9/20/2018 21:31:11'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self aSetOfFailureCollaborations: [ customerBook removeCustomerNamed: 'Paul McCartney']
	 OnFailure: NotFound 	
	CheckASetOfAssertions:[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].	

	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'imf 9/23/2018 12:58:37'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	customerBook _ CustomerBook new.
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self
		checkInCustomerBook: customerBook
		NumberOfActiveUsers: 0
		andNumberOfSuspendedCustomers: 1
		andNumberOfCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'imf 9/23/2018 12:58:37'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	customerBook _ CustomerBook new.
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self
		checkInCustomerBook: customerBook
		NumberOfActiveUsers: 0
		andNumberOfSuspendedCustomers: 0
		andNumberOfCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'imf 9/23/2018 13:55:24'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self assertThatCustomerWithName: johnLennon IsInCustomerBook:  customerBook AfterSuspendingACustomerWithName: 'Paul McCartney'.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'imf 9/23/2018 13:55:31'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self assertThatCustomerWithName: johnLennon IsInCustomerBook: customerBook  AfterSuspendingACustomerWithName: johnLennon .
		
! !


!CustomerBookTest methodsFor: 'TimingMethods' stamp: 'if 9/20/2018 20:41:29'!
AssertThatABlock: aBlock isExecutedInLessThanMilliseconds: anAmountOfMilliseconds
	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (anAmountOfMilliseconds)
	! !


!CustomerBookTest methodsFor: 'On-Do Collaborations' stamp: 'if 9/20/2018 21:28:56'!
aSetOfFailureCollaborations: aBlockofCollaborations OnFailure: aFailMessage CheckASetOfAssertions: aBlockOfAssertions	
	[aBlockofCollaborations value. self fail] 
		on: aFailMessage 
		do: aBlockOfAssertions ! !

!CustomerBookTest methodsFor: 'On-Do Collaborations' stamp: 'imf 9/23/2018 12:55:24'!
assertThatCustomerWithName: aCustomerNameInBook IsInCustomerBook: aCustomerBook AfterSuspendingACustomerWithName: aCustomerNameNotInBook
	[ aCustomerBook suspendCustomerNamed: aCustomerNameNotInBook. ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: aCustomerNameInBook) ]! !


!CustomerBookTest methodsFor: 'ConsultInternalCollaborators' stamp: 'imf 9/23/2018 13:02:17'!
checkInCustomerBook: aCustomerBook NumberOfActiveUsers: aNumberOfActiveUsers andNumberOfSuspendedCustomers: aNumberOfSuspendedUsers andNumberOfCustomers: aNumberOfCustomers
	self
		assert: aNumberOfActiveUsers
		equals: aCustomerBook numberOfActiveCustomers.
	self
		assert: aNumberOfSuspendedUsers
		equals: aCustomerBook numberOfSuspendedCustomers.
	self
		assert: aNumberOfCustomers
		equals: aCustomerBook numberOfCustomers.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers suspended'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:28'!
includesCustomerNamed: aName

	^(customers includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:38'!
isEmpty
	
	^customers isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NicolasRinaldi 9/16/2018 21:55:33'!
initialize

	super initialize.
	customers := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'HAW 9/19/2018 08:41:11'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((customers includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'imf 9/23/2018 11:20:40'!
giveAllRegisteredCustomers 
	"Mensaje creado para devolver todos los clientes registrados. Eventualmente si se agrega una nueva categoria de clientes habria que agregarlos aqui"

	|allCustomers |
	allCustomers := OrderedCollection new . 
	allCustomers add: customers . 
	allCustomers add: suspended .
	^allCustomers .! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:57'!
numberOfActiveCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NicolasRinaldi 9/16/2018 22:01:43'!
numberOfCustomers
	
	^customers size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'imf 9/23/2018 14:28:53'!
removeACustomerFromAllCustomerCategories: aCollectionOfCustomerCategories WithTheName: aName
	aCollectionOfCustomerCategories do: [ :aCustomerCategory | | name |
		name _ self
			removeCustomerIfExistsIn: aCustomerCategory
			withName: aName.
		name ifNotEmpty: [ ^ name ]].
	^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'imf 9/23/2018 14:25:29'!
removeCustomerIfExistsIn: aCustomerCategory withName: aName
	| customer |
	customer _ aCustomerCategory
		detect: [ :aCustomer |
			aCustomer = aName ]
		ifNone: [ customer := '' ].
	customer ifNotEmpty: [ aCustomerCategory remove: customer ].
	^ customer.! !

!CustomerBook methodsFor: 'customer management' stamp: 'imf 9/23/2018 12:00:54'!
removeCustomerNamed: aName
	^ self
		removeACustomerFromAllCustomerCategories: self giveAllRegisteredCustomers
		WithTheName: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:27:55'!
suspendCustomerNamed: aName 
	
	(customers includes: aName) ifFalse: [^CantSuspend signal].
	
	customers remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
