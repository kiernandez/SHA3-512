/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł chiFun realizuje układ obliczający zawartość stanu dla funkcji Chi.
	Na wejście zostaje podana tablica stanu A, natomiast na wyjście zostaje podana tablica stanu A' po transformacji.
*/

module chiFun (
	input wire  [1599:0] inData,
	output wire [1599:0] outData
);

/*
	Przypisania są wykonywane na podstawie równania:
	
	A[x,y,z]⊕((A[(x+1)mod5,y,z]⊕1)⋅A[(x+2)mod5,y,z]).
	
	Zapisy zostały uporządkowane na podstawie wierszy oraz na podstawie współrzędnej Y.	
	W równaniu zastosowano negację, która pełni rolę działania XOR przez 1 logiczne.
	Jest to inna forma zapisu A[x,y,z] XOR 1.
*/

// Przypisania pasów 64 bitowych dla wierszy o współrzędnej Y = 4 (1280:1599)
assign outData[1599:1536] =   inData[1599:1536] ^ ((~inData[1343:1280]) & inData[1407:1344]);
assign outData[1535:1472] =   inData[1535:1472] ^ ((~inData[1599:1536]) & inData[1343:1280]);
assign outData[1471:1408] =   inData[1471:1408] ^ ((~inData[1535:1472]) & inData[1599:1536]);
assign outData[1407:1344] =   inData[1407:1344] ^ ((~inData[1471:1408]) & inData[1535:1472]);
assign outData[1343:1280] =   inData[1343:1280] ^ ((~inData[1407:1344]) & inData[1471:1408]);

// Przypisania pasów 64 bitowych dla wierszy o współrzędnej Y = 3 (960:1279)
assign outData[1279:1216] =   inData[1279:1216] ^ ((~inData[1023:960]) & inData[1087:1024]);
assign outData[1215:1152] =   inData[1215:1152] ^ ((~inData[1279:1216]) & inData[1023:960]);
assign outData[1151:1088] =   inData[1151:1088] ^ ((~inData[1215:1152]) & inData[1279:1216]);
assign outData[1087:1024] =   inData[1087:1024] ^ ((~inData[1151:1088]) & inData[1215:1152]);
assign outData[1023:960]  =   inData[1023:960]  ^ ((~inData[1087:1024]) & inData[1151:1088]);

// Przypisania pasów 64 bitowych dla wierszy o współrzędnej Y = 2 (640:959)
assign outData[959:896]   =   inData[959:896] ^ ((~inData[703:640]) & inData[767:704]);
assign outData[895:832]   =   inData[895:832] ^ ((~inData[959:896]) & inData[703:640]);
assign outData[831:768]   =   inData[831:768] ^ ((~inData[895:832]) & inData[959:896]);
assign outData[767:704]   =   inData[767:704] ^ ((~inData[831:768]) & inData[895:832]);
assign outData[703:640]   =   inData[703:640] ^ ((~inData[767:704]) & inData[831:768]);

// Przypisania pasów 64 bitowych dla wierszy o współrzędnej Y = 1 (320:639)
assign outData[639:576]   =   inData[639:576] ^ ((~inData[383:320]) & inData[447:384]);
assign outData[575:512]   =   inData[575:512] ^ ((~inData[639:576]) & inData[383:320]);
assign outData[511:448]   =   inData[511:448] ^ ((~inData[575:512]) & inData[639:576]);
assign outData[447:384]   =   inData[447:384] ^ ((~inData[511:448]) & inData[575:512]);
assign outData[383:320]   =   inData[383:320] ^ ((~inData[447:384]) & inData[511:448]);

// Przypisania pasów 64 bitowych dla wierszy o współrzędnej Y = 0 (0:319)
assign outData[319:256]   =   inData[319:256] ^ ((~inData[63:0]) & inData[127:64]);
assign outData[255:192]   =   inData[255:192] ^ ((~inData[319:256]) & inData[63:0]);
assign outData[191:128]   =   inData[191:128] ^ ((~inData[255:192]) & inData[319:256]);
assign outData[127:64]    =   inData[127:64]  ^ ((~inData[191:128]) & inData[255:192]);
assign outData[63:0]      =   inData[63:0]    ^ ((~inData[127:64]) & inData[191:128]); 

endmodule
