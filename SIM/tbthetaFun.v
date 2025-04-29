/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł testujący odpowiada za wprowadzanie 1600-bitowej wartości stanu przed wykonaniem funkcji Theta.
	Moduł przyjmuje wejście szerokości 1600 bitów A. Testowana jest funkcja thetaFun, której wyjście A' również będzie stanem 1600 bitowym po transformacji.
*/

module tbthetaFun;

/////////////////////////////////////////


parameter	inClkp	= 10;
reg         inClk		= 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg	[1599:0]  inData = 1600'b0;
wire	[1599:0]	outData;

thetaFun thetafun(.inData(inData), .outData(outData)); // Instancja modułu thetaFun.
 
always
begin
	inData = 1600'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001997b5853; // Tablica stanu podana na wejście.
	#(inClkp);
	$stop;
end
 endmodule
