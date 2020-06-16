**Instructions to switch on/off and monitor PMT HV using the IPBUs, for the 3PMT test system in IHEP.**

1) login to the IHEP 3 PMT computer (ip: 192.168.247.251)

2) change directory to:
   /home/electronics/JUNOelectronics/HV_scripts.20191207

3) open two separate terminals (with the same directory)

4) in one terminal run:

    python rx_chars_uart_0.py

5) in the second window, run

    python send_multiple_chars_uart_0.py

(change both to 1 or 2 if you need to control PMT #2 or #3, respectively).

In the second windows yu can type the command to operate on the HV. If
everything works, you get an echo back on the first window.

The commands are:

C1 - Set Voltage:    w010202ffc\r
 02ff is the HV field. It spans from 0 (1500 V) to 7FFF (3000 V)
 the conversion formula is: HV_value = 0.364 * HV_hex + 1466

C2 - Set HV ON:      w01010001c\r

C3 - Set HV OFF:     w01010000c\r

C4 - Read applied voltage:  r0103c\r

[Note: '\r' is the carriage return on the keyboard]

Video example: https://istnazfisnucl-my.sharepoint.com/:v:/g/personal/fmarini_infn_it/Ea5vOF7CDAdDlLub_1_yCX0BGKwLbC_2qb9fq5Xxnx5M4g?e=rC3OYc
