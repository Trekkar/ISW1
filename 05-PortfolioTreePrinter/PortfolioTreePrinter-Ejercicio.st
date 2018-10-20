!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'transactions printing' stamp: 'nacho 10/20/2018 19:16:36'!
printCertificateOfDepositWithValue: anAmount during: aNumberOfDays at: anInterestRate 
	^'Plazo fijo por ' , anAmount printString , ' durante ',  aNumberOfDays printString, ' dias a una tna de ', (anInterestRate*100) printString,'%'. ! !

!AccountSummary methodsFor: 'transactions printing' stamp: 'nacho 10/20/2018 18:10:09'!
printDepositWithValue: aValue  
	^'Deposito por ' , aValue printString .
	! !

!AccountSummary methodsFor: 'transactions printing' stamp: 'nacho 10/20/2018 18:10:19'!
printTransferDepositWithValue: aValue  
	^'Transferencia por ' , aValue printString.
	! !

!AccountSummary methodsFor: 'transactions printing' stamp: 'nacho 10/20/2018 18:10:23'!
printTransferWithdrawWithValue: aValue  
	^'Transferencia por -' , aValue printString.
	! !

!AccountSummary methodsFor: 'transactions printing' stamp: 'nacho 10/20/2018 18:10:28'!
printWithdrawWithValue: aValue  
	^'Extraccion por ' , aValue printString.
	! !


!AccountSummary methodsFor: 'printing' stamp: 'nacho 10/20/2018 18:01:23'!
accountSummaryOf: anAccount 

	^anAccount summaryOn: self.

	! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'account summary' stamp: 'nacho 10/20/2018 18:02:04'!
printTransaction: anAccountSummary 
	self subclassResponsibility .! !


!AccountTransaction methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 18:32:49'!
transferNet: aTransferNet 
	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'investmentNet' stamp: 'nacho 10/20/2018 19:07:51'!
investmentNet: anInvestmentNet 
	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'investmentEarning' stamp: 'nacho 10/20/2018 19:23:59'!
investmentEarning: anInvestmentEarning 
	self subclassResponsibility 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value during interestrate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'nacho 10/20/2018 18:56:23'!
initializeWithValue: anAmount WithDays: aNumberOfDays WithInterest: anInterestRate  
	value  := anAmount . 
	during := aNumberOfDays . 
	interestrate := anInterestRate .! !


!CertificateOfDeposit methodsFor: 'account summary' stamp: 'nacho 10/20/2018 19:00:25'!
printTransaction: anAccountSummary 
	^anAccountSummary printCertificateOfDepositWithValue: self value during: self during at: self interestRate .! !


!CertificateOfDeposit methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 19:03:03'!
transferNet: aTransferNet 
	^aTransferNet aZeroTransferNet .! !


!CertificateOfDeposit methodsFor: 'accesing' stamp: 'nacho 10/20/2018 18:57:38'!
during	 
	^during ! !

!CertificateOfDeposit methodsFor: 'accesing' stamp: 'nacho 10/20/2018 18:57:45'!
interestRate	 
	^interestrate ! !

!CertificateOfDeposit methodsFor: 'accesing' stamp: 'nacho 10/20/2018 18:57:31'!
value 	 
	^value ! !


!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'nacho 10/20/2018 18:58:43'!
affectBalance: currentBalance 
	^currentBalance - value! !


!CertificateOfDeposit methodsFor: 'investmentNet' stamp: 'nacho 10/20/2018 19:09:29'!
investmentNet: anInvestmentNet  
	^anInvestmentNet investmentNetOfCertificateOfDepositWithValue: self value ! !


!CertificateOfDeposit methodsFor: 'investmentEarning' stamp: 'nacho 10/20/2018 19:25:52'!
investmentEarning: anInvestmentEarning  
	^anInvestmentEarning investmentEarningOfCertificateOfDepositWithValue: self value during: self during at: self interestRate .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'nacho 10/20/2018 18:55:22'!
withAmount:anAmount during:aNumberOfDays at:anInteresRate  
	^self new initializeWithValue: anAmount WithDays: aNumberOfDays WithInterest: anInteresRate .! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:00'!
affectBalance: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'account summary' stamp: 'nacho 10/20/2018 18:03:17'!
printTransaction: anAccountSummary 
	^anAccountSummary printDepositWithValue: self value .! !


