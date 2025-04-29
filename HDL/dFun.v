/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł dFun jest układem kombinacyjnym realizującym funkcję D będącą składową funkcji Theta.
	Na wejście podawany jest 320-bitowy blok danych.
	Dane te są transformowane zgodnie z dokumentacją:
			D[x, z] = C[(x-1) mod 5, z] ⊕ C[(x+1) mod 5, (z – 1) mod w].
			
	Współrzędne x oraz z zawierają się odpowiednio w ciałach Z5 oraz Zw.
*/

module dFun (
	input wire [319:0] inData,
	output wire [319:0] outData
);

/*
	Przykładowo:
	
	  x  z
	D[0, 0] = C[4, 0] ⊕ C[1, 63],		...		, D[0, 63] = C[4, 63] ⊕ C[1, 62],
	D[1, 0] = C[0, 0] ⊕ C[2, 63],		...		, D[1, 63] = C[0, 63] ⊕ C[2, 62],
	D[2, 0] = C[1, 0] ⊕ C[3, 63],		...		, D[2, 63] = C[1, 63] ⊕ C[3, 62],
	D[3, 0] = C[2, 0] ⊕ C[4, 63],		...		, D[3, 63] = C[2, 63] ⊕ C[4, 62],
	D[4, 0] = C[3, 0] ⊕ C[0, 63],		...		, D[4, 63] = C[3, 63] ⊕ C[0, 62],
	
	a z poprzedniego modułu cFun wiadomo, że np.:
	
	assign outData[63:0] = inData[63:0]  ^ inData[383:320] ^ inData[703:640] ^ inData[1023:960]  ^ inData[1343:1280]; // Przypisania dla x = 0.
	
	C[0,0] jest na wierszu 0, C[0,63] jest na wierszu 63,
	C[1,0] jest na wierszu 64 C[1,63] jest na wierszu 127,
	C[2,0] jest na wierszu 128 C[2,63] jest na wierszu 191,
	C[3,0] jest na wierszu 192 C[3,63] jest na wierszu 255,
	C[4,0] jest na wierszu 256 C[4,63] jest na wierszu 319,
	
	więc do wyznaczania wyjścia np. D0 zostanie wykorzystane:
	
	D[0, 0]  =  inData[256] ^ inData[127], ponieważ inData[256] = C[4, 0], a inData[127] = C[1, 63].
	D[0, 1]  =  inData[257] ^ inData[63],
	
								 ...
								 
	D[0, 63] =  inData[319] ^ inData[126],
	
	a do wyjścia D1 wykorzystane:
	
	D[1, 0]  =  inData[0] ^ inData[191], ponieważ inData[0] = C[0, 0], a inData[191] = C[2, 63].
	D[1, 1]  =  inData[1] ^ inData[128],
	
					          ...
								 
	D[1, 63] =  inData[63] ^ inData[190].
	
	Tak więc nie można tu zastosować od razu przypisania typu:
		
	np. assign outData[63:0] = inData[319:256] ^ inData[127:64], ponieważ dla D[0] jest inData[127],
	a w takim zapisie byłoby inData[64] co byłoby niezgodne z dokumentacją.	
*/


assign outData[319:257] = inData[255:193] ^ inData[62:0];
assign outData[256] = inData[192] ^ inData[63];

assign outData[255:193] = inData[191:129] ^ inData[318:256];
assign outData[192] = inData[128] ^ inData[319];

assign outData[191:129] = inData[127:65] ^ inData[254:192];
assign outData[128] = inData[64] ^ inData[255];

assign outData[127:65] = inData[63:1] ^ inData[190:128];
assign outData[64] = inData[0] ^ inData[191];
 
assign outData[63:1] = inData[319:257] ^ inData[126:64];
assign outData[0] = inData[256] ^ inData[127];

endmodule

