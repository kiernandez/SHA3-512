/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł testujący odpowiada za wprowadzanie 1600-bitowej wartości stanu przed wykonaniem funkcji Chi.
	Moduł przyjmuje wejście szerokości 1600 bitów A. Testowana jest funkcja chiFun, której wyjście A' również będzie stanem 1600 bitowym po transformacji.
	Wynik symulacji będzie wejściem do kolejnej funkcji lota.
*/

module tbchiFun;

/////////////////////////////////////////


parameter	inClkp	= 10;
reg         inClk		= 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg	[1599:0]  inData = 1600'b0;
wire	[1599:0]	 outData;

chiFun chifun(.inData(inData), .outData(outData)); // Instancja modułu chiFun.
 
always
begin
	inData = 1600'h0000000665ed614c00000000000000007b58534000000199004000000000000040000000000000000000000000000000000000000000800000000665ed614c0000000000000000001997b58534000000000000000000000000000332f6b0a680000000000000000000000000000000400000000332f6b0a620000000000000006b0a60000000332f000000000000000000332f6b0a68000000000000000000000000ccbdac29a00000000000000000000000080000000000b58530000000199700000001997b5853; // Tablica stanu podana na wejście.
	#(inClkp);
	$stop;
end
 endmodule
