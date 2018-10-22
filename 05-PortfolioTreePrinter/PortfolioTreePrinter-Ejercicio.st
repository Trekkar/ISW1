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




!CertificateOfDeposit methodsFor: 'accept' stamp: 'if 10/22/2018 18:14:42'!
accept: aVisitor 
	^aVisitor visitCertificateOfDeposit: self.! !

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






!Deposit methodsFor: 'accept' stamp: 'if 10/22/2018 18:14:01'!
accept: aVisitor 
	^aVisitor visitDeposit: self.! !

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






!TransferLeg methodsFor: 'accept' stamp: 'if 10/22/2018 18:15:09'!
accept: aVisitor 
	self subclassResponsibility ! !

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




!TransferDeposit methodsFor: 'accept' stamp: 'if 10/22/2018 18:15:30'!
accept: aVisitor 
	^aVisitor visitTransferDeposit: self.! !

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




!TransferWithdraw methodsFor: 'accept' stamp: 'if 10/22/2018 18:15:53'!
accept: aVisitor 
	^aVisitor visitTransferWithdraw: self.! !

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






!Withdraw methodsFor: 'accept' stamp: 'if 10/22/2018 18:16:18'!
accept: aVisitor 
	^aVisitor visitWithdraw: self.! !

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


!classDefinition: #AccountTransactionVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransactionVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransactionVisitor methodsFor: 'visit transactions' stamp: 'if 10/22/2018 18:41:12'!
visitCertificateOfDeposit: aCertificateOfDeposit
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visit transactions' stamp: 'if 10/22/2018 18:40:23'!
visitDeposit: aDeposit 
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visit transactions' stamp: 'if 10/22/2018 18:40:49'!
visitTransferDeposit: aTransferDeposit
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visit transactions' stamp: 'if 10/22/2018 18:41:00'!
visitTransferWithdraw: aTransferWithdraw
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visit transactions' stamp: 'if 10/22/2018 18:40:35'!
visitWithdraw: aWithdraw
	self subclassResponsibility ! !


!AccountTransactionVisitor methodsFor: 'value' stamp: 'if 10/22/2018 18:39:52'!
value 	
	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'transactions printing' stamp: 'if 10/22/2018 18:23:28'!
visitCertificateOfDeposit: aCertificateOfDeposit 
	^'Plazo fijo por ' , (aCertificateOfDeposit value) printString , ' durante ',  (aCertificateOfDeposit during) printString, ' dias a una tna de ', ((aCertificateOfDeposit interestRate)*100) printString,'%'. ! !

!AccountSummary methodsFor: 'transactions printing' stamp: 'if 10/22/2018 18:21:24'!
visitDeposit: aDeposit 
	^'Deposito por ' , (aDeposit value) printString .! !

!AccountSummary methodsFor: 'transactions printing' stamp: 'if 10/22/2018 18:23:54'!
visitTransferDeposit: aTransferDeposit 
	^'Transferencia por ' , (aTransferDeposit value) printString.! !

!AccountSummary methodsFor: 'transactions printing' stamp: 'if 10/22/2018 18:24:21'!
visitTransferWithdraw: aTransferWithdraw 
	^'Transferencia por -' , (aTransferWithdraw value) printString.! !

!AccountSummary methodsFor: 'transactions printing' stamp: 'if 10/22/2018 18:24:42'!
visitWithdraw: aWithdraw 
	^'Extraccion por ' , (aWithdraw value) printString.! !


!AccountSummary methodsFor: 'printing' stamp: 'if 10/22/2018 17:58:14'!
value

	^account summaryOn: self.

	! !


!AccountSummary methodsFor: 'initialization' stamp: 'if 10/22/2018 17:56:58'!
initializeWith: anAccount  
	account := anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'class initialization' stamp: 'if 10/22/2018 17:43:25'!
of: anAccount 
	^self new initializeWith: anAccount ! !


!classDefinition: #InvestmentEarning category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #InvestmentEarning
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarning methodsFor: 'earnings' stamp: 'if 10/22/2018 17:58:57'!
value
	^account investmentEarningOfTransactionsOn: self.! !


!InvestmentEarning methodsFor: 'transaction investmentEarnings' stamp: 'nacho 10/20/2018 19:27:43'!
aZeroInvestmentEarning 
	^0.! !

