!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'if 9/27/2018 21:51:31'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'if 9/28/2018 20:02:56'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 20:21:43'!
// aDivisor 
	
	^self class with: self integerValue // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 20:43:53'!
asDenominatorOf: aNumerator 
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'imf 9/30/2018 17:07:11'!
assignDenominator
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'imf 9/30/2018 17:07:05'!
assignNumerator 
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'EG 9/30/2018 12:06:09'!
fibonacci

	self subclassResponsibility 
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 19:28:53'!
greatestCommonDivisorWith: anEntero 
	
	^self subclassResponsibility ! !


!Entero methodsFor: 'value' stamp: 'if 9/28/2018 20:14:15'!
integerValue 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 9/23/2018 22:17:16'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no est� definido aqu� para enteros negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'if 9/28/2018 21:29:01'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue  = 0 ifTrue: [^Cero new ]. 
	aValue  = 1 ifTrue: [^Uno new].
	aValue < 0 ifTrue:[^EnterosNegativos withValue: aValue].
	
	^EnterosPositivosMenosCeroYUno withValue: aValue! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'value' stamp: 'if 9/28/2018 17:53:15'!
integerValue 
	^0.! !


!Cero methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 17:58:08'!
* aMultiplier 
	^self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 17:58:25'!
+ anAdder 
	^anAdder ! !

!Cero methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 18:31:10'!
- aSubtrahend 
	^EnterosNegativos with: aSubtrahend *-1! !

!Cero methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 18:05:46'!
/ aDivisor
	^aDivisor  divideCero: self.! !


!Cero methodsFor: 'testing' stamp: 'if 9/28/2018 18:07:39'!
isOne 
	^false! !

!Cero methodsFor: 'testing' stamp: 'if 9/28/2018 18:07:32'!
isZero 
	^true! !


!Cero methodsFor: 'error handling' stamp: 'if 9/28/2018 18:12:10'!
signalZeroDivisionError 
	self error: self class canNotDivideByZeroErrorDescription! !


!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/29/2018 12:42:35'!
addCero: anAdder 
	^self! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:08:33'!
addEnterosPositivosMenosCeroYUno: anAdder 
	^anAdder! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:08:46'!
addFraccion: anAdder 
	^anAdder! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:08:55'!
addUno: anAdder 
	^anAdder! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:44:07'!
asDenominatorOf: aNumerator 
	self signalZeroDivisionError ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:13:41'!
assignDenominator 
	^self error: 'una fraccion no puede tener el denominador 0'.! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:12:33'!
assignNumerator 
 ^self error: 'una fraccion no puede ser cero'! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/29/2018 12:43:00'!
divideCero: aDividend 
	self signalZeroDivisionError ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/29/2018 12:43:07'!
divideEnterosNegativos: aDividend 
	self signalZeroDivisionError ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/29/2018 12:43:17'!
divideEnterosPositivosMenosCeroYUno: aDividend 
	self signalZeroDivisionError ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/29/2018 12:43:24'!
divideFraccion: aDividend 
	self signalZeroDivisionError ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/29/2018 12:43:37'!
divideUno: aDividend 
	self signalZeroDivisionError ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:00:49'!
fibonacci
	^Entero with:1! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:06:41'!
greatestCommonDivisorWith: aEntero 
	^aEntero! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:16:15'!
multiplyEnterosNegativos:  aNegativeMultiplier
	^self ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:15:42'!
multiplyEnterosPositivosMenosCeroYUno:  aPositiveMultiplier
	^self ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:16:01'!
multiplyFraccion:  aFraccionMultiplier
	^self ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:33:00'!
substractCero: aSubtrahend 
	^self! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:34:44'!
substractEnterosNegativos: aSubtrahend 
	^aSubtrahend ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:35:20'!
substractEnterosPositivosMenosCeroYUno: aSubtrahend 
	^aSubtrahend ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:34:58'!
substractFraccion: aSubtrahend 
	^aSubtrahend ! !

