/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł cFun jest układem kombinacyjnym realizującym funkcję C, która jest składową makrofunkcji Theta.
	Moduł realizuje przypisania danych wejściowych na 320 bitowe wyjście.
	Operacja przypisań wykorzystuje działanie XOR na pięciu 64-bitowych magistralach danych w oparciu o dokumentację:
				C[x, z] = A[x, 0, z] ⊕ A[x, 1, z] ⊕ A[x, 2, z] ⊕ A[x, 3, z] ⊕ A[x, 4, z].

	!Dane zostają podane na wejście funkcji zgodnie z konwencją Little Endian.
*/

module cFun (                
	input wire [1599:0] inData,  
	output wire [319:0] outData
	);

/*
Przykładowo:
	Dla wyznaczania wartości C[0,0],C[0,1],C[0,2], ... , C[0,63] potrzebne będą następujące słowa:
	
		C[0,0] = A[0, 0, 0] ⊕ A[0, 1, 0] ⊕ A[0, 2, 0] ⊕ A[0, 3, 0] ⊕ A[0, 4, 0],
		
	czyli słowa o takich samych inteksach (x,z), natomiast o różnych indeksach y.
	Do wyznaczenia wartośći C[0,0] potrzeba 5 różnych słów, gdzie:

		Początkowy zakres dla z = 0:			Końcowy zakres dla z = 63:
	
	Dla x = 0: 
		
		A[0, 0, 0] = S[0],			...		A[0, 0, 63] = S[63],
		A[0, 1, 0] = S[320],			...		A[0, 1, 63] = S[383],
		A[0, 2, 0] = S[640],			...		A[0, 2, 63] = S[703],
		A[0, 3, 0] = S[960],			...		A[0, 3, 63] = S[1023],
		A[0, 4, 0] = S[1280].		...		A[0, 4, 63] = S[1343],
		
	Dla x = 1:
	
		A[1, 0, 0] = S[64],			...		A[1, 0, 63] = S[127],
		A[1, 1, 0] = S[384],			...		A[1, 1, 63] = S[447],
		A[1, 2, 0] = S[704],			...		A[1, 2, 63] = S[767],
		A[1, 3, 0] = S[1024],		...		A[1, 3, 63] = S[1087],
		A[1, 4, 0] = S[1344].		...		A[1, 4, 63] = S[1407],
		
											...
											...
											
		A[4, 0, 0] = S[256],			...		A[4, 0, 63] = S[319],
		A[4, 1, 0] = S[576],			...		A[4, 1, 63] = S[639],
		A[4, 2, 0] = S[896],			...		A[4, 2, 63] = S[959],
		A[4, 3, 0] = S[1216],		...		A[4, 3, 63] = S[1279],
		A[4, 4, 0] = S[1536].		...		A[4, 4, 63] = S[1599],
		
	czyli każde z pięciu przypisań jest dla innej wartości x.		
*/

assign outData = { inData[319:256] ^ inData[639:576] ^ inData[959:896] ^ inData[1279:1216] ^ inData[1599:1536],	// Przypisania dla x = 4,
						 inData[255:192] ^ inData[575:512] ^ inData[895:832] ^ inData[1215:1152] ^ inData[1535:1472],	// Przypisania dla x = 3,
						 inData[191:128] ^ inData[511:448] ^ inData[831:768] ^ inData[1151:1088] ^ inData[1471:1408],	// Przypisania dla x = 2,
						 inData[127:64]  ^ inData[447:384] ^ inData[767:704] ^ inData[1087:1024] ^ inData[1407:1344],   // Przypisania dla x = 1,
						 inData[63:0] 	  ^ inData[383:320] ^ inData[703:640] ^ inData[1023:960]  ^ inData[1343:1280] }; // Przypisania dla x = 0.

// Na wyjście zostaje przypisana konkatenacja 320-bitowa poszczególnych wierszy.

endmodule
