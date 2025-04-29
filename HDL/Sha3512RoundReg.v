/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł realizujący rejestr wewnętrzny koprocesora.
	W przypadku flagi inExtWr == 1'b1 dane zostają podawane do rejestru z zewnątrz (inData),
	w przypadku flagi inIntWr == 1'b1 dane zostają podawane do rejestru z modułu keccak-p.
	Wyjście modułu podaje zawartość do modułu keccak-p.
*/

module Sha3512RoundReg(
	input wire 					inClk,
	input wire					inInit,		// Sygnał resetu rejestru regData.
	input wire 					inExtWr,		// Sygnał zapisu danych z zewnątrz.
	input wire		[575:0]	inExtData,	// Magistrala wejściowa danych zewnętrznych.					
	input wire 					inIntWr,		// Sygnał zapisu danych wewnetrznych.
	input wire		[1599:0] inIntData,	// Magistrala wejściowa danych wewnętrznych.								
   output wire		[1599:0] outData		
);

reg [1599:0] regData = 1600'b0;

always @ (posedge(inClk))
begin
    if (inExtWr == 1'b1) begin
		regData[575:0] <=  (regData[575:0] ^ inExtData[575:0]); // Zgodnie ze SHA3  dane zanim zostanę podane do funkcji keccak-p,
		regData[1599:576] <= 1024'b0;									  // Wejście jest XOR'owane z Rate.
    end
    
    if (inIntWr == 1'b1) begin										  // Gdy sygnał inIntWr == 1'b1, rejestr przyjmuje dane wewnętrzne.
        regData <= inIntData[1599:0];
    end
	 
	 if (inInit == 1'b1) begin											  // Gdy sygnał inInit == 1'b1, rejestr jest resetowany.
		  regData <= 1600'b0;
	 end
end

assign outData = regData;


endmodule