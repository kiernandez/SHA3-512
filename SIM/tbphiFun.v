/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł testujący odpowiada za wprowadzanie 1600-bitowej wartości stanu przed wykonaniem funkcji Phi.
	Moduł przyjmuje wejście szerokości 1600 bitów A. Testowana jest funkcja phiFun, której wyjście A' również będzie stanem 1600 bitowym po transformacji.
	Wynik symulacji będzie wejściem do kolejnej funkcji Chi.
*/

module tbphiFun;

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

phiFun phifun(.inData(inData), .outData(outData)); // Instancja modułu phiFun.
 
always
begin
	inData = 1600'h0000ccbdac29a000000000000000000020000000000000000000000665ed614c000000000000000000000332f6b0a680000000000000000000000000000080006b0a60000000332f00000000000000007b585340000001990000000000000000000008000000000000000665ed614c00000000000000000000332f6b0a68000000400000000000000000000000000040b58530000000199700000000000000001997b58534000000000000000000000040000000000000000000000332f6b0a600000001997b5853; // Tablica stanu podana na wejście.
	#(inClkp);
	$stop;
end
 endmodule
