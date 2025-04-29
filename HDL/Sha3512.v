/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Interfejs zewnętrzny koprocesora Sha3512.
	Sha3512.v to moduł nadrzędny.
	Moduł ten zawiera sygnały resetu, zapisu,
	umożliwia wprowadzanie 576 bitowych danych zgodnie z konwencją Little Endian.
	Wyjście układu również prezentowane jest zgodnie z konwencją Little Endian.
*/

module Sha3512(
		input wire 				inClk, 		// Sygnał zegarowy.
		input wire				inInit,		// Sygnał resetu koprocesora, podawany z zewnątrz.
		input wire				inDataWr,	// Sygnał zapisu wiadomości, podawany z zewnątrz.
		input wire	[575:0] 	inData,		// Magistrala wejściowa wiadomości.		
		output wire	[575:0] 	outData,		// Magistrala wyjściowa wiadomości.
		output wire 			outBusy		// Sygnał informujący o pracy koprocesora.
);


wire wireControloutIntStateExtWr;
wire wireControloutIntStateIntWr;
wire wireControloutIntDataOutWr;
wire wireControloutInInit;

wire[1599:0] wireKeccakPoutData;
wire[1599:0] wireStateRegoutData;
wire[7:0] wireRoundNumber;

// Instancja układu sterującego.
Sha3512Control Sha3512Control(
					.inClk(inClk),
					.inInit(inInit),
					.inExtDataWr(inDataWr),
					.outIntStateExtWr(wireControloutIntStateExtWr),
					.outIntStateIntWr(wireControloutIntStateIntWr),
					.outIntDataOutWr(wireControloutIntDataOutWr),
					.outBusy(outBusy),
					.outRoundNumber(wireRoundNumber),
					.outInInit(wireControloutInInit)
					);

// Instancja funkcji keccak-p.
keccakP keccakp(
            .inData(wireStateRegoutData),
				.inRoundNumber(wireRoundNumber),
            .outData(wireKeccakPoutData)
				);

// Instancja rejestru wewnętrznego koprocesora.
Sha3512RoundReg Sha3512RoundReg(
                .inClk(inClk),
					 .inInit(wireControloutInInit),
                .inExtWr(wireControloutIntStateExtWr),
                .inExtData(inData),
                .inIntWr(wireControloutIntStateIntWr),
                .inIntData(wireKeccakPoutData),
                .outData(wireStateRegoutData)
				);

// Instancja rejestru wyjściowego koprocesora.
Sha3512DataOutReg Sha3512DataOutReg(
                .inClk(inClk),
					 .inInit(wireControloutInInit),
                .inWr(wireControloutIntDataOutWr),
                .inData(wireKeccakPoutData),
                .outData(outData)
				);

endmodule