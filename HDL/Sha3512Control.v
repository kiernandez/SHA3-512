/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł Sha3512Control jest układem sterującym.
	Moduł ten opiera się na liczniku inkrementowanym przy narastającym zboczu zegara.
	Licznik wykonuje łącznie 25 rund.
	Runda początkowa wykonuje przesłanie danych wejściowych do koprocesora.
	Pozostałe 24 rundy iterują rundy keccak.
*/

module Sha3512Control(
	input wire 			inClk, 				// Wejście zegara.
	input wire			inInit,				// Wejście sygnału resetowania stanu wewnętrznego koprocesora.
	input wire 			inExtDataWr,		// Wejście sygnału zapisu danych z zewnątrz do koprocesora, można manipulować nim tylko dla regCounter == 1'b0.	
	output wire 		outIntStateExtWr,	// Wyjście sygnału zapisu danych z zewnątrz do koprocesora.
	output wire 		outIntStateIntWr,	// Wyjście sygnału zapisu danych wewnętrznych między modułem keccakP a RoundReg, aktywne dla licznika != 1'b0.
	output wire 		outIntDataOutWr,	// Wyjście sygnału zapisu danych wewnętrznych na wyjście koprocesora, aktywne gdy licznik = 8'd24.	
	output wire 		outBusy,				// Wyjście sygnału informującego o pracy koprocesora.
	output wire	[7:0] outRoundNumber,	// Wyjście wartości aktualnej rundy koprocesora, przypisywane kombinacyjnie.
	output wire			outInInit			// Wyjście sygnału resetowania wewnętrznych rejestrów koprocesora.
);


reg [7:0] regCounter = 8'b0;

/*
	Licznik zaczyna się aktualizować, gdy na początku zostanie ustawiony sygnał zapisu na 1, lub gdy koprocesor
	zacznie pracę, czyli licznik będzie różny od zera. Licznik kończy pracę po 25 taktach.
	Gdy licznik osiąga wartość 8'd24, zeruje się.
*/

always @ (posedge(inClk))
begin
    if ((inExtDataWr == 1'b1) || (regCounter != 8'b0)) begin
        if (regCounter == 8'd24) begin
            regCounter <= 8'b0;
        end else begin
            regCounter <= regCounter + 8'd1;
        end
    
    end
end

// Sygnał odpowiada za rozpoczęcie pracy koprocesora.
assign outIntStateExtWr = (regCounter == 8'd0) ? inExtDataWr : 1'b0;

// Sygnał odpowiada za przesyłanie danych między wewnętrznymi rejestrami.
assign outIntStateIntWr = (regCounter == 8'd0) ? 1'b0 : 1'b1;

// Sygnał odpowiada za przekazanie danych na wyjście podczas 24 rundy.
assign outIntDataOutWr = (regCounter == 8'd24) ? 1'b1 : 1'b0;

// Sygnał odpowiada za informowanie o pracy koprocesora.
assign outBusy = (regCounter == 8'd0) ? 1'b0 : 1'b1;

// Przypisanie aktualnego numeru rundy na wyjście.
assign outRoundNumber = regCounter;

// Sygnał resetowania koprocesora, można manipulować tylko gdy licznik jest równy 8'd0.
assign outInInit = (regCounter == 8'd0) ? inInit : 1'b0;

endmodule

