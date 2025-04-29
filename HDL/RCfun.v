/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł RC realizuje układ odpowiadający za pobranie odpowiedniej wartości RC zależnie od podanej na wejście rundy.
	Moduł pobiera na wejście numer rundy z modułu sterowania.
	Zależnie od pobranego numeru rundy na wyjście podawana jest 64-bitowa wartość.
	Wartości RC zostały wcześniej obliczone. Do modułu podano gotowy wynik, aby uniknąć niepotrzebnych dla koprocesora obliczeń.
	Alternatywnie można było wykonać pełną tablicę 1536 bitową, która co rundę będzie wykonywać przesunięcie o 64 bity.
	Wartości modułu zapisane są zgodnie z konwencją Little Endian.
*/

module RCfun(
	input wire	[7:0]  inRoundNumber,
	output wire	[63:0] outData
);

// Na wyjście są przypisywane 64 bitowe wartości zależnie od numeru rundy.

assign outData = (inRoundNumber == 8'd1) ? 64'h0000000000000001 :
					  (inRoundNumber == 8'd2) ? 64'h0000000000008082 :
					  (inRoundNumber == 8'd3) ? 64'h800000000000808A :
					  (inRoundNumber == 8'd4) ? 64'h8000000080008000 :
					  (inRoundNumber == 8'd5) ? 64'h000000000000808B :
					  (inRoundNumber == 8'd6) ? 64'h0000000080000001 :
					  (inRoundNumber == 8'd7) ? 64'h8000000080008081 :
					  (inRoundNumber == 8'd8) ? 64'h8000000000008009 :
					  (inRoundNumber == 8'd9) ? 64'h000000000000008A :
					  (inRoundNumber == 8'd10) ? 64'h0000000000000088 :
					  (inRoundNumber == 8'd11) ? 64'h0000000080008009 :
					  (inRoundNumber == 8'd12) ? 64'h000000008000000A :
					  (inRoundNumber == 8'd13) ? 64'h000000008000808B :
					  (inRoundNumber == 8'd14) ? 64'h800000000000008B :
				     (inRoundNumber == 8'd15) ? 64'h8000000000008089 :
					  (inRoundNumber == 8'd16) ? 64'h8000000000008003 :
					  (inRoundNumber == 8'd17) ? 64'h8000000000008002 :
					  (inRoundNumber == 8'd18) ? 64'h8000000000000080 :
					  (inRoundNumber == 8'd19) ? 64'h000000000000800A :
					  (inRoundNumber == 8'd20) ? 64'h800000008000000A :
					  (inRoundNumber == 8'd21) ? 64'h8000000080008081 :
					  (inRoundNumber == 8'd22) ? 64'h8000000000008080 :
					  (inRoundNumber == 8'd23) ? 64'h0000000080000001 : 64'h8000000080008008; //Wynik dla 24 rundy na końcu.
					
endmodule


					