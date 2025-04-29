/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł Sha3512DataOutReg przekazuje wynik ostatniej rundy algorytmu na wyjście koprocesora.
	Wynik jest przekazywany, gdy sygnał zapisu dla ostatniej rundy jest ustawiony przez
	układ sterowania na stan wysoki.
	Przypisania sygnałów zachodzą synchronicznie z zegarem
*/

module Sha3512DataOutReg(
	input wire 				inClk, 	// Wejście zegara.
	input wire				inInit,
	input wire 				inWr,		// Sygnał zapisu danych na wyjście, aktywny w ostatniej rundzie algorytmu keccak-p.
	input wire	[1599:0] inData,	// Wejście tablicy stanu A' po ostatniej rundzie algorytmu 
	output wire	[575:0] 	outData	// Wyjście 576 bitowe.
);

reg [575:0] regData = 576'b0;

/*
	Dla ostatniej rundy obcięty wynik 512 bitowy jest od lewej strony dopełniany zerami do 576 bitów.
	Mimo, że powinno być wyjście 512 bitowe, to jednak aby móc zaprojektować taki koprocesor na płycie deweloperskiej,
	wymagane jest utworzenie komponentu, który zawiera taką samą szerokość wejścia i wyjścia, dlatego wyjście jest szersze, niż zwykle.
*/

always @ (posedge(inClk))
begin
    if (inWr == 1'b1) begin
        regData <= {64'b0, inData[511:0]}; // Wyjście dopełniane z lewej strony do pełnego bloku ze względu na konwencję Little Endian,
    end												 // oraz ze względu na przymus stosowania tej samej szerokości wejść/wyjść przy tworzeniu
														 // komponentu do struktury programowalnej.
	 
	 if (inInit == 1'b1) begin // Sygnał realizujący resetowanie stanu wewnętrznego dla Rejestru wyjściowego.
		  regData <= 576'b0;
	 end
end

assign outData = regData;

endmodule