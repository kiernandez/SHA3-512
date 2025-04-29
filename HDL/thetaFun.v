/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł thetaFun jest układem kombinacyjnym realizującym funkcję Theta. Moduł ten zawiera instancje podmodułów cFun i dFun, które obliczają 320-bitowe transformacje.
	Wynik 320-bitowych transformacji jest poddawany działaniu XOR wraz z 320-bitowymi blokami danych:
	
				A′[x, y, z] = A[x, y, z] ⊕ D[x, z].
				
	Wynik działania XOR na 320-bitowych blokach jest zaktualizowanym stanem tablicy stanu A' i zostanie przekazany do funkcji Rho jako stan wejściowy.
*/

module thetaFun (
	input wire [1599:0] inData,  // Wejście tablicy stanu o szerokości 5x5xw, gdzie w dla b=1600 wynosi 64.
	output wire [1599:0] outData // Wyjście A' po transformacji, przekazywane do funkcji Rho.
);

wire[319:0] outCData; // Magistrala przechowująca wynik funkcji C, łączy wyjście funkcji C z wejściem funkcji D.
wire[319:0] outDData; // Magistrala przechowująca wynik funkcji D.

cFun cfun (.inData(inData), .outData(outCData));

dFun dfun (.inData(outCData), .outData(outDData));

// Wykonywane jest kilka przypisań na 320-bitowych blokach, ponieważ wyjście funkcji D jest 320 bitowe.

assign outData[1599:1280] = inData[1599:1280] ^ outDData;
assign outData[1279:960]  = inData[1279:960]  ^ outDData;
assign outData[959:640]   = inData[959:640]   ^ outDData;
assign outData[639:320]   = inData[639:320]   ^ outDData;
assign outData[319:0]     = inData[319:0]     ^ outDData;

endmodule