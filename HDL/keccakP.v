/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł keccakP jest układem realizującym funkcję keccak-p rodziny keccak. Funkcja jest stosowana w ramach algorytmu SHA-3 512.
	Funkcja zawiera 5 transformacji operujących na przekształceniach tablicy stanu 1600 bitowej.
	Wykonywane są 24 rundy obliczania skrótu za pomocą funkcji keccak-p
*/

module keccakP (
	input wire  [1599:0]   inData, // Wejście 1600 bitowej tablicy stanu A
	input wire  [7:0] 	  inRoundNumber, // Wejście numeru rundy potrzebne do wykonywania się funkcji lota.
	output wire [1599:0]   outData	// Wyjście 1600 bitowe będące tablicą stanu A' algorytmu keccak-p po n-tej rundzie.
);

/*
	Magistrale pomocnicze, które przekazują wyniki tablicy stanu A' do kolejnej funkcji. Ostania funkcja
	przekazuje wynik na wyjście funkcji keccak-p.
*/

wire[1599:0] outTheta;
wire[1599:0] outRho;
wire[1599:0] outPhi;
wire[1599:0] outChi;

thetaFun Thetafun (.inData(inData), .outData(outTheta));
rhoFun Rhofun (.inData(outTheta), .outData(outRho));
phiFun Phifun (.inData(outRho), .outData(outPhi));
chiFun Chifun (.inData(outPhi), .outData(outChi));
lotaFun Lotafun (.inData(outChi), .inRoundNumber(inRoundNumber), .outData(outData));

endmodule

