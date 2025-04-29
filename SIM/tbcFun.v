/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
Moduł testujący odpowiada za wprowadzanie wartości poddawanej skracaniu. Wiadomość ta będzie poddawana pierwsza właśnie funkcji cFun.
Moduł przyjmuje wejście szerokości 1600 bitów po dopełnieniu 576 bitowego bloku wiadomości zerami - czyli moduł przyjmuje do funkcji pełną 1600 bitową tablicę stanu.
Na wyjście symulacji podawany będzie wynik po przekształceniach, który będzie jednocześnie wejściem podawanym do kolejnej funkcji dFun. 
*/

module tbcFun;

/////////////////////////////////////////


parameter	inClkp	= 10;
reg         inClk		= 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg	[1599:0] inData = 1600'b0;
wire	[319:0]	outData;

cFun cfun(.inData(inData), .outData(outData));
 
always
begin
	inData = 1600'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001997B5853;
	#(inClkp);
	$stop;
end
 endmodule