!Cero methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:35:09'!
substractUno: aSubtrahend 
	^aSubtrahend ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: #'Numero-Exercise'!
Cero class
	instanceVariableNames: 'uniqueInstance'!

!Cero class methodsFor: 'instance creation' stamp: 'if 9/28/2018 19:44:25'!
new 
	^uniqueInstance ! !


!Cero class methodsFor: 'initialization' stamp: 'if 9/28/2018 19:51:57'!
initialize 
	uniqueInstance := self basicNew! !


!classDefinition: #EnterosNegativos category: #'Numero-Exercise'!
Entero subclass: #EnterosNegativos
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnterosNegativos methodsFor: 'initialization' stamp: 'if 9/28/2018 17:51:27'!
initializeWith: aValue 
	value := aValue .! !


!EnterosNegativos methodsFor: 'value' stamp: 'if 9/28/2018 17:54:11'!
integerValue 
	^value .! !


!EnterosNegativos methodsFor: 'testing' stamp: 'if 9/28/2018 18:42:25'!
isOne
	^false 
	! !

!EnterosNegativos methodsFor: 'testing' stamp: 'if 9/28/2018 18:42:18'!
isZero 
	^false 
	! !


!EnterosNegativos methodsFor: 'arithmetic operations' stamp: 'imf 9/30/2018 17:39:46'!
* aMultiplier 
	^aMultiplier multiplyEnterosNegativos: self! !

!EnterosNegativos methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 19:12:04'!
+ anAdder 
	^ anAdder addEnterosNegativos: self! !

!EnterosNegativos methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 19:13:12'!
- aSubtrahend
	^ aSubtrahend substractEnterosNegativos: self! !

!EnterosNegativos methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 19:12:49'!
/ aDivisor
	^ aDivisor divideEnterosNegativos: self.! !


!EnterosNegativos methodsFor: 'comparing' stamp: 'if 9/28/2018 23:01:37'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!EnterosNegativos methodsFor: 'comparing' stamp: 'if 9/28/2018 23:02:02'!
hash  
	^value hash! !


!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:49:01'!
addEnterosNegativos: aNegativeAdder
	^self class withValue: (aNegativeAdder integerValue + self integerValue )! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 19:22:55'!
addEnterosPositivosMenosCeroYUno: aPositiveAdder 
	^aPositiveAdder - self! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:35:43'!
addUno: aUnoAdder
	^self class with:self integerValue +1! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 22:46:48'!
asDenominatorOf: aNumerator
	
	^Fraccion with: aNumerator over: self! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:07:36'!
assignDenominator
	^self! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:07:30'!
assignNumerator 
	^self! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 22:45:33'!
divideEnterosNegativos: aNegativeDividend 
	| denominator greatestCommonDivisor numerator| 
	greatestCommonDivisor := aNegativeDividend greatestCommonDivisorWith: self. 
	numerator := aNegativeDividend // greatestCommonDivisor . 
	denominator := self // greatestCommonDivisor.
	
	
	^denominator asDenominatorOf: numerator ! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 22:24:16'!
divideEnterosPositivosMenosCeroYUno: aPositiveDividend 
	| denominator greatestCommonDivisor numerator| 
	greatestCommonDivisor := aPositiveDividend greatestCommonDivisorWith: self. 
	numerator := aPositiveDividend // greatestCommonDivisor . 
	denominator := self // greatestCommonDivisor.
	
	^denominator asDenominatorOf: numerator.! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 22:26:11'!
divideUno: aUnoDividend 
	^Fraccion with: aUnoDividend over:self	! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 19:33:49'!
fibonacci 
	^self error: Entero negativeFibonacciErrorDescription 
		! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 22:49:45'!
greatestCommonDivisorWith: anEntero 
	^Entero with:(value gcd: anEntero integerValue) ! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:47:14'!
multiplyEnterosNegativos: aNegativeMultiplier 
	^EnterosPositivosMenosCeroYUno withValue: aNegativeMultiplier integerValue * self integerValue ! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:41:55'!
