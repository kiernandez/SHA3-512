/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł testujący odpowiada za wprowadzanie 1600-bitowej wartości stanu przed wykonaniem funkcji Rho.
	Moduł przyjmuje wejście szerokości 1600 bitów A. Testowana jest funkcja rhoFun, której wyjście A' również będzie stanem 1600 bitowym po transformacji.
	Wynik symulacji będzie wejściem do kolejnej funkcji Phi.
*/

module tbrhoFun;

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

rhoFun rhofun(.inData(inData), .outData(outData)); // Instancja modułu rhoFun.
 
always
begin
	inData = 1600'h8000000332f6b0a60000000000000000000000000000000100000001997b585300000000000000008000000332f6b0a60000000000000000000000000000000100000001997b585300000000000000008000000332f6b0a60000000000000000000000000000000100000001997b585300000000000000008000000332f6b0a68000000000000000000000000000000100000001997b585300000000000000008000000332f6b0a60000000000000000000000000000000100000001997b585300000001997b5853; // Tablica stanu podana na wejście.
	#(inClkp);
	$stop;
end
 endmodule
