/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł phiFun realizuje układ wykonujący funkcję Phi zgodnie z dokumentacją algorytmu.
	Moduł przyjmuje na wejście tablicę stanu A, po transformacji przekazuje do funkcji Chi tablicę stanu A'.
*/

module phiFun (
	input  wire [1599:0] inData, // 1600-bitowe wejście stanu A.
	output wire [1599:0] outData // 1600-bitowe wyjście stanu A'.
);
/*
	Na podstawie dokumentacji:
	  - Pierwszy Pas (Wiersze od 63 do 0) wykonuje rotację wokół siebie, czyli nie zmienia pozycji,
	    więc wiersze stanu od 0 do 63 nie ulegają zmianie w przypisaniu.
	  - Wszystkie pasy zmieniają pozycję na podstawie wzoru zawartego w dokumentacji:
	
						A′[x, y, z] = A[(x + 3y) mod 5, x, z],
	więc np.
	  
	Na Wiersz 64 (A[1,0,0]) zostaje przypisana wartosć z wiersza A[1,1,0].
	Tak samo wartość Y będzie równa 1 dla wszystkich wierszy z X = 1,
	czyli wiersze z przedziału od 384 do 447 będą wprowadzane na wiersze z przedziału od 64 do 127.
	Analogiczne obliczenia i przypisania zachodzą dla innych szerokości. W implementacji przypisania są w postaci bloków 64 bitowych ze względu na to,
	że 64 bity odpowiadają w tablicy jednemu pasowi (Lane'owi).	
*/


assign outData[1599:1280] = {inData[1407:1344], inData[1023:960], inData[959:896],
									  inData[575:512], inData[191:128]};

assign outData[1279:960]  = {inData[1535:1472], inData[1151:1088], inData[767:704],
									  inData[383:320], inData[319:256]};

assign outData[959:640]   = {inData[1343:1280], inData[1279:1216], inData[895:832],
									  inData[511:448], inData[127:64]};

assign outData[639:320]   = {inData[1471:1408], inData[1087:1024], inData[703:640],
									  inData[639:576], inData[255:192]};

assign outData[319:64]    = {inData[1599:1536], inData[1215:1152], inData[831:768],
								     inData[447:384]};
								 
assign outData[63:0]      =  inData[63:0];

endmodule