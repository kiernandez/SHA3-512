/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł testujący odpowiada za wprowadzanie 1600-bitowej wartości stanu przed wykonaniem funkcji lota.
	Moduł przyjmuje wejście szerokości 1600 bitów A. Testowana jest funkcja lotaFun, której wyjście A' również będzie stanem 1600 bitowym po transformacji.
	Wynik symulacji będzie wynikiem dla rundy n (testowana jest runda 0).
*/

module tblotaFun;

/////////////////////////////////////////


parameter	inClkp	= 10;
reg         inClk		= 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg	[7:0]		  inRoundNumber	= 8'd0;
reg	[1599:0]   inData 			= 1600'b0;
wire	[1599:0]	  outData;

lotaFun lotafun(.inRoundNumber(inRoundNumber), .inData(inData), .outData(outData)); // Instancja modułu lotaFun.
 
always
begin
	inData = 1600'h0040000665ed614c40000000000000007b58534665ed60d500400000000000003b1853400000019900000000000000001997b5853400800000000665ed614c0000000000000080001997b3e0d9614c00000000000000004000000331c4461626000000000000000000000332f6b0a6c00000000332f6b0a620332f6b0a6800006b0a60000000332f00000000000000006b394f6b0a68332f0000000000000000b585fcbdac29a18400000000115258530000c4bdac29a000b58530000000199700000801997b5853; // Tablica stanu podana na wejście.
	#(inClkp);
	$stop;
end
 endmodule