!InvestmentEarning methodsFor: 'transaction investmentEarnings' stamp: 'if 10/22/2018 18:29:41'!
visitCertificateOfDeposit: aCertificateOfDeposit
	^((aCertificateOfDeposit value)*((aCertificateOfDeposit interestRate)/360))* (aCertificateOfDeposit during) ! !

!InvestmentEarning methodsFor: 'transaction investmentEarnings' stamp: 'if 10/22/2018 18:27:41'!
visitDeposit: aDeposit 
	^self aZeroInvestmentEarning .! !

!InvestmentEarning methodsFor: 'transaction investmentEarnings' stamp: 'if 10/22/2018 18:28:13'!
visitTransferDeposit: aTransferDeposit 
	^self aZeroInvestmentEarning .! !

!InvestmentEarning methodsFor: 'transaction investmentEarnings' stamp: 'if 10/22/2018 18:28:25'!
visitTransferWithdraw: aTransferWithdraw 
	^self aZeroInvestmentEarning .! !

!InvestmentEarning methodsFor: 'transaction investmentEarnings' stamp: 'if 10/22/2018 18:27:59'!
visitWithdraw: aWithdraw 
	^self aZeroInvestmentEarning .! !


!InvestmentEarning methodsFor: 'initialization' stamp: 'if 10/22/2018 17:57:17'!
initializeWith: anAccount  
	account := anAccount ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentEarning class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentEarning class
	instanceVariableNames: ''!

!InvestmentEarning class methodsFor: 'class initialization' stamp: 'if 10/22/2018 17:43:55'!
of: anAccount 
	^self new initializeWith: anAccount .! !


!classDefinition: #InvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #InvestmentNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNet methodsFor: 'investment' stamp: 'if 10/22/2018 17:59:13'!
value
	^account investmentNetOfTransactionsOn: self! !


!InvestmentNet methodsFor: 'transactions investmentNet' stamp: 'nacho 10/20/2018 19:10:39'!
aZeroInvestmentNet 
 	^0.! !

!InvestmentNet methodsFor: 'transactions investmentNet' stamp: 'if 10/22/2018 18:34:08'!
visitCertificateOfDeposit: aCertificateOfDeposit
	^aCertificateOfDeposit value ! !

!InvestmentNet methodsFor: 'transactions investmentNet' stamp: 'if 10/22/2018 18:32:57'!
visitDeposit: aDeposit 
	^self aZeroInvestmentNet ! !

!InvestmentNet methodsFor: 'transactions investmentNet' stamp: 'if 10/22/2018 18:33:20'!
visitTransferDeposit: aTransferDeposit
	^self aZeroInvestmentNet ! !

!InvestmentNet methodsFor: 'transactions investmentNet' stamp: 'if 10/22/2018 18:33:34'!
visitTransferWithdraw: aTransferWithdraw
	^self aZeroInvestmentNet ! !

!InvestmentNet methodsFor: 'transactions investmentNet' stamp: 'if 10/22/2018 18:33:09'!
visitWithdraw: aWithdraw 
	^self aZeroInvestmentNet ! !


!InvestmentNet methodsFor: 'initialization' stamp: 'if 10/22/2018 17:57:32'!
initializeWith: anAccount  
	account := anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentNet class
	instanceVariableNames: ''!

!InvestmentNet class methodsFor: 'class initialization' stamp: 'if 10/22/2018 17:44:07'!
of: anAccount 
	^self new initializeWith: anAccount ! !


!classDefinition: #TransferNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #TransferNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferNet methodsFor: 'transferNet' stamp: 'if 10/22/2018 17:59:29'!
value
	^account transferNetTransactionsOn: self.! !


!TransferNet methodsFor: 'transaction transferNet' stamp: 'nacho 10/20/2018 18:37:32'!
aZeroTransferNet 
	^0.! !

!TransferNet methodsFor: 'transaction transferNet' stamp: 'if 10/22/2018 18:37:43'!
visitCertificateOfDeposit: aCertificateOfDeposit
	^self aZeroTransferNet ! !

!TransferNet methodsFor: 'transaction transferNet' stamp: 'if 10/22/2018 18:37:08'!
visitDeposit: aDeposit 
	^self aZeroTransferNet ! !

!TransferNet methodsFor: 'transaction transferNet' stamp: 'if 10/22/2018 18:38:21'!
visitTransferDeposit: aTransferDeposit
	^aTransferDeposit value! !

