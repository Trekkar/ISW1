!classDefinition: #I category: #'Quinta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta Actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'error handling' stamp: 'if 9/11/2018 19:26:24'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'error handling' stamp: 'if 9/11/2018 19:23:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados 
	^'Numeros negativos no soportados'! !


!I class methodsFor: 'operadores' stamp: 'EG 9/9/2018 15:38:44'!
* unNumeroDePeano
	^unNumeroDePeano ! !

!I class methodsFor: 'operadores' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:24:57'!
- unNumeroDePeano

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:38:25'!
/ divisorDePeano
	(divisorDePeano = self) ifTrue:[
			^self
		].
	
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	
	! !

!I class methodsFor: 'operadores' stamp: 'EG 9/9/2018 16:47:18'!
> unNumeroDePeano
	^false! !

!I class methodsFor: 'operadores' stamp: 'EG 9/9/2018 17:58:21'!
>= unNumeroDePeano
	unNumeroDePeano = self ifTrue:[
		^true
		].
	^false! !

!I class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:35:07'!
leRestoA: unNumeroDePeano 
	^unNumeroDePeano previous ! !

!I class methodsFor: 'operadores' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !


!classDefinition: #II category: #'Quinta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta Actividad'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'error handling' stamp: 'if 9/11/2018 19:26:34'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'error handling' stamp: 'if 9/11/2018 19:24:26'!
descripcionDeErrorDeNumerosNegativosNoSoportados 
	^'Numeros negativos no soportados'! !


!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:10'!
* unNumeroDePeano
	^(self previous * unNumeroDePeano)  + unNumeroDePeano ! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:10'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:19:05'!
- unNumeroDePeano

	^unNumeroDePeano leRestoA: self.! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:36:29'!
/ unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[
		^self
	].
		
	unNumeroDePeano > self ifTrue:[
		^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
		].
	
	^unNumeroDePeano divideAl: self! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:10'!
> unNumeroDePeano
	unNumeroDePeano = I ifTrue:[
			^true
		].
	^self previous > unNumeroDePeano previous! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:10'!
>= unNumeroDePeano
	unNumeroDePeano = I ifTrue:[
			^true
		].
	^self previous >= unNumeroDePeano previous! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:10'!
divideAl: unNumeroDePeano
	|contador dividendo| 
	unNumeroDePeano = self ifTrue:[
			^I
		].
	contador := I.
	dividendo :=unNumeroDePeano.
	
	[ dividendo > self] whileTrue:[
		dividendo:= dividendo - self.
		contador:= contador next.
		].
	
	dividendo = self ifTrue:[
		contador:= contador next
		]. 
	^contador previous! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:10'!
leRestoA: unNumeroDePeano 
	^unNumeroDePeano  previous - self previous.! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:27'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:10'!
previous

	^prev! !

!II class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:30:27'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!II class methodsFor: 'as yet unclassified' stamp: 'if 9/11/2018 19:38:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !


!classDefinition: #III category: #'Quinta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta Actividad'!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'error handling' stamp: 'if 9/11/2018 19:37:19'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	^'No se puede dividir por un numero mayor'! !

!III class methodsFor: 'error handling' stamp: 'if 9/11/2018 19:37:19'!
descripcionDeErrorDeNumerosNegativosNoSoportados 
	^'Numeros negativos no soportados'! !


!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
* unNumeroDePeano
	^(self previous * unNumeroDePeano)  + unNumeroDePeano ! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
- unNumeroDePeano

	^unNumeroDePeano leRestoA: self.! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
/ unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[
		^self
	].
		
	unNumeroDePeano > self ifTrue:[
		^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
		].
	
	^unNumeroDePeano divideAl: self! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
> unNumeroDePeano
	unNumeroDePeano = I ifTrue:[
			^true
		].
	^self previous > unNumeroDePeano previous! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
>= unNumeroDePeano
	unNumeroDePeano = I ifTrue:[
			^true
		].
	^self previous >= unNumeroDePeano previous! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
divideAl: unNumeroDePeano
	|contador dividendo| 
	unNumeroDePeano = self ifTrue:[
			^I
		].
	contador := I.
	dividendo :=unNumeroDePeano.
	
	[ dividendo > self] whileTrue:[
		dividendo:= dividendo - self.
		contador:= contador next.
		].
	
	dividendo = self ifTrue:[
		contador:= contador next
		]. 
	^contador previous! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
leRestoA: unNumeroDePeano 
	^unNumeroDePeano  previous - self previous.! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
previous

	^prev! !

!III class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!III class methodsFor: 'as yet unclassified' stamp: 'if 9/11/2018 19:38:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !


!classDefinition: #IIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta Actividad'!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'error handling' stamp: 'if 9/11/2018 19:37:19'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	^'No se puede dividir por un numero mayor'! !

!IIII class methodsFor: 'error handling' stamp: 'if 9/11/2018 19:37:19'!
descripcionDeErrorDeNumerosNegativosNoSoportados 
	^'Numeros negativos no soportados'! !


!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
* unNumeroDePeano
	^(self previous * unNumeroDePeano)  + unNumeroDePeano ! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
- unNumeroDePeano

	^unNumeroDePeano leRestoA: self.! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
/ unNumeroDePeano
	
	unNumeroDePeano = I ifTrue:[
		^self
	].
		
	unNumeroDePeano > self ifTrue:[
		^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
		].
	
	^unNumeroDePeano divideAl: self! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
> unNumeroDePeano
	unNumeroDePeano = I ifTrue:[
			^true
		].
	^self previous > unNumeroDePeano previous! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
>= unNumeroDePeano
	unNumeroDePeano = I ifTrue:[
			^true
		].
	^self previous >= unNumeroDePeano previous! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
divideAl: unNumeroDePeano
	|contador dividendo| 
	unNumeroDePeano = self ifTrue:[
			^I
		].
	contador := I.
	dividendo :=unNumeroDePeano.
	
	[ dividendo > self] whileTrue:[
		dividendo:= dividendo - self.
		contador:= contador next.
		].
	
	dividendo = self ifTrue:[
		contador:= contador next
		]. 
	^contador previous! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
leRestoA: unNumeroDePeano 
	^unNumeroDePeano  previous - self previous.! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
previous

	^prev! !

!IIII class methodsFor: 'operadores' stamp: 'if 9/11/2018 19:37:19'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!IIII class methodsFor: 'as yet unclassified' stamp: 'if 9/11/2018 19:38:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!