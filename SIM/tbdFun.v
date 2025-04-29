/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł testujący odpowiada za wprowadzanie wartości obliczonej z funkcji C. Stan algorytmu będzie poddawany funkcji D.
	Moduł przyjmuje wejście szerokości 320 bitów z funkcji D. W module wywoływana jest instancja modułu dFun.
	Na wyjście symulacji podawany będzie wynik po przekształceniach w funkcji C, który będzie jednocześnie wejściem podawanym do obliczenia funkcji Theta. 
*/

module tbdFun;

/////////////////////////////////////////


parameter	inClkp	= 10;
reg         inClk		= 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg	[319:0]  inData = 320'b0;
wire	[319:0]	outData;

dFun dfun(.inData(inData), .outData(outData)); // Instancja modułu dFun.
 
always
begin
	inData = 320'h000000000000000080000000000000000000000000000000000000000000000000000001997b5853; // Wynik funkcji C.
	#(inClkp);
	$stop;
end
 endmodule