!TransferNet methodsFor: 'transaction transferNet' stamp: 'if 10/22/2018 18:38:38'!
visitTransferWithdraw: aTransferWithdraw
	^-1*(aTransferWithdraw value) ! !

!TransferNet methodsFor: 'transaction transferNet' stamp: 'if 10/22/2018 18:37:23'!
visitWithdraw: aWithdraw
	^self aZeroTransferNet ! !


!TransferNet methodsFor: 'initialization' stamp: 'if 10/22/2018 17:57:47'!
initializeWith: anAccount  
	account := anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'class initialization' stamp: 'if 10/22/2018 17:46:32'!
of: anAccount 
	^self new initializeWith: anAccount ! !


!classDefinition: #PortfolioTreePrinter category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio namingaccounts lines spaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'if 10/22/2018 18:49:07'!
initializefor: aPortfolio with:aDictionary  
	portfolio := aPortfolio . 
	namingaccounts := aDictionary .! !


!PortfolioTreePrinter methodsFor: 'value' stamp: 'if 10/22/2018 19:41:19'!
value
	
	lines := OrderedCollection new. 
	spaces := ''.
	portfolio accept: self. 
	spaces := ''.
	^lines.
	! !


!PortfolioTreePrinter methodsFor: 'account' stamp: 'if 10/22/2018 19:53:47'!
visitPortfolio: aPortfolio 
	lines add:  (spaces , (namingaccounts at: aPortfolio)).
	spaces := spaces , ' '.
	(aPortfolio accounts ) do: [:anAccount | anAccount accept: self]. 
	self substractSpaces.
	^lines.
	! !

!PortfolioTreePrinter methodsFor: 'account' stamp: 'if 10/22/2018 19:40:36'!
visitReceptiveAccount: aReceptiveAccount
	lines add: ( spaces , (namingaccounts at: aReceptiveAccount)).
	^lines.
	! !


!PortfolioTreePrinter methodsFor: 'auxiliary' stamp: 'if 10/22/2018 19:53:30'!
substractSpaces
 	^spaces:= (spaces copyFrom: 1 to: (spaces size -1) )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'class initialization' stamp: 'if 10/22/2018 18:48:33'!
for: aPortfolio with: aDictionary  
	^self new initializefor: aPortfolio with:aDictionary ! !


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


!SummarizingAccount methodsFor: 'summary' stamp: 'if 10/22/2018 18:25:58'!
summaryOn: anAccountSummary 
 	|summary| 
	summary := OrderedCollection  new.
	self transactions do: [:aTransaction|  summary add: (aTransaction accept:anAccountSummary)].
	^summary ! !


!SummarizingAccount methodsFor: 'transferNet' stamp: 'if 10/22/2018 18:43:01'!
transferNetTransactionsOn: aTransferNet  
	
	^self transactions inject: 0 into: [:netValue :aTransaction | netValue  + (aTransaction accept: aTransferNet) ].
	! !


!SummarizingAccount methodsFor: 'investmentNet' stamp: 'if 10/22/2018 18:35:51'!
investmentNetOfTransactionsOn: anInvestmentNet 
	^self transactions inject:0 into: [:netValue :aTransaction | netValue + (aTransaction accept: anInvestmentNet )]! !


!SummarizingAccount methodsFor: 'investmentEarning' stamp: 'if 10/22/2018 18:32:13'!
investmentEarningOfTransactionsOn: anInvestmentEarning 
	^self transactions inject: 0 into: [:earnings :aTransaction | earnings + (aTransaction accept: anInvestmentEarning )] ! !


!SummarizingAccount methodsFor: 'visitors' stamp: 'if 10/22/2018 19:20:18'!
accept: aVisitor 
	self subclassResponsibility ! !


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


!Portfolio methodsFor: 'visitors' stamp: 'if 10/22/2018 19:21:35'!
accept: aVisitor
	aVisitor visitPortfolio: self.
	! !


!Portfolio methodsFor: 'accesing ' stamp: 'if 10/22/2018 19:23:51'!
accounts 
	^accounts ! !

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


!ReceptiveAccount methodsFor: 'visitors' stamp: 'if 10/22/2018 19:22:31'!
accept: aVisitor
	aVisitor visitReceptiveAccount: self.! !


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