!Deposit methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 18:35:17'!
transferNet: aTransferNet  
	^aTransferNet aZeroTransferNet.! !


!Deposit methodsFor: 'investmentNet' stamp: 'nacho 10/20/2018 19:09:20'!
investmentNet: anInvestmentNet   
	^anInvestmentNet aZeroInvestmentNet! !


!Deposit methodsFor: 'investmentEarning' stamp: 'nacho 10/20/2018 19:26:39'!
investmentEarning: anInvestmentEarning  
	^anInvestmentEarning aZeroInvestmentEarning! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'transfer' stamp: 'if 10/18/2018 20:41:00'!
transfer 
	^transfer! !


!TransferLeg methodsFor: 'account summary' stamp: 'nacho 10/20/2018 18:03:53'!
printTransaction: anAccountSummary 
	self subclassResponsibility .! !


!TransferLeg methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 18:33:24'!
transferNet: aTransferNet  
	self subclassResponsibility ! !


!TransferLeg methodsFor: 'investmentNet' stamp: 'nacho 10/20/2018 19:09:53'!
investmentNet: anInvestmentNet   
	^anInvestmentNet aZeroInvestmentNet! !


!TransferLeg methodsFor: 'investmentEarning' stamp: 'nacho 10/20/2018 19:27:11'!
investmentEarning: anInvestmentEarning  
	^anInvestmentEarning aZeroInvestmentEarning! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'if 10/18/2018 20:48:51'!
for: aTransfer 
	self subclassResponsibility .! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'value' stamp: 'if 10/18/2018 19:51:32'!
affectBalance: currentBalance
	^currentBalance + transfer value! !

!TransferDeposit methodsFor: 'value' stamp: 'if 10/18/2018 20:04:42'!
value 
	^transfer  value.! !


!TransferDeposit methodsFor: 'initialization' stamp: 'if 10/18/2018 19:50:04'!
initializeWith: aTransfer 
	transfer := aTransfer .! !


!TransferDeposit methodsFor: 'account summary' stamp: 'nacho 10/20/2018 18:04:18'!
printTransaction: anAccountSummary 
	^anAccountSummary printTransferDepositWithValue: self value .! !


!TransferDeposit methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 18:34:44'!
transferNet: aTransferNet 
	^aTransferNet transferOfTransferDepositWithValue: transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'if 10/18/2018 21:01:24'!
For: aTransfer 
	^self new initializeWith: aTransfer .! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'if 10/18/2018 19:51:44'!
affectBalance: currentBalance
	^currentBalance  - transfer value.! !

!TransferWithdraw methodsFor: 'value' stamp: 'if 10/18/2018 20:04:51'!
value 
	^transfer  value.! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'if 10/18/2018 19:50:39'!
initializeWith: aTransfer 
	transfer := aTransfer .! !


!TransferWithdraw methodsFor: 'account summary' stamp: 'nacho 10/20/2018 18:04:44'!
printTransaction: anAccountSummary 
	^anAccountSummary printTransferWithdrawWithValue: self value .! !


!TransferWithdraw methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 18:36:40'!
transferNet: aTransferNet 
	^aTransferNet transferOfTransferWithdrawWithValue: transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'if 10/18/2018 21:01:44'!
For: aTransfer 
	^self new initializeWith: aTransfer .! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'account summary' stamp: 'nacho 10/20/2018 18:03:30'!
printTransaction: anAccountSummary 
	^anAccountSummary printWithdrawWithValue: self value.! !


!Withdraw methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 18:36:09'!
transferNet: aTransferNet  
	^aTransferNet aZeroTransferNet.! !


!Withdraw methodsFor: 'investmentNet' stamp: 'nacho 10/20/2018 19:10:07'!
investmentNet: anInvestmentNet   
	^anInvestmentNet aZeroInvestmentNet! !


!Withdraw methodsFor: 'investmentEarning' stamp: 'nacho 10/20/2018 19:27:21'!
investmentEarning: anInvestmentEarning  
	^anInvestmentEarning aZeroInvestmentEarning! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #InvestmentEarning category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #InvestmentEarning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarning methodsFor: 'earnings' stamp: 'nacho 10/20/2018 19:21:44'!
investmentEarningsOf: aReceptiveAccount 
	^aReceptiveAccount investmentEarningOfTransactionsOn: self.! !


