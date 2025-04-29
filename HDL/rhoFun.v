/////////////////////////////
//									//
//		Damian KIERNOZEK		//
//		+48 535 233 556		//
//		dkiernozek@wp.pl		//
//								`	//
/////////////////////////////

/*
	Moduł rhoFun realizuje funkcję Rho, której celem jest wykonanie przesunięcie poszczególnych Pasów (Lanes) tablicy stanu.
	Wartość przesunięcia pasa zależy od współrzędnych (X,Y). Każdy pas (Lane) będzie wykonywał przesunięcie o inną ilość miejsc.
	Wyjątkiem jest środek tablicy stanu o współrzędnych (0, 0), gdzie przesunięcie nie w wierszach pasa nie występuje.
	Ilość przesunięć jest określona w specyfikacji i prezentuje się następująco:
	
			-------------------------
		   |y\x| 3 | 4 | 0 | 1 | 2 |
			| 2 |153|231| 3 |10 |171|
			| 1 |55 |276|36 |300| 6 |
			| 0 |28 |91 | 0 | 1 |190|
			| 4 |120|78 |210|66 |253|
			| 3 |21 |136|105|45 |15 |
			-------------------------
	
	Jako że magistrala tablicy stanu dla poszczególnych wierszy wejściowych ma przypisane poszczególne współrzędne (x,y),
	to poszczególne szerokości wierszy trzeba przesuwać zgodnie z tabelą.
	
	Fakt jest taki, że dokumentacja przedstawia oczywiście tabelę dla Rho[w = 8], ale znaczy to tyle, że przesunięcia będą zachodzić modulo 8.
	Dla tego układu przesunięcia zachodzą modulo 64, wiec mimo tego przesunięcie jest zgodne z dokumentacją.
*/

module rhoFun (
	input wire  [1599:0]  inData, // Wejście tablicy stanu A po wykonaniu funkcji Theta.
	output wire [1599:0]  outData  // Wyjście tablicy stanu A' po wykonaniu funkcji Rho.
);


assign outData[1599:1536] = {inData[1585:1536], inData[1599:1586]};       //wartosc przesuniecia 78
assign outData[1535:1472] = {inData[1479:1472], inData[1535:1480]};       //wartosc przesuniecia 120
assign outData[1471:1408] = {inData[1410:1408], inData[1471:1411]};       //wartosc przesuniecia 253
assign outData[1407:1344] = {inData[1405:1344], inData[1407:1406]};       //wartosc przesuniecia 66
assign outData[1343:1280] = {inData[1325:1280], inData[1343:1326]};       //wartosc przesuniecia 210

assign outData[1279:1216] = {inData[1271:1216], inData[1279:1272]};       //wartosc przesuniecia136
assign outData[1215:1152] = {inData[1194:1152], inData[1215:1195]};       //wartosc przesuniecia 21
assign outData[1151:1088] = {inData[1136:1088], inData[1151:1137]};       //wartosc przesuniecia 15
assign outData[1087:1024] = {inData[1042:1024], inData[1087:1043]};       //wartosc przesuniecia 45
assign outData[1023:960] = {inData[982:960], inData[1023:983]};           //wartosc przesuniecia 105

assign outData[959:896] = {inData[920:896], inData[959:921]};             //wartosc przesuniecia 231
assign outData[895:832] = {inData[870:832], inData[895:871]};             //wartosc przesuniecia 153
assign outData[831:768] = {inData[788:768], inData[831:789]};             //wartosc przesuniecia 171
assign outData[767:704] = {inData[757:704], inData[767:758]};             //wartosc przesuniecia 10
assign outData[703:640] = {inData[700:640], inData[703:701]};             //wartosc przesuniecia 3

assign outData[639:576] = {inData[619:576], inData[639:620]};             //wartosc przesuniecia 276
assign outData[575:512] = {inData[520:512], inData[575:521]};             //wartosc przesuniecia 55
assign outData[511:448] = {inData[505:448], inData[511:506]};             //wartosc przesuniecia 6
assign outData[447:384] = {inData[403:384], inData[447:404]};             //wartosc przesuniecia 300
assign outData[383:320] = {inData[347:320], inData[383:348]};             //wartosc przesuniecia 36

assign outData[319:256] = {inData[292:256], inData[319:293]};             //wartosc przesuniecia 91
assign outData[255:192] = {inData[227:192], inData[255:228]};             //wartosc przesuniecia 28
assign outData[191:128] = {inData[129:128], inData[191:130]};             //wartosc przesuniecia 190
assign outData[127:64] = {inData[126:64], inData[127]}; 


assign outData[63:0] = inData[63:0];  //  let A′ [0, 0, z]  = A[0, 0, z]. Pierwsze 64 wartości stanu nie są przesuwane

endmodule