multiplyEnterosPositivosMenosCeroYUno: aPositiveMultiplier 
	^self class with: (aPositiveMultiplier integerValue * self integerValue )! !

!EnterosNegativos methodsFor: 'arithmetic operations private' stamp: 'EG 9/29/2018 21:34:33'!
multiplyFraccion: aFraccionMultiplier 
	^self * aFraccionMultiplier ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnterosNegativos class' category: #'Numero-Exercise'!
EnterosNegativos class
	instanceVariableNames: ''!

!EnterosNegativos class methodsFor: 'instance creation' stamp: 'if 9/28/2018 20:49:01'!
withValue: aNegativeIntegerValue
	^self new initializeWith: aNegativeIntegerValue .! !


!classDefinition: #EnterosPositivosMenosCeroYUno category: #'Numero-Exercise'!
Entero subclass: #EnterosPositivosMenosCeroYUno
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnterosPositivosMenosCeroYUno methodsFor: 'initialization' stamp: 'if 9/28/2018 17:52:03'!
initializeWith: aValue 
	value := aValue .! !


!EnterosPositivosMenosCeroYUno methodsFor: 'value' stamp: 'if 9/28/2018 20:14:32'!
integerValue
	^value ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'value' stamp: 'if 9/28/2018 17:54:27'!
value 
	^value ! !


!EnterosPositivosMenosCeroYUno methodsFor: 'testing' stamp: 'if 9/28/2018 18:43:19'!
isOne
 ^false! !

!EnterosPositivosMenosCeroYUno methodsFor: 'testing' stamp: 'if 9/28/2018 18:43:16'!
isZero 
 ^false! !


!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 18:44:01'!
* aMultiplier 
	^aMultiplier multiplyEnterosPositivosMenosCeroYUno: self! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 18:44:26'!
+ anAdder 
	^anAdder addEnterosPositivosMenosCeroYUno: self! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 21:05:28'!
- aSubtrahend 
	^aSubtrahend substractEnterosPositivosMenosCeroYUno: self! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 18:44:54'!
/ aDivisor
	^aDivisor divideEnterosPositivosMenosCeroYUno: self! !


!EnterosPositivosMenosCeroYUno methodsFor: 'comparing' stamp: 'if 9/28/2018 20:09:16'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!EnterosPositivosMenosCeroYUno methodsFor: 'comparing' stamp: 'if 9/28/2018 20:10:42'!
hash  
	^value hash! !


!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:50:13'!
addCero: aCeroAdder 
	^self ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:53:14'!
addEnterosPositivosMenosCeroYUno: anPositiveAdder 
	^Entero with: value + anPositiveAdder integerValue ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:48:50'!
addFraccion: aFraccionAdder 
	^self + aFraccionAdder ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:53:24'!
addUno: aUnoAdder 
	^Entero with: 1 + value ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:43:30'!
asDenominatorOf: aNumerator 
	^Fraccion with: aNumerator over: self! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:08:03'!
assignDenominator 
	^self! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:07:56'!
assignNumerator 
	^self! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:50:34'!
divideCero: aCeroDividend 
	^aCeroDividend ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:59:57'!
divideEnterosNegativos: aNegativeDividend 
	^Fraccion with:  aNegativeDividend  over: self	! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:42:54'!
divideEnterosPositivosMenosCeroYUno: aPositiveDividend 
	| denominator greatestCommonDivisor numerator| 
	greatestCommonDivisor := aPositiveDividend greatestCommonDivisorWith: self. 
	numerator := aPositiveDividend // greatestCommonDivisor . 
	denominator := self // greatestCommonDivisor.
	
	^denominator asDenominatorOf: numerator.! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:57:36'!
divideFraccion: aFraccionDividend 
	^ aFraccionDividend numerator / (aFraccionDividend denominator *self)	! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:58:15'!
divideUno: aUnoDividend 
	^Fraccion with: aUnoDividend over:self	! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:53:40'!
fibonacci  
	| one two |
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci.
	! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:48:41'!