!InvestmentEarning methodsFor: 'transaction investmentEarnings' stamp: 'nacho 10/20/2018 19:27:43'!
aZeroInvestmentEarning 
	^0.! !

!InvestmentEarning methodsFor: 'transaction investmentEarnings' stamp: 'nacho 10/20/2018 19:29:17'!
investmentEarningOfCertificateOfDepositWithValue: anAmount during: aNumberOfDays at: anInterestRate 
	^(anAmount *(anInterestRate/360))* aNumberOfDays ! !


!classDefinition: #InvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #InvestmentNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNet methodsFor: 'investment' stamp: 'nacho 10/20/2018 19:05:55'!
investmentNetOf: anAccount 
	^anAccount investmentNetOfTransactionsOn: self! !


!InvestmentNet methodsFor: 'transactions investmentNet' stamp: 'nacho 10/20/2018 19:10:39'!
aZeroInvestmentNet 
 	^0.! !

!InvestmentNet methodsFor: 'transactions investmentNet' stamp: 'nacho 10/20/2018 19:11:43'!
investmentNetOfCertificateOfDepositWithValue: anAmount 
	^anAmount ! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'summary' stamp: 'nacho 10/20/2018 18:11:47'!
summaryOn: anAccountSummary 
 	|summary| 
	summary := OrderedCollection  new.
	self transactions do: [:aTransaction|  summary add: (aTransaction printTransaction:anAccountSummary)].
	^summary ! !


!SummarizingAccount methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 18:41:44'!
transferNetTransactionsOn: aTransferNet  
	
	^self transactions inject: 0 into: [:netValue :aTransaction | netValue  + (aTransaction transferNet: aTransferNet) ].
	! !


!SummarizingAccount methodsFor: 'investmentNet' stamp: 'nacho 10/20/2018 19:12:28'!
investmentNetOfTransactionsOn: anInvestmentNet 
	^self transactions inject:0 into: [:netValue :aTransaction | netValue + (aTransaction investmentNet: anInvestmentNet )]! !


!SummarizingAccount methodsFor: 'investmentEarning' stamp: 'nacho 10/20/2018 19:23:19'!
investmentEarningOfTransactionsOn: anInvestmentEarning 
	^self transactions inject: 0 into: [:earnings :aTransaction | earnings + (aTransaction investmentEarning: anInvestmentEarning )] ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 10/18/2018 16:31:24'!
transactionsOf: anAccount 

	^ (self doesManage: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/18/2018 18:49:23'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'if 10/18/2018 21:02:01'!
initializeWith: anAmount 
	value := anAmount . 
	withdrawLeg := (TransferWithdraw For: self) .
	depositLeg := (TransferDeposit For: self) .
	! !


!Transfer methodsFor: 'value' stamp: 'if 10/18/2018 19:45:53'!
affectBalance: currentBalance
 	self subclassResponsibility .! !

!Transfer methodsFor: 'value' stamp: 'if 10/18/2018 19:45:26'!
value 
	^value! !


!Transfer methodsFor: 'transfers' stamp: 'if 10/18/2018 19:57:10'!
depositLeg 
	^depositLeg ! !

!Transfer methodsFor: 'transfers' stamp: 'if 10/18/2018 19:57:42'!
withdrawLeg
	^withdrawLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'if 10/18/2018 20:55:12'!
withAmount: anAmount from:fromAccount to: toAccount  

	|transfer|
	transfer := self new initializeWith: anAmount.
	fromAccount register: transfer withdrawLeg .
	toAccount  register: transfer depositLeg .
	^transfer! !


!classDefinition: #TransferNet category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferNet methodsFor: 'transferNet' stamp: 'nacho 10/20/2018 18:26:31'!
transferNetOf: anAccount 
	^anAccount transferNetTransactionsOn: self.! !


!TransferNet methodsFor: 'transaction transferNet' stamp: 'nacho 10/20/2018 18:37:32'!
aZeroTransferNet 
	^0.! !

!TransferNet methodsFor: 'transaction transferNet' stamp: 'nacho 10/20/2018 18:37:55'!
transferOfTransferDepositWithValue: aValue 
	^aValue ! !

!TransferNet methodsFor: 'transaction transferNet' stamp: 'nacho 10/20/2018 18:38:44'!
transferOfTransferWithdrawWithValue: aValue 
	^-1*aValue ! !
