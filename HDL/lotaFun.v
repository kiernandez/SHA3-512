/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł realizuje funkcję lota, która przyjmuje na wejście stan A z funkcji chi.
	Funkcja aktualizuje pas o współrzędnych (0,0,z). Działaniu XOR podlegają tylko 64 bity ze względu na szerokość w tablicy = 64.
*/

module lotaFun(
	input wire  [7:0]    inRoundNumber, // Magistrala przekazująca numer rundy, od którego zależy, jaka wartość RC zostanie pobrana.
	input wire  [1599:0] inData,			// Wejście tablicy stanu A.
	output wire [1599:0] outData			// Wyjście tablicy stanu A'.
);

wire [63:0] rcNumber; // Magistrala przechowująca wynik instancji modułu RCfun

RCfun rcfun(.inRoundNumber(inRoundNumber), .outData(rcNumber));

// Przepisanie wejścia na wyjście, ponieważ ta część nie dotyczy funkcji lota.
assign outData[1599:64] = inData[1599:64];

// Aktualizacja wyłącznie Pasa o współrzędnych (x,y) = (0,0).
assign outData[63:0] = inData[63:0] ^ rcNumber[63:0];


endmodule