greatestCommonDivisorWith: aEntero 
	^self class withValue:(value gcd: aEntero integerValue)! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:48:50'!
multiplyEnterosNegativos: aNegativeMultiplier 
	^EnterosNegativos withValue: aNegativeMultiplier integerValue * self integerValue ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:48:41'!
multiplyEnterosPositivosMenosCeroYUno: aPositiveMultiplier 
	^self class withValue: value * aPositiveMultiplier integerValue ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 19:01:52'!
multiplyFraccion: aFraccionMultiplier 
	^self * aFraccionMultiplier ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 19:10:08'!
substractEnterosNegativos: aNegativeSubtrahend 
	^aNegativeSubtrahend  - self! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:17:20'!
substractEnterosPositivosMenosCeroYUno: aPositiveSubtrahend 
	^Entero with:aPositiveSubtrahend integerValue - self integerValue ! !

!EnterosPositivosMenosCeroYUno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 19:09:32'!
substractFraccion: aFraccionSubtrahend 
	^aFraccionSubtrahend - self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnterosPositivosMenosCeroYUno class' category: #'Numero-Exercise'!
EnterosPositivosMenosCeroYUno class
	instanceVariableNames: ''!

!EnterosPositivosMenosCeroYUno class methodsFor: 'instance creation' stamp: 'if 9/28/2018 20:48:41'!
withValue: aPositiveIntegerValue
	^self new initializeWith: aPositiveIntegerValue .! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'value' stamp: 'if 9/28/2018 17:52:55'!
integerValue 
	^1.! !


!Uno methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 18:18:48'!
* aMultiplier 
	^aMultiplier ! !

!Uno methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 18:19:39'!
+ anAdder 
	^anAdder addUno:self! !

!Uno methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 21:25:28'!
- aSubtrahend 
	^aSubtrahend substractUno: self! !

!Uno methodsFor: 'arithmetic operations' stamp: 'if 9/28/2018 18:21:32'!
/ aDivisor 
	^aDivisor divideUno: self! !


!Uno methodsFor: 'testing' stamp: 'if 9/28/2018 18:22:25'!
isOne 
 	^true! !

!Uno methodsFor: 'testing' stamp: 'if 9/28/2018 18:22:35'!
isZero
 	^false! !


!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:23:25'!
addEnterosPositivosMenosCeroYUno: aPositiveAdder 
	^Entero with: 1 + aPositiveAdder integerValue ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:24:18'!
addFraccion: aFraccionAdder 
	^aFraccionAdder  denominator  + aFraccionAdder numerator  / aFraccionAdder  denominator ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:25:25'!
addUno: aUnoAdder 
	^EnterosPositivosMenosCeroYUno with:2! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:44:40'!
asDenominatorOf: aNumerator 
  ^aNumerator ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:10:32'!
assignDenominator
 	^self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'imf 9/30/2018 17:08:53'!
assignNumerator 
 ^self.! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:27:23'!
divideCero: aDividend  
	^aDividend ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:28:09'!
divideEnterosNegativos: aDividend  
	^aDividend ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:28:02'!
divideEnterosPositivosMenosCeroYUno: aDividend  
	^aDividend ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:27:47'!
divideUno: aDividend  
	^self! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:28:11'!
fibonacci 
	^self
	 ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:22:02'!
greatestCommonDivisorWith: aEntero 
	^self! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:28:54'!
multiplyEnterosNegativos: aMultiplier 
	^aMultiplier ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:28:45'!
multiplyEnterosPositivosMenosCeroYUno: aMultiplier 
	^aMultiplier ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:37:07'!
substractCero: aSubtrahend 
	^EnterosNegativos with: -1! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 18:41:02'!
substractEnterosNegativos: aSubtrahend 
	^aSubtrahend - 1! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:04:45'!
substractEnterosPositivosMenosCeroYUno: aSubtrahend 
	^Entero with: aSubtrahend integerValue -1! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:27:24'!
