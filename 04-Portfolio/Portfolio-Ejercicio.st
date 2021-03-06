!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'if 10/11/2018 21:11:48'!
netValue 
 	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'if 10/11/2018 21:11:58'!
netValue 
	^value ! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'if 10/11/2018 21:12:07'!
netValue 
	^-1*value ! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'EG 10/14/2018 17:43:00'!
doesManageOrThereIsAnAccountFrom: anAccount
	self subclassResponsibility .! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'EG 10/14/2018 16:03:58'!
transactionsOf: anAccount

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'if 10/11/2018 21:25:02'!
balance
		^accounts inject: 0 into: [:balance :anAccount | balance + anAccount balance ]. 
! !


!Portfolio methodsFor: 'testing' stamp: 'EG 10/14/2018 17:47:08'!
doesManage: anAccount	
	^self = anAccount  or: [accounts anySatisfy: [:aSummerizingAccount | aSummerizingAccount doesManage: anAccount]]! !

!Portfolio methodsFor: 'testing' stamp: 'EG 10/14/2018 17:45:37'!
doesManageOrThereIsAnAccountFrom: anAccount
	^self = anAccount  or: [accounts anySatisfy: [:aSummerizingAccount | (aSummerizingAccount doesManageOrThereIsAnAccountFrom: anAccount) or: [anAccount doesManageOrThereIsAnAccountFrom: aSummerizingAccount ]]]! !

!Portfolio methodsFor: 'testing' stamp: 'if 10/11/2018 21:28:44'!
hasRegistered: aTransaction

	^accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction ]! !


!Portfolio methodsFor: 'transactions' stamp: 'EG 10/14/2018 17:43:41'!
transactions 

	|transactions |
	transactions := OrderedCollection  new. 
	accounts do:[:anAccount | transactions addAll: anAccount transactions ].
	^transactions 
	

! !

!Portfolio methodsFor: 'transactions' stamp: 'EG 10/14/2018 16:11:20'!
transactionsOf: anAccount 
	
	accounts detect: [:aSummarizingAccount | aSummarizingAccount  doesManage:anAccount ] ifNone:[^self error: self class accountNotManagedMessageDescription ].
	^anAccount transactions .! !


!Portfolio methodsFor: 'initialization' stamp: 'if 10/11/2018 21:25:47'!
initializeWith: aCollectionOfAccounts 
	accounts := OrderedCollection new.
	accounts addAll: aCollectionOfAccounts ! !

!Portfolio methodsFor: 'initialization' stamp: 'if 10/11/2018 21:25:55'!
initializeWith: leftAccount with:rightAccount 
	accounts := OrderedCollection new.
	accounts  add: leftAccount . 
	accounts  add: rightAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'EG 10/14/2018 17:21:06'!
with: leftAccount with: rightAccount
	
	(self checkDifferentAccount:leftAccount andAccount:rightAccount) ifFalse:[^self new initializeWith: leftAccount with:rightAccount].
	^self error: self accountAlreadyManagedErrorMessage.
	
	 ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'if 10/11/2018 21:22:55'!
withAll: aCollectionOfAccounts

	^self new initializeWith: aCollectionOfAccounts .! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!Portfolio class methodsFor: 'as yet unclassified' stamp: 'EG 10/14/2018 17:42:22'!
checkDifferentAccount:leftAccount andAccount:rightAccount
	^(leftAccount doesManageOrThereIsAnAccountFrom: rightAccount)  or: [ (rightAccount doesManageOrThereIsAnAccountFrom: leftAccount )  or:  [ leftAccount = rightAccount .]]! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'EG 10/14/2018 15:59:06'!
balance
	
	^transactions inject: 0 into: [:balance :aTransaction | balance + aTransaction netValue]. 
	
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'EG 10/14/2018 17:46:15'!
doesManageOrThereIsAnAccountFrom: anAccount
	^ self = anAccount ! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !
