# set clock 
set_location_assignment PIN_M9 -to clock;
# set reset
set_location_assignment PIN_P22 -to reset;

# set dot matrix column
set_location_assignment PIN_L8 -to dot_column[7];
set_location_assignment PIN_J13 -to dot_column[6];
set_location_assignment PIN_C15 -to dot_column[5];
set_location_assignment PIN_B13 -to dot_column[4];
set_location_assignment PIN_E16 -to dot_column[3];
set_location_assignment PIN_G17 -to dot_column[2];
set_location_assignment PIN_J18 -to dot_column[1];
set_location_assignment PIN_A14 -to dot_column[0];

# set dot matrix row
set_location_assignment PIN_D13 -to dot_row[7];
set_location_assignment PIN_A13 -to dot_row[6];
set_location_assignment PIN_B12 -to dot_row[5];
set_location_assignment PIN_C13 -to dot_row[4];
set_location_assignment PIN_E14 -to dot_row[3];
set_location_assignment PIN_A12 -to dot_row[2];
set_location_assignment PIN_B15 -to dot_row[1];
set_location_assignment PIN_E15 -to dot_row[0];

#set keypad
set_location_assignment PIN_J17 -to keypadRow[0];
set_location_assignment PIN_G13 -to keypadRow[1];
set_location_assignment PIN_G16 -to keypadRow[2];
set_location_assignment PIN_F13 -to keypadRow[3];
set_location_assignment PIN_F12 -to keypadCol[0];
set_location_assignment PIN_G15 -to keypadCol[1];
set_location_assignment PIN_G12 -to keypadCol[2];
set_location_assignment PIN_K16 -to keypadCol[3];