substractFraccion: aSubtrahend 
	^(aSubtrahend numerator - aSubtrahend denominator ) / aSubtrahend denominator ! !

!Uno methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:19:23'!
substractUno: aSubtrahend 
	^Entero with: 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: #'Numero-Exercise'!
Uno class
	instanceVariableNames: 'uniqueInstance'!

!Uno class methodsFor: 'initialization' stamp: 'if 9/28/2018 19:51:53'!
initialize 
	uniqueInstance := self basicNew! !


!Uno class methodsFor: 'instance creation' stamp: 'if 9/28/2018 19:44:39'!
new 
	^uniqueInstance ! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EG 9/30/2018 12:11:16'!
* aMultiplier 
	
	^aMultiplier  multiplyFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EG 9/30/2018 12:11:30'!
+ anAdder 
	^anAdder addFraccion: self.
	
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EG 9/30/2018 12:11:35'!
- aSubtrahend 
	
	^aSubtrahend substractFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EG 9/30/2018 12:11:42'!
/ aDivisor 
	^aDivisor  divideFraccion: self.
! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'imf 9/30/2018 17:13:55'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	"aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ]."
	
	
	numerator := aNumerator assignNumerator.
	denominator := aDenominator assignDenominator. ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/27/2018 21:15:25'!
addAnInteger: anInteger
	^(Fraccion with:((anInteger *  denominator ) + numerator) over: denominator)! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:55:31'!
addEnterosPositivosMenosCeroYUno: anPositiveAdder 
	^anPositiveAdder *denominator +numerator  / denominator ! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:02:17'!
addFraccion: unaFraccion
	|newNumerator newDenominator|
	
	newNumerator := (numerator * unaFraccion denominator) + (denominator * unaFraccion numerator).
	newDenominator := denominator * unaFraccion denominator.
	
		
	^newNumerator / newDenominator
		! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:56:04'!
addUno: anUnoAdder 
	^denominator + numerator / denominator ! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:57:40'!
divideCero: aCeroDividend 
	^aCeroDividend ! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:58:25'!
divideEnterosPositivosMenosCeroYUno: aPositiveDividend 
	^aPositiveDividend * denominator  /numerator ! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:59:12'!
divideFraccion: aFraccionDividend 
	^(aFraccionDividend numerator * denominator )/(aFraccionDividend denominator * numerator )! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:59:29'!
divideUno: aUnoDividend 
	^denominator / numerator ! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'EG 9/30/2018 11:53:50'!
multiplyEnterosNegativos: aNegativeMultiplier 
	^numerator  * aNegativeMultiplier / denominator ! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 20:59:59'!
multiplyEnterosPositivosMenosCeroYUno: aPositiveMultiplier 
	^numerator  * aPositiveMultiplier / denominator ! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:01:00'!
multiplyFraccion: aFraccionMultiplier 
	^(numerator  * aFraccionMultiplier numerator ) / (denominator * aFraccionMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:14:29'!
substractEnterosPositivosMenosCeroYUno: aPositiveSubtrahend 
	^(aPositiveSubtrahend * denominator  / denominator ) - self! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 21:10:11'!
substractFraccion: aFraccionSubtrahend 
	| newNumerator newDenominator|

	newNumerator := (aFraccionSubtrahend numerator * denominator) - (aFraccionSubtrahend denominator * numerator).
		newDenominator := aFraccionSubtrahend denominator * denominator.
		^newNumerator / newDenominator	! !

!Fraccion methodsFor: 'arithmetic operations private' stamp: 'if 9/28/2018 22:56:35'!
substractUno: aUnoSubtrahend 
	^(Entero with:denominator integerValue - numerator integerValue) / (Entero with:denominator integerValue ) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'imf 9/30/2018 17:20:29'!
with: aNumerator over: aDenominator

	"Notar que la creacion de una Fraccion utilizando este mensaje no la simplifica. Para ese caso usar el operador a /b"
	
	^self new initializeWith: aNumerator over: aDenominator 
	! !

Cero initialize!
Uno initialize!