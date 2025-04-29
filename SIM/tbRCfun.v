/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł testujący funkcję RCfun.
	Na wejście podawana jest 8-bitowa wartość będąca numerem rundy od 0 do 23.
*/

module tbRCfun;

/////////////////////////////////////////


parameter	inClkp	= 10;
reg         inClk		= 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg	[7:0] 	inRoundNumber = 8'b0;
wire	[63:0]	outData;

RCfun rcfun(.inRoundNumber(inRoundNumber), .outData(outData)); // Instancja modułu RCfun.
 
always
begin
	inRoundNumber = 8'd0; #(inClkp);
	inRoundNumber = 8'd1; #(inClkp);
	inRoundNumber = 8'd2; #(inClkp);
	inRoundNumber = 8'd3; #(inClkp);
	inRoundNumber = 8'd4; #(inClkp);
	inRoundNumber = 8'd5; #(inClkp);
	inRoundNumber = 8'd6; #(inClkp);
	inRoundNumber = 8'd7; #(inClkp);
	inRoundNumber = 8'd8; #(inClkp);
	inRoundNumber = 8'd9; #(inClkp);
	inRoundNumber = 8'd10; #(inClkp);
	inRoundNumber = 8'd11; #(inClkp);
	inRoundNumber = 8'd12; #(inClkp);
	inRoundNumber = 8'd13; #(inClkp);
	inRoundNumber = 8'd14; #(inClkp);
	inRoundNumber = 8'd15; #(inClkp);
	inRoundNumber = 8'd16; #(inClkp);
	inRoundNumber = 8'd17; #(inClkp);
	inRoundNumber = 8'd18; #(inClkp);
	inRoundNumber = 8'd19; #(inClkp);
	inRoundNumber = 8'd20; #(inClkp);
	inRoundNumber = 8'd21; #(inClkp);
	inRoundNumber = 8'd22; #(inClkp);
	inRoundNumber = 8'd23; #(inClkp);
	
	$stop;
end
 endmodule
