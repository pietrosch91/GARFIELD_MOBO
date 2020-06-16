
  	;;  Scratch pad definition
	CONSTANT Saved_Byte0, 00
	CONSTANT Saved_Byte1, 01
	CONSTANT Saved_Byte2, 02
	CONSTANT Saved_Byte3, 03
	CONSTANT Saved_Byte4, 04
	CONSTANT Saved_Byte5, 05
	CONSTANT Saved_Byte6, 06
	CONSTANT Saved_Byte7, 07

store_reg_in_first_slot:
	store sD, Saved_Byte3
	store sC, Saved_Byte2
	store sB, Saved_Byte1
	store sA, Saved_Byte0
	return

store_reg_in_second_slot:
	store sD, Saved_Byte7
	store sC, Saved_Byte6
	store sB, Saved_Byte5
	store sA, Saved_Byte4
	return

fetch_reg_in_first_slot:
	fetch sD, Saved_Byte3
	fetch sC, Saved_Byte2
	fetch sB, Saved_Byte1
	fetch sA, Saved_Byte0
	return

fetch_reg_in_second_slot:
	fetch sD, Saved_Byte7
	fetch sC, Saved_Byte6
	fetch sB, Saved_Byte5
	fetch sA, Saved_Byte4
	return
