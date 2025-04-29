////////////////////////////////////////////
//							 							//
//  Damian KIERNOZEK  							//
//  +48 535 233 556   							//
//  damian.kiernozek@student.wat.edu.pl   //
//														//
////////////////////////////////////////////

/*
	Moduł realizuje testowanie koprocesora Sha3512.
	Moduł zawiera wszystkie sygnały oraz magistrale wejścia/wyjścia zgodne z interfejsem koprocesora.
	Na magistrale wejściową podawana jest 576 bitowa wartość poddawana skracaniu.
*/

module tbSha3512;

/////////////////////////////////////////

reg [63:0] TEST = 0;

/////////////////////////////////////////

parameter	inClkp = 10;
reg			inClk = 1'b0;

always
begin
	#(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg					inInit = 1'b0;		// Sygnał zerujący rejestr wewnętrzny koprocesora.
reg					inDataWr	= 1'b0;	// Sygnał zapisu danych wejściowych do koprocesora.
reg		[575:0]	inData  = 576'b0;	// Magistrala danych wejściowych.
wire 		[511:0]	outData;				// Magistrala danych wyjściowych poddanych skróceniu.
wire					outBusy;				// Sygnał informujący o wykonywaniu pracy przez koprocesor.

// Instancja koprocesora Sha3512.

Sha3512 sha3512(
    .inClk(inClk),
	 .inInit(inInit),
    .inDataWr(inDataWr),
    .inData(inData),
    .outData(outData),
    .outBusy(outBusy));

reg [575:0] tempData = 576'h8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014B616A614B3A6F6C736148;

always
begin
	// Test:
	TEST = TEST + 1;
	inInit = 1'b1; #(inClkp);
	inDataWr = 1'b0; inInit = 1'b0; inData <= 576'b0;	
	inDataWr = 1'b1; inData <= tempData; #(inClkp);
	inDataWr = 1'b0; inData <= 576'b0; inInit = 1'b1;
	wait(outBusy == 1'b0 && inClk == 1'b0);
	tempData = {64'h8000000000000001,outData};
	if (TEST == 64'd10) begin
		$stop;
	end
end 
	
endmodule
