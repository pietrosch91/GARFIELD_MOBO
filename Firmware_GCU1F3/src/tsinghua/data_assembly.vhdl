
--
-- Verific VHDL Description of OPERATOR add_10u_10u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity add_10u_10u is
    port (cin: in std_logic;
        a: in std_logic_vector(9 downto 0);
        b: in std_logic_vector(9 downto 0);
        o: out std_logic_vector(9 downto 0);
        cout: out std_logic
    );
    
end entity add_10u_10u;

architecture INTERFACE of add_10u_10u is 
    signal n2,n4,n6,n8,n10,n12,n14,n16,n18 : std_logic; 
begin
    n2 <= a(0) or b(0) when cin='1' else a(0) and b(0);
    o(0) <= a(0) xor b(0) xor cin;
    n4 <= a(1) or b(1) when n2='1' else a(1) and b(1);
    o(1) <= a(1) xor b(1) xor n2;
    n6 <= a(2) or b(2) when n4='1' else a(2) and b(2);
    o(2) <= a(2) xor b(2) xor n4;
    n8 <= a(3) or b(3) when n6='1' else a(3) and b(3);
    o(3) <= a(3) xor b(3) xor n6;
    n10 <= a(4) or b(4) when n8='1' else a(4) and b(4);
    o(4) <= a(4) xor b(4) xor n8;
    n12 <= a(5) or b(5) when n10='1' else a(5) and b(5);
    o(5) <= a(5) xor b(5) xor n10;
    n14 <= a(6) or b(6) when n12='1' else a(6) and b(6);
    o(6) <= a(6) xor b(6) xor n12;
    n16 <= a(7) or b(7) when n14='1' else a(7) and b(7);
    o(7) <= a(7) xor b(7) xor n14;
    n18 <= a(8) or b(8) when n16='1' else a(8) and b(8);
    o(8) <= a(8) xor b(8) xor n16;
    cout <= a(9) or b(9) when n18='1' else a(9) and b(9);
    o(9) <= a(9) xor b(9) xor n18;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR LessThan_16u_16u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity LessThan_16u_16u is
    port (cin: in std_logic;
        a: in std_logic_vector(15 downto 0);
        b: in std_logic_vector(15 downto 0);
        o: out std_logic
    );
    
end entity LessThan_16u_16u;

architecture INTERFACE of LessThan_16u_16u is 
    signal n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,
        n16,n17,n18,n19,n20,n21,n22,n23,n24,n25,n26,n27,n28,n29,
        n30,n31 : std_logic; 
begin
    n1 <= a(0) xor b(0);
    n2 <= b(0) when n1='1' else cin;
    n3 <= a(1) xor b(1);
    n4 <= b(1) when n3='1' else n2;
    n5 <= a(2) xor b(2);
    n6 <= b(2) when n5='1' else n4;
    n7 <= a(3) xor b(3);
    n8 <= b(3) when n7='1' else n6;
    n9 <= a(4) xor b(4);
    n10 <= b(4) when n9='1' else n8;
    n11 <= a(5) xor b(5);
    n12 <= b(5) when n11='1' else n10;
    n13 <= a(6) xor b(6);
    n14 <= b(6) when n13='1' else n12;
    n15 <= a(7) xor b(7);
    n16 <= b(7) when n15='1' else n14;
    n17 <= a(8) xor b(8);
    n18 <= b(8) when n17='1' else n16;
    n19 <= a(9) xor b(9);
    n20 <= b(9) when n19='1' else n18;
    n21 <= a(10) xor b(10);
    n22 <= b(10) when n21='1' else n20;
    n23 <= a(11) xor b(11);
    n24 <= b(11) when n23='1' else n22;
    n25 <= a(12) xor b(12);
    n26 <= b(12) when n25='1' else n24;
    n27 <= a(13) xor b(13);
    n28 <= b(13) when n27='1' else n26;
    n29 <= a(14) xor b(14);
    n30 <= b(14) when n29='1' else n28;
    n31 <= a(15) xor b(15);
    o <= b(15) when n31='1' else n30;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of module trig_latency_fifo
--

-- trig_latency_fifo is a black box. Cannot print a valid VHDL entity description for it

--
-- Verific VHDL Description of OPERATOR reduce_or_16
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_or_16 is
    port (a: in std_logic_vector(15 downto 0);
        o: out std_logic
    );
    
end entity reduce_or_16;

architecture INTERFACE of reduce_or_16 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(2) or a(3);
    n3 <= n1 or n2;
    n4 <= a(4) or a(5);
    n5 <= a(6) or a(7);
    n6 <= n4 or n5;
    n7 <= n3 or n6;
    n8 <= a(8) or a(9);
    n9 <= a(10) or a(11);
    n10 <= n8 or n9;
    n11 <= a(12) or a(13);
    n12 <= a(14) or a(15);
    n13 <= n11 or n12;
    n14 <= n10 or n13;
    o <= n7 or n14;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of module data_channel_fifo
--

-- data_channel_fifo is a black box. Cannot print a valid VHDL entity description for it

--
-- Verific VHDL Description of OPERATOR add_64u_64u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity add_64u_64u is
    port (cin: in std_logic;
        a: in std_logic_vector(63 downto 0);
        b: in std_logic_vector(63 downto 0);
        o: out std_logic_vector(63 downto 0);
        cout: out std_logic
    );
    
end entity add_64u_64u;

architecture INTERFACE of add_64u_64u is 
    signal n2,n4,n6,n8,n10,n12,n14,n16,n18,n20,n22,n24,n26,n28,
        n30,n32,n34,n36,n38,n40,n42,n44,n46,n48,n50,n52,n54,n56,
        n58,n60,n62,n64,n66,n68,n70,n72,n74,n76,n78,n80,n82,n84,
        n86,n88,n90,n92,n94,n96,n98,n100,n102,n104,n106,n108,n110,
        n112,n114,n116,n118,n120,n122,n124,n126 : std_logic; 
begin
    n2 <= a(0) or b(0) when cin='1' else a(0) and b(0);
    o(0) <= a(0) xor b(0) xor cin;
    n4 <= a(1) or b(1) when n2='1' else a(1) and b(1);
    o(1) <= a(1) xor b(1) xor n2;
    n6 <= a(2) or b(2) when n4='1' else a(2) and b(2);
    o(2) <= a(2) xor b(2) xor n4;
    n8 <= a(3) or b(3) when n6='1' else a(3) and b(3);
    o(3) <= a(3) xor b(3) xor n6;
    n10 <= a(4) or b(4) when n8='1' else a(4) and b(4);
    o(4) <= a(4) xor b(4) xor n8;
    n12 <= a(5) or b(5) when n10='1' else a(5) and b(5);
    o(5) <= a(5) xor b(5) xor n10;
    n14 <= a(6) or b(6) when n12='1' else a(6) and b(6);
    o(6) <= a(6) xor b(6) xor n12;
    n16 <= a(7) or b(7) when n14='1' else a(7) and b(7);
    o(7) <= a(7) xor b(7) xor n14;
    n18 <= a(8) or b(8) when n16='1' else a(8) and b(8);
    o(8) <= a(8) xor b(8) xor n16;
    n20 <= a(9) or b(9) when n18='1' else a(9) and b(9);
    o(9) <= a(9) xor b(9) xor n18;
    n22 <= a(10) or b(10) when n20='1' else a(10) and b(10);
    o(10) <= a(10) xor b(10) xor n20;
    n24 <= a(11) or b(11) when n22='1' else a(11) and b(11);
    o(11) <= a(11) xor b(11) xor n22;
    n26 <= a(12) or b(12) when n24='1' else a(12) and b(12);
    o(12) <= a(12) xor b(12) xor n24;
    n28 <= a(13) or b(13) when n26='1' else a(13) and b(13);
    o(13) <= a(13) xor b(13) xor n26;
    n30 <= a(14) or b(14) when n28='1' else a(14) and b(14);
    o(14) <= a(14) xor b(14) xor n28;
    n32 <= a(15) or b(15) when n30='1' else a(15) and b(15);
    o(15) <= a(15) xor b(15) xor n30;
    n34 <= a(16) or b(16) when n32='1' else a(16) and b(16);
    o(16) <= a(16) xor b(16) xor n32;
    n36 <= a(17) or b(17) when n34='1' else a(17) and b(17);
    o(17) <= a(17) xor b(17) xor n34;
    n38 <= a(18) or b(18) when n36='1' else a(18) and b(18);
    o(18) <= a(18) xor b(18) xor n36;
    n40 <= a(19) or b(19) when n38='1' else a(19) and b(19);
    o(19) <= a(19) xor b(19) xor n38;
    n42 <= a(20) or b(20) when n40='1' else a(20) and b(20);
    o(20) <= a(20) xor b(20) xor n40;
    n44 <= a(21) or b(21) when n42='1' else a(21) and b(21);
    o(21) <= a(21) xor b(21) xor n42;
    n46 <= a(22) or b(22) when n44='1' else a(22) and b(22);
    o(22) <= a(22) xor b(22) xor n44;
    n48 <= a(23) or b(23) when n46='1' else a(23) and b(23);
    o(23) <= a(23) xor b(23) xor n46;
    n50 <= a(24) or b(24) when n48='1' else a(24) and b(24);
    o(24) <= a(24) xor b(24) xor n48;
    n52 <= a(25) or b(25) when n50='1' else a(25) and b(25);
    o(25) <= a(25) xor b(25) xor n50;
    n54 <= a(26) or b(26) when n52='1' else a(26) and b(26);
    o(26) <= a(26) xor b(26) xor n52;
    n56 <= a(27) or b(27) when n54='1' else a(27) and b(27);
    o(27) <= a(27) xor b(27) xor n54;
    n58 <= a(28) or b(28) when n56='1' else a(28) and b(28);
    o(28) <= a(28) xor b(28) xor n56;
    n60 <= a(29) or b(29) when n58='1' else a(29) and b(29);
    o(29) <= a(29) xor b(29) xor n58;
    n62 <= a(30) or b(30) when n60='1' else a(30) and b(30);
    o(30) <= a(30) xor b(30) xor n60;
    n64 <= a(31) or b(31) when n62='1' else a(31) and b(31);
    o(31) <= a(31) xor b(31) xor n62;
    n66 <= a(32) or b(32) when n64='1' else a(32) and b(32);
    o(32) <= a(32) xor b(32) xor n64;
    n68 <= a(33) or b(33) when n66='1' else a(33) and b(33);
    o(33) <= a(33) xor b(33) xor n66;
    n70 <= a(34) or b(34) when n68='1' else a(34) and b(34);
    o(34) <= a(34) xor b(34) xor n68;
    n72 <= a(35) or b(35) when n70='1' else a(35) and b(35);
    o(35) <= a(35) xor b(35) xor n70;
    n74 <= a(36) or b(36) when n72='1' else a(36) and b(36);
    o(36) <= a(36) xor b(36) xor n72;
    n76 <= a(37) or b(37) when n74='1' else a(37) and b(37);
    o(37) <= a(37) xor b(37) xor n74;
    n78 <= a(38) or b(38) when n76='1' else a(38) and b(38);
    o(38) <= a(38) xor b(38) xor n76;
    n80 <= a(39) or b(39) when n78='1' else a(39) and b(39);
    o(39) <= a(39) xor b(39) xor n78;
    n82 <= a(40) or b(40) when n80='1' else a(40) and b(40);
    o(40) <= a(40) xor b(40) xor n80;
    n84 <= a(41) or b(41) when n82='1' else a(41) and b(41);
    o(41) <= a(41) xor b(41) xor n82;
    n86 <= a(42) or b(42) when n84='1' else a(42) and b(42);
    o(42) <= a(42) xor b(42) xor n84;
    n88 <= a(43) or b(43) when n86='1' else a(43) and b(43);
    o(43) <= a(43) xor b(43) xor n86;
    n90 <= a(44) or b(44) when n88='1' else a(44) and b(44);
    o(44) <= a(44) xor b(44) xor n88;
    n92 <= a(45) or b(45) when n90='1' else a(45) and b(45);
    o(45) <= a(45) xor b(45) xor n90;
    n94 <= a(46) or b(46) when n92='1' else a(46) and b(46);
    o(46) <= a(46) xor b(46) xor n92;
    n96 <= a(47) or b(47) when n94='1' else a(47) and b(47);
    o(47) <= a(47) xor b(47) xor n94;
    n98 <= a(48) or b(48) when n96='1' else a(48) and b(48);
    o(48) <= a(48) xor b(48) xor n96;
    n100 <= a(49) or b(49) when n98='1' else a(49) and b(49);
    o(49) <= a(49) xor b(49) xor n98;
    n102 <= a(50) or b(50) when n100='1' else a(50) and b(50);
    o(50) <= a(50) xor b(50) xor n100;
    n104 <= a(51) or b(51) when n102='1' else a(51) and b(51);
    o(51) <= a(51) xor b(51) xor n102;
    n106 <= a(52) or b(52) when n104='1' else a(52) and b(52);
    o(52) <= a(52) xor b(52) xor n104;
    n108 <= a(53) or b(53) when n106='1' else a(53) and b(53);
    o(53) <= a(53) xor b(53) xor n106;
    n110 <= a(54) or b(54) when n108='1' else a(54) and b(54);
    o(54) <= a(54) xor b(54) xor n108;
    n112 <= a(55) or b(55) when n110='1' else a(55) and b(55);
    o(55) <= a(55) xor b(55) xor n110;
    n114 <= a(56) or b(56) when n112='1' else a(56) and b(56);
    o(56) <= a(56) xor b(56) xor n112;
    n116 <= a(57) or b(57) when n114='1' else a(57) and b(57);
    o(57) <= a(57) xor b(57) xor n114;
    n118 <= a(58) or b(58) when n116='1' else a(58) and b(58);
    o(58) <= a(58) xor b(58) xor n116;
    n120 <= a(59) or b(59) when n118='1' else a(59) and b(59);
    o(59) <= a(59) xor b(59) xor n118;
    n122 <= a(60) or b(60) when n120='1' else a(60) and b(60);
    o(60) <= a(60) xor b(60) xor n120;
    n124 <= a(61) or b(61) when n122='1' else a(61) and b(61);
    o(61) <= a(61) xor b(61) xor n122;
    n126 <= a(62) or b(62) when n124='1' else a(62) and b(62);
    o(62) <= a(62) xor b(62) xor n124;
    cout <= a(63) or b(63) when n126='1' else a(63) and b(63);
    o(63) <= a(63) xor b(63) xor n126;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_and_2
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_and_2 is
    port (a: in std_logic_vector(1 downto 0);
        o: out std_logic
    );
    
end entity reduce_and_2;

architecture INTERFACE of reduce_and_2 is 
    
begin
    o <= a(0) and a(1);
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR add_15u_15u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity add_15u_15u is
    port (cin: in std_logic;
        a: in std_logic_vector(14 downto 0);
        b: in std_logic_vector(14 downto 0);
        o: out std_logic_vector(14 downto 0);
        cout: out std_logic
    );
    
end entity add_15u_15u;

architecture INTERFACE of add_15u_15u is 
    signal n2,n4,n6,n8,n10,n12,n14,n16,n18,n20,n22,n24,n26,n28 : std_logic; 
begin
    n2 <= a(0) or b(0) when cin='1' else a(0) and b(0);
    o(0) <= a(0) xor b(0) xor cin;
    n4 <= a(1) or b(1) when n2='1' else a(1) and b(1);
    o(1) <= a(1) xor b(1) xor n2;
    n6 <= a(2) or b(2) when n4='1' else a(2) and b(2);
    o(2) <= a(2) xor b(2) xor n4;
    n8 <= a(3) or b(3) when n6='1' else a(3) and b(3);
    o(3) <= a(3) xor b(3) xor n6;
    n10 <= a(4) or b(4) when n8='1' else a(4) and b(4);
    o(4) <= a(4) xor b(4) xor n8;
    n12 <= a(5) or b(5) when n10='1' else a(5) and b(5);
    o(5) <= a(5) xor b(5) xor n10;
    n14 <= a(6) or b(6) when n12='1' else a(6) and b(6);
    o(6) <= a(6) xor b(6) xor n12;
    n16 <= a(7) or b(7) when n14='1' else a(7) and b(7);
    o(7) <= a(7) xor b(7) xor n14;
    n18 <= a(8) or b(8) when n16='1' else a(8) and b(8);
    o(8) <= a(8) xor b(8) xor n16;
    n20 <= a(9) or b(9) when n18='1' else a(9) and b(9);
    o(9) <= a(9) xor b(9) xor n18;
    n22 <= a(10) or b(10) when n20='1' else a(10) and b(10);
    o(10) <= a(10) xor b(10) xor n20;
    n24 <= a(11) or b(11) when n22='1' else a(11) and b(11);
    o(11) <= a(11) xor b(11) xor n22;
    n26 <= a(12) or b(12) when n24='1' else a(12) and b(12);
    o(12) <= a(12) xor b(12) xor n24;
    n28 <= a(13) or b(13) when n26='1' else a(13) and b(13);
    o(13) <= a(13) xor b(13) xor n26;
    cout <= a(14) or b(14) when n28='1' else a(14) and b(14);
    o(14) <= a(14) xor b(14) xor n28;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_16
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_16 is
    port (a: in std_logic_vector(15 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_16;

architecture INTERFACE of reduce_nor_16 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(2) or a(3);
    n3 <= n1 or n2;
    n4 <= a(4) or a(5);
    n5 <= a(6) or a(7);
    n6 <= n4 or n5;
    n7 <= n3 or n6;
    n8 <= a(8) or a(9);
    n9 <= a(10) or a(11);
    n10 <= n8 or n9;
    n11 <= a(12) or a(13);
    n12 <= a(14) or a(15);
    n13 <= n11 or n12;
    n14 <= n10 or n13;
    n15 <= n7 or n14;
    o <= not n15;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR add_16u_16u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity add_16u_16u is
    port (cin: in std_logic;
        a: in std_logic_vector(15 downto 0);
        b: in std_logic_vector(15 downto 0);
        o: out std_logic_vector(15 downto 0);
        cout: out std_logic
    );
    
end entity add_16u_16u;

architecture INTERFACE of add_16u_16u is 
    signal n2,n4,n6,n8,n10,n12,n14,n16,n18,n20,n22,n24,n26,n28,
        n30 : std_logic; 
begin
    n2 <= a(0) or b(0) when cin='1' else a(0) and b(0);
    o(0) <= a(0) xor b(0) xor cin;
    n4 <= a(1) or b(1) when n2='1' else a(1) and b(1);
    o(1) <= a(1) xor b(1) xor n2;
    n6 <= a(2) or b(2) when n4='1' else a(2) and b(2);
    o(2) <= a(2) xor b(2) xor n4;
    n8 <= a(3) or b(3) when n6='1' else a(3) and b(3);
    o(3) <= a(3) xor b(3) xor n6;
    n10 <= a(4) or b(4) when n8='1' else a(4) and b(4);
    o(4) <= a(4) xor b(4) xor n8;
    n12 <= a(5) or b(5) when n10='1' else a(5) and b(5);
    o(5) <= a(5) xor b(5) xor n10;
    n14 <= a(6) or b(6) when n12='1' else a(6) and b(6);
    o(6) <= a(6) xor b(6) xor n12;
    n16 <= a(7) or b(7) when n14='1' else a(7) and b(7);
    o(7) <= a(7) xor b(7) xor n14;
    n18 <= a(8) or b(8) when n16='1' else a(8) and b(8);
    o(8) <= a(8) xor b(8) xor n16;
    n20 <= a(9) or b(9) when n18='1' else a(9) and b(9);
    o(9) <= a(9) xor b(9) xor n18;
    n22 <= a(10) or b(10) when n20='1' else a(10) and b(10);
    o(10) <= a(10) xor b(10) xor n20;
    n24 <= a(11) or b(11) when n22='1' else a(11) and b(11);
    o(11) <= a(11) xor b(11) xor n22;
    n26 <= a(12) or b(12) when n24='1' else a(12) and b(12);
    o(12) <= a(12) xor b(12) xor n24;
    n28 <= a(13) or b(13) when n26='1' else a(13) and b(13);
    o(13) <= a(13) xor b(13) xor n26;
    n30 <= a(14) or b(14) when n28='1' else a(14) and b(14);
    o(14) <= a(14) xor b(14) xor n28;
    cout <= a(15) or b(15) when n30='1' else a(15) and b(15);
    o(15) <= a(15) xor b(15) xor n30;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR Mux_3u_8u
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Mux_3u_8u is
    port (sel: in std_logic_vector(2 downto 0);
        data: in std_logic_vector(7 downto 0);
        o: out std_logic
    );
    
end entity Mux_3u_8u;

architecture INTERFACE of Mux_3u_8u is 
    signal n1,n2,n3,n4,n5,n6 : std_logic; 
begin
    n1 <= data(1) when sel(0)='1' else data(0);
    n2 <= data(3) when sel(0)='1' else data(2);
    n3 <= n2 when sel(1)='1' else n1;
    n4 <= data(5) when sel(0)='1' else data(4);
    n5 <= data(7) when sel(0)='1' else data(6);
    n6 <= n5 when sel(1)='1' else n4;
    o <= n6 when sel(2)='1' else n3;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_3
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_3 is
    port (a: in std_logic_vector(2 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_3;

architecture INTERFACE of reduce_nor_3 is 
    signal n1,n2 : std_logic; 
begin
    n1 <= a(1) or a(2);
    n2 <= a(0) or n1;
    o <= not n2;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_32
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_32 is
    port (a: in std_logic_vector(31 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_32;

architecture INTERFACE of reduce_nor_32 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,
        n16,n17,n18,n19,n20,n21,n22,n23,n24,n25,n26,n27,n28,n29,
        n30,n31 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(2) or a(3);
    n3 <= n1 or n2;
    n4 <= a(4) or a(5);
    n5 <= a(6) or a(7);
    n6 <= n4 or n5;
    n7 <= n3 or n6;
    n8 <= a(8) or a(9);
    n9 <= a(10) or a(11);
    n10 <= n8 or n9;
    n11 <= a(12) or a(13);
    n12 <= a(14) or a(15);
    n13 <= n11 or n12;
    n14 <= n10 or n13;
    n15 <= n7 or n14;
    n16 <= a(16) or a(17);
    n17 <= a(18) or a(19);
    n18 <= n16 or n17;
    n19 <= a(20) or a(21);
    n20 <= a(22) or a(23);
    n21 <= n19 or n20;
    n22 <= n18 or n21;
    n23 <= a(24) or a(25);
    n24 <= a(26) or a(27);
    n25 <= n23 or n24;
    n26 <= a(28) or a(29);
    n27 <= a(30) or a(31);
    n28 <= n26 or n27;
    n29 <= n25 or n28;
    n30 <= n22 or n29;
    n31 <= n15 or n30;
    o <= not n31;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_nor_9
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_nor_9 is
    port (a: in std_logic_vector(8 downto 0);
        o: out std_logic
    );
    
end entity reduce_nor_9;

architecture INTERFACE of reduce_nor_9 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(2) or a(3);
    n3 <= n1 or n2;
    n4 <= a(4) or a(5);
    n5 <= a(7) or a(8);
    n6 <= a(6) or n5;
    n7 <= n4 or n6;
    n8 <= n3 or n7;
    o <= not n8;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_or_6
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_or_6 is
    port (a: in std_logic_vector(5 downto 0);
        o: out std_logic
    );
    
end entity reduce_or_6;

architecture INTERFACE of reduce_or_6 is 
    signal n1,n2,n3,n4 : std_logic; 
begin
    n1 <= a(1) or a(2);
    n2 <= a(0) or n1;
    n3 <= a(4) or a(5);
    n4 <= a(3) or n3;
    o <= n2 or n4;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR Select_5
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Select_5 is
    port (sel: in std_logic_vector(4 downto 0);
        data: in std_logic_vector(4 downto 0);
        o: out std_logic
    );
    
end entity Select_5;

architecture INTERFACE of Select_5 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8 : std_logic; 
begin
    n1 <= data(0) and sel(0);
    n2 <= data(1) and sel(1);
    n3 <= data(2) and sel(2);
    n4 <= data(3) and sel(3);
    n5 <= data(4) and sel(4);
    n6 <= n1 or n2;
    n7 <= n4 or n5;
    n8 <= n3 or n7;
    o <= n6 or n8;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR reduce_or_5
--

library ieee ;
use ieee.std_logic_1164.all ;

entity reduce_or_5 is
    port (a: in std_logic_vector(4 downto 0);
        o: out std_logic
    );
    
end entity reduce_or_5;

architecture INTERFACE of reduce_or_5 is 
    signal n1,n2,n3 : std_logic; 
begin
    n1 <= a(0) or a(1);
    n2 <= a(3) or a(4);
    n3 <= a(2) or n2;
    o <= n1 or n3;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of OPERATOR Select_6
--

library ieee ;
use ieee.std_logic_1164.all ;

entity Select_6 is
    port (sel: in std_logic_vector(5 downto 0);
        data: in std_logic_vector(5 downto 0);
        o: out std_logic
    );
    
end entity Select_6;

architecture INTERFACE of Select_6 is 
    signal n1,n2,n3,n4,n5,n6,n7,n8,n9,n10 : std_logic; 
begin
    n1 <= data(0) and sel(0);
    n2 <= data(1) and sel(1);
    n3 <= data(2) and sel(2);
    n4 <= data(3) and sel(3);
    n5 <= data(4) and sel(4);
    n6 <= data(5) and sel(5);
    n7 <= n2 or n3;
    n8 <= n1 or n7;
    n9 <= n5 or n6;
    n10 <= n4 or n9;
    o <= n8 or n10;
    
end architecture INTERFACE;


--
-- Verific VHDL Description of module data_assembly
--

library ieee ;
use ieee.std_logic_1164.all ;

entity data_assembly is
    port (adc_raw_data: in std_logic_vector(127 downto 0);   -- data_assembly.v(24)
        adc_user_clk: in std_logic;   -- data_assembly.v(25)
        init_rst: in std_logic;   -- data_assembly.v(27)
        trig_in: in std_logic;   -- data_assembly.v(28)
        trig_out: out std_logic;   -- data_assembly.v(29)
        config_din_valid: in std_logic;   -- data_assembly.v(31)
        config_din_addr: in std_logic_vector(31 downto 0);   -- data_assembly.v(32)
        config_din_data: in std_logic_vector(31 downto 0);   -- data_assembly.v(33)
        config_dout_valid: out std_logic;   -- data_assembly.v(35)
        config_dout_addr: out std_logic_vector(31 downto 0);   -- data_assembly.v(36)
        config_dout_data: out std_logic_vector(31 downto 0);   -- data_assembly.v(37)
        init_clk: in std_logic;   -- data_assembly.v(40)
        data_channel_fifo_rd_en: in std_logic_vector(1 downto 0);   -- data_assembly.v(41)
        data_channel_fifo_out: out std_logic_vector(255 downto 0);   -- data_assembly.v(42)
        data_channel_fifo_out_valid: out std_logic_vector(1 downto 0);   -- data_assembly.v(43)
        data_channel_fifo_full: out std_logic_vector(1 downto 0);   -- data_assembly.v(44)
        data_channel_fifo_empty: out std_logic_vector(1 downto 0);   -- data_assembly.v(45)
        windows_cnt: out std_logic_vector(15 downto 0);   -- data_assembly.v(47)
        start_out: in std_logic;   -- data_assembly.v(48)
        fmc_reg: in std_logic_vector(255 downto 0)   -- data_assembly.v(49)
    );
    
end entity data_assembly;   -- data_assembly.v(21)

architecture \.\ of data_assembly is 
    procedure VERIFIC_DFFRS (d: in std_logic;
        signal clk: in std_logic;
        s: in std_logic;
        r: in std_logic;
        signal q: inout std_logic
    ) is begin
        if (s='1') then
            q <= '1' ;
        elsif (r='1') then
            q <= '0' ;
        elsif (clk'event and clk='1') then
            q <= d ;
        end if ;
    end procedure VERIFIC_DFFRS;
    component trig_latency_fifo is
        port (clk: inout std_logic;
            rst: inout std_logic;
            din: inout std_logic_vector(127 downto 0);
            wr_en: inout std_logic;
            rd_en: inout std_logic;
            dout: inout std_logic_vector(127 downto 0);
            full: inout std_logic;
            empty: inout std_logic;
            data_count: inout std_logic_vector(10 downto 0)
        );
        
    end component trig_latency_fifo;   -- data_assembly.v(77)
    component data_channel_fifo is
        port (rst: inout std_logic;
            wr_clk: inout std_logic;
            wr_en: inout std_logic;
            din: inout std_logic_vector(127 downto 0);
            rd_clk: inout std_logic;
            rd_en: inout std_logic;
            dout: inout std_logic_vector(127 downto 0);
            valid: inout std_logic;
            full: inout std_logic;
            empty: inout std_logic;
            rd_data_count: inout std_logic_vector(5 downto 0)
        );
        
    end component data_channel_fifo;   -- data_assembly.v(93)
    signal adc_raw_data_c : std_logic_vector(127 downto 0);   -- data_assembly.v(24)
    signal adc_user_clk_c : std_logic;   -- data_assembly.v(25)
    signal config_dout_valid_c : std_logic;   -- data_assembly.v(35)
    signal init_clk_c : std_logic;   -- data_assembly.v(40)
    signal data_channel_fifo_rd_en_c : std_logic_vector(1 downto 0);   -- data_assembly.v(41)
    signal data_channel_fifo_out_c : std_logic_vector(255 downto 0);   -- data_assembly.v(42)
    signal data_channel_fifo_out_valid_c : std_logic_vector(1 downto 0);   -- data_assembly.v(43)
    signal data_channel_fifo_full_c : std_logic_vector(1 downto 0);   -- data_assembly.v(44)
    signal data_channel_fifo_empty_c : std_logic_vector(1 downto 0);   -- data_assembly.v(45)
    signal sample_reset : std_logic;   -- data_assembly.v(52)
    signal sample_start : std_logic;   -- data_assembly.v(52)
    signal sample_count_value_r : std_logic_vector(15 downto 0);   -- data_assembly.v(53)
    signal trig_latency_count_value_r : std_logic_vector(15 downto 0);   -- data_assembly.v(53)
    signal sample_delay_count_value_r : std_logic_vector(15 downto 0);   -- data_assembly.v(53)
    signal samping_count : std_logic_vector(15 downto 0);   -- data_assembly.v(54)
    signal trig_latency_count : std_logic_vector(15 downto 0);   -- data_assembly.v(54)
    signal sample_delay_count : std_logic_vector(15 downto 0);   -- data_assembly.v(54)
    signal extrig_en_r : std_logic;   -- data_assembly.v(55)
    signal reset_i : std_logic;   -- data_assembly.v(57)
    signal reset_r : std_logic_vector(9 downto 0);   -- data_assembly.v(58)
    signal reset_i_dly : std_logic;   -- data_assembly.v(62)
    signal trigger_type : std_logic_vector(1 downto 0);   -- data_assembly.v(65)
    signal trig_latency_fifo_out : std_logic_vector(127 downto 0);   -- data_assembly.v(67)
    signal trig_latency_fifo_full : std_logic; -- KEEP="TRUE"    -- data_assembly.v(68)
    signal trig_latency_fifo_empty : std_logic; -- KEEP="TRUE"    -- data_assembly.v(69)
    signal trig_latency_fifo_data_count : std_logic_vector(10 downto 0);   -- data_assembly.v(70)
    signal trig_latency_fifo_wren : std_logic;   -- data_assembly.v(72)
    signal trig_latency_fifo_rden : std_logic;   -- data_assembly.v(73)
    signal data_channel_fifo_wren : std_logic_vector(1 downto 0);   -- data_assembly.v(89)
    signal data_channel_fifo_in : std_logic_vector(127 downto 0);   -- data_assembly.v(90)
    signal data_channel_fifo_rd_data_count : std_logic_vector(11 downto 0);   -- data_assembly.v(91)
    signal start_adc : std_logic; -- KEEP="TRUE"    -- data_assembly.v(120)
    signal start_adc_plus : std_logic; -- KEEP="TRUE"    -- data_assembly.v(120)
    signal trig_in_plus_r : std_logic_vector(1 downto 0);   -- data_assembly.v(121)
    signal trig_num : std_logic_vector(15 downto 0);   -- data_assembly.v(122)
    signal time_cnt : std_logic_vector(63 downto 0);   -- data_assembly.v(123)
    signal sample_current_state : std_logic_vector(2 downto 0);   -- data_assembly.v(150)
    signal sample_next_state : std_logic_vector(2 downto 0);   -- data_assembly.v(150)
    signal config_daq2c : std_logic_vector(15 downto 0);   -- data_assembly.v(268)
    signal n8,n9,n10,n11,n12,n13,n14,n15,n16,n17,n18,n19,n20,n21,
        n22,n23,n24,n25,n26,n27,n28,n29,n30,n31,n32,n33,n34,n35,
        n36,n37,n50,n53,n55,n56,n58,n61,n62,n63,n64,n65,n66,n67,
        n68,n69,n70,n71,n72,n73,n74,n75,n76,n77,n78,n79,n80,n81,
        n82,n83,n84,n85,n86,n87,n88,n89,n90,n91,n92,n93,n94,n95,
        n96,n97,n98,n99,n100,n101,n102,n103,n104,n105,n106,n107,
        n108,n109,n110,n111,n112,n113,n114,n115,n116,n117,n118,n119,
        n120,n121,n122,n123,n124,n125,n126,n127,n128,n129,n130,n131,
        n132,n133,n134,n135,n136,n137,n138,n139,n140,n141,n142,n143,
        n144,n145,n146,n147,n148,n149,n150,n151,n152,n153,n154,n155,
        n156,n157,n158,n159,n160,n161,n162,n163,n164,n165,n166,n167,
        n168,n169,n170,n171,n172,n173,n174,n175,n176,n177,n178,n179,
        n180,n181,n182,n183,n184,n185,n186,n187,n188,n191,n258,n264,
        n265,n266,n267,n269,n270,n271,n272,n273,n274,n275,n276,n277,
        n278,n279,n280,n281,n282,n283,n284,n285,n286,n287,n288,n289,
        n290,n291,n292,n293,n294,n295,n296,n297,n298,n299,n300,n302,
        n303,n304,n305,n306,n307,n308,n309,n310,n311,n312,n313,n314,
        n315,n316,n317,n318,n319,n320,n321,n322,n323,n324,n325,n326,
        n327,n328,n329,n330,n331,n332,n333,n334,n335,n341,n342,n343,
        n344,n345,n346,n347,n348,n349,n350,n351,n352,n353,n354,n355,
        n356,n357,n358,n359,n360,n361,n362,n363,n364,n365,n366,n367,
        n368,n369,n370,n371,n372,n373,n374,n375,n376,n377,n378,n379,
        n380,n381,n382,n383,n384,n385,n386,n387,n388,n389,n390,n391,
        n392,n393,n394,n395,n396,n397,n398,n399,n400,n401,n402,n403,
        n404,n405,n406,n407,n408,n409,n410,n411,n412,n413,n414,n415,
        n416,n417,n418,n419,n420,n421,n422,n423,n424,n425,n426,n427,
        n428,n429,n430,n431,n432,n433,n434,n435,n436,n437,n438,n439,
        n440,n441,n442,n443,n444,n445,n446,n447,n448,n449,n450,n451,
        n452,n453,n454,n455,n456,n457,n458,n459,n460,n461,n462,n463,
        n464,n465,n466,n467,n468,n469,n470,n471,n472,n473,n474,n475,
        n476,n477,n478,n479,n480,n481,n482,n483,n484,n485,n487,n488,
        n489,n490,n491,n492,n493,n494,n495,n496,n497,n498,n499,n500,
        n501,n502,n503,n504,n505,n506,n507,n508,n509,n510,n511,n512,
        n513,n514,n515,n516,n517,n518,n519,n520,n521,n522,n523,n524,
        n525,n526,n527,n528,n529,n530,n531,n532,n533,n534,n535,n536,
        n537,n538,n539,n540,n541,n542,n543,n544,n545,n546,n547,n548,
        n549,n550,n551,n552,n553,n554,n555,n556,n557,n558,n559,n560,
        n561,n562,n563,n564,n565,n566,n567,n568,n569,n570,n571,n572,
        n573,n574,n575,n576,n577,n578,n579,n580,n581,n582,n583,n584,
        n585,n586,n587,n588,n589,n590,n591,n592,n593,n594,n595,n596,
        n597,n598,n599,n600,n601,n602,n603,n604,n605,n606,n607,n608,
        n609,n610,n611,n612,n613,n614,n615,n616,n617,n618,n619,n620,
        n621,n622,n623,n624,n625,n626,n627,n628,n629,n630,n631,n632,
        n633,n634,n635,n636,n637,n638,n639,n640,n641,n642,n643,n644,
        n645,n646,n647,n648,n649,n650,n651,n652,n653,n654,n655,n656,
        n657,n658,n659,n660,n661,n662,n663,n664,n665,n666,n667,n668,
        n669,n670,n671,n672,n673,n674,n675,n676,n677,n678,n679,n680,
        n681,n682,n683,n684,n685,n686,n687,n688,n689,n690,n691,n692,
        n693,n694,n695,n696,n697,n698,n699,n700,n701,n702,n703,n704,
        n705,n706,n707,n708,n709,n710,n711,n712,n713,n714,n715,n716,
        n717,n718,n719,n720,n721,n722,n723,n724,n725,n726,n727,n728,
        n729,n730,n731,n732,n733,n734,n735,n736,n737,n738,n739,n740,
        n741,n742,n743,n744,n745,n746,n747,n748,n749,n750,n751,n752,
        n753,n754,n755,n756,n757,n758,n759,n760,n761,n762,n763,n764,
        n765,n766,n767,n768,n769,n770,n771,n772,n773,n774,n775,n776,
        n777,n778,n779,n780,n781,n782,n783,n784,n785,n786,n787,n788,
        n789,n790,n791,n792,n793,n794,n795,n796,n797,n798,n799,n800,
        n801,n802,n803,n804,n805,n806,n807,n808,n809,n810,n811,n812,
        n813,n814,n815,n816,n817,n818,n819,n820,n821,n822,n823,n824,
        n825,n826,n990,n991,n993,n994,n995,n996,n997,n998,n999,n1000,
        n1001,n1002,n1003,n1004,n1005,n1006,n1007,n1008,n1009,n1010,
        n1011,n1012,n1013,n1014,n1015,n1016,n1017,n1018,n1019,n1020,
        n1021,n1022,n1023,n1024,n1025,n1026,n1027,n1028,n1029,n1030,
        n1031,n1032,n1033,n1034,n1035,n1036,n1037,n1038,n1039,n1040,
        n1059,n1060,n1061,n1062,n1063,n1064,n1065,n1066,n1067,n1068,
        n1069,n1070,n1071,n1072,n1073,n1074,n1075,n1076,n1077,n1079,
        n1080,n1081,n1082,n1083,n1084,n1085,n1086,n1087,n1088,n1089,
        n1090,n1091,n1092,n1093,n1094,n1095,n1097,n1098,n1099,n1100,
        n1101,n1102,n1103,n1104,n1105,n1106,n1107,n1108,n1109,n1110,
        n1111,n1112,n1113,n1114,n1115,n1116,n1117,n1118,n1119,n1120,
        n1121,n1122,n1123,n1124,n1125,n1126,n1127,n1128,n1129,n1130,
        n1131,n1132,n1133,n1134,n1135,n1136,n1137,n1138,n1139,n1140,
        n1141,n1142,n1143,n1144,n1145,n1146,n1147,n1148,n1149,n1150,
        n1151,n1152,n1153,n1154,n1155,n1156,n1157,n1158,n1159,n1160,
        n1161,n1162,n1163,n1164,n1165,n1166,n1167,n1168,n1169,n1170,
        n1171,n1172,n1173,n1174,n1175,n1176,n1194,n1195,n1196,n1197,
        n1198,n1199,n1204,n1209,n1210,n1215,n1220,n1227,n1233,n1234,
        n1239,n1244,n1245,n1246,n1248,n1249,n1250,n1251,n1252,n1253,
        n1254,n1255,n1256,n1257,n1258,n1259,n1260,n1261,n1262,n1263,
        n1264,n1265,n1266,n1268,n1270,n1272,n1274,n1276,n1278,n1280,
        n1282,n1284,n1286,n1288,n1290,n1292,n1294,n1295,n1296,n1297,
        n1298,n1299,n1300,n1301,n1302,n1303,n1304,n1305,n1306,n1307,
        n1308,n1309,n1310,n1311,n1312,n1313,n1314,n1315,n1316,n1317,
        n1318,n1319,n1320,n1321,n1322,n1323,n1324,n1325,n1326,n1327,
        n1328,n1329,n1330,n1331,n1332,n1333,n1334,n1335,n1336,n1337,
        n1338,n1339,n1340,n1341,n1342,n1343,n1344,n1345,n1346,n1347,
        n1348,n1349,n1350,n1351,n1352,n1353,n1354,n1355,n1356,n1357,
        n1358,n1359,n1360,n1361,n1362,n1363,n1364,n1365,n1366,n1367,
        n1368,n1369,n1370,n1371,n1372,n1373,n1374,n1375,n1376,n1377,
        n1378,n1379,n1380,n1381,n1382,n1383,n1384,n1385,n1386,n1387,
        n1388,n1389,n1390,n1391,n1392,n1393,n1394,n1395,n1396,n1397,
        n1398,n1399,n1400,n1401,n1402,n1403,n1404,n1405,n1406,n1407,
        n1408,n1409,n1410,n1411,n1412,n1413,n1414,n1415,n1416,n1417,
        n1418,n1419,n1420,n1421,n1422,n1423,n1424,n1425,n1426,n1427,
        n1428,n1429,n1430,n1431,n1432,n1433,n1434,n1435,n1436,n1437,
        n1438,n1439,n1440,n1441,n1442,n1443,n1444,n1445,n1446,n1447,
        n1448,n1449,n1450,n1451,n1452,n1453,n1454,n1455,n1456,n1457,
        n1458,n1459,n1460,n1461,n1462,n1463,n1464,n1465,n1466,n1535,
        n1536,n1537,n1538,n1539,n1540,n1541,n1542,n1543,n1544,n1545,
        n1546,n1547,n1548 : std_logic; 
begin
    adc_raw_data_c(127) <= adc_raw_data(127);   -- data_assembly.v(24)
    adc_raw_data_c(126) <= adc_raw_data(126);   -- data_assembly.v(24)
    adc_raw_data_c(125) <= adc_raw_data(125);   -- data_assembly.v(24)
    adc_raw_data_c(124) <= adc_raw_data(124);   -- data_assembly.v(24)
    adc_raw_data_c(123) <= adc_raw_data(123);   -- data_assembly.v(24)
    adc_raw_data_c(122) <= adc_raw_data(122);   -- data_assembly.v(24)
    adc_raw_data_c(121) <= adc_raw_data(121);   -- data_assembly.v(24)
    adc_raw_data_c(120) <= adc_raw_data(120);   -- data_assembly.v(24)
    adc_raw_data_c(119) <= adc_raw_data(119);   -- data_assembly.v(24)
    adc_raw_data_c(118) <= adc_raw_data(118);   -- data_assembly.v(24)
    adc_raw_data_c(117) <= adc_raw_data(117);   -- data_assembly.v(24)
    adc_raw_data_c(116) <= adc_raw_data(116);   -- data_assembly.v(24)
    adc_raw_data_c(115) <= adc_raw_data(115);   -- data_assembly.v(24)
    adc_raw_data_c(114) <= adc_raw_data(114);   -- data_assembly.v(24)
    adc_raw_data_c(113) <= adc_raw_data(113);   -- data_assembly.v(24)
    adc_raw_data_c(112) <= adc_raw_data(112);   -- data_assembly.v(24)
    adc_raw_data_c(111) <= adc_raw_data(111);   -- data_assembly.v(24)
    adc_raw_data_c(110) <= adc_raw_data(110);   -- data_assembly.v(24)
    adc_raw_data_c(109) <= adc_raw_data(109);   -- data_assembly.v(24)
    adc_raw_data_c(108) <= adc_raw_data(108);   -- data_assembly.v(24)
    adc_raw_data_c(107) <= adc_raw_data(107);   -- data_assembly.v(24)
    adc_raw_data_c(106) <= adc_raw_data(106);   -- data_assembly.v(24)
    adc_raw_data_c(105) <= adc_raw_data(105);   -- data_assembly.v(24)
    adc_raw_data_c(104) <= adc_raw_data(104);   -- data_assembly.v(24)
    adc_raw_data_c(103) <= adc_raw_data(103);   -- data_assembly.v(24)
    adc_raw_data_c(102) <= adc_raw_data(102);   -- data_assembly.v(24)
    adc_raw_data_c(101) <= adc_raw_data(101);   -- data_assembly.v(24)
    adc_raw_data_c(100) <= adc_raw_data(100);   -- data_assembly.v(24)
    adc_raw_data_c(99) <= adc_raw_data(99);   -- data_assembly.v(24)
    adc_raw_data_c(98) <= adc_raw_data(98);   -- data_assembly.v(24)
    adc_raw_data_c(97) <= adc_raw_data(97);   -- data_assembly.v(24)
    adc_raw_data_c(96) <= adc_raw_data(96);   -- data_assembly.v(24)
    adc_raw_data_c(95) <= adc_raw_data(95);   -- data_assembly.v(24)
    adc_raw_data_c(94) <= adc_raw_data(94);   -- data_assembly.v(24)
    adc_raw_data_c(93) <= adc_raw_data(93);   -- data_assembly.v(24)
    adc_raw_data_c(92) <= adc_raw_data(92);   -- data_assembly.v(24)
    adc_raw_data_c(91) <= adc_raw_data(91);   -- data_assembly.v(24)
    adc_raw_data_c(90) <= adc_raw_data(90);   -- data_assembly.v(24)
    adc_raw_data_c(89) <= adc_raw_data(89);   -- data_assembly.v(24)
    adc_raw_data_c(88) <= adc_raw_data(88);   -- data_assembly.v(24)
    adc_raw_data_c(87) <= adc_raw_data(87);   -- data_assembly.v(24)
    adc_raw_data_c(86) <= adc_raw_data(86);   -- data_assembly.v(24)
    adc_raw_data_c(85) <= adc_raw_data(85);   -- data_assembly.v(24)
    adc_raw_data_c(84) <= adc_raw_data(84);   -- data_assembly.v(24)
    adc_raw_data_c(83) <= adc_raw_data(83);   -- data_assembly.v(24)
    adc_raw_data_c(82) <= adc_raw_data(82);   -- data_assembly.v(24)
    adc_raw_data_c(81) <= adc_raw_data(81);   -- data_assembly.v(24)
    adc_raw_data_c(80) <= adc_raw_data(80);   -- data_assembly.v(24)
    adc_raw_data_c(79) <= adc_raw_data(79);   -- data_assembly.v(24)
    adc_raw_data_c(78) <= adc_raw_data(78);   -- data_assembly.v(24)
    adc_raw_data_c(77) <= adc_raw_data(77);   -- data_assembly.v(24)
    adc_raw_data_c(76) <= adc_raw_data(76);   -- data_assembly.v(24)
    adc_raw_data_c(75) <= adc_raw_data(75);   -- data_assembly.v(24)
    adc_raw_data_c(74) <= adc_raw_data(74);   -- data_assembly.v(24)
    adc_raw_data_c(73) <= adc_raw_data(73);   -- data_assembly.v(24)
    adc_raw_data_c(72) <= adc_raw_data(72);   -- data_assembly.v(24)
    adc_raw_data_c(71) <= adc_raw_data(71);   -- data_assembly.v(24)
    adc_raw_data_c(70) <= adc_raw_data(70);   -- data_assembly.v(24)
    adc_raw_data_c(69) <= adc_raw_data(69);   -- data_assembly.v(24)
    adc_raw_data_c(68) <= adc_raw_data(68);   -- data_assembly.v(24)
    adc_raw_data_c(67) <= adc_raw_data(67);   -- data_assembly.v(24)
    adc_raw_data_c(66) <= adc_raw_data(66);   -- data_assembly.v(24)
    adc_raw_data_c(65) <= adc_raw_data(65);   -- data_assembly.v(24)
    adc_raw_data_c(64) <= adc_raw_data(64);   -- data_assembly.v(24)
    adc_raw_data_c(63) <= adc_raw_data(63);   -- data_assembly.v(24)
    adc_raw_data_c(62) <= adc_raw_data(62);   -- data_assembly.v(24)
    adc_raw_data_c(61) <= adc_raw_data(61);   -- data_assembly.v(24)
    adc_raw_data_c(60) <= adc_raw_data(60);   -- data_assembly.v(24)
    adc_raw_data_c(59) <= adc_raw_data(59);   -- data_assembly.v(24)
    adc_raw_data_c(58) <= adc_raw_data(58);   -- data_assembly.v(24)
    adc_raw_data_c(57) <= adc_raw_data(57);   -- data_assembly.v(24)
    adc_raw_data_c(56) <= adc_raw_data(56);   -- data_assembly.v(24)
    adc_raw_data_c(55) <= adc_raw_data(55);   -- data_assembly.v(24)
    adc_raw_data_c(54) <= adc_raw_data(54);   -- data_assembly.v(24)
    adc_raw_data_c(53) <= adc_raw_data(53);   -- data_assembly.v(24)
    adc_raw_data_c(52) <= adc_raw_data(52);   -- data_assembly.v(24)
    adc_raw_data_c(51) <= adc_raw_data(51);   -- data_assembly.v(24)
    adc_raw_data_c(50) <= adc_raw_data(50);   -- data_assembly.v(24)
    adc_raw_data_c(49) <= adc_raw_data(49);   -- data_assembly.v(24)
    adc_raw_data_c(48) <= adc_raw_data(48);   -- data_assembly.v(24)
    adc_raw_data_c(47) <= adc_raw_data(47);   -- data_assembly.v(24)
    adc_raw_data_c(46) <= adc_raw_data(46);   -- data_assembly.v(24)
    adc_raw_data_c(45) <= adc_raw_data(45);   -- data_assembly.v(24)
    adc_raw_data_c(44) <= adc_raw_data(44);   -- data_assembly.v(24)
    adc_raw_data_c(43) <= adc_raw_data(43);   -- data_assembly.v(24)
    adc_raw_data_c(42) <= adc_raw_data(42);   -- data_assembly.v(24)
    adc_raw_data_c(41) <= adc_raw_data(41);   -- data_assembly.v(24)
    adc_raw_data_c(40) <= adc_raw_data(40);   -- data_assembly.v(24)
    adc_raw_data_c(39) <= adc_raw_data(39);   -- data_assembly.v(24)
    adc_raw_data_c(38) <= adc_raw_data(38);   -- data_assembly.v(24)
    adc_raw_data_c(37) <= adc_raw_data(37);   -- data_assembly.v(24)
    adc_raw_data_c(36) <= adc_raw_data(36);   -- data_assembly.v(24)
    adc_raw_data_c(35) <= adc_raw_data(35);   -- data_assembly.v(24)
    adc_raw_data_c(34) <= adc_raw_data(34);   -- data_assembly.v(24)
    adc_raw_data_c(33) <= adc_raw_data(33);   -- data_assembly.v(24)
    adc_raw_data_c(32) <= adc_raw_data(32);   -- data_assembly.v(24)
    adc_raw_data_c(31) <= adc_raw_data(31);   -- data_assembly.v(24)
    adc_raw_data_c(30) <= adc_raw_data(30);   -- data_assembly.v(24)
    adc_raw_data_c(29) <= adc_raw_data(29);   -- data_assembly.v(24)
    adc_raw_data_c(28) <= adc_raw_data(28);   -- data_assembly.v(24)
    adc_raw_data_c(27) <= adc_raw_data(27);   -- data_assembly.v(24)
    adc_raw_data_c(26) <= adc_raw_data(26);   -- data_assembly.v(24)
    adc_raw_data_c(25) <= adc_raw_data(25);   -- data_assembly.v(24)
    adc_raw_data_c(24) <= adc_raw_data(24);   -- data_assembly.v(24)
    adc_raw_data_c(23) <= adc_raw_data(23);   -- data_assembly.v(24)
    adc_raw_data_c(22) <= adc_raw_data(22);   -- data_assembly.v(24)
    adc_raw_data_c(21) <= adc_raw_data(21);   -- data_assembly.v(24)
    adc_raw_data_c(20) <= adc_raw_data(20);   -- data_assembly.v(24)
    adc_raw_data_c(19) <= adc_raw_data(19);   -- data_assembly.v(24)
    adc_raw_data_c(18) <= adc_raw_data(18);   -- data_assembly.v(24)
    adc_raw_data_c(17) <= adc_raw_data(17);   -- data_assembly.v(24)
    adc_raw_data_c(16) <= adc_raw_data(16);   -- data_assembly.v(24)
    adc_raw_data_c(15) <= adc_raw_data(15);   -- data_assembly.v(24)
    adc_raw_data_c(14) <= adc_raw_data(14);   -- data_assembly.v(24)
    adc_raw_data_c(13) <= adc_raw_data(13);   -- data_assembly.v(24)
    adc_raw_data_c(12) <= adc_raw_data(12);   -- data_assembly.v(24)
    adc_raw_data_c(11) <= adc_raw_data(11);   -- data_assembly.v(24)
    adc_raw_data_c(10) <= adc_raw_data(10);   -- data_assembly.v(24)
    adc_raw_data_c(9) <= adc_raw_data(9);   -- data_assembly.v(24)
    adc_raw_data_c(8) <= adc_raw_data(8);   -- data_assembly.v(24)
    adc_raw_data_c(7) <= adc_raw_data(7);   -- data_assembly.v(24)
    adc_raw_data_c(6) <= adc_raw_data(6);   -- data_assembly.v(24)
    adc_raw_data_c(5) <= adc_raw_data(5);   -- data_assembly.v(24)
    adc_raw_data_c(4) <= adc_raw_data(4);   -- data_assembly.v(24)
    adc_raw_data_c(3) <= adc_raw_data(3);   -- data_assembly.v(24)
    adc_raw_data_c(2) <= adc_raw_data(2);   -- data_assembly.v(24)
    adc_raw_data_c(1) <= adc_raw_data(1);   -- data_assembly.v(24)
    adc_raw_data_c(0) <= adc_raw_data(0);   -- data_assembly.v(24)
    adc_user_clk_c <= adc_user_clk;   -- data_assembly.v(25)
    config_dout_valid <= config_dout_valid_c;   -- data_assembly.v(35)
    config_dout_data(31) <= config_din_data(31);   -- data_assembly.v(37)
    config_dout_data(30) <= config_din_data(30);   -- data_assembly.v(37)
    config_dout_data(29) <= config_din_data(29);   -- data_assembly.v(37)
    config_dout_data(28) <= config_din_data(28);   -- data_assembly.v(37)
    config_dout_data(27) <= config_din_data(27);   -- data_assembly.v(37)
    config_dout_data(26) <= config_din_data(26);   -- data_assembly.v(37)
    config_dout_data(25) <= config_din_data(25);   -- data_assembly.v(37)
    config_dout_data(24) <= config_din_data(24);   -- data_assembly.v(37)
    config_dout_data(23) <= trigger_type(1);   -- data_assembly.v(37)
    config_dout_data(22) <= trigger_type(1);   -- data_assembly.v(37)
    config_dout_data(21) <= trigger_type(1);   -- data_assembly.v(37)
    config_dout_data(20) <= trigger_type(1);   -- data_assembly.v(37)
    config_dout_data(19) <= trigger_type(1);   -- data_assembly.v(37)
    config_dout_data(18) <= trigger_type(1);   -- data_assembly.v(37)
    config_dout_data(17) <= trigger_type(1);   -- data_assembly.v(37)
    config_dout_data(16) <= trigger_type(1);   -- data_assembly.v(37)
    config_dout_data(15) <= config_daq2c(15);   -- data_assembly.v(37)
    config_dout_data(14) <= config_daq2c(14);   -- data_assembly.v(37)
    config_dout_data(13) <= config_daq2c(13);   -- data_assembly.v(37)
    config_dout_data(12) <= config_daq2c(12);   -- data_assembly.v(37)
    config_dout_data(11) <= config_daq2c(11);   -- data_assembly.v(37)
    config_dout_data(10) <= config_daq2c(10);   -- data_assembly.v(37)
    config_dout_data(9) <= config_daq2c(9);   -- data_assembly.v(37)
    config_dout_data(8) <= config_daq2c(8);   -- data_assembly.v(37)
    config_dout_data(7) <= config_daq2c(7);   -- data_assembly.v(37)
    config_dout_data(6) <= config_daq2c(6);   -- data_assembly.v(37)
    config_dout_data(5) <= config_daq2c(5);   -- data_assembly.v(37)
    config_dout_data(4) <= config_daq2c(4);   -- data_assembly.v(37)
    config_dout_data(3) <= config_daq2c(3);   -- data_assembly.v(37)
    config_dout_data(2) <= config_daq2c(2);   -- data_assembly.v(37)
    config_dout_data(1) <= config_daq2c(1);   -- data_assembly.v(37)
    config_dout_data(0) <= config_daq2c(0);   -- data_assembly.v(37)
    init_clk_c <= init_clk;   -- data_assembly.v(40)
    data_channel_fifo_rd_en_c(1) <= data_channel_fifo_rd_en(1);   -- data_assembly.v(41)
    data_channel_fifo_rd_en_c(0) <= data_channel_fifo_rd_en(0);   -- data_assembly.v(41)
    data_channel_fifo_out(255) <= data_channel_fifo_out_c(255);   -- data_assembly.v(42)
    data_channel_fifo_out(254) <= data_channel_fifo_out_c(254);   -- data_assembly.v(42)
    data_channel_fifo_out(253) <= data_channel_fifo_out_c(253);   -- data_assembly.v(42)
    data_channel_fifo_out(252) <= data_channel_fifo_out_c(252);   -- data_assembly.v(42)
    data_channel_fifo_out(251) <= data_channel_fifo_out_c(251);   -- data_assembly.v(42)
    data_channel_fifo_out(250) <= data_channel_fifo_out_c(250);   -- data_assembly.v(42)
    data_channel_fifo_out(249) <= data_channel_fifo_out_c(249);   -- data_assembly.v(42)
    data_channel_fifo_out(248) <= data_channel_fifo_out_c(248);   -- data_assembly.v(42)
    data_channel_fifo_out(247) <= data_channel_fifo_out_c(247);   -- data_assembly.v(42)
    data_channel_fifo_out(246) <= data_channel_fifo_out_c(246);   -- data_assembly.v(42)
    data_channel_fifo_out(245) <= data_channel_fifo_out_c(245);   -- data_assembly.v(42)
    data_channel_fifo_out(244) <= data_channel_fifo_out_c(244);   -- data_assembly.v(42)
    data_channel_fifo_out(243) <= data_channel_fifo_out_c(243);   -- data_assembly.v(42)
    data_channel_fifo_out(242) <= data_channel_fifo_out_c(242);   -- data_assembly.v(42)
    data_channel_fifo_out(241) <= data_channel_fifo_out_c(241);   -- data_assembly.v(42)
    data_channel_fifo_out(240) <= data_channel_fifo_out_c(240);   -- data_assembly.v(42)
    data_channel_fifo_out(239) <= data_channel_fifo_out_c(239);   -- data_assembly.v(42)
    data_channel_fifo_out(238) <= data_channel_fifo_out_c(238);   -- data_assembly.v(42)
    data_channel_fifo_out(237) <= data_channel_fifo_out_c(237);   -- data_assembly.v(42)
    data_channel_fifo_out(236) <= data_channel_fifo_out_c(236);   -- data_assembly.v(42)
    data_channel_fifo_out(235) <= data_channel_fifo_out_c(235);   -- data_assembly.v(42)
    data_channel_fifo_out(234) <= data_channel_fifo_out_c(234);   -- data_assembly.v(42)
    data_channel_fifo_out(233) <= data_channel_fifo_out_c(233);   -- data_assembly.v(42)
    data_channel_fifo_out(232) <= data_channel_fifo_out_c(232);   -- data_assembly.v(42)
    data_channel_fifo_out(231) <= data_channel_fifo_out_c(231);   -- data_assembly.v(42)
    data_channel_fifo_out(230) <= data_channel_fifo_out_c(230);   -- data_assembly.v(42)
    data_channel_fifo_out(229) <= data_channel_fifo_out_c(229);   -- data_assembly.v(42)
    data_channel_fifo_out(228) <= data_channel_fifo_out_c(228);   -- data_assembly.v(42)
    data_channel_fifo_out(227) <= data_channel_fifo_out_c(227);   -- data_assembly.v(42)
    data_channel_fifo_out(226) <= data_channel_fifo_out_c(226);   -- data_assembly.v(42)
    data_channel_fifo_out(225) <= data_channel_fifo_out_c(225);   -- data_assembly.v(42)
    data_channel_fifo_out(224) <= data_channel_fifo_out_c(224);   -- data_assembly.v(42)
    data_channel_fifo_out(223) <= data_channel_fifo_out_c(223);   -- data_assembly.v(42)
    data_channel_fifo_out(222) <= data_channel_fifo_out_c(222);   -- data_assembly.v(42)
    data_channel_fifo_out(221) <= data_channel_fifo_out_c(221);   -- data_assembly.v(42)
    data_channel_fifo_out(220) <= data_channel_fifo_out_c(220);   -- data_assembly.v(42)
    data_channel_fifo_out(219) <= data_channel_fifo_out_c(219);   -- data_assembly.v(42)
    data_channel_fifo_out(218) <= data_channel_fifo_out_c(218);   -- data_assembly.v(42)
    data_channel_fifo_out(217) <= data_channel_fifo_out_c(217);   -- data_assembly.v(42)
    data_channel_fifo_out(216) <= data_channel_fifo_out_c(216);   -- data_assembly.v(42)
    data_channel_fifo_out(215) <= data_channel_fifo_out_c(215);   -- data_assembly.v(42)
    data_channel_fifo_out(214) <= data_channel_fifo_out_c(214);   -- data_assembly.v(42)
    data_channel_fifo_out(213) <= data_channel_fifo_out_c(213);   -- data_assembly.v(42)
    data_channel_fifo_out(212) <= data_channel_fifo_out_c(212);   -- data_assembly.v(42)
    data_channel_fifo_out(211) <= data_channel_fifo_out_c(211);   -- data_assembly.v(42)
    data_channel_fifo_out(210) <= data_channel_fifo_out_c(210);   -- data_assembly.v(42)
    data_channel_fifo_out(209) <= data_channel_fifo_out_c(209);   -- data_assembly.v(42)
    data_channel_fifo_out(208) <= data_channel_fifo_out_c(208);   -- data_assembly.v(42)
    data_channel_fifo_out(207) <= data_channel_fifo_out_c(207);   -- data_assembly.v(42)
    data_channel_fifo_out(206) <= data_channel_fifo_out_c(206);   -- data_assembly.v(42)
    data_channel_fifo_out(205) <= data_channel_fifo_out_c(205);   -- data_assembly.v(42)
    data_channel_fifo_out(204) <= data_channel_fifo_out_c(204);   -- data_assembly.v(42)
    data_channel_fifo_out(203) <= data_channel_fifo_out_c(203);   -- data_assembly.v(42)
    data_channel_fifo_out(202) <= data_channel_fifo_out_c(202);   -- data_assembly.v(42)
    data_channel_fifo_out(201) <= data_channel_fifo_out_c(201);   -- data_assembly.v(42)
    data_channel_fifo_out(200) <= data_channel_fifo_out_c(200);   -- data_assembly.v(42)
    data_channel_fifo_out(199) <= data_channel_fifo_out_c(199);   -- data_assembly.v(42)
    data_channel_fifo_out(198) <= data_channel_fifo_out_c(198);   -- data_assembly.v(42)
    data_channel_fifo_out(197) <= data_channel_fifo_out_c(197);   -- data_assembly.v(42)
    data_channel_fifo_out(196) <= data_channel_fifo_out_c(196);   -- data_assembly.v(42)
    data_channel_fifo_out(195) <= data_channel_fifo_out_c(195);   -- data_assembly.v(42)
    data_channel_fifo_out(194) <= data_channel_fifo_out_c(194);   -- data_assembly.v(42)
    data_channel_fifo_out(193) <= data_channel_fifo_out_c(193);   -- data_assembly.v(42)
    data_channel_fifo_out(192) <= data_channel_fifo_out_c(192);   -- data_assembly.v(42)
    data_channel_fifo_out(191) <= data_channel_fifo_out_c(191);   -- data_assembly.v(42)
    data_channel_fifo_out(190) <= data_channel_fifo_out_c(190);   -- data_assembly.v(42)
    data_channel_fifo_out(189) <= data_channel_fifo_out_c(189);   -- data_assembly.v(42)
    data_channel_fifo_out(188) <= data_channel_fifo_out_c(188);   -- data_assembly.v(42)
    data_channel_fifo_out(187) <= data_channel_fifo_out_c(187);   -- data_assembly.v(42)
    data_channel_fifo_out(186) <= data_channel_fifo_out_c(186);   -- data_assembly.v(42)
    data_channel_fifo_out(185) <= data_channel_fifo_out_c(185);   -- data_assembly.v(42)
    data_channel_fifo_out(184) <= data_channel_fifo_out_c(184);   -- data_assembly.v(42)
    data_channel_fifo_out(183) <= data_channel_fifo_out_c(183);   -- data_assembly.v(42)
    data_channel_fifo_out(182) <= data_channel_fifo_out_c(182);   -- data_assembly.v(42)
    data_channel_fifo_out(181) <= data_channel_fifo_out_c(181);   -- data_assembly.v(42)
    data_channel_fifo_out(180) <= data_channel_fifo_out_c(180);   -- data_assembly.v(42)
    data_channel_fifo_out(179) <= data_channel_fifo_out_c(179);   -- data_assembly.v(42)
    data_channel_fifo_out(178) <= data_channel_fifo_out_c(178);   -- data_assembly.v(42)
    data_channel_fifo_out(177) <= data_channel_fifo_out_c(177);   -- data_assembly.v(42)
    data_channel_fifo_out(176) <= data_channel_fifo_out_c(176);   -- data_assembly.v(42)
    data_channel_fifo_out(175) <= data_channel_fifo_out_c(175);   -- data_assembly.v(42)
    data_channel_fifo_out(174) <= data_channel_fifo_out_c(174);   -- data_assembly.v(42)
    data_channel_fifo_out(173) <= data_channel_fifo_out_c(173);   -- data_assembly.v(42)
    data_channel_fifo_out(172) <= data_channel_fifo_out_c(172);   -- data_assembly.v(42)
    data_channel_fifo_out(171) <= data_channel_fifo_out_c(171);   -- data_assembly.v(42)
    data_channel_fifo_out(170) <= data_channel_fifo_out_c(170);   -- data_assembly.v(42)
    data_channel_fifo_out(169) <= data_channel_fifo_out_c(169);   -- data_assembly.v(42)
    data_channel_fifo_out(168) <= data_channel_fifo_out_c(168);   -- data_assembly.v(42)
    data_channel_fifo_out(167) <= data_channel_fifo_out_c(167);   -- data_assembly.v(42)
    data_channel_fifo_out(166) <= data_channel_fifo_out_c(166);   -- data_assembly.v(42)
    data_channel_fifo_out(165) <= data_channel_fifo_out_c(165);   -- data_assembly.v(42)
    data_channel_fifo_out(164) <= data_channel_fifo_out_c(164);   -- data_assembly.v(42)
    data_channel_fifo_out(163) <= data_channel_fifo_out_c(163);   -- data_assembly.v(42)
    data_channel_fifo_out(162) <= data_channel_fifo_out_c(162);   -- data_assembly.v(42)
    data_channel_fifo_out(161) <= data_channel_fifo_out_c(161);   -- data_assembly.v(42)
    data_channel_fifo_out(160) <= data_channel_fifo_out_c(160);   -- data_assembly.v(42)
    data_channel_fifo_out(159) <= data_channel_fifo_out_c(159);   -- data_assembly.v(42)
    data_channel_fifo_out(158) <= data_channel_fifo_out_c(158);   -- data_assembly.v(42)
    data_channel_fifo_out(157) <= data_channel_fifo_out_c(157);   -- data_assembly.v(42)
    data_channel_fifo_out(156) <= data_channel_fifo_out_c(156);   -- data_assembly.v(42)
    data_channel_fifo_out(155) <= data_channel_fifo_out_c(155);   -- data_assembly.v(42)
    data_channel_fifo_out(154) <= data_channel_fifo_out_c(154);   -- data_assembly.v(42)
    data_channel_fifo_out(153) <= data_channel_fifo_out_c(153);   -- data_assembly.v(42)
    data_channel_fifo_out(152) <= data_channel_fifo_out_c(152);   -- data_assembly.v(42)
    data_channel_fifo_out(151) <= data_channel_fifo_out_c(151);   -- data_assembly.v(42)
    data_channel_fifo_out(150) <= data_channel_fifo_out_c(150);   -- data_assembly.v(42)
    data_channel_fifo_out(149) <= data_channel_fifo_out_c(149);   -- data_assembly.v(42)
    data_channel_fifo_out(148) <= data_channel_fifo_out_c(148);   -- data_assembly.v(42)
    data_channel_fifo_out(147) <= data_channel_fifo_out_c(147);   -- data_assembly.v(42)
    data_channel_fifo_out(146) <= data_channel_fifo_out_c(146);   -- data_assembly.v(42)
    data_channel_fifo_out(145) <= data_channel_fifo_out_c(145);   -- data_assembly.v(42)
    data_channel_fifo_out(144) <= data_channel_fifo_out_c(144);   -- data_assembly.v(42)
    data_channel_fifo_out(143) <= data_channel_fifo_out_c(143);   -- data_assembly.v(42)
    data_channel_fifo_out(142) <= data_channel_fifo_out_c(142);   -- data_assembly.v(42)
    data_channel_fifo_out(141) <= data_channel_fifo_out_c(141);   -- data_assembly.v(42)
    data_channel_fifo_out(140) <= data_channel_fifo_out_c(140);   -- data_assembly.v(42)
    data_channel_fifo_out(139) <= data_channel_fifo_out_c(139);   -- data_assembly.v(42)
    data_channel_fifo_out(138) <= data_channel_fifo_out_c(138);   -- data_assembly.v(42)
    data_channel_fifo_out(137) <= data_channel_fifo_out_c(137);   -- data_assembly.v(42)
    data_channel_fifo_out(136) <= data_channel_fifo_out_c(136);   -- data_assembly.v(42)
    data_channel_fifo_out(135) <= data_channel_fifo_out_c(135);   -- data_assembly.v(42)
    data_channel_fifo_out(134) <= data_channel_fifo_out_c(134);   -- data_assembly.v(42)
    data_channel_fifo_out(133) <= data_channel_fifo_out_c(133);   -- data_assembly.v(42)
    data_channel_fifo_out(132) <= data_channel_fifo_out_c(132);   -- data_assembly.v(42)
    data_channel_fifo_out(131) <= data_channel_fifo_out_c(131);   -- data_assembly.v(42)
    data_channel_fifo_out(130) <= data_channel_fifo_out_c(130);   -- data_assembly.v(42)
    data_channel_fifo_out(129) <= data_channel_fifo_out_c(129);   -- data_assembly.v(42)
    data_channel_fifo_out(128) <= data_channel_fifo_out_c(128);   -- data_assembly.v(42)
    data_channel_fifo_out(127) <= data_channel_fifo_out_c(127);   -- data_assembly.v(42)
    data_channel_fifo_out(126) <= data_channel_fifo_out_c(126);   -- data_assembly.v(42)
    data_channel_fifo_out(125) <= data_channel_fifo_out_c(125);   -- data_assembly.v(42)
    data_channel_fifo_out(124) <= data_channel_fifo_out_c(124);   -- data_assembly.v(42)
    data_channel_fifo_out(123) <= data_channel_fifo_out_c(123);   -- data_assembly.v(42)
    data_channel_fifo_out(122) <= data_channel_fifo_out_c(122);   -- data_assembly.v(42)
    data_channel_fifo_out(121) <= data_channel_fifo_out_c(121);   -- data_assembly.v(42)
    data_channel_fifo_out(120) <= data_channel_fifo_out_c(120);   -- data_assembly.v(42)
    data_channel_fifo_out(119) <= data_channel_fifo_out_c(119);   -- data_assembly.v(42)
    data_channel_fifo_out(118) <= data_channel_fifo_out_c(118);   -- data_assembly.v(42)
    data_channel_fifo_out(117) <= data_channel_fifo_out_c(117);   -- data_assembly.v(42)
    data_channel_fifo_out(116) <= data_channel_fifo_out_c(116);   -- data_assembly.v(42)
    data_channel_fifo_out(115) <= data_channel_fifo_out_c(115);   -- data_assembly.v(42)
    data_channel_fifo_out(114) <= data_channel_fifo_out_c(114);   -- data_assembly.v(42)
    data_channel_fifo_out(113) <= data_channel_fifo_out_c(113);   -- data_assembly.v(42)
    data_channel_fifo_out(112) <= data_channel_fifo_out_c(112);   -- data_assembly.v(42)
    data_channel_fifo_out(111) <= data_channel_fifo_out_c(111);   -- data_assembly.v(42)
    data_channel_fifo_out(110) <= data_channel_fifo_out_c(110);   -- data_assembly.v(42)
    data_channel_fifo_out(109) <= data_channel_fifo_out_c(109);   -- data_assembly.v(42)
    data_channel_fifo_out(108) <= data_channel_fifo_out_c(108);   -- data_assembly.v(42)
    data_channel_fifo_out(107) <= data_channel_fifo_out_c(107);   -- data_assembly.v(42)
    data_channel_fifo_out(106) <= data_channel_fifo_out_c(106);   -- data_assembly.v(42)
    data_channel_fifo_out(105) <= data_channel_fifo_out_c(105);   -- data_assembly.v(42)
    data_channel_fifo_out(104) <= data_channel_fifo_out_c(104);   -- data_assembly.v(42)
    data_channel_fifo_out(103) <= data_channel_fifo_out_c(103);   -- data_assembly.v(42)
    data_channel_fifo_out(102) <= data_channel_fifo_out_c(102);   -- data_assembly.v(42)
    data_channel_fifo_out(101) <= data_channel_fifo_out_c(101);   -- data_assembly.v(42)
    data_channel_fifo_out(100) <= data_channel_fifo_out_c(100);   -- data_assembly.v(42)
    data_channel_fifo_out(99) <= data_channel_fifo_out_c(99);   -- data_assembly.v(42)
    data_channel_fifo_out(98) <= data_channel_fifo_out_c(98);   -- data_assembly.v(42)
    data_channel_fifo_out(97) <= data_channel_fifo_out_c(97);   -- data_assembly.v(42)
    data_channel_fifo_out(96) <= data_channel_fifo_out_c(96);   -- data_assembly.v(42)
    data_channel_fifo_out(95) <= data_channel_fifo_out_c(95);   -- data_assembly.v(42)
    data_channel_fifo_out(94) <= data_channel_fifo_out_c(94);   -- data_assembly.v(42)
    data_channel_fifo_out(93) <= data_channel_fifo_out_c(93);   -- data_assembly.v(42)
    data_channel_fifo_out(92) <= data_channel_fifo_out_c(92);   -- data_assembly.v(42)
    data_channel_fifo_out(91) <= data_channel_fifo_out_c(91);   -- data_assembly.v(42)
    data_channel_fifo_out(90) <= data_channel_fifo_out_c(90);   -- data_assembly.v(42)
    data_channel_fifo_out(89) <= data_channel_fifo_out_c(89);   -- data_assembly.v(42)
    data_channel_fifo_out(88) <= data_channel_fifo_out_c(88);   -- data_assembly.v(42)
    data_channel_fifo_out(87) <= data_channel_fifo_out_c(87);   -- data_assembly.v(42)
    data_channel_fifo_out(86) <= data_channel_fifo_out_c(86);   -- data_assembly.v(42)
    data_channel_fifo_out(85) <= data_channel_fifo_out_c(85);   -- data_assembly.v(42)
    data_channel_fifo_out(84) <= data_channel_fifo_out_c(84);   -- data_assembly.v(42)
    data_channel_fifo_out(83) <= data_channel_fifo_out_c(83);   -- data_assembly.v(42)
    data_channel_fifo_out(82) <= data_channel_fifo_out_c(82);   -- data_assembly.v(42)
    data_channel_fifo_out(81) <= data_channel_fifo_out_c(81);   -- data_assembly.v(42)
    data_channel_fifo_out(80) <= data_channel_fifo_out_c(80);   -- data_assembly.v(42)
    data_channel_fifo_out(79) <= data_channel_fifo_out_c(79);   -- data_assembly.v(42)
    data_channel_fifo_out(78) <= data_channel_fifo_out_c(78);   -- data_assembly.v(42)
    data_channel_fifo_out(77) <= data_channel_fifo_out_c(77);   -- data_assembly.v(42)
    data_channel_fifo_out(76) <= data_channel_fifo_out_c(76);   -- data_assembly.v(42)
    data_channel_fifo_out(75) <= data_channel_fifo_out_c(75);   -- data_assembly.v(42)
    data_channel_fifo_out(74) <= data_channel_fifo_out_c(74);   -- data_assembly.v(42)
    data_channel_fifo_out(73) <= data_channel_fifo_out_c(73);   -- data_assembly.v(42)
    data_channel_fifo_out(72) <= data_channel_fifo_out_c(72);   -- data_assembly.v(42)
    data_channel_fifo_out(71) <= data_channel_fifo_out_c(71);   -- data_assembly.v(42)
    data_channel_fifo_out(70) <= data_channel_fifo_out_c(70);   -- data_assembly.v(42)
    data_channel_fifo_out(69) <= data_channel_fifo_out_c(69);   -- data_assembly.v(42)
    data_channel_fifo_out(68) <= data_channel_fifo_out_c(68);   -- data_assembly.v(42)
    data_channel_fifo_out(67) <= data_channel_fifo_out_c(67);   -- data_assembly.v(42)
    data_channel_fifo_out(66) <= data_channel_fifo_out_c(66);   -- data_assembly.v(42)
    data_channel_fifo_out(65) <= data_channel_fifo_out_c(65);   -- data_assembly.v(42)
    data_channel_fifo_out(64) <= data_channel_fifo_out_c(64);   -- data_assembly.v(42)
    data_channel_fifo_out(63) <= data_channel_fifo_out_c(63);   -- data_assembly.v(42)
    data_channel_fifo_out(62) <= data_channel_fifo_out_c(62);   -- data_assembly.v(42)
    data_channel_fifo_out(61) <= data_channel_fifo_out_c(61);   -- data_assembly.v(42)
    data_channel_fifo_out(60) <= data_channel_fifo_out_c(60);   -- data_assembly.v(42)
    data_channel_fifo_out(59) <= data_channel_fifo_out_c(59);   -- data_assembly.v(42)
    data_channel_fifo_out(58) <= data_channel_fifo_out_c(58);   -- data_assembly.v(42)
    data_channel_fifo_out(57) <= data_channel_fifo_out_c(57);   -- data_assembly.v(42)
    data_channel_fifo_out(56) <= data_channel_fifo_out_c(56);   -- data_assembly.v(42)
    data_channel_fifo_out(55) <= data_channel_fifo_out_c(55);   -- data_assembly.v(42)
    data_channel_fifo_out(54) <= data_channel_fifo_out_c(54);   -- data_assembly.v(42)
    data_channel_fifo_out(53) <= data_channel_fifo_out_c(53);   -- data_assembly.v(42)
    data_channel_fifo_out(52) <= data_channel_fifo_out_c(52);   -- data_assembly.v(42)
    data_channel_fifo_out(51) <= data_channel_fifo_out_c(51);   -- data_assembly.v(42)
    data_channel_fifo_out(50) <= data_channel_fifo_out_c(50);   -- data_assembly.v(42)
    data_channel_fifo_out(49) <= data_channel_fifo_out_c(49);   -- data_assembly.v(42)
    data_channel_fifo_out(48) <= data_channel_fifo_out_c(48);   -- data_assembly.v(42)
    data_channel_fifo_out(47) <= data_channel_fifo_out_c(47);   -- data_assembly.v(42)
    data_channel_fifo_out(46) <= data_channel_fifo_out_c(46);   -- data_assembly.v(42)
    data_channel_fifo_out(45) <= data_channel_fifo_out_c(45);   -- data_assembly.v(42)
    data_channel_fifo_out(44) <= data_channel_fifo_out_c(44);   -- data_assembly.v(42)
    data_channel_fifo_out(43) <= data_channel_fifo_out_c(43);   -- data_assembly.v(42)
    data_channel_fifo_out(42) <= data_channel_fifo_out_c(42);   -- data_assembly.v(42)
    data_channel_fifo_out(41) <= data_channel_fifo_out_c(41);   -- data_assembly.v(42)
    data_channel_fifo_out(40) <= data_channel_fifo_out_c(40);   -- data_assembly.v(42)
    data_channel_fifo_out(39) <= data_channel_fifo_out_c(39);   -- data_assembly.v(42)
    data_channel_fifo_out(38) <= data_channel_fifo_out_c(38);   -- data_assembly.v(42)
    data_channel_fifo_out(37) <= data_channel_fifo_out_c(37);   -- data_assembly.v(42)
    data_channel_fifo_out(36) <= data_channel_fifo_out_c(36);   -- data_assembly.v(42)
    data_channel_fifo_out(35) <= data_channel_fifo_out_c(35);   -- data_assembly.v(42)
    data_channel_fifo_out(34) <= data_channel_fifo_out_c(34);   -- data_assembly.v(42)
    data_channel_fifo_out(33) <= data_channel_fifo_out_c(33);   -- data_assembly.v(42)
    data_channel_fifo_out(32) <= data_channel_fifo_out_c(32);   -- data_assembly.v(42)
    data_channel_fifo_out(31) <= data_channel_fifo_out_c(31);   -- data_assembly.v(42)
    data_channel_fifo_out(30) <= data_channel_fifo_out_c(30);   -- data_assembly.v(42)
    data_channel_fifo_out(29) <= data_channel_fifo_out_c(29);   -- data_assembly.v(42)
    data_channel_fifo_out(28) <= data_channel_fifo_out_c(28);   -- data_assembly.v(42)
    data_channel_fifo_out(27) <= data_channel_fifo_out_c(27);   -- data_assembly.v(42)
    data_channel_fifo_out(26) <= data_channel_fifo_out_c(26);   -- data_assembly.v(42)
    data_channel_fifo_out(25) <= data_channel_fifo_out_c(25);   -- data_assembly.v(42)
    data_channel_fifo_out(24) <= data_channel_fifo_out_c(24);   -- data_assembly.v(42)
    data_channel_fifo_out(23) <= data_channel_fifo_out_c(23);   -- data_assembly.v(42)
    data_channel_fifo_out(22) <= data_channel_fifo_out_c(22);   -- data_assembly.v(42)
    data_channel_fifo_out(21) <= data_channel_fifo_out_c(21);   -- data_assembly.v(42)
    data_channel_fifo_out(20) <= data_channel_fifo_out_c(20);   -- data_assembly.v(42)
    data_channel_fifo_out(19) <= data_channel_fifo_out_c(19);   -- data_assembly.v(42)
    data_channel_fifo_out(18) <= data_channel_fifo_out_c(18);   -- data_assembly.v(42)
    data_channel_fifo_out(17) <= data_channel_fifo_out_c(17);   -- data_assembly.v(42)
    data_channel_fifo_out(16) <= data_channel_fifo_out_c(16);   -- data_assembly.v(42)
    data_channel_fifo_out(15) <= data_channel_fifo_out_c(15);   -- data_assembly.v(42)
    data_channel_fifo_out(14) <= data_channel_fifo_out_c(14);   -- data_assembly.v(42)
    data_channel_fifo_out(13) <= data_channel_fifo_out_c(13);   -- data_assembly.v(42)
    data_channel_fifo_out(12) <= data_channel_fifo_out_c(12);   -- data_assembly.v(42)
    data_channel_fifo_out(11) <= data_channel_fifo_out_c(11);   -- data_assembly.v(42)
    data_channel_fifo_out(10) <= data_channel_fifo_out_c(10);   -- data_assembly.v(42)
    data_channel_fifo_out(9) <= data_channel_fifo_out_c(9);   -- data_assembly.v(42)
    data_channel_fifo_out(8) <= data_channel_fifo_out_c(8);   -- data_assembly.v(42)
    data_channel_fifo_out(7) <= data_channel_fifo_out_c(7);   -- data_assembly.v(42)
    data_channel_fifo_out(6) <= data_channel_fifo_out_c(6);   -- data_assembly.v(42)
    data_channel_fifo_out(5) <= data_channel_fifo_out_c(5);   -- data_assembly.v(42)
    data_channel_fifo_out(4) <= data_channel_fifo_out_c(4);   -- data_assembly.v(42)
    data_channel_fifo_out(3) <= data_channel_fifo_out_c(3);   -- data_assembly.v(42)
    data_channel_fifo_out(2) <= data_channel_fifo_out_c(2);   -- data_assembly.v(42)
    data_channel_fifo_out(1) <= data_channel_fifo_out_c(1);   -- data_assembly.v(42)
    data_channel_fifo_out(0) <= data_channel_fifo_out_c(0);   -- data_assembly.v(42)
    data_channel_fifo_out_valid(1) <= data_channel_fifo_out_valid_c(1);   -- data_assembly.v(43)
    data_channel_fifo_out_valid(0) <= data_channel_fifo_out_valid_c(0);   -- data_assembly.v(43)
    data_channel_fifo_full(1) <= data_channel_fifo_full_c(1);   -- data_assembly.v(44)
    data_channel_fifo_full(0) <= data_channel_fifo_full_c(0);   -- data_assembly.v(44)
    data_channel_fifo_empty(1) <= data_channel_fifo_empty_c(1);   -- data_assembly.v(45)
    data_channel_fifo_empty(0) <= data_channel_fifo_empty_c(0);   -- data_assembly.v(45)
    windows_cnt(15) <= sample_count_value_r(15);   -- data_assembly.v(47)
    windows_cnt(14) <= sample_count_value_r(14);   -- data_assembly.v(47)
    windows_cnt(13) <= sample_count_value_r(13);   -- data_assembly.v(47)
    windows_cnt(12) <= sample_count_value_r(12);   -- data_assembly.v(47)
    windows_cnt(11) <= sample_count_value_r(11);   -- data_assembly.v(47)
    windows_cnt(10) <= sample_count_value_r(10);   -- data_assembly.v(47)
    windows_cnt(9) <= sample_count_value_r(9);   -- data_assembly.v(47)
    windows_cnt(8) <= sample_count_value_r(8);   -- data_assembly.v(47)
    windows_cnt(7) <= sample_count_value_r(7);   -- data_assembly.v(47)
    windows_cnt(6) <= sample_count_value_r(6);   -- data_assembly.v(47)
    windows_cnt(5) <= sample_count_value_r(5);   -- data_assembly.v(47)
    windows_cnt(4) <= sample_count_value_r(4);   -- data_assembly.v(47)
    windows_cnt(3) <= sample_count_value_r(3);   -- data_assembly.v(47)
    windows_cnt(2) <= sample_count_value_r(2);   -- data_assembly.v(47)
    windows_cnt(1) <= sample_count_value_r(1);   -- data_assembly.v(47)
    windows_cnt(0) <= sample_count_value_r(0);   -- data_assembly.v(47)
    trigger_type(1) <= '0' ;
    trigger_type(0) <= '1' ;
    reset_i <= init_rst or sample_reset;   -- data_assembly.v(57)
    reset_i_dly <= not reset_r(9);   -- data_assembly.v(61)
    add_6: entity work.add_10u_10u(INTERFACE)  port map (cin=>trigger_type(1),
            a(9)=>reset_r(9),a(8)=>reset_r(8),a(7)=>reset_r(7),a(6)=>reset_r(6),
            a(5)=>reset_r(5),a(4)=>reset_r(4),a(3)=>reset_r(3),a(2)=>reset_r(2),
            a(1)=>reset_r(1),a(0)=>reset_r(0),b(9)=>trigger_type(1),b(8)=>trigger_type(1),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(0),o(9)=>n8,o(8)=>n9,
            o(7)=>n10,o(6)=>n11,o(5)=>n12,o(4)=>n13,o(3)=>n14,o(2)=>n15,
            o(1)=>n16,o(0)=>n17);   -- data_assembly.v(61)
    n18 <= n8 when reset_i_dly='1' else reset_r(9);   -- data_assembly.v(61)
    n19 <= n9 when reset_i_dly='1' else reset_r(8);   -- data_assembly.v(61)
    n20 <= n10 when reset_i_dly='1' else reset_r(7);   -- data_assembly.v(61)
    n21 <= n11 when reset_i_dly='1' else reset_r(6);   -- data_assembly.v(61)
    n22 <= n12 when reset_i_dly='1' else reset_r(5);   -- data_assembly.v(61)
    n23 <= n13 when reset_i_dly='1' else reset_r(4);   -- data_assembly.v(61)
    n24 <= n14 when reset_i_dly='1' else reset_r(3);   -- data_assembly.v(61)
    n25 <= n15 when reset_i_dly='1' else reset_r(2);   -- data_assembly.v(61)
    n26 <= n16 when reset_i_dly='1' else reset_r(1);   -- data_assembly.v(61)
    n27 <= n17 when reset_i_dly='1' else reset_r(0);   -- data_assembly.v(61)
    n28 <= trigger_type(1) when reset_i='1' else n18;   -- data_assembly.v(60)
    n29 <= trigger_type(1) when reset_i='1' else n19;   -- data_assembly.v(60)
    n30 <= trigger_type(1) when reset_i='1' else n20;   -- data_assembly.v(60)
    n31 <= trigger_type(1) when reset_i='1' else n21;   -- data_assembly.v(60)
    n32 <= trigger_type(1) when reset_i='1' else n22;   -- data_assembly.v(60)
    n33 <= trigger_type(1) when reset_i='1' else n23;   -- data_assembly.v(60)
    n34 <= trigger_type(1) when reset_i='1' else n24;   -- data_assembly.v(60)
    n35 <= trigger_type(1) when reset_i='1' else n25;   -- data_assembly.v(60)
    n36 <= trigger_type(1) when reset_i='1' else n26;   -- data_assembly.v(60)
    n37 <= trigger_type(1) when reset_i='1' else n27;   -- data_assembly.v(60)
    i29: VERIFIC_DFFRS (d=>n29,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(8));   -- data_assembly.v(59)
    i30: VERIFIC_DFFRS (d=>n30,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(7));   -- data_assembly.v(59)
    i31: VERIFIC_DFFRS (d=>n31,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(6));   -- data_assembly.v(59)
    i32: VERIFIC_DFFRS (d=>n32,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(5));   -- data_assembly.v(59)
    i33: VERIFIC_DFFRS (d=>n33,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(4));   -- data_assembly.v(59)
    i34: VERIFIC_DFFRS (d=>n34,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(3));   -- data_assembly.v(59)
    i35: VERIFIC_DFFRS (d=>n35,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(2));   -- data_assembly.v(59)
    i36: VERIFIC_DFFRS (d=>n36,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(1));   -- data_assembly.v(59)
    i37: VERIFIC_DFFRS (d=>n37,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(0));   -- data_assembly.v(59)
    i118: VERIFIC_DFFRS (d=>n125,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(63));   -- data_assembly.v(124)
    LessThan_39: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(0),
            a(15)=>trig_latency_count(15),a(14)=>trig_latency_count(14),a(13)=>trig_latency_count(13),
            a(12)=>trig_latency_count(12),a(11)=>trig_latency_count(11),a(10)=>trig_latency_count(10),
            a(9)=>trig_latency_count(9),a(8)=>trig_latency_count(8),a(7)=>trig_latency_count(7),
            a(6)=>trig_latency_count(6),a(5)=>trig_latency_count(5),a(4)=>trig_latency_count(4),
            a(3)=>trig_latency_count(3),a(2)=>trig_latency_count(2),a(1)=>trig_latency_count(1),
            a(0)=>trig_latency_count(0),b(15)=>trig_latency_count_value_r(15),
            b(14)=>trig_latency_count_value_r(14),b(13)=>trig_latency_count_value_r(13),
            b(12)=>trig_latency_count_value_r(12),b(11)=>trig_latency_count_value_r(11),
            b(10)=>trig_latency_count_value_r(10),b(9)=>trig_latency_count_value_r(9),
            b(8)=>trig_latency_count_value_r(8),b(7)=>trig_latency_count_value_r(7),
            b(6)=>trig_latency_count_value_r(6),b(5)=>trig_latency_count_value_r(5),
            b(4)=>trig_latency_count_value_r(4),b(3)=>trig_latency_count_value_r(3),
            b(2)=>trig_latency_count_value_r(2),b(1)=>trig_latency_count_value_r(1),
            b(0)=>trig_latency_count_value_r(0),o=>n50);   -- data_assembly.v(72)
    trig_latency_fifo_wren <= reset_r(9) and n50;   -- data_assembly.v(72)
    LessThan_42: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(0),
            a(15)=>trig_latency_count_value_r(15),a(14)=>trig_latency_count_value_r(14),
            a(13)=>trig_latency_count_value_r(13),a(12)=>trig_latency_count_value_r(12),
            a(11)=>trig_latency_count_value_r(11),a(10)=>trig_latency_count_value_r(10),
            a(9)=>trig_latency_count_value_r(9),a(8)=>trig_latency_count_value_r(8),
            a(7)=>trig_latency_count_value_r(7),a(6)=>trig_latency_count_value_r(6),
            a(5)=>trig_latency_count_value_r(5),a(4)=>trig_latency_count_value_r(4),
            a(3)=>trig_latency_count_value_r(3),a(2)=>trig_latency_count_value_r(2),
            a(1)=>trig_latency_count_value_r(1),a(0)=>trig_latency_count_value_r(0),
            b(15)=>trig_latency_count(15),b(14)=>trig_latency_count(14),b(13)=>trig_latency_count(13),
            b(12)=>trig_latency_count(12),b(11)=>trig_latency_count(11),b(10)=>trig_latency_count(10),
            b(9)=>trig_latency_count(9),b(8)=>trig_latency_count(8),b(7)=>trig_latency_count(7),
            b(6)=>trig_latency_count(6),b(5)=>trig_latency_count(5),b(4)=>trig_latency_count(4),
            b(3)=>trig_latency_count(3),b(2)=>trig_latency_count(2),b(1)=>trig_latency_count(1),
            b(0)=>trig_latency_count(0),o=>n53);   -- data_assembly.v(73)
    trig_latency_fifo_rden <= reset_r(9) and n53;   -- data_assembly.v(73)
    fifo_128x2048: component trig_latency_fifo port map (clk=>adc_user_clk_c,
            rst=>reset_i,din(127)=>adc_raw_data_c(127),din(126)=>adc_raw_data_c(126),
            din(125)=>adc_raw_data_c(125),din(124)=>adc_raw_data_c(124),din(123)=>adc_raw_data_c(123),
            din(122)=>adc_raw_data_c(122),din(121)=>adc_raw_data_c(121),din(120)=>adc_raw_data_c(120),
            din(119)=>adc_raw_data_c(119),din(118)=>adc_raw_data_c(118),din(117)=>adc_raw_data_c(117),
            din(116)=>adc_raw_data_c(116),din(115)=>adc_raw_data_c(115),din(114)=>adc_raw_data_c(114),
            din(113)=>adc_raw_data_c(113),din(112)=>adc_raw_data_c(112),din(111)=>adc_raw_data_c(111),
            din(110)=>adc_raw_data_c(110),din(109)=>adc_raw_data_c(109),din(108)=>adc_raw_data_c(108),
            din(107)=>adc_raw_data_c(107),din(106)=>adc_raw_data_c(106),din(105)=>adc_raw_data_c(105),
            din(104)=>adc_raw_data_c(104),din(103)=>adc_raw_data_c(103),din(102)=>adc_raw_data_c(102),
            din(101)=>adc_raw_data_c(101),din(100)=>adc_raw_data_c(100),din(99)=>adc_raw_data_c(99),
            din(98)=>adc_raw_data_c(98),din(97)=>adc_raw_data_c(97),din(96)=>adc_raw_data_c(96),
            din(95)=>adc_raw_data_c(95),din(94)=>adc_raw_data_c(94),din(93)=>adc_raw_data_c(93),
            din(92)=>adc_raw_data_c(92),din(91)=>adc_raw_data_c(91),din(90)=>adc_raw_data_c(90),
            din(89)=>adc_raw_data_c(89),din(88)=>adc_raw_data_c(88),din(87)=>adc_raw_data_c(87),
            din(86)=>adc_raw_data_c(86),din(85)=>adc_raw_data_c(85),din(84)=>adc_raw_data_c(84),
            din(83)=>adc_raw_data_c(83),din(82)=>adc_raw_data_c(82),din(81)=>adc_raw_data_c(81),
            din(80)=>adc_raw_data_c(80),din(79)=>adc_raw_data_c(79),din(78)=>adc_raw_data_c(78),
            din(77)=>adc_raw_data_c(77),din(76)=>adc_raw_data_c(76),din(75)=>adc_raw_data_c(75),
            din(74)=>adc_raw_data_c(74),din(73)=>adc_raw_data_c(73),din(72)=>adc_raw_data_c(72),
            din(71)=>adc_raw_data_c(71),din(70)=>adc_raw_data_c(70),din(69)=>adc_raw_data_c(69),
            din(68)=>adc_raw_data_c(68),din(67)=>adc_raw_data_c(67),din(66)=>adc_raw_data_c(66),
            din(65)=>adc_raw_data_c(65),din(64)=>adc_raw_data_c(64),din(63)=>adc_raw_data_c(63),
            din(62)=>adc_raw_data_c(62),din(61)=>adc_raw_data_c(61),din(60)=>adc_raw_data_c(60),
            din(59)=>adc_raw_data_c(59),din(58)=>adc_raw_data_c(58),din(57)=>adc_raw_data_c(57),
            din(56)=>adc_raw_data_c(56),din(55)=>adc_raw_data_c(55),din(54)=>adc_raw_data_c(54),
            din(53)=>adc_raw_data_c(53),din(52)=>adc_raw_data_c(52),din(51)=>adc_raw_data_c(51),
            din(50)=>adc_raw_data_c(50),din(49)=>adc_raw_data_c(49),din(48)=>adc_raw_data_c(48),
            din(47)=>adc_raw_data_c(47),din(46)=>adc_raw_data_c(46),din(45)=>adc_raw_data_c(45),
            din(44)=>adc_raw_data_c(44),din(43)=>adc_raw_data_c(43),din(42)=>adc_raw_data_c(42),
            din(41)=>adc_raw_data_c(41),din(40)=>adc_raw_data_c(40),din(39)=>adc_raw_data_c(39),
            din(38)=>adc_raw_data_c(38),din(37)=>adc_raw_data_c(37),din(36)=>adc_raw_data_c(36),
            din(35)=>adc_raw_data_c(35),din(34)=>adc_raw_data_c(34),din(33)=>adc_raw_data_c(33),
            din(32)=>adc_raw_data_c(32),din(31)=>adc_raw_data_c(31),din(30)=>adc_raw_data_c(30),
            din(29)=>adc_raw_data_c(29),din(28)=>adc_raw_data_c(28),din(27)=>adc_raw_data_c(27),
            din(26)=>adc_raw_data_c(26),din(25)=>adc_raw_data_c(25),din(24)=>adc_raw_data_c(24),
            din(23)=>adc_raw_data_c(23),din(22)=>adc_raw_data_c(22),din(21)=>adc_raw_data_c(21),
            din(20)=>adc_raw_data_c(20),din(19)=>adc_raw_data_c(19),din(18)=>adc_raw_data_c(18),
            din(17)=>adc_raw_data_c(17),din(16)=>adc_raw_data_c(16),din(15)=>adc_raw_data_c(15),
            din(14)=>adc_raw_data_c(14),din(13)=>adc_raw_data_c(13),din(12)=>adc_raw_data_c(12),
            din(11)=>adc_raw_data_c(11),din(10)=>adc_raw_data_c(10),din(9)=>adc_raw_data_c(9),
            din(8)=>adc_raw_data_c(8),din(7)=>adc_raw_data_c(7),din(6)=>adc_raw_data_c(6),
            din(5)=>adc_raw_data_c(5),din(4)=>adc_raw_data_c(4),din(3)=>adc_raw_data_c(3),
            din(2)=>adc_raw_data_c(2),din(1)=>adc_raw_data_c(1),din(0)=>adc_raw_data_c(0),
            wr_en=>n56,rd_en=>n58,dout(127)=>trig_latency_fifo_out(127),dout(126)=>trig_latency_fifo_out(126),
            dout(125)=>trig_latency_fifo_out(125),dout(124)=>trig_latency_fifo_out(124),
            dout(123)=>trig_latency_fifo_out(123),dout(122)=>trig_latency_fifo_out(122),
            dout(121)=>trig_latency_fifo_out(121),dout(120)=>trig_latency_fifo_out(120),
            dout(119)=>trig_latency_fifo_out(119),dout(118)=>trig_latency_fifo_out(118),
            dout(117)=>trig_latency_fifo_out(117),dout(116)=>trig_latency_fifo_out(116),
            dout(115)=>trig_latency_fifo_out(115),dout(114)=>trig_latency_fifo_out(114),
            dout(113)=>trig_latency_fifo_out(113),dout(112)=>trig_latency_fifo_out(112),
            dout(111)=>trig_latency_fifo_out(111),dout(110)=>trig_latency_fifo_out(110),
            dout(109)=>trig_latency_fifo_out(109),dout(108)=>trig_latency_fifo_out(108),
            dout(107)=>trig_latency_fifo_out(107),dout(106)=>trig_latency_fifo_out(106),
            dout(105)=>trig_latency_fifo_out(105),dout(104)=>trig_latency_fifo_out(104),
            dout(103)=>trig_latency_fifo_out(103),dout(102)=>trig_latency_fifo_out(102),
            dout(101)=>trig_latency_fifo_out(101),dout(100)=>trig_latency_fifo_out(100),
            dout(99)=>trig_latency_fifo_out(99),dout(98)=>trig_latency_fifo_out(98),
            dout(97)=>trig_latency_fifo_out(97),dout(96)=>trig_latency_fifo_out(96),
            dout(95)=>trig_latency_fifo_out(95),dout(94)=>trig_latency_fifo_out(94),
            dout(93)=>trig_latency_fifo_out(93),dout(92)=>trig_latency_fifo_out(92),
            dout(91)=>trig_latency_fifo_out(91),dout(90)=>trig_latency_fifo_out(90),
            dout(89)=>trig_latency_fifo_out(89),dout(88)=>trig_latency_fifo_out(88),
            dout(87)=>trig_latency_fifo_out(87),dout(86)=>trig_latency_fifo_out(86),
            dout(85)=>trig_latency_fifo_out(85),dout(84)=>trig_latency_fifo_out(84),
            dout(83)=>trig_latency_fifo_out(83),dout(82)=>trig_latency_fifo_out(82),
            dout(81)=>trig_latency_fifo_out(81),dout(80)=>trig_latency_fifo_out(80),
            dout(79)=>trig_latency_fifo_out(79),dout(78)=>trig_latency_fifo_out(78),
            dout(77)=>trig_latency_fifo_out(77),dout(76)=>trig_latency_fifo_out(76),
            dout(75)=>trig_latency_fifo_out(75),dout(74)=>trig_latency_fifo_out(74),
            dout(73)=>trig_latency_fifo_out(73),dout(72)=>trig_latency_fifo_out(72),
            dout(71)=>trig_latency_fifo_out(71),dout(70)=>trig_latency_fifo_out(70),
            dout(69)=>trig_latency_fifo_out(69),dout(68)=>trig_latency_fifo_out(68),
            dout(67)=>trig_latency_fifo_out(67),dout(66)=>trig_latency_fifo_out(66),
            dout(65)=>trig_latency_fifo_out(65),dout(64)=>trig_latency_fifo_out(64),
            dout(63)=>trig_latency_fifo_out(63),dout(62)=>trig_latency_fifo_out(62),
            dout(61)=>trig_latency_fifo_out(61),dout(60)=>trig_latency_fifo_out(60),
            dout(59)=>trig_latency_fifo_out(59),dout(58)=>trig_latency_fifo_out(58),
            dout(57)=>trig_latency_fifo_out(57),dout(56)=>trig_latency_fifo_out(56),
            dout(55)=>trig_latency_fifo_out(55),dout(54)=>trig_latency_fifo_out(54),
            dout(53)=>trig_latency_fifo_out(53),dout(52)=>trig_latency_fifo_out(52),
            dout(51)=>trig_latency_fifo_out(51),dout(50)=>trig_latency_fifo_out(50),
            dout(49)=>trig_latency_fifo_out(49),dout(48)=>trig_latency_fifo_out(48),
            dout(47)=>trig_latency_fifo_out(47),dout(46)=>trig_latency_fifo_out(46),
            dout(45)=>trig_latency_fifo_out(45),dout(44)=>trig_latency_fifo_out(44),
            dout(43)=>trig_latency_fifo_out(43),dout(42)=>trig_latency_fifo_out(42),
            dout(41)=>trig_latency_fifo_out(41),dout(40)=>trig_latency_fifo_out(40),
            dout(39)=>trig_latency_fifo_out(39),dout(38)=>trig_latency_fifo_out(38),
            dout(37)=>trig_latency_fifo_out(37),dout(36)=>trig_latency_fifo_out(36),
            dout(35)=>trig_latency_fifo_out(35),dout(34)=>trig_latency_fifo_out(34),
            dout(33)=>trig_latency_fifo_out(33),dout(32)=>trig_latency_fifo_out(32),
            dout(31)=>trig_latency_fifo_out(31),dout(30)=>trig_latency_fifo_out(30),
            dout(29)=>trig_latency_fifo_out(29),dout(28)=>trig_latency_fifo_out(28),
            dout(27)=>trig_latency_fifo_out(27),dout(26)=>trig_latency_fifo_out(26),
            dout(25)=>trig_latency_fifo_out(25),dout(24)=>trig_latency_fifo_out(24),
            dout(23)=>trig_latency_fifo_out(23),dout(22)=>trig_latency_fifo_out(22),
            dout(21)=>trig_latency_fifo_out(21),dout(20)=>trig_latency_fifo_out(20),
            dout(19)=>trig_latency_fifo_out(19),dout(18)=>trig_latency_fifo_out(18),
            dout(17)=>trig_latency_fifo_out(17),dout(16)=>trig_latency_fifo_out(16),
            dout(15)=>trig_latency_fifo_out(15),dout(14)=>trig_latency_fifo_out(14),
            dout(13)=>trig_latency_fifo_out(13),dout(12)=>trig_latency_fifo_out(12),
            dout(11)=>trig_latency_fifo_out(11),dout(10)=>trig_latency_fifo_out(10),
            dout(9)=>trig_latency_fifo_out(9),dout(8)=>trig_latency_fifo_out(8),
            dout(7)=>trig_latency_fifo_out(7),dout(6)=>trig_latency_fifo_out(6),
            dout(5)=>trig_latency_fifo_out(5),dout(4)=>trig_latency_fifo_out(4),
            dout(3)=>trig_latency_fifo_out(3),dout(2)=>trig_latency_fifo_out(2),
            dout(1)=>trig_latency_fifo_out(1),dout(0)=>trig_latency_fifo_out(0),
            full=>trig_latency_fifo_full,empty=>trig_latency_fifo_empty,data_count(10)=>trig_latency_fifo_data_count(10),
            data_count(9)=>trig_latency_fifo_data_count(9),data_count(8)=>trig_latency_fifo_data_count(8),
            data_count(7)=>trig_latency_fifo_data_count(7),data_count(6)=>trig_latency_fifo_data_count(6),
            data_count(5)=>trig_latency_fifo_data_count(5),data_count(4)=>trig_latency_fifo_data_count(4),
            data_count(3)=>trig_latency_fifo_data_count(3),data_count(2)=>trig_latency_fifo_data_count(2),
            data_count(1)=>trig_latency_fifo_data_count(1),data_count(0)=>trig_latency_fifo_data_count(0));   -- data_assembly.v(77)
    reduce_or_44: entity work.reduce_or_16(INTERFACE)  port map (a(15)=>trig_latency_count_value_r(15),
            a(14)=>trig_latency_count_value_r(14),a(13)=>trig_latency_count_value_r(13),
            a(12)=>trig_latency_count_value_r(12),a(11)=>trig_latency_count_value_r(11),
            a(10)=>trig_latency_count_value_r(10),a(9)=>trig_latency_count_value_r(9),
            a(8)=>trig_latency_count_value_r(8),a(7)=>trig_latency_count_value_r(7),
            a(6)=>trig_latency_count_value_r(6),a(5)=>trig_latency_count_value_r(5),
            a(4)=>trig_latency_count_value_r(4),a(3)=>trig_latency_count_value_r(3),
            a(2)=>trig_latency_count_value_r(2),a(1)=>trig_latency_count_value_r(1),
            a(0)=>trig_latency_count_value_r(0),o=>n55);   -- data_assembly.v(81)
    n56 <= trig_latency_fifo_wren and n55;   -- data_assembly.v(81)
    n58 <= trig_latency_fifo_rden and n55;   -- data_assembly.v(82)
    dfifo_128x64_internal: component data_channel_fifo port map (rst=>reset_i,
            wr_clk=>adc_user_clk_c,wr_en=>data_channel_fifo_wren(0),din(127)=>data_channel_fifo_in(127),
            din(126)=>data_channel_fifo_in(126),din(125)=>data_channel_fifo_in(125),
            din(124)=>data_channel_fifo_in(124),din(123)=>data_channel_fifo_in(123),
            din(122)=>data_channel_fifo_in(122),din(121)=>data_channel_fifo_in(121),
            din(120)=>data_channel_fifo_in(120),din(119)=>data_channel_fifo_in(119),
            din(118)=>data_channel_fifo_in(118),din(117)=>data_channel_fifo_in(117),
            din(116)=>data_channel_fifo_in(116),din(115)=>data_channel_fifo_in(115),
            din(114)=>data_channel_fifo_in(114),din(113)=>data_channel_fifo_in(113),
            din(112)=>data_channel_fifo_in(112),din(111)=>data_channel_fifo_in(111),
            din(110)=>data_channel_fifo_in(110),din(109)=>data_channel_fifo_in(109),
            din(108)=>data_channel_fifo_in(108),din(107)=>data_channel_fifo_in(107),
            din(106)=>data_channel_fifo_in(106),din(105)=>data_channel_fifo_in(105),
            din(104)=>data_channel_fifo_in(104),din(103)=>data_channel_fifo_in(103),
            din(102)=>data_channel_fifo_in(102),din(101)=>data_channel_fifo_in(101),
            din(100)=>data_channel_fifo_in(100),din(99)=>data_channel_fifo_in(99),
            din(98)=>data_channel_fifo_in(98),din(97)=>data_channel_fifo_in(97),
            din(96)=>data_channel_fifo_in(96),din(95)=>data_channel_fifo_in(95),
            din(94)=>data_channel_fifo_in(94),din(93)=>data_channel_fifo_in(93),
            din(92)=>data_channel_fifo_in(92),din(91)=>data_channel_fifo_in(91),
            din(90)=>data_channel_fifo_in(90),din(89)=>data_channel_fifo_in(89),
            din(88)=>data_channel_fifo_in(88),din(87)=>data_channel_fifo_in(87),
            din(86)=>data_channel_fifo_in(86),din(85)=>data_channel_fifo_in(85),
            din(84)=>data_channel_fifo_in(84),din(83)=>data_channel_fifo_in(83),
            din(82)=>data_channel_fifo_in(82),din(81)=>data_channel_fifo_in(81),
            din(80)=>data_channel_fifo_in(80),din(79)=>data_channel_fifo_in(79),
            din(78)=>data_channel_fifo_in(78),din(77)=>data_channel_fifo_in(77),
            din(76)=>data_channel_fifo_in(76),din(75)=>data_channel_fifo_in(75),
            din(74)=>data_channel_fifo_in(74),din(73)=>data_channel_fifo_in(73),
            din(72)=>data_channel_fifo_in(72),din(71)=>data_channel_fifo_in(71),
            din(70)=>data_channel_fifo_in(70),din(69)=>data_channel_fifo_in(69),
            din(68)=>data_channel_fifo_in(68),din(67)=>data_channel_fifo_in(67),
            din(66)=>data_channel_fifo_in(66),din(65)=>data_channel_fifo_in(65),
            din(64)=>data_channel_fifo_in(64),din(63)=>data_channel_fifo_in(63),
            din(62)=>data_channel_fifo_in(62),din(61)=>data_channel_fifo_in(61),
            din(60)=>data_channel_fifo_in(60),din(59)=>data_channel_fifo_in(59),
            din(58)=>data_channel_fifo_in(58),din(57)=>data_channel_fifo_in(57),
            din(56)=>data_channel_fifo_in(56),din(55)=>data_channel_fifo_in(55),
            din(54)=>data_channel_fifo_in(54),din(53)=>data_channel_fifo_in(53),
            din(52)=>data_channel_fifo_in(52),din(51)=>data_channel_fifo_in(51),
            din(50)=>data_channel_fifo_in(50),din(49)=>data_channel_fifo_in(49),
            din(48)=>data_channel_fifo_in(48),din(47)=>data_channel_fifo_in(47),
            din(46)=>data_channel_fifo_in(46),din(45)=>data_channel_fifo_in(45),
            din(44)=>data_channel_fifo_in(44),din(43)=>data_channel_fifo_in(43),
            din(42)=>data_channel_fifo_in(42),din(41)=>data_channel_fifo_in(41),
            din(40)=>data_channel_fifo_in(40),din(39)=>data_channel_fifo_in(39),
            din(38)=>data_channel_fifo_in(38),din(37)=>data_channel_fifo_in(37),
            din(36)=>data_channel_fifo_in(36),din(35)=>data_channel_fifo_in(35),
            din(34)=>data_channel_fifo_in(34),din(33)=>data_channel_fifo_in(33),
            din(32)=>data_channel_fifo_in(32),din(31)=>data_channel_fifo_in(31),
            din(30)=>data_channel_fifo_in(30),din(29)=>data_channel_fifo_in(29),
            din(28)=>data_channel_fifo_in(28),din(27)=>data_channel_fifo_in(27),
            din(26)=>data_channel_fifo_in(26),din(25)=>data_channel_fifo_in(25),
            din(24)=>data_channel_fifo_in(24),din(23)=>data_channel_fifo_in(23),
            din(22)=>data_channel_fifo_in(22),din(21)=>data_channel_fifo_in(21),
            din(20)=>data_channel_fifo_in(20),din(19)=>data_channel_fifo_in(19),
            din(18)=>data_channel_fifo_in(18),din(17)=>data_channel_fifo_in(17),
            din(16)=>data_channel_fifo_in(16),din(15)=>data_channel_fifo_in(15),
            din(14)=>data_channel_fifo_in(14),din(13)=>data_channel_fifo_in(13),
            din(12)=>data_channel_fifo_in(12),din(11)=>data_channel_fifo_in(11),
            din(10)=>data_channel_fifo_in(10),din(9)=>data_channel_fifo_in(9),
            din(8)=>data_channel_fifo_in(8),din(7)=>data_channel_fifo_in(7),
            din(6)=>data_channel_fifo_in(6),din(5)=>data_channel_fifo_in(5),
            din(4)=>data_channel_fifo_in(4),din(3)=>data_channel_fifo_in(3),
            din(2)=>data_channel_fifo_in(2),din(1)=>data_channel_fifo_in(1),
            din(0)=>data_channel_fifo_in(0),rd_clk=>init_clk_c,rd_en=>data_channel_fifo_rd_en_c(0),
            dout(127)=>data_channel_fifo_out_c(127),dout(126)=>data_channel_fifo_out_c(126),
            dout(125)=>data_channel_fifo_out_c(125),dout(124)=>data_channel_fifo_out_c(124),
            dout(123)=>data_channel_fifo_out_c(123),dout(122)=>data_channel_fifo_out_c(122),
            dout(121)=>data_channel_fifo_out_c(121),dout(120)=>data_channel_fifo_out_c(120),
            dout(119)=>data_channel_fifo_out_c(119),dout(118)=>data_channel_fifo_out_c(118),
            dout(117)=>data_channel_fifo_out_c(117),dout(116)=>data_channel_fifo_out_c(116),
            dout(115)=>data_channel_fifo_out_c(115),dout(114)=>data_channel_fifo_out_c(114),
            dout(113)=>data_channel_fifo_out_c(113),dout(112)=>data_channel_fifo_out_c(112),
            dout(111)=>data_channel_fifo_out_c(111),dout(110)=>data_channel_fifo_out_c(110),
            dout(109)=>data_channel_fifo_out_c(109),dout(108)=>data_channel_fifo_out_c(108),
            dout(107)=>data_channel_fifo_out_c(107),dout(106)=>data_channel_fifo_out_c(106),
            dout(105)=>data_channel_fifo_out_c(105),dout(104)=>data_channel_fifo_out_c(104),
            dout(103)=>data_channel_fifo_out_c(103),dout(102)=>data_channel_fifo_out_c(102),
            dout(101)=>data_channel_fifo_out_c(101),dout(100)=>data_channel_fifo_out_c(100),
            dout(99)=>data_channel_fifo_out_c(99),dout(98)=>data_channel_fifo_out_c(98),
            dout(97)=>data_channel_fifo_out_c(97),dout(96)=>data_channel_fifo_out_c(96),
            dout(95)=>data_channel_fifo_out_c(95),dout(94)=>data_channel_fifo_out_c(94),
            dout(93)=>data_channel_fifo_out_c(93),dout(92)=>data_channel_fifo_out_c(92),
            dout(91)=>data_channel_fifo_out_c(91),dout(90)=>data_channel_fifo_out_c(90),
            dout(89)=>data_channel_fifo_out_c(89),dout(88)=>data_channel_fifo_out_c(88),
            dout(87)=>data_channel_fifo_out_c(87),dout(86)=>data_channel_fifo_out_c(86),
            dout(85)=>data_channel_fifo_out_c(85),dout(84)=>data_channel_fifo_out_c(84),
            dout(83)=>data_channel_fifo_out_c(83),dout(82)=>data_channel_fifo_out_c(82),
            dout(81)=>data_channel_fifo_out_c(81),dout(80)=>data_channel_fifo_out_c(80),
            dout(79)=>data_channel_fifo_out_c(79),dout(78)=>data_channel_fifo_out_c(78),
            dout(77)=>data_channel_fifo_out_c(77),dout(76)=>data_channel_fifo_out_c(76),
            dout(75)=>data_channel_fifo_out_c(75),dout(74)=>data_channel_fifo_out_c(74),
            dout(73)=>data_channel_fifo_out_c(73),dout(72)=>data_channel_fifo_out_c(72),
            dout(71)=>data_channel_fifo_out_c(71),dout(70)=>data_channel_fifo_out_c(70),
            dout(69)=>data_channel_fifo_out_c(69),dout(68)=>data_channel_fifo_out_c(68),
            dout(67)=>data_channel_fifo_out_c(67),dout(66)=>data_channel_fifo_out_c(66),
            dout(65)=>data_channel_fifo_out_c(65),dout(64)=>data_channel_fifo_out_c(64),
            dout(63)=>data_channel_fifo_out_c(63),dout(62)=>data_channel_fifo_out_c(62),
            dout(61)=>data_channel_fifo_out_c(61),dout(60)=>data_channel_fifo_out_c(60),
            dout(59)=>data_channel_fifo_out_c(59),dout(58)=>data_channel_fifo_out_c(58),
            dout(57)=>data_channel_fifo_out_c(57),dout(56)=>data_channel_fifo_out_c(56),
            dout(55)=>data_channel_fifo_out_c(55),dout(54)=>data_channel_fifo_out_c(54),
            dout(53)=>data_channel_fifo_out_c(53),dout(52)=>data_channel_fifo_out_c(52),
            dout(51)=>data_channel_fifo_out_c(51),dout(50)=>data_channel_fifo_out_c(50),
            dout(49)=>data_channel_fifo_out_c(49),dout(48)=>data_channel_fifo_out_c(48),
            dout(47)=>data_channel_fifo_out_c(47),dout(46)=>data_channel_fifo_out_c(46),
            dout(45)=>data_channel_fifo_out_c(45),dout(44)=>data_channel_fifo_out_c(44),
            dout(43)=>data_channel_fifo_out_c(43),dout(42)=>data_channel_fifo_out_c(42),
            dout(41)=>data_channel_fifo_out_c(41),dout(40)=>data_channel_fifo_out_c(40),
            dout(39)=>data_channel_fifo_out_c(39),dout(38)=>data_channel_fifo_out_c(38),
            dout(37)=>data_channel_fifo_out_c(37),dout(36)=>data_channel_fifo_out_c(36),
            dout(35)=>data_channel_fifo_out_c(35),dout(34)=>data_channel_fifo_out_c(34),
            dout(33)=>data_channel_fifo_out_c(33),dout(32)=>data_channel_fifo_out_c(32),
            dout(31)=>data_channel_fifo_out_c(31),dout(30)=>data_channel_fifo_out_c(30),
            dout(29)=>data_channel_fifo_out_c(29),dout(28)=>data_channel_fifo_out_c(28),
            dout(27)=>data_channel_fifo_out_c(27),dout(26)=>data_channel_fifo_out_c(26),
            dout(25)=>data_channel_fifo_out_c(25),dout(24)=>data_channel_fifo_out_c(24),
            dout(23)=>data_channel_fifo_out_c(23),dout(22)=>data_channel_fifo_out_c(22),
            dout(21)=>data_channel_fifo_out_c(21),dout(20)=>data_channel_fifo_out_c(20),
            dout(19)=>data_channel_fifo_out_c(19),dout(18)=>data_channel_fifo_out_c(18),
            dout(17)=>data_channel_fifo_out_c(17),dout(16)=>data_channel_fifo_out_c(16),
            dout(15)=>data_channel_fifo_out_c(15),dout(14)=>data_channel_fifo_out_c(14),
            dout(13)=>data_channel_fifo_out_c(13),dout(12)=>data_channel_fifo_out_c(12),
            dout(11)=>data_channel_fifo_out_c(11),dout(10)=>data_channel_fifo_out_c(10),
            dout(9)=>data_channel_fifo_out_c(9),dout(8)=>data_channel_fifo_out_c(8),
            dout(7)=>data_channel_fifo_out_c(7),dout(6)=>data_channel_fifo_out_c(6),
            dout(5)=>data_channel_fifo_out_c(5),dout(4)=>data_channel_fifo_out_c(4),
            dout(3)=>data_channel_fifo_out_c(3),dout(2)=>data_channel_fifo_out_c(2),
            dout(1)=>data_channel_fifo_out_c(1),dout(0)=>data_channel_fifo_out_c(0),
            valid=>data_channel_fifo_out_valid_c(0),full=>data_channel_fifo_full_c(0),
            empty=>data_channel_fifo_empty_c(0),rd_data_count(5)=>data_channel_fifo_rd_data_count(5),
            rd_data_count(4)=>data_channel_fifo_rd_data_count(4),rd_data_count(3)=>data_channel_fifo_rd_data_count(3),
            rd_data_count(2)=>data_channel_fifo_rd_data_count(2),rd_data_count(1)=>data_channel_fifo_rd_data_count(1),
            rd_data_count(0)=>data_channel_fifo_rd_data_count(0));   -- data_assembly.v(93)
    dfifo_128x64_external: component data_channel_fifo port map (rst=>reset_i,
            wr_clk=>adc_user_clk_c,wr_en=>data_channel_fifo_wren(1),din(127)=>data_channel_fifo_in(127),
            din(126)=>data_channel_fifo_in(126),din(125)=>data_channel_fifo_in(125),
            din(124)=>data_channel_fifo_in(124),din(123)=>data_channel_fifo_in(123),
            din(122)=>data_channel_fifo_in(122),din(121)=>data_channel_fifo_in(121),
            din(120)=>data_channel_fifo_in(120),din(119)=>data_channel_fifo_in(119),
            din(118)=>data_channel_fifo_in(118),din(117)=>data_channel_fifo_in(117),
            din(116)=>data_channel_fifo_in(116),din(115)=>data_channel_fifo_in(115),
            din(114)=>data_channel_fifo_in(114),din(113)=>data_channel_fifo_in(113),
            din(112)=>data_channel_fifo_in(112),din(111)=>data_channel_fifo_in(111),
            din(110)=>data_channel_fifo_in(110),din(109)=>data_channel_fifo_in(109),
            din(108)=>data_channel_fifo_in(108),din(107)=>data_channel_fifo_in(107),
            din(106)=>data_channel_fifo_in(106),din(105)=>data_channel_fifo_in(105),
            din(104)=>data_channel_fifo_in(104),din(103)=>data_channel_fifo_in(103),
            din(102)=>data_channel_fifo_in(102),din(101)=>data_channel_fifo_in(101),
            din(100)=>data_channel_fifo_in(100),din(99)=>data_channel_fifo_in(99),
            din(98)=>data_channel_fifo_in(98),din(97)=>data_channel_fifo_in(97),
            din(96)=>data_channel_fifo_in(96),din(95)=>data_channel_fifo_in(95),
            din(94)=>data_channel_fifo_in(94),din(93)=>data_channel_fifo_in(93),
            din(92)=>data_channel_fifo_in(92),din(91)=>data_channel_fifo_in(91),
            din(90)=>data_channel_fifo_in(90),din(89)=>data_channel_fifo_in(89),
            din(88)=>data_channel_fifo_in(88),din(87)=>data_channel_fifo_in(87),
            din(86)=>data_channel_fifo_in(86),din(85)=>data_channel_fifo_in(85),
            din(84)=>data_channel_fifo_in(84),din(83)=>data_channel_fifo_in(83),
            din(82)=>data_channel_fifo_in(82),din(81)=>data_channel_fifo_in(81),
            din(80)=>data_channel_fifo_in(80),din(79)=>data_channel_fifo_in(79),
            din(78)=>data_channel_fifo_in(78),din(77)=>data_channel_fifo_in(77),
            din(76)=>data_channel_fifo_in(76),din(75)=>data_channel_fifo_in(75),
            din(74)=>data_channel_fifo_in(74),din(73)=>data_channel_fifo_in(73),
            din(72)=>data_channel_fifo_in(72),din(71)=>data_channel_fifo_in(71),
            din(70)=>data_channel_fifo_in(70),din(69)=>data_channel_fifo_in(69),
            din(68)=>data_channel_fifo_in(68),din(67)=>data_channel_fifo_in(67),
            din(66)=>data_channel_fifo_in(66),din(65)=>data_channel_fifo_in(65),
            din(64)=>data_channel_fifo_in(64),din(63)=>data_channel_fifo_in(63),
            din(62)=>data_channel_fifo_in(62),din(61)=>data_channel_fifo_in(61),
            din(60)=>data_channel_fifo_in(60),din(59)=>data_channel_fifo_in(59),
            din(58)=>data_channel_fifo_in(58),din(57)=>data_channel_fifo_in(57),
            din(56)=>data_channel_fifo_in(56),din(55)=>data_channel_fifo_in(55),
            din(54)=>data_channel_fifo_in(54),din(53)=>data_channel_fifo_in(53),
            din(52)=>data_channel_fifo_in(52),din(51)=>data_channel_fifo_in(51),
            din(50)=>data_channel_fifo_in(50),din(49)=>data_channel_fifo_in(49),
            din(48)=>data_channel_fifo_in(48),din(47)=>data_channel_fifo_in(47),
            din(46)=>data_channel_fifo_in(46),din(45)=>data_channel_fifo_in(45),
            din(44)=>data_channel_fifo_in(44),din(43)=>data_channel_fifo_in(43),
            din(42)=>data_channel_fifo_in(42),din(41)=>data_channel_fifo_in(41),
            din(40)=>data_channel_fifo_in(40),din(39)=>data_channel_fifo_in(39),
            din(38)=>data_channel_fifo_in(38),din(37)=>data_channel_fifo_in(37),
            din(36)=>data_channel_fifo_in(36),din(35)=>data_channel_fifo_in(35),
            din(34)=>data_channel_fifo_in(34),din(33)=>data_channel_fifo_in(33),
            din(32)=>data_channel_fifo_in(32),din(31)=>data_channel_fifo_in(31),
            din(30)=>data_channel_fifo_in(30),din(29)=>data_channel_fifo_in(29),
            din(28)=>data_channel_fifo_in(28),din(27)=>data_channel_fifo_in(27),
            din(26)=>data_channel_fifo_in(26),din(25)=>data_channel_fifo_in(25),
            din(24)=>data_channel_fifo_in(24),din(23)=>data_channel_fifo_in(23),
            din(22)=>data_channel_fifo_in(22),din(21)=>data_channel_fifo_in(21),
            din(20)=>data_channel_fifo_in(20),din(19)=>data_channel_fifo_in(19),
            din(18)=>data_channel_fifo_in(18),din(17)=>data_channel_fifo_in(17),
            din(16)=>data_channel_fifo_in(16),din(15)=>data_channel_fifo_in(15),
            din(14)=>data_channel_fifo_in(14),din(13)=>data_channel_fifo_in(13),
            din(12)=>data_channel_fifo_in(12),din(11)=>data_channel_fifo_in(11),
            din(10)=>data_channel_fifo_in(10),din(9)=>data_channel_fifo_in(9),
            din(8)=>data_channel_fifo_in(8),din(7)=>data_channel_fifo_in(7),
            din(6)=>data_channel_fifo_in(6),din(5)=>data_channel_fifo_in(5),
            din(4)=>data_channel_fifo_in(4),din(3)=>data_channel_fifo_in(3),
            din(2)=>data_channel_fifo_in(2),din(1)=>data_channel_fifo_in(1),
            din(0)=>data_channel_fifo_in(0),rd_clk=>init_clk_c,rd_en=>data_channel_fifo_rd_en_c(1),
            dout(127)=>data_channel_fifo_out_c(255),dout(126)=>data_channel_fifo_out_c(254),
            dout(125)=>data_channel_fifo_out_c(253),dout(124)=>data_channel_fifo_out_c(252),
            dout(123)=>data_channel_fifo_out_c(251),dout(122)=>data_channel_fifo_out_c(250),
            dout(121)=>data_channel_fifo_out_c(249),dout(120)=>data_channel_fifo_out_c(248),
            dout(119)=>data_channel_fifo_out_c(247),dout(118)=>data_channel_fifo_out_c(246),
            dout(117)=>data_channel_fifo_out_c(245),dout(116)=>data_channel_fifo_out_c(244),
            dout(115)=>data_channel_fifo_out_c(243),dout(114)=>data_channel_fifo_out_c(242),
            dout(113)=>data_channel_fifo_out_c(241),dout(112)=>data_channel_fifo_out_c(240),
            dout(111)=>data_channel_fifo_out_c(239),dout(110)=>data_channel_fifo_out_c(238),
            dout(109)=>data_channel_fifo_out_c(237),dout(108)=>data_channel_fifo_out_c(236),
            dout(107)=>data_channel_fifo_out_c(235),dout(106)=>data_channel_fifo_out_c(234),
            dout(105)=>data_channel_fifo_out_c(233),dout(104)=>data_channel_fifo_out_c(232),
            dout(103)=>data_channel_fifo_out_c(231),dout(102)=>data_channel_fifo_out_c(230),
            dout(101)=>data_channel_fifo_out_c(229),dout(100)=>data_channel_fifo_out_c(228),
            dout(99)=>data_channel_fifo_out_c(227),dout(98)=>data_channel_fifo_out_c(226),
            dout(97)=>data_channel_fifo_out_c(225),dout(96)=>data_channel_fifo_out_c(224),
            dout(95)=>data_channel_fifo_out_c(223),dout(94)=>data_channel_fifo_out_c(222),
            dout(93)=>data_channel_fifo_out_c(221),dout(92)=>data_channel_fifo_out_c(220),
            dout(91)=>data_channel_fifo_out_c(219),dout(90)=>data_channel_fifo_out_c(218),
            dout(89)=>data_channel_fifo_out_c(217),dout(88)=>data_channel_fifo_out_c(216),
            dout(87)=>data_channel_fifo_out_c(215),dout(86)=>data_channel_fifo_out_c(214),
            dout(85)=>data_channel_fifo_out_c(213),dout(84)=>data_channel_fifo_out_c(212),
            dout(83)=>data_channel_fifo_out_c(211),dout(82)=>data_channel_fifo_out_c(210),
            dout(81)=>data_channel_fifo_out_c(209),dout(80)=>data_channel_fifo_out_c(208),
            dout(79)=>data_channel_fifo_out_c(207),dout(78)=>data_channel_fifo_out_c(206),
            dout(77)=>data_channel_fifo_out_c(205),dout(76)=>data_channel_fifo_out_c(204),
            dout(75)=>data_channel_fifo_out_c(203),dout(74)=>data_channel_fifo_out_c(202),
            dout(73)=>data_channel_fifo_out_c(201),dout(72)=>data_channel_fifo_out_c(200),
            dout(71)=>data_channel_fifo_out_c(199),dout(70)=>data_channel_fifo_out_c(198),
            dout(69)=>data_channel_fifo_out_c(197),dout(68)=>data_channel_fifo_out_c(196),
            dout(67)=>data_channel_fifo_out_c(195),dout(66)=>data_channel_fifo_out_c(194),
            dout(65)=>data_channel_fifo_out_c(193),dout(64)=>data_channel_fifo_out_c(192),
            dout(63)=>data_channel_fifo_out_c(191),dout(62)=>data_channel_fifo_out_c(190),
            dout(61)=>data_channel_fifo_out_c(189),dout(60)=>data_channel_fifo_out_c(188),
            dout(59)=>data_channel_fifo_out_c(187),dout(58)=>data_channel_fifo_out_c(186),
            dout(57)=>data_channel_fifo_out_c(185),dout(56)=>data_channel_fifo_out_c(184),
            dout(55)=>data_channel_fifo_out_c(183),dout(54)=>data_channel_fifo_out_c(182),
            dout(53)=>data_channel_fifo_out_c(181),dout(52)=>data_channel_fifo_out_c(180),
            dout(51)=>data_channel_fifo_out_c(179),dout(50)=>data_channel_fifo_out_c(178),
            dout(49)=>data_channel_fifo_out_c(177),dout(48)=>data_channel_fifo_out_c(176),
            dout(47)=>data_channel_fifo_out_c(175),dout(46)=>data_channel_fifo_out_c(174),
            dout(45)=>data_channel_fifo_out_c(173),dout(44)=>data_channel_fifo_out_c(172),
            dout(43)=>data_channel_fifo_out_c(171),dout(42)=>data_channel_fifo_out_c(170),
            dout(41)=>data_channel_fifo_out_c(169),dout(40)=>data_channel_fifo_out_c(168),
            dout(39)=>data_channel_fifo_out_c(167),dout(38)=>data_channel_fifo_out_c(166),
            dout(37)=>data_channel_fifo_out_c(165),dout(36)=>data_channel_fifo_out_c(164),
            dout(35)=>data_channel_fifo_out_c(163),dout(34)=>data_channel_fifo_out_c(162),
            dout(33)=>data_channel_fifo_out_c(161),dout(32)=>data_channel_fifo_out_c(160),
            dout(31)=>data_channel_fifo_out_c(159),dout(30)=>data_channel_fifo_out_c(158),
            dout(29)=>data_channel_fifo_out_c(157),dout(28)=>data_channel_fifo_out_c(156),
            dout(27)=>data_channel_fifo_out_c(155),dout(26)=>data_channel_fifo_out_c(154),
            dout(25)=>data_channel_fifo_out_c(153),dout(24)=>data_channel_fifo_out_c(152),
            dout(23)=>data_channel_fifo_out_c(151),dout(22)=>data_channel_fifo_out_c(150),
            dout(21)=>data_channel_fifo_out_c(149),dout(20)=>data_channel_fifo_out_c(148),
            dout(19)=>data_channel_fifo_out_c(147),dout(18)=>data_channel_fifo_out_c(146),
            dout(17)=>data_channel_fifo_out_c(145),dout(16)=>data_channel_fifo_out_c(144),
            dout(15)=>data_channel_fifo_out_c(143),dout(14)=>data_channel_fifo_out_c(142),
            dout(13)=>data_channel_fifo_out_c(141),dout(12)=>data_channel_fifo_out_c(140),
            dout(11)=>data_channel_fifo_out_c(139),dout(10)=>data_channel_fifo_out_c(138),
            dout(9)=>data_channel_fifo_out_c(137),dout(8)=>data_channel_fifo_out_c(136),
            dout(7)=>data_channel_fifo_out_c(135),dout(6)=>data_channel_fifo_out_c(134),
            dout(5)=>data_channel_fifo_out_c(133),dout(4)=>data_channel_fifo_out_c(132),
            dout(3)=>data_channel_fifo_out_c(131),dout(2)=>data_channel_fifo_out_c(130),
            dout(1)=>data_channel_fifo_out_c(129),dout(0)=>data_channel_fifo_out_c(128),
            valid=>data_channel_fifo_out_valid_c(1),full=>data_channel_fifo_full_c(1),
            empty=>data_channel_fifo_empty_c(1),rd_data_count(5)=>data_channel_fifo_rd_data_count(11),
            rd_data_count(4)=>data_channel_fifo_rd_data_count(10),rd_data_count(3)=>data_channel_fifo_rd_data_count(9),
            rd_data_count(2)=>data_channel_fifo_rd_data_count(8),rd_data_count(1)=>data_channel_fifo_rd_data_count(7),
            rd_data_count(0)=>data_channel_fifo_rd_data_count(6));   -- data_assembly.v(106)
    add_49: entity work.add_64u_64u(INTERFACE)  port map (cin=>trigger_type(1),
            a(63)=>time_cnt(63),a(62)=>time_cnt(62),a(61)=>time_cnt(61),a(60)=>time_cnt(60),
            a(59)=>time_cnt(59),a(58)=>time_cnt(58),a(57)=>time_cnt(57),a(56)=>time_cnt(56),
            a(55)=>time_cnt(55),a(54)=>time_cnt(54),a(53)=>time_cnt(53),a(52)=>time_cnt(52),
            a(51)=>time_cnt(51),a(50)=>time_cnt(50),a(49)=>time_cnt(49),a(48)=>time_cnt(48),
            a(47)=>time_cnt(47),a(46)=>time_cnt(46),a(45)=>time_cnt(45),a(44)=>time_cnt(44),
            a(43)=>time_cnt(43),a(42)=>time_cnt(42),a(41)=>time_cnt(41),a(40)=>time_cnt(40),
            a(39)=>time_cnt(39),a(38)=>time_cnt(38),a(37)=>time_cnt(37),a(36)=>time_cnt(36),
            a(35)=>time_cnt(35),a(34)=>time_cnt(34),a(33)=>time_cnt(33),a(32)=>time_cnt(32),
            a(31)=>time_cnt(31),a(30)=>time_cnt(30),a(29)=>time_cnt(29),a(28)=>time_cnt(28),
            a(27)=>time_cnt(27),a(26)=>time_cnt(26),a(25)=>time_cnt(25),a(24)=>time_cnt(24),
            a(23)=>time_cnt(23),a(22)=>time_cnt(22),a(21)=>time_cnt(21),a(20)=>time_cnt(20),
            a(19)=>time_cnt(19),a(18)=>time_cnt(18),a(17)=>time_cnt(17),a(16)=>time_cnt(16),
            a(15)=>time_cnt(15),a(14)=>time_cnt(14),a(13)=>time_cnt(13),a(12)=>time_cnt(12),
            a(11)=>time_cnt(11),a(10)=>time_cnt(10),a(9)=>time_cnt(9),a(8)=>time_cnt(8),
            a(7)=>time_cnt(7),a(6)=>time_cnt(6),a(5)=>time_cnt(5),a(4)=>time_cnt(4),
            a(3)=>time_cnt(3),a(2)=>time_cnt(2),a(1)=>time_cnt(1),a(0)=>time_cnt(0),
            b(63)=>trigger_type(1),b(62)=>trigger_type(1),b(61)=>trigger_type(1),
            b(60)=>trigger_type(1),b(59)=>trigger_type(1),b(58)=>trigger_type(1),
            b(57)=>trigger_type(1),b(56)=>trigger_type(1),b(55)=>trigger_type(1),
            b(54)=>trigger_type(1),b(53)=>trigger_type(1),b(52)=>trigger_type(1),
            b(51)=>trigger_type(1),b(50)=>trigger_type(1),b(49)=>trigger_type(1),
            b(48)=>trigger_type(1),b(47)=>trigger_type(1),b(46)=>trigger_type(1),
            b(45)=>trigger_type(1),b(44)=>trigger_type(1),b(43)=>trigger_type(1),
            b(42)=>trigger_type(1),b(41)=>trigger_type(1),b(40)=>trigger_type(1),
            b(39)=>trigger_type(1),b(38)=>trigger_type(1),b(37)=>trigger_type(1),
            b(36)=>trigger_type(1),b(35)=>trigger_type(1),b(34)=>trigger_type(1),
            b(33)=>trigger_type(1),b(32)=>trigger_type(1),b(31)=>trigger_type(1),
            b(30)=>trigger_type(1),b(29)=>trigger_type(1),b(28)=>trigger_type(1),
            b(27)=>trigger_type(1),b(26)=>trigger_type(1),b(25)=>trigger_type(1),
            b(24)=>trigger_type(1),b(23)=>trigger_type(1),b(22)=>trigger_type(1),
            b(21)=>trigger_type(1),b(20)=>trigger_type(1),b(19)=>trigger_type(1),
            b(18)=>trigger_type(1),b(17)=>trigger_type(1),b(16)=>trigger_type(1),
            b(15)=>trigger_type(1),b(14)=>trigger_type(1),b(13)=>trigger_type(1),
            b(12)=>trigger_type(1),b(11)=>trigger_type(1),b(10)=>trigger_type(1),
            b(9)=>trigger_type(1),b(8)=>trigger_type(1),b(7)=>trigger_type(1),
            b(6)=>trigger_type(1),b(5)=>trigger_type(1),b(4)=>trigger_type(1),
            b(3)=>trigger_type(1),b(2)=>trigger_type(1),b(1)=>trigger_type(1),
            b(0)=>trigger_type(0),o(63)=>n61,o(62)=>n62,o(61)=>n63,o(60)=>n64,
            o(59)=>n65,o(58)=>n66,o(57)=>n67,o(56)=>n68,o(55)=>n69,o(54)=>n70,
            o(53)=>n71,o(52)=>n72,o(51)=>n73,o(50)=>n74,o(49)=>n75,o(48)=>n76,
            o(47)=>n77,o(46)=>n78,o(45)=>n79,o(44)=>n80,o(43)=>n81,o(42)=>n82,
            o(41)=>n83,o(40)=>n84,o(39)=>n85,o(38)=>n86,o(37)=>n87,o(36)=>n88,
            o(35)=>n89,o(34)=>n90,o(33)=>n91,o(32)=>n92,o(31)=>n93,o(30)=>n94,
            o(29)=>n95,o(28)=>n96,o(27)=>n97,o(26)=>n98,o(25)=>n99,o(24)=>n100,
            o(23)=>n101,o(22)=>n102,o(21)=>n103,o(20)=>n104,o(19)=>n105,
            o(18)=>n106,o(17)=>n107,o(16)=>n108,o(15)=>n109,o(14)=>n110,
            o(13)=>n111,o(12)=>n112,o(11)=>n113,o(10)=>n114,o(9)=>n115,
            o(8)=>n116,o(7)=>n117,o(6)=>n118,o(5)=>n119,o(4)=>n120,o(3)=>n121,
            o(2)=>n122,o(1)=>n123,o(0)=>n124);   -- data_assembly.v(129)
    n125 <= trigger_type(1) when reset_i_dly='1' else n61;   -- data_assembly.v(125)
    n126 <= trigger_type(1) when reset_i_dly='1' else n62;   -- data_assembly.v(125)
    n127 <= trigger_type(1) when reset_i_dly='1' else n63;   -- data_assembly.v(125)
    n128 <= trigger_type(1) when reset_i_dly='1' else n64;   -- data_assembly.v(125)
    n129 <= trigger_type(1) when reset_i_dly='1' else n65;   -- data_assembly.v(125)
    n130 <= trigger_type(1) when reset_i_dly='1' else n66;   -- data_assembly.v(125)
    n131 <= trigger_type(1) when reset_i_dly='1' else n67;   -- data_assembly.v(125)
    n132 <= trigger_type(1) when reset_i_dly='1' else n68;   -- data_assembly.v(125)
    n133 <= trigger_type(1) when reset_i_dly='1' else n69;   -- data_assembly.v(125)
    n134 <= trigger_type(1) when reset_i_dly='1' else n70;   -- data_assembly.v(125)
    n135 <= trigger_type(1) when reset_i_dly='1' else n71;   -- data_assembly.v(125)
    n136 <= trigger_type(1) when reset_i_dly='1' else n72;   -- data_assembly.v(125)
    n137 <= trigger_type(1) when reset_i_dly='1' else n73;   -- data_assembly.v(125)
    n138 <= trigger_type(1) when reset_i_dly='1' else n74;   -- data_assembly.v(125)
    n139 <= trigger_type(1) when reset_i_dly='1' else n75;   -- data_assembly.v(125)
    n140 <= trigger_type(1) when reset_i_dly='1' else n76;   -- data_assembly.v(125)
    n141 <= trigger_type(1) when reset_i_dly='1' else n77;   -- data_assembly.v(125)
    n142 <= trigger_type(1) when reset_i_dly='1' else n78;   -- data_assembly.v(125)
    n143 <= trigger_type(1) when reset_i_dly='1' else n79;   -- data_assembly.v(125)
    n144 <= trigger_type(1) when reset_i_dly='1' else n80;   -- data_assembly.v(125)
    n145 <= trigger_type(1) when reset_i_dly='1' else n81;   -- data_assembly.v(125)
    n146 <= trigger_type(1) when reset_i_dly='1' else n82;   -- data_assembly.v(125)
    n147 <= trigger_type(1) when reset_i_dly='1' else n83;   -- data_assembly.v(125)
    n148 <= trigger_type(1) when reset_i_dly='1' else n84;   -- data_assembly.v(125)
    n149 <= trigger_type(1) when reset_i_dly='1' else n85;   -- data_assembly.v(125)
    n150 <= trigger_type(1) when reset_i_dly='1' else n86;   -- data_assembly.v(125)
    n151 <= trigger_type(1) when reset_i_dly='1' else n87;   -- data_assembly.v(125)
    n152 <= trigger_type(1) when reset_i_dly='1' else n88;   -- data_assembly.v(125)
    n153 <= trigger_type(1) when reset_i_dly='1' else n89;   -- data_assembly.v(125)
    n154 <= trigger_type(1) when reset_i_dly='1' else n90;   -- data_assembly.v(125)
    n155 <= trigger_type(1) when reset_i_dly='1' else n91;   -- data_assembly.v(125)
    n156 <= trigger_type(1) when reset_i_dly='1' else n92;   -- data_assembly.v(125)
    n157 <= trigger_type(1) when reset_i_dly='1' else n93;   -- data_assembly.v(125)
    n158 <= trigger_type(1) when reset_i_dly='1' else n94;   -- data_assembly.v(125)
    n159 <= trigger_type(1) when reset_i_dly='1' else n95;   -- data_assembly.v(125)
    n160 <= trigger_type(1) when reset_i_dly='1' else n96;   -- data_assembly.v(125)
    n161 <= trigger_type(1) when reset_i_dly='1' else n97;   -- data_assembly.v(125)
    n162 <= trigger_type(1) when reset_i_dly='1' else n98;   -- data_assembly.v(125)
    n163 <= trigger_type(1) when reset_i_dly='1' else n99;   -- data_assembly.v(125)
    n164 <= trigger_type(1) when reset_i_dly='1' else n100;   -- data_assembly.v(125)
    n165 <= trigger_type(1) when reset_i_dly='1' else n101;   -- data_assembly.v(125)
    n166 <= trigger_type(1) when reset_i_dly='1' else n102;   -- data_assembly.v(125)
    n167 <= trigger_type(1) when reset_i_dly='1' else n103;   -- data_assembly.v(125)
    n168 <= trigger_type(1) when reset_i_dly='1' else n104;   -- data_assembly.v(125)
    n169 <= trigger_type(1) when reset_i_dly='1' else n105;   -- data_assembly.v(125)
    n170 <= trigger_type(1) when reset_i_dly='1' else n106;   -- data_assembly.v(125)
    n171 <= trigger_type(1) when reset_i_dly='1' else n107;   -- data_assembly.v(125)
    n172 <= trigger_type(1) when reset_i_dly='1' else n108;   -- data_assembly.v(125)
    n173 <= trigger_type(1) when reset_i_dly='1' else n109;   -- data_assembly.v(125)
    n174 <= trigger_type(1) when reset_i_dly='1' else n110;   -- data_assembly.v(125)
    n175 <= trigger_type(1) when reset_i_dly='1' else n111;   -- data_assembly.v(125)
    n176 <= trigger_type(1) when reset_i_dly='1' else n112;   -- data_assembly.v(125)
    n177 <= trigger_type(1) when reset_i_dly='1' else n113;   -- data_assembly.v(125)
    n178 <= trigger_type(1) when reset_i_dly='1' else n114;   -- data_assembly.v(125)
    n179 <= trigger_type(1) when reset_i_dly='1' else n115;   -- data_assembly.v(125)
    n180 <= trigger_type(1) when reset_i_dly='1' else n116;   -- data_assembly.v(125)
    n181 <= trigger_type(1) when reset_i_dly='1' else n117;   -- data_assembly.v(125)
    n182 <= trigger_type(1) when reset_i_dly='1' else n118;   -- data_assembly.v(125)
    n183 <= trigger_type(1) when reset_i_dly='1' else n119;   -- data_assembly.v(125)
    n184 <= trigger_type(1) when reset_i_dly='1' else n120;   -- data_assembly.v(125)
    n185 <= trigger_type(1) when reset_i_dly='1' else n121;   -- data_assembly.v(125)
    n186 <= trigger_type(1) when reset_i_dly='1' else n122;   -- data_assembly.v(125)
    n187 <= trigger_type(1) when reset_i_dly='1' else n123;   -- data_assembly.v(125)
    n188 <= trigger_type(1) when reset_i_dly='1' else n124;   -- data_assembly.v(125)
    n191 <= trig_in when extrig_en_r='1' else time_cnt(22);   -- data_assembly.v(131)
    i119: VERIFIC_DFFRS (d=>n126,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(62));   -- data_assembly.v(124)
    i120: VERIFIC_DFFRS (d=>n127,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(61));   -- data_assembly.v(124)
    i121: VERIFIC_DFFRS (d=>n128,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(60));   -- data_assembly.v(124)
    i122: VERIFIC_DFFRS (d=>n129,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(59));   -- data_assembly.v(124)
    i123: VERIFIC_DFFRS (d=>n130,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(58));   -- data_assembly.v(124)
    i124: VERIFIC_DFFRS (d=>n131,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(57));   -- data_assembly.v(124)
    i125: VERIFIC_DFFRS (d=>n132,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(56));   -- data_assembly.v(124)
    i126: VERIFIC_DFFRS (d=>n133,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(55));   -- data_assembly.v(124)
    i127: VERIFIC_DFFRS (d=>n134,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(54));   -- data_assembly.v(124)
    i128: VERIFIC_DFFRS (d=>n135,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(53));   -- data_assembly.v(124)
    i129: VERIFIC_DFFRS (d=>n136,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(52));   -- data_assembly.v(124)
    i130: VERIFIC_DFFRS (d=>n137,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(51));   -- data_assembly.v(124)
    i131: VERIFIC_DFFRS (d=>n138,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(50));   -- data_assembly.v(124)
    i132: VERIFIC_DFFRS (d=>n139,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(49));   -- data_assembly.v(124)
    i133: VERIFIC_DFFRS (d=>n140,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(48));   -- data_assembly.v(124)
    i134: VERIFIC_DFFRS (d=>n141,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(47));   -- data_assembly.v(124)
    i135: VERIFIC_DFFRS (d=>n142,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(46));   -- data_assembly.v(124)
    i136: VERIFIC_DFFRS (d=>n143,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(45));   -- data_assembly.v(124)
    i137: VERIFIC_DFFRS (d=>n144,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(44));   -- data_assembly.v(124)
    i138: VERIFIC_DFFRS (d=>n145,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(43));   -- data_assembly.v(124)
    i139: VERIFIC_DFFRS (d=>n146,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(42));   -- data_assembly.v(124)
    i140: VERIFIC_DFFRS (d=>n147,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(41));   -- data_assembly.v(124)
    i141: VERIFIC_DFFRS (d=>n148,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(40));   -- data_assembly.v(124)
    i142: VERIFIC_DFFRS (d=>n149,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(39));   -- data_assembly.v(124)
    i143: VERIFIC_DFFRS (d=>n150,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(38));   -- data_assembly.v(124)
    i144: VERIFIC_DFFRS (d=>n151,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(37));   -- data_assembly.v(124)
    i145: VERIFIC_DFFRS (d=>n152,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(36));   -- data_assembly.v(124)
    i146: VERIFIC_DFFRS (d=>n153,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(35));   -- data_assembly.v(124)
    i147: VERIFIC_DFFRS (d=>n154,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(34));   -- data_assembly.v(124)
    i148: VERIFIC_DFFRS (d=>n155,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(33));   -- data_assembly.v(124)
    i149: VERIFIC_DFFRS (d=>n156,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(32));   -- data_assembly.v(124)
    i150: VERIFIC_DFFRS (d=>n157,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(31));   -- data_assembly.v(124)
    i151: VERIFIC_DFFRS (d=>n158,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(30));   -- data_assembly.v(124)
    i152: VERIFIC_DFFRS (d=>n159,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(29));   -- data_assembly.v(124)
    i153: VERIFIC_DFFRS (d=>n160,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(28));   -- data_assembly.v(124)
    i154: VERIFIC_DFFRS (d=>n161,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(27));   -- data_assembly.v(124)
    i155: VERIFIC_DFFRS (d=>n162,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(26));   -- data_assembly.v(124)
    i156: VERIFIC_DFFRS (d=>n163,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(25));   -- data_assembly.v(124)
    i157: VERIFIC_DFFRS (d=>n164,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(24));   -- data_assembly.v(124)
    i158: VERIFIC_DFFRS (d=>n165,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(23));   -- data_assembly.v(124)
    i159: VERIFIC_DFFRS (d=>n166,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(22));   -- data_assembly.v(124)
    i160: VERIFIC_DFFRS (d=>n167,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(21));   -- data_assembly.v(124)
    i161: VERIFIC_DFFRS (d=>n168,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(20));   -- data_assembly.v(124)
    i162: VERIFIC_DFFRS (d=>n169,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(19));   -- data_assembly.v(124)
    i163: VERIFIC_DFFRS (d=>n170,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(18));   -- data_assembly.v(124)
    i164: VERIFIC_DFFRS (d=>n171,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(17));   -- data_assembly.v(124)
    i165: VERIFIC_DFFRS (d=>n172,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(16));   -- data_assembly.v(124)
    i166: VERIFIC_DFFRS (d=>n173,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(15));   -- data_assembly.v(124)
    i167: VERIFIC_DFFRS (d=>n174,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(14));   -- data_assembly.v(124)
    i168: VERIFIC_DFFRS (d=>n175,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(13));   -- data_assembly.v(124)
    i169: VERIFIC_DFFRS (d=>n176,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(12));   -- data_assembly.v(124)
    i170: VERIFIC_DFFRS (d=>n177,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(11));   -- data_assembly.v(124)
    i171: VERIFIC_DFFRS (d=>n178,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(10));   -- data_assembly.v(124)
    i172: VERIFIC_DFFRS (d=>n179,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(9));   -- data_assembly.v(124)
    i173: VERIFIC_DFFRS (d=>n180,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(8));   -- data_assembly.v(124)
    i174: VERIFIC_DFFRS (d=>n181,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(7));   -- data_assembly.v(124)
    i175: VERIFIC_DFFRS (d=>n182,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(6));   -- data_assembly.v(124)
    i176: VERIFIC_DFFRS (d=>n183,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(5));   -- data_assembly.v(124)
    i177: VERIFIC_DFFRS (d=>n184,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(4));   -- data_assembly.v(124)
    i178: VERIFIC_DFFRS (d=>n185,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(3));   -- data_assembly.v(124)
    i179: VERIFIC_DFFRS (d=>n186,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(2));   -- data_assembly.v(124)
    i180: VERIFIC_DFFRS (d=>n187,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(1));   -- data_assembly.v(124)
    i181: VERIFIC_DFFRS (d=>n188,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>time_cnt(0));   -- data_assembly.v(124)
    i182: VERIFIC_DFFRS (d=>trig_in_plus_r(0),clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>start_adc);   -- data_assembly.v(124)
    i183: VERIFIC_DFFRS (d=>n191,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_in_plus_r(0));   -- data_assembly.v(124)
    i187: VERIFIC_DFFRS (d=>sample_next_state(2),clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>reset_i_dly,q=>sample_current_state(2));   -- data_assembly.v(152)
    n258 <= not start_adc;   -- data_assembly.v(137)
    start_adc_plus <= trig_in_plus_r(0) and n258;   -- data_assembly.v(137)
    i188: VERIFIC_DFFRS (d=>sample_next_state(1),clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>reset_i_dly,q=>sample_current_state(1));   -- data_assembly.v(152)
    i189: VERIFIC_DFFRS (d=>sample_next_state(0),clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>reset_i_dly,q=>sample_current_state(0));   -- data_assembly.v(152)
    i690: VERIFIC_DFFRS (d=>n665,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(127));   -- data_assembly.v(183)
    n264 <= sample_start and start_adc_plus;   -- data_assembly.v(160)
    n265 <= n264 and start_out;   -- data_assembly.v(160)
    reduce_and_191: entity work.reduce_and_2(INTERFACE)  port map (a(1)=>data_channel_fifo_empty_c(1),
            a(0)=>data_channel_fifo_empty_c(0),o=>n266);   -- data_assembly.v(160)
    n267 <= n265 and n266;   -- data_assembly.v(160)
    add_193: entity work.add_15u_15u(INTERFACE)  port map (cin=>trigger_type(0),
            a(14)=>sample_count_value_r(15),a(13)=>sample_count_value_r(14),
            a(12)=>sample_count_value_r(13),a(11)=>sample_count_value_r(12),
            a(10)=>sample_count_value_r(11),a(9)=>sample_count_value_r(10),
            a(8)=>sample_count_value_r(9),a(7)=>sample_count_value_r(8),a(6)=>sample_count_value_r(7),
            a(5)=>sample_count_value_r(6),a(4)=>sample_count_value_r(5),a(3)=>sample_count_value_r(4),
            a(2)=>sample_count_value_r(3),a(1)=>sample_count_value_r(2),a(0)=>sample_count_value_r(1),
            b(14)=>trigger_type(0),b(13)=>trigger_type(0),b(12)=>trigger_type(0),
            b(11)=>trigger_type(0),b(10)=>trigger_type(0),b(9)=>trigger_type(0),
            b(8)=>trigger_type(0),b(7)=>trigger_type(0),b(6)=>trigger_type(0),
            b(5)=>trigger_type(0),b(4)=>trigger_type(0),b(3)=>trigger_type(0),
            b(2)=>trigger_type(0),b(1)=>trigger_type(0),b(0)=>trigger_type(1),
            o(14)=>n269,o(13)=>n270,o(12)=>n271,o(11)=>n272,o(10)=>n273,
            o(9)=>n274,o(8)=>n275,o(7)=>n276,o(6)=>n277,o(5)=>n278,o(4)=>n279,
            o(3)=>n280,o(2)=>n281,o(1)=>n282,o(0)=>n283);   -- data_assembly.v(169)
    n284 <= samping_count(0) xor sample_count_value_r(0);   -- data_assembly.v(169)
    n285 <= samping_count(1) xor n283;   -- data_assembly.v(169)
    n286 <= samping_count(2) xor n282;   -- data_assembly.v(169)
    n287 <= samping_count(3) xor n281;   -- data_assembly.v(169)
    n288 <= samping_count(4) xor n280;   -- data_assembly.v(169)
    n289 <= samping_count(5) xor n279;   -- data_assembly.v(169)
    n290 <= samping_count(6) xor n278;   -- data_assembly.v(169)
    n291 <= samping_count(7) xor n277;   -- data_assembly.v(169)
    n292 <= samping_count(8) xor n276;   -- data_assembly.v(169)
    n293 <= samping_count(9) xor n275;   -- data_assembly.v(169)
    n294 <= samping_count(10) xor n274;   -- data_assembly.v(169)
    n295 <= samping_count(11) xor n273;   -- data_assembly.v(169)
    n296 <= samping_count(12) xor n272;   -- data_assembly.v(169)
    n297 <= samping_count(13) xor n271;   -- data_assembly.v(169)
    n298 <= samping_count(14) xor n270;   -- data_assembly.v(169)
    n299 <= samping_count(15) xor n269;   -- data_assembly.v(169)
    reduce_nor_210: entity work.reduce_nor_16(INTERFACE)  port map (a(15)=>n299,
            a(14)=>n298,a(13)=>n297,a(12)=>n296,a(11)=>n295,a(10)=>n294,
            a(9)=>n293,a(8)=>n292,a(7)=>n291,a(6)=>n290,a(5)=>n289,a(4)=>n288,
            a(3)=>n287,a(2)=>n286,a(1)=>n285,a(0)=>n284,o=>n300);   -- data_assembly.v(169)
    add_211: entity work.add_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>sample_delay_count_value_r(15),a(14)=>sample_delay_count_value_r(14),
            a(13)=>sample_delay_count_value_r(13),a(12)=>sample_delay_count_value_r(12),
            a(11)=>sample_delay_count_value_r(11),a(10)=>sample_delay_count_value_r(10),
            a(9)=>sample_delay_count_value_r(9),a(8)=>sample_delay_count_value_r(8),
            a(7)=>sample_delay_count_value_r(7),a(6)=>sample_delay_count_value_r(6),
            a(5)=>sample_delay_count_value_r(5),a(4)=>sample_delay_count_value_r(4),
            a(3)=>sample_delay_count_value_r(3),a(2)=>sample_delay_count_value_r(2),
            a(1)=>sample_delay_count_value_r(1),a(0)=>sample_delay_count_value_r(0),
            b(15)=>trigger_type(1),b(14)=>trigger_type(1),b(13)=>trigger_type(1),
            b(12)=>trigger_type(1),b(11)=>trigger_type(1),b(10)=>trigger_type(1),
            b(9)=>trigger_type(1),b(8)=>trigger_type(1),b(7)=>trigger_type(1),
            b(6)=>trigger_type(1),b(5)=>trigger_type(1),b(4)=>trigger_type(1),
            b(3)=>trigger_type(1),b(2)=>trigger_type(1),b(1)=>trigger_type(1),
            b(0)=>trigger_type(0),o(15)=>n302,o(14)=>n303,o(13)=>n304,o(12)=>n305,
            o(11)=>n306,o(10)=>n307,o(9)=>n308,o(8)=>n309,o(7)=>n310,o(6)=>n311,
            o(5)=>n312,o(4)=>n313,o(3)=>n314,o(2)=>n315,o(1)=>n316,o(0)=>n317);   -- data_assembly.v(176)
    n318 <= sample_delay_count(0) xor n317;   -- data_assembly.v(176)
    n319 <= sample_delay_count(1) xor n316;   -- data_assembly.v(176)
    n320 <= sample_delay_count(2) xor n315;   -- data_assembly.v(176)
    n321 <= sample_delay_count(3) xor n314;   -- data_assembly.v(176)
    n322 <= sample_delay_count(4) xor n313;   -- data_assembly.v(176)
    n323 <= sample_delay_count(5) xor n312;   -- data_assembly.v(176)
    n324 <= sample_delay_count(6) xor n311;   -- data_assembly.v(176)
    n325 <= sample_delay_count(7) xor n310;   -- data_assembly.v(176)
    n326 <= sample_delay_count(8) xor n309;   -- data_assembly.v(176)
    n327 <= sample_delay_count(9) xor n308;   -- data_assembly.v(176)
    n328 <= sample_delay_count(10) xor n307;   -- data_assembly.v(176)
    n329 <= sample_delay_count(11) xor n306;   -- data_assembly.v(176)
    n330 <= sample_delay_count(12) xor n305;   -- data_assembly.v(176)
    n331 <= sample_delay_count(13) xor n304;   -- data_assembly.v(176)
    n332 <= sample_delay_count(14) xor n303;   -- data_assembly.v(176)
    n333 <= sample_delay_count(15) xor n302;   -- data_assembly.v(176)
    reduce_nor_228: entity work.reduce_nor_16(INTERFACE)  port map (a(15)=>n333,
            a(14)=>n332,a(13)=>n331,a(12)=>n330,a(11)=>n329,a(10)=>n328,
            a(9)=>n327,a(8)=>n326,a(7)=>n325,a(6)=>n324,a(5)=>n323,a(4)=>n322,
            a(3)=>n321,a(2)=>n320,a(1)=>n319,a(0)=>n318,o=>n334);   -- data_assembly.v(176)
    n335 <= not n334;   -- data_assembly.v(176)
    Mux_230: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_current_state(2),
            sel(1)=>sample_current_state(1),sel(0)=>sample_current_state(0),
            data(7)=>trigger_type(1),data(6)=>trigger_type(1),data(5)=>trigger_type(1),
            data(4)=>n335,data(3)=>trigger_type(0),data(2)=>trigger_type(1),
            data(1)=>trigger_type(1),data(0)=>trigger_type(1),o=>sample_next_state(2));   -- data_assembly.v(158)
    Mux_231: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_current_state(2),
            sel(1)=>sample_current_state(1),sel(0)=>sample_current_state(0),
            data(7)=>trigger_type(1),data(6)=>trigger_type(1),data(5)=>trigger_type(1),
            data(4)=>trigger_type(1),data(3)=>trigger_type(1),data(2)=>trigger_type(0),
            data(1)=>trigger_type(0),data(0)=>trigger_type(1),o=>sample_next_state(1));   -- data_assembly.v(158)
    Mux_232: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_current_state(2),
            sel(1)=>sample_current_state(1),sel(0)=>sample_current_state(0),
            data(7)=>trigger_type(1),data(6)=>trigger_type(1),data(5)=>trigger_type(1),
            data(4)=>trigger_type(1),data(3)=>trigger_type(1),data(2)=>n300,
            data(1)=>trigger_type(1),data(0)=>n267,o=>sample_next_state(0));   -- data_assembly.v(158)
    add_234: entity work.add_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>samping_count(15),a(14)=>samping_count(14),a(13)=>samping_count(13),
            a(12)=>samping_count(12),a(11)=>samping_count(11),a(10)=>samping_count(10),
            a(9)=>samping_count(9),a(8)=>samping_count(8),a(7)=>samping_count(7),
            a(6)=>samping_count(6),a(5)=>samping_count(5),a(4)=>samping_count(4),
            a(3)=>samping_count(3),a(2)=>samping_count(2),a(1)=>samping_count(1),
            a(0)=>samping_count(0),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(1),b(11)=>trigger_type(1),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(1),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(0),o(15)=>n341,o(14)=>n342,
            o(13)=>n343,o(12)=>n344,o(11)=>n345,o(10)=>n346,o(9)=>n347,
            o(8)=>n348,o(7)=>n349,o(6)=>n350,o(5)=>n351,o(4)=>n352,o(3)=>n353,
            o(2)=>n354,o(1)=>n355,o(0)=>n356);   -- data_assembly.v(211)
    reduce_nor_235: entity work.reduce_nor_16(INTERFACE)  port map (a(15)=>trig_latency_count_value_r(15),
            a(14)=>trig_latency_count_value_r(14),a(13)=>trig_latency_count_value_r(13),
            a(12)=>trig_latency_count_value_r(12),a(11)=>trig_latency_count_value_r(11),
            a(10)=>trig_latency_count_value_r(10),a(9)=>trig_latency_count_value_r(9),
            a(8)=>trig_latency_count_value_r(8),a(7)=>trig_latency_count_value_r(7),
            a(6)=>trig_latency_count_value_r(6),a(5)=>trig_latency_count_value_r(5),
            a(4)=>trig_latency_count_value_r(4),a(3)=>trig_latency_count_value_r(3),
            a(2)=>trig_latency_count_value_r(2),a(1)=>trig_latency_count_value_r(1),
            a(0)=>trig_latency_count_value_r(0),o=>n357);   -- data_assembly.v(212)
    n358 <= adc_raw_data_c(127) when n357='1' else trig_latency_fifo_out(127);   -- data_assembly.v(212)
    n359 <= adc_raw_data_c(126) when n357='1' else trig_latency_fifo_out(126);   -- data_assembly.v(212)
    n360 <= adc_raw_data_c(125) when n357='1' else trig_latency_fifo_out(125);   -- data_assembly.v(212)
    n361 <= adc_raw_data_c(124) when n357='1' else trig_latency_fifo_out(124);   -- data_assembly.v(212)
    n362 <= adc_raw_data_c(123) when n357='1' else trig_latency_fifo_out(123);   -- data_assembly.v(212)
    n363 <= adc_raw_data_c(122) when n357='1' else trig_latency_fifo_out(122);   -- data_assembly.v(212)
    n364 <= adc_raw_data_c(121) when n357='1' else trig_latency_fifo_out(121);   -- data_assembly.v(212)
    n365 <= adc_raw_data_c(120) when n357='1' else trig_latency_fifo_out(120);   -- data_assembly.v(212)
    n366 <= adc_raw_data_c(119) when n357='1' else trig_latency_fifo_out(119);   -- data_assembly.v(212)
    n367 <= adc_raw_data_c(118) when n357='1' else trig_latency_fifo_out(118);   -- data_assembly.v(212)
    n368 <= adc_raw_data_c(117) when n357='1' else trig_latency_fifo_out(117);   -- data_assembly.v(212)
    n369 <= adc_raw_data_c(116) when n357='1' else trig_latency_fifo_out(116);   -- data_assembly.v(212)
    n370 <= adc_raw_data_c(115) when n357='1' else trig_latency_fifo_out(115);   -- data_assembly.v(212)
    n371 <= adc_raw_data_c(114) when n357='1' else trig_latency_fifo_out(114);   -- data_assembly.v(212)
    n372 <= adc_raw_data_c(113) when n357='1' else trig_latency_fifo_out(113);   -- data_assembly.v(212)
    n373 <= adc_raw_data_c(112) when n357='1' else trig_latency_fifo_out(112);   -- data_assembly.v(212)
    n374 <= adc_raw_data_c(111) when n357='1' else trig_latency_fifo_out(111);   -- data_assembly.v(212)
    n375 <= adc_raw_data_c(110) when n357='1' else trig_latency_fifo_out(110);   -- data_assembly.v(212)
    n376 <= adc_raw_data_c(109) when n357='1' else trig_latency_fifo_out(109);   -- data_assembly.v(212)
    n377 <= adc_raw_data_c(108) when n357='1' else trig_latency_fifo_out(108);   -- data_assembly.v(212)
    n378 <= adc_raw_data_c(107) when n357='1' else trig_latency_fifo_out(107);   -- data_assembly.v(212)
    n379 <= adc_raw_data_c(106) when n357='1' else trig_latency_fifo_out(106);   -- data_assembly.v(212)
    n380 <= adc_raw_data_c(105) when n357='1' else trig_latency_fifo_out(105);   -- data_assembly.v(212)
    n381 <= adc_raw_data_c(104) when n357='1' else trig_latency_fifo_out(104);   -- data_assembly.v(212)
    n382 <= adc_raw_data_c(103) when n357='1' else trig_latency_fifo_out(103);   -- data_assembly.v(212)
    n383 <= adc_raw_data_c(102) when n357='1' else trig_latency_fifo_out(102);   -- data_assembly.v(212)
    n384 <= adc_raw_data_c(101) when n357='1' else trig_latency_fifo_out(101);   -- data_assembly.v(212)
    n385 <= adc_raw_data_c(100) when n357='1' else trig_latency_fifo_out(100);   -- data_assembly.v(212)
    n386 <= adc_raw_data_c(99) when n357='1' else trig_latency_fifo_out(99);   -- data_assembly.v(212)
    n387 <= adc_raw_data_c(98) when n357='1' else trig_latency_fifo_out(98);   -- data_assembly.v(212)
    n388 <= adc_raw_data_c(97) when n357='1' else trig_latency_fifo_out(97);   -- data_assembly.v(212)
    n389 <= adc_raw_data_c(96) when n357='1' else trig_latency_fifo_out(96);   -- data_assembly.v(212)
    n390 <= adc_raw_data_c(95) when n357='1' else trig_latency_fifo_out(95);   -- data_assembly.v(212)
    n391 <= adc_raw_data_c(94) when n357='1' else trig_latency_fifo_out(94);   -- data_assembly.v(212)
    n392 <= adc_raw_data_c(93) when n357='1' else trig_latency_fifo_out(93);   -- data_assembly.v(212)
    n393 <= adc_raw_data_c(92) when n357='1' else trig_latency_fifo_out(92);   -- data_assembly.v(212)
    n394 <= adc_raw_data_c(91) when n357='1' else trig_latency_fifo_out(91);   -- data_assembly.v(212)
    n395 <= adc_raw_data_c(90) when n357='1' else trig_latency_fifo_out(90);   -- data_assembly.v(212)
    n396 <= adc_raw_data_c(89) when n357='1' else trig_latency_fifo_out(89);   -- data_assembly.v(212)
    n397 <= adc_raw_data_c(88) when n357='1' else trig_latency_fifo_out(88);   -- data_assembly.v(212)
    n398 <= adc_raw_data_c(87) when n357='1' else trig_latency_fifo_out(87);   -- data_assembly.v(212)
    n399 <= adc_raw_data_c(86) when n357='1' else trig_latency_fifo_out(86);   -- data_assembly.v(212)
    n400 <= adc_raw_data_c(85) when n357='1' else trig_latency_fifo_out(85);   -- data_assembly.v(212)
    n401 <= adc_raw_data_c(84) when n357='1' else trig_latency_fifo_out(84);   -- data_assembly.v(212)
    n402 <= adc_raw_data_c(83) when n357='1' else trig_latency_fifo_out(83);   -- data_assembly.v(212)
    n403 <= adc_raw_data_c(82) when n357='1' else trig_latency_fifo_out(82);   -- data_assembly.v(212)
    n404 <= adc_raw_data_c(81) when n357='1' else trig_latency_fifo_out(81);   -- data_assembly.v(212)
    n405 <= adc_raw_data_c(80) when n357='1' else trig_latency_fifo_out(80);   -- data_assembly.v(212)
    n406 <= adc_raw_data_c(79) when n357='1' else trig_latency_fifo_out(79);   -- data_assembly.v(212)
    n407 <= adc_raw_data_c(78) when n357='1' else trig_latency_fifo_out(78);   -- data_assembly.v(212)
    n408 <= adc_raw_data_c(77) when n357='1' else trig_latency_fifo_out(77);   -- data_assembly.v(212)
    n409 <= adc_raw_data_c(76) when n357='1' else trig_latency_fifo_out(76);   -- data_assembly.v(212)
    n410 <= adc_raw_data_c(75) when n357='1' else trig_latency_fifo_out(75);   -- data_assembly.v(212)
    n411 <= adc_raw_data_c(74) when n357='1' else trig_latency_fifo_out(74);   -- data_assembly.v(212)
    n412 <= adc_raw_data_c(73) when n357='1' else trig_latency_fifo_out(73);   -- data_assembly.v(212)
    n413 <= adc_raw_data_c(72) when n357='1' else trig_latency_fifo_out(72);   -- data_assembly.v(212)
    n414 <= adc_raw_data_c(71) when n357='1' else trig_latency_fifo_out(71);   -- data_assembly.v(212)
    n415 <= adc_raw_data_c(70) when n357='1' else trig_latency_fifo_out(70);   -- data_assembly.v(212)
    n416 <= adc_raw_data_c(69) when n357='1' else trig_latency_fifo_out(69);   -- data_assembly.v(212)
    n417 <= adc_raw_data_c(68) when n357='1' else trig_latency_fifo_out(68);   -- data_assembly.v(212)
    n418 <= adc_raw_data_c(67) when n357='1' else trig_latency_fifo_out(67);   -- data_assembly.v(212)
    n419 <= adc_raw_data_c(66) when n357='1' else trig_latency_fifo_out(66);   -- data_assembly.v(212)
    n420 <= adc_raw_data_c(65) when n357='1' else trig_latency_fifo_out(65);   -- data_assembly.v(212)
    n421 <= adc_raw_data_c(64) when n357='1' else trig_latency_fifo_out(64);   -- data_assembly.v(212)
    n422 <= adc_raw_data_c(63) when n357='1' else trig_latency_fifo_out(63);   -- data_assembly.v(212)
    n423 <= adc_raw_data_c(62) when n357='1' else trig_latency_fifo_out(62);   -- data_assembly.v(212)
    n424 <= adc_raw_data_c(61) when n357='1' else trig_latency_fifo_out(61);   -- data_assembly.v(212)
    n425 <= adc_raw_data_c(60) when n357='1' else trig_latency_fifo_out(60);   -- data_assembly.v(212)
    n426 <= adc_raw_data_c(59) when n357='1' else trig_latency_fifo_out(59);   -- data_assembly.v(212)
    n427 <= adc_raw_data_c(58) when n357='1' else trig_latency_fifo_out(58);   -- data_assembly.v(212)
    n428 <= adc_raw_data_c(57) when n357='1' else trig_latency_fifo_out(57);   -- data_assembly.v(212)
    n429 <= adc_raw_data_c(56) when n357='1' else trig_latency_fifo_out(56);   -- data_assembly.v(212)
    n430 <= adc_raw_data_c(55) when n357='1' else trig_latency_fifo_out(55);   -- data_assembly.v(212)
    n431 <= adc_raw_data_c(54) when n357='1' else trig_latency_fifo_out(54);   -- data_assembly.v(212)
    n432 <= adc_raw_data_c(53) when n357='1' else trig_latency_fifo_out(53);   -- data_assembly.v(212)
    n433 <= adc_raw_data_c(52) when n357='1' else trig_latency_fifo_out(52);   -- data_assembly.v(212)
    n434 <= adc_raw_data_c(51) when n357='1' else trig_latency_fifo_out(51);   -- data_assembly.v(212)
    n435 <= adc_raw_data_c(50) when n357='1' else trig_latency_fifo_out(50);   -- data_assembly.v(212)
    n436 <= adc_raw_data_c(49) when n357='1' else trig_latency_fifo_out(49);   -- data_assembly.v(212)
    n437 <= adc_raw_data_c(48) when n357='1' else trig_latency_fifo_out(48);   -- data_assembly.v(212)
    n438 <= adc_raw_data_c(47) when n357='1' else trig_latency_fifo_out(47);   -- data_assembly.v(212)
    n439 <= adc_raw_data_c(46) when n357='1' else trig_latency_fifo_out(46);   -- data_assembly.v(212)
    n440 <= adc_raw_data_c(45) when n357='1' else trig_latency_fifo_out(45);   -- data_assembly.v(212)
    n441 <= adc_raw_data_c(44) when n357='1' else trig_latency_fifo_out(44);   -- data_assembly.v(212)
    n442 <= adc_raw_data_c(43) when n357='1' else trig_latency_fifo_out(43);   -- data_assembly.v(212)
    n443 <= adc_raw_data_c(42) when n357='1' else trig_latency_fifo_out(42);   -- data_assembly.v(212)
    n444 <= adc_raw_data_c(41) when n357='1' else trig_latency_fifo_out(41);   -- data_assembly.v(212)
    n445 <= adc_raw_data_c(40) when n357='1' else trig_latency_fifo_out(40);   -- data_assembly.v(212)
    n446 <= adc_raw_data_c(39) when n357='1' else trig_latency_fifo_out(39);   -- data_assembly.v(212)
    n447 <= adc_raw_data_c(38) when n357='1' else trig_latency_fifo_out(38);   -- data_assembly.v(212)
    n448 <= adc_raw_data_c(37) when n357='1' else trig_latency_fifo_out(37);   -- data_assembly.v(212)
    n449 <= adc_raw_data_c(36) when n357='1' else trig_latency_fifo_out(36);   -- data_assembly.v(212)
    n450 <= adc_raw_data_c(35) when n357='1' else trig_latency_fifo_out(35);   -- data_assembly.v(212)
    n451 <= adc_raw_data_c(34) when n357='1' else trig_latency_fifo_out(34);   -- data_assembly.v(212)
    n452 <= adc_raw_data_c(33) when n357='1' else trig_latency_fifo_out(33);   -- data_assembly.v(212)
    n453 <= adc_raw_data_c(32) when n357='1' else trig_latency_fifo_out(32);   -- data_assembly.v(212)
    n454 <= adc_raw_data_c(31) when n357='1' else trig_latency_fifo_out(31);   -- data_assembly.v(212)
    n455 <= adc_raw_data_c(30) when n357='1' else trig_latency_fifo_out(30);   -- data_assembly.v(212)
    n456 <= adc_raw_data_c(29) when n357='1' else trig_latency_fifo_out(29);   -- data_assembly.v(212)
    n457 <= adc_raw_data_c(28) when n357='1' else trig_latency_fifo_out(28);   -- data_assembly.v(212)
    n458 <= adc_raw_data_c(27) when n357='1' else trig_latency_fifo_out(27);   -- data_assembly.v(212)
    n459 <= adc_raw_data_c(26) when n357='1' else trig_latency_fifo_out(26);   -- data_assembly.v(212)
    n460 <= adc_raw_data_c(25) when n357='1' else trig_latency_fifo_out(25);   -- data_assembly.v(212)
    n461 <= adc_raw_data_c(24) when n357='1' else trig_latency_fifo_out(24);   -- data_assembly.v(212)
    n462 <= adc_raw_data_c(23) when n357='1' else trig_latency_fifo_out(23);   -- data_assembly.v(212)
    n463 <= adc_raw_data_c(22) when n357='1' else trig_latency_fifo_out(22);   -- data_assembly.v(212)
    n464 <= adc_raw_data_c(21) when n357='1' else trig_latency_fifo_out(21);   -- data_assembly.v(212)
    n465 <= adc_raw_data_c(20) when n357='1' else trig_latency_fifo_out(20);   -- data_assembly.v(212)
    n466 <= adc_raw_data_c(19) when n357='1' else trig_latency_fifo_out(19);   -- data_assembly.v(212)
    n467 <= adc_raw_data_c(18) when n357='1' else trig_latency_fifo_out(18);   -- data_assembly.v(212)
    n468 <= adc_raw_data_c(17) when n357='1' else trig_latency_fifo_out(17);   -- data_assembly.v(212)
    n469 <= adc_raw_data_c(16) when n357='1' else trig_latency_fifo_out(16);   -- data_assembly.v(212)
    n470 <= adc_raw_data_c(15) when n357='1' else trig_latency_fifo_out(15);   -- data_assembly.v(212)
    n471 <= adc_raw_data_c(14) when n357='1' else trig_latency_fifo_out(14);   -- data_assembly.v(212)
    n472 <= adc_raw_data_c(13) when n357='1' else trig_latency_fifo_out(13);   -- data_assembly.v(212)
    n473 <= adc_raw_data_c(12) when n357='1' else trig_latency_fifo_out(12);   -- data_assembly.v(212)
    n474 <= adc_raw_data_c(11) when n357='1' else trig_latency_fifo_out(11);   -- data_assembly.v(212)
    n475 <= adc_raw_data_c(10) when n357='1' else trig_latency_fifo_out(10);   -- data_assembly.v(212)
    n476 <= adc_raw_data_c(9) when n357='1' else trig_latency_fifo_out(9);   -- data_assembly.v(212)
    n477 <= adc_raw_data_c(8) when n357='1' else trig_latency_fifo_out(8);   -- data_assembly.v(212)
    n478 <= adc_raw_data_c(7) when n357='1' else trig_latency_fifo_out(7);   -- data_assembly.v(212)
    n479 <= adc_raw_data_c(6) when n357='1' else trig_latency_fifo_out(6);   -- data_assembly.v(212)
    n480 <= adc_raw_data_c(5) when n357='1' else trig_latency_fifo_out(5);   -- data_assembly.v(212)
    n481 <= adc_raw_data_c(4) when n357='1' else trig_latency_fifo_out(4);   -- data_assembly.v(212)
    n482 <= adc_raw_data_c(3) when n357='1' else trig_latency_fifo_out(3);   -- data_assembly.v(212)
    n483 <= adc_raw_data_c(2) when n357='1' else trig_latency_fifo_out(2);   -- data_assembly.v(212)
    n484 <= adc_raw_data_c(1) when n357='1' else trig_latency_fifo_out(1);   -- data_assembly.v(212)
    n485 <= adc_raw_data_c(0) when n357='1' else trig_latency_fifo_out(0);   -- data_assembly.v(212)
    add_364: entity work.add_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>sample_delay_count(15),a(14)=>sample_delay_count(14),a(13)=>sample_delay_count(13),
            a(12)=>sample_delay_count(12),a(11)=>sample_delay_count(11),a(10)=>sample_delay_count(10),
            a(9)=>sample_delay_count(9),a(8)=>sample_delay_count(8),a(7)=>sample_delay_count(7),
            a(6)=>sample_delay_count(6),a(5)=>sample_delay_count(5),a(4)=>sample_delay_count(4),
            a(3)=>sample_delay_count(3),a(2)=>sample_delay_count(2),a(1)=>sample_delay_count(1),
            a(0)=>sample_delay_count(0),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(1),b(11)=>trigger_type(1),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(1),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(0),o(15)=>n487,o(14)=>n488,
            o(13)=>n489,o(12)=>n490,o(11)=>n491,o(10)=>n492,o(9)=>n493,
            o(8)=>n494,o(7)=>n495,o(6)=>n496,o(5)=>n497,o(4)=>n498,o(3)=>n499,
            o(2)=>n500,o(1)=>n501,o(0)=>n502);   -- data_assembly.v(228)
    Mux_365: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(127),
            data(3)=>trigger_type(1),data(2)=>n358,data(1)=>trigger_type(0),
            data(0)=>trigger_type(1),o=>n503);   -- data_assembly.v(191)
    Mux_366: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(126),
            data(3)=>trigger_type(0),data(2)=>n359,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n504);   -- data_assembly.v(191)
    Mux_367: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(125),
            data(3)=>trigger_type(1),data(2)=>n360,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n505);   -- data_assembly.v(191)
    Mux_368: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(124),
            data(3)=>trigger_type(0),data(2)=>n361,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n506);   -- data_assembly.v(191)
    Mux_369: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(123),
            data(3)=>trigger_type(1),data(2)=>n362,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n507);   -- data_assembly.v(191)
    Mux_370: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(122),
            data(3)=>trigger_type(0),data(2)=>n363,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n508);   -- data_assembly.v(191)
    Mux_371: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(121),
            data(3)=>trigger_type(1),data(2)=>n364,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n509);   -- data_assembly.v(191)
    Mux_372: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(120),
            data(3)=>trigger_type(0),data(2)=>n365,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n510);   -- data_assembly.v(191)
    Mux_373: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(119),
            data(3)=>trigger_type(0),data(2)=>n366,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n511);   -- data_assembly.v(191)
    Mux_374: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(118),
            data(3)=>trigger_type(1),data(2)=>n367,data(1)=>trigger_type(0),
            data(0)=>trigger_type(1),o=>n512);   -- data_assembly.v(191)
    Mux_375: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(117),
            data(3)=>trigger_type(0),data(2)=>n368,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n513);   -- data_assembly.v(191)
    Mux_376: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(116),
            data(3)=>trigger_type(1),data(2)=>n369,data(1)=>trigger_type(0),
            data(0)=>trigger_type(1),o=>n514);   -- data_assembly.v(191)
    Mux_377: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(115),
            data(3)=>trigger_type(0),data(2)=>n370,data(1)=>trigger_type(0),
            data(0)=>trigger_type(1),o=>n515);   -- data_assembly.v(191)
    Mux_378: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(114),
            data(3)=>trigger_type(1),data(2)=>n371,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n516);   -- data_assembly.v(191)
    Mux_379: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(113),
            data(3)=>trigger_type(0),data(2)=>n372,data(1)=>trigger_type(0),
            data(0)=>trigger_type(1),o=>n517);   -- data_assembly.v(191)
    Mux_380: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(112),
            data(3)=>trigger_type(1),data(2)=>n373,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n518);   -- data_assembly.v(191)
    Mux_381: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(111),
            data(3)=>trigger_type(1),data(2)=>n374,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n519);   -- data_assembly.v(191)
    Mux_382: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(110),
            data(3)=>trigger_type(1),data(2)=>n375,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n520);   -- data_assembly.v(191)
    Mux_383: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(109),
            data(3)=>trigger_type(1),data(2)=>n376,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n521);   -- data_assembly.v(191)
    Mux_384: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(108),
            data(3)=>trigger_type(1),data(2)=>n377,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n522);   -- data_assembly.v(191)
    Mux_385: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(107),
            data(3)=>trigger_type(1),data(2)=>n378,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n523);   -- data_assembly.v(191)
    Mux_386: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(106),
            data(3)=>trigger_type(1),data(2)=>n379,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n524);   -- data_assembly.v(191)
    Mux_387: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(105),
            data(3)=>trigger_type(1),data(2)=>n380,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n525);   -- data_assembly.v(191)
    Mux_388: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(104),
            data(3)=>trigger_type(0),data(2)=>n381,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n526);   -- data_assembly.v(191)
    Mux_389: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(103),
            data(3)=>trigger_type(1),data(2)=>n382,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n527);   -- data_assembly.v(191)
    Mux_390: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(102),
            data(3)=>trigger_type(1),data(2)=>n383,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n528);   -- data_assembly.v(191)
    Mux_391: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(101),
            data(3)=>trigger_type(0),data(2)=>n384,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n529);   -- data_assembly.v(191)
    Mux_392: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(100),
            data(3)=>trigger_type(1),data(2)=>n385,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n530);   -- data_assembly.v(191)
    Mux_393: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(99),
            data(3)=>trigger_type(1),data(2)=>n386,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n531);   -- data_assembly.v(191)
    Mux_394: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(98),
            data(3)=>trigger_type(1),data(2)=>n387,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n532);   -- data_assembly.v(191)
    Mux_395: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(97),
            data(3)=>trigger_type(0),data(2)=>n388,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n533);   -- data_assembly.v(191)
    Mux_396: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(96),
            data(3)=>trigger_type(0),data(2)=>n389,data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n534);   -- data_assembly.v(191)
    Mux_397: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(95),
            data(3)=>trigger_type(1),data(2)=>n390,data(1)=>sample_count_value_r(15),
            data(0)=>trigger_type(1),o=>n535);   -- data_assembly.v(191)
    Mux_398: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(94),
            data(3)=>trigger_type(0),data(2)=>n391,data(1)=>sample_count_value_r(14),
            data(0)=>trigger_type(1),o=>n536);   -- data_assembly.v(191)
    Mux_399: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(93),
            data(3)=>trigger_type(1),data(2)=>n392,data(1)=>sample_count_value_r(13),
            data(0)=>trigger_type(1),o=>n537);   -- data_assembly.v(191)
    Mux_400: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(92),
            data(3)=>trigger_type(1),data(2)=>n393,data(1)=>sample_count_value_r(12),
            data(0)=>trigger_type(1),o=>n538);   -- data_assembly.v(191)
    Mux_401: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(91),
            data(3)=>trigger_type(1),data(2)=>n394,data(1)=>sample_count_value_r(11),
            data(0)=>trigger_type(1),o=>n539);   -- data_assembly.v(191)
    Mux_402: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(90),
            data(3)=>trigger_type(0),data(2)=>n395,data(1)=>sample_count_value_r(10),
            data(0)=>trigger_type(1),o=>n540);   -- data_assembly.v(191)
    Mux_403: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(89),
            data(3)=>trigger_type(1),data(2)=>n396,data(1)=>sample_count_value_r(9),
            data(0)=>trigger_type(1),o=>n541);   -- data_assembly.v(191)
    Mux_404: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(88),
            data(3)=>trigger_type(0),data(2)=>n397,data(1)=>sample_count_value_r(8),
            data(0)=>trigger_type(1),o=>n542);   -- data_assembly.v(191)
    Mux_405: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(87),
            data(3)=>trigger_type(1),data(2)=>n398,data(1)=>sample_count_value_r(7),
            data(0)=>trigger_type(1),o=>n543);   -- data_assembly.v(191)
    Mux_406: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(86),
            data(3)=>trigger_type(0),data(2)=>n399,data(1)=>sample_count_value_r(6),
            data(0)=>trigger_type(1),o=>n544);   -- data_assembly.v(191)
    Mux_407: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(85),
            data(3)=>trigger_type(0),data(2)=>n400,data(1)=>sample_count_value_r(5),
            data(0)=>trigger_type(1),o=>n545);   -- data_assembly.v(191)
    Mux_408: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(84),
            data(3)=>trigger_type(1),data(2)=>n401,data(1)=>sample_count_value_r(4),
            data(0)=>trigger_type(1),o=>n546);   -- data_assembly.v(191)
    Mux_409: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(83),
            data(3)=>trigger_type(1),data(2)=>n402,data(1)=>sample_count_value_r(3),
            data(0)=>trigger_type(1),o=>n547);   -- data_assembly.v(191)
    Mux_410: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(82),
            data(3)=>trigger_type(0),data(2)=>n403,data(1)=>sample_count_value_r(2),
            data(0)=>trigger_type(1),o=>n548);   -- data_assembly.v(191)
    Mux_411: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(81),
            data(3)=>trigger_type(0),data(2)=>n404,data(1)=>sample_count_value_r(1),
            data(0)=>trigger_type(1),o=>n549);   -- data_assembly.v(191)
    Mux_412: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(80),
            data(3)=>trigger_type(0),data(2)=>n405,data(1)=>sample_count_value_r(0),
            data(0)=>trigger_type(1),o=>n550);   -- data_assembly.v(191)
    Mux_413: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(79),
            data(3)=>trigger_type(0),data(2)=>n406,data(1)=>trig_num(15),
            data(0)=>trigger_type(1),o=>n551);   -- data_assembly.v(191)
    Mux_414: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(78),
            data(3)=>trigger_type(1),data(2)=>n407,data(1)=>trig_num(14),
            data(0)=>trigger_type(1),o=>n552);   -- data_assembly.v(191)
    Mux_415: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(77),
            data(3)=>trigger_type(1),data(2)=>n408,data(1)=>trig_num(13),
            data(0)=>trigger_type(1),o=>n553);   -- data_assembly.v(191)
    Mux_416: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(76),
            data(3)=>trigger_type(1),data(2)=>n409,data(1)=>trig_num(12),
            data(0)=>trigger_type(1),o=>n554);   -- data_assembly.v(191)
    Mux_417: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(75),
            data(3)=>trigger_type(0),data(2)=>n410,data(1)=>trig_num(11),
            data(0)=>trigger_type(1),o=>n555);   -- data_assembly.v(191)
    Mux_418: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(74),
            data(3)=>trigger_type(1),data(2)=>n411,data(1)=>trig_num(10),
            data(0)=>trigger_type(1),o=>n556);   -- data_assembly.v(191)
    Mux_419: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(73),
            data(3)=>trigger_type(1),data(2)=>n412,data(1)=>trig_num(9),data(0)=>trigger_type(1),
            o=>n557);   -- data_assembly.v(191)
    Mux_420: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(72),
            data(3)=>trigger_type(0),data(2)=>n413,data(1)=>trig_num(8),data(0)=>trigger_type(1),
            o=>n558);   -- data_assembly.v(191)
    Mux_421: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(71),
            data(3)=>trigger_type(0),data(2)=>n414,data(1)=>trig_num(7),data(0)=>trigger_type(1),
            o=>n559);   -- data_assembly.v(191)
    Mux_422: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(70),
            data(3)=>trigger_type(1),data(2)=>n415,data(1)=>trig_num(6),data(0)=>trigger_type(1),
            o=>n560);   -- data_assembly.v(191)
    Mux_423: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(69),
            data(3)=>trigger_type(0),data(2)=>n416,data(1)=>trig_num(5),data(0)=>trigger_type(1),
            o=>n561);   -- data_assembly.v(191)
    Mux_424: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(68),
            data(3)=>trigger_type(1),data(2)=>n417,data(1)=>trig_num(4),data(0)=>trigger_type(1),
            o=>n562);   -- data_assembly.v(191)
    Mux_425: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(67),
            data(3)=>trigger_type(0),data(2)=>n418,data(1)=>trig_num(3),data(0)=>trigger_type(1),
            o=>n563);   -- data_assembly.v(191)
    Mux_426: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(66),
            data(3)=>trigger_type(1),data(2)=>n419,data(1)=>trig_num(2),data(0)=>trigger_type(1),
            o=>n564);   -- data_assembly.v(191)
    Mux_427: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(65),
            data(3)=>trigger_type(0),data(2)=>n420,data(1)=>trig_num(1),data(0)=>trigger_type(1),
            o=>n565);   -- data_assembly.v(191)
    Mux_428: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(64),
            data(3)=>trigger_type(0),data(2)=>n421,data(1)=>trig_num(0),data(0)=>trigger_type(1),
            o=>n566);   -- data_assembly.v(191)
    Mux_429: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(63),
            data(3)=>trigger_type(0),data(2)=>n422,data(1)=>time_cnt(63),
            data(0)=>trigger_type(1),o=>n567);   -- data_assembly.v(191)
    Mux_430: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(62),
            data(3)=>trigger_type(0),data(2)=>n423,data(1)=>time_cnt(62),
            data(0)=>trigger_type(1),o=>n568);   -- data_assembly.v(191)
    Mux_431: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(61),
            data(3)=>trigger_type(1),data(2)=>n424,data(1)=>time_cnt(61),
            data(0)=>trigger_type(1),o=>n569);   -- data_assembly.v(191)
    Mux_432: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(60),
            data(3)=>trigger_type(1),data(2)=>n425,data(1)=>time_cnt(60),
            data(0)=>trigger_type(1),o=>n570);   -- data_assembly.v(191)
    Mux_433: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(59),
            data(3)=>trigger_type(0),data(2)=>n426,data(1)=>time_cnt(59),
            data(0)=>trigger_type(1),o=>n571);   -- data_assembly.v(191)
    Mux_434: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(58),
            data(3)=>trigger_type(0),data(2)=>n427,data(1)=>time_cnt(58),
            data(0)=>trigger_type(1),o=>n572);   -- data_assembly.v(191)
    Mux_435: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(57),
            data(3)=>trigger_type(1),data(2)=>n428,data(1)=>time_cnt(57),
            data(0)=>trigger_type(1),o=>n573);   -- data_assembly.v(191)
    Mux_436: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(56),
            data(3)=>trigger_type(0),data(2)=>n429,data(1)=>time_cnt(56),
            data(0)=>trigger_type(1),o=>n574);   -- data_assembly.v(191)
    Mux_437: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(55),
            data(3)=>trigger_type(0),data(2)=>n430,data(1)=>time_cnt(55),
            data(0)=>trigger_type(1),o=>n575);   -- data_assembly.v(191)
    Mux_438: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(54),
            data(3)=>trigger_type(0),data(2)=>n431,data(1)=>time_cnt(54),
            data(0)=>trigger_type(1),o=>n576);   -- data_assembly.v(191)
    Mux_439: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(53),
            data(3)=>trigger_type(0),data(2)=>n432,data(1)=>time_cnt(53),
            data(0)=>trigger_type(1),o=>n577);   -- data_assembly.v(191)
    Mux_440: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(52),
            data(3)=>trigger_type(1),data(2)=>n433,data(1)=>time_cnt(52),
            data(0)=>trigger_type(1),o=>n578);   -- data_assembly.v(191)
    Mux_441: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(51),
            data(3)=>trigger_type(0),data(2)=>n434,data(1)=>time_cnt(51),
            data(0)=>trigger_type(1),o=>n579);   -- data_assembly.v(191)
    Mux_442: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(50),
            data(3)=>trigger_type(0),data(2)=>n435,data(1)=>time_cnt(50),
            data(0)=>trigger_type(1),o=>n580);   -- data_assembly.v(191)
    Mux_443: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(49),
            data(3)=>trigger_type(0),data(2)=>n436,data(1)=>time_cnt(49),
            data(0)=>trigger_type(1),o=>n581);   -- data_assembly.v(191)
    Mux_444: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(48),
            data(3)=>trigger_type(0),data(2)=>n437,data(1)=>time_cnt(48),
            data(0)=>trigger_type(1),o=>n582);   -- data_assembly.v(191)
    Mux_445: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(47),
            data(3)=>trigger_type(0),data(2)=>n438,data(1)=>time_cnt(47),
            data(0)=>trigger_type(1),o=>n583);   -- data_assembly.v(191)
    Mux_446: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(46),
            data(3)=>trigger_type(0),data(2)=>n439,data(1)=>time_cnt(46),
            data(0)=>trigger_type(1),o=>n584);   -- data_assembly.v(191)
    Mux_447: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(45),
            data(3)=>trigger_type(0),data(2)=>n440,data(1)=>time_cnt(45),
            data(0)=>trigger_type(1),o=>n585);   -- data_assembly.v(191)
    Mux_448: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(44),
            data(3)=>trigger_type(0),data(2)=>n441,data(1)=>time_cnt(44),
            data(0)=>trigger_type(1),o=>n586);   -- data_assembly.v(191)
    Mux_449: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(43),
            data(3)=>trigger_type(0),data(2)=>n442,data(1)=>time_cnt(43),
            data(0)=>trigger_type(1),o=>n587);   -- data_assembly.v(191)
    Mux_450: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(42),
            data(3)=>trigger_type(0),data(2)=>n443,data(1)=>time_cnt(42),
            data(0)=>trigger_type(1),o=>n588);   -- data_assembly.v(191)
    Mux_451: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(41),
            data(3)=>trigger_type(0),data(2)=>n444,data(1)=>time_cnt(41),
            data(0)=>trigger_type(1),o=>n589);   -- data_assembly.v(191)
    Mux_452: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(40),
            data(3)=>trigger_type(0),data(2)=>n445,data(1)=>time_cnt(40),
            data(0)=>trigger_type(1),o=>n590);   -- data_assembly.v(191)
    Mux_453: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(39),
            data(3)=>trigger_type(1),data(2)=>n446,data(1)=>time_cnt(39),
            data(0)=>trigger_type(1),o=>n591);   -- data_assembly.v(191)
    Mux_454: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(38),
            data(3)=>trigger_type(1),data(2)=>n447,data(1)=>time_cnt(38),
            data(0)=>trigger_type(1),o=>n592);   -- data_assembly.v(191)
    Mux_455: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(37),
            data(3)=>trigger_type(1),data(2)=>n448,data(1)=>time_cnt(37),
            data(0)=>trigger_type(1),o=>n593);   -- data_assembly.v(191)
    Mux_456: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(36),
            data(3)=>trigger_type(1),data(2)=>n449,data(1)=>time_cnt(36),
            data(0)=>trigger_type(1),o=>n594);   -- data_assembly.v(191)
    Mux_457: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(35),
            data(3)=>trigger_type(1),data(2)=>n450,data(1)=>time_cnt(35),
            data(0)=>trigger_type(1),o=>n595);   -- data_assembly.v(191)
    Mux_458: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(34),
            data(3)=>trigger_type(1),data(2)=>n451,data(1)=>time_cnt(34),
            data(0)=>trigger_type(1),o=>n596);   -- data_assembly.v(191)
    Mux_459: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(33),
            data(3)=>trigger_type(1),data(2)=>n452,data(1)=>time_cnt(33),
            data(0)=>trigger_type(1),o=>n597);   -- data_assembly.v(191)
    Mux_460: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(32),
            data(3)=>trigger_type(1),data(2)=>n453,data(1)=>time_cnt(32),
            data(0)=>trigger_type(1),o=>n598);   -- data_assembly.v(191)
    Mux_461: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(31),
            data(3)=>trigger_type(1),data(2)=>n454,data(1)=>time_cnt(31),
            data(0)=>trigger_type(1),o=>n599);   -- data_assembly.v(191)
    Mux_462: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(30),
            data(3)=>trigger_type(1),data(2)=>n455,data(1)=>time_cnt(30),
            data(0)=>trigger_type(1),o=>n600);   -- data_assembly.v(191)
    Mux_463: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(29),
            data(3)=>trigger_type(1),data(2)=>n456,data(1)=>time_cnt(29),
            data(0)=>trigger_type(1),o=>n601);   -- data_assembly.v(191)
    Mux_464: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(28),
            data(3)=>trigger_type(1),data(2)=>n457,data(1)=>time_cnt(28),
            data(0)=>trigger_type(1),o=>n602);   -- data_assembly.v(191)
    Mux_465: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(27),
            data(3)=>trigger_type(1),data(2)=>n458,data(1)=>time_cnt(27),
            data(0)=>trigger_type(1),o=>n603);   -- data_assembly.v(191)
    Mux_466: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(26),
            data(3)=>trigger_type(1),data(2)=>n459,data(1)=>time_cnt(26),
            data(0)=>trigger_type(1),o=>n604);   -- data_assembly.v(191)
    Mux_467: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(25),
            data(3)=>trigger_type(1),data(2)=>n460,data(1)=>time_cnt(25),
            data(0)=>trigger_type(1),o=>n605);   -- data_assembly.v(191)
    Mux_468: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(24),
            data(3)=>trigger_type(1),data(2)=>n461,data(1)=>time_cnt(24),
            data(0)=>trigger_type(1),o=>n606);   -- data_assembly.v(191)
    Mux_469: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(23),
            data(3)=>trigger_type(1),data(2)=>n462,data(1)=>time_cnt(23),
            data(0)=>trigger_type(1),o=>n607);   -- data_assembly.v(191)
    Mux_470: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(22),
            data(3)=>trigger_type(1),data(2)=>n463,data(1)=>time_cnt(22),
            data(0)=>trigger_type(1),o=>n608);   -- data_assembly.v(191)
    Mux_471: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(21),
            data(3)=>trigger_type(1),data(2)=>n464,data(1)=>time_cnt(21),
            data(0)=>trigger_type(1),o=>n609);   -- data_assembly.v(191)
    Mux_472: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(20),
            data(3)=>trigger_type(1),data(2)=>n465,data(1)=>time_cnt(20),
            data(0)=>trigger_type(1),o=>n610);   -- data_assembly.v(191)
    Mux_473: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(19),
            data(3)=>trigger_type(1),data(2)=>n466,data(1)=>time_cnt(19),
            data(0)=>trigger_type(1),o=>n611);   -- data_assembly.v(191)
    Mux_474: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(18),
            data(3)=>trigger_type(1),data(2)=>n467,data(1)=>time_cnt(18),
            data(0)=>trigger_type(1),o=>n612);   -- data_assembly.v(191)
    Mux_475: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(17),
            data(3)=>trigger_type(1),data(2)=>n468,data(1)=>time_cnt(17),
            data(0)=>trigger_type(1),o=>n613);   -- data_assembly.v(191)
    Mux_476: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(16),
            data(3)=>trigger_type(1),data(2)=>n469,data(1)=>time_cnt(16),
            data(0)=>trigger_type(1),o=>n614);   -- data_assembly.v(191)
    Mux_477: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(15),
            data(3)=>trigger_type(0),data(2)=>n470,data(1)=>time_cnt(15),
            data(0)=>trigger_type(1),o=>n615);   -- data_assembly.v(191)
    Mux_478: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(14),
            data(3)=>trigger_type(1),data(2)=>n471,data(1)=>time_cnt(14),
            data(0)=>trigger_type(1),o=>n616);   -- data_assembly.v(191)
    Mux_479: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(13),
            data(3)=>trigger_type(1),data(2)=>n472,data(1)=>time_cnt(13),
            data(0)=>trigger_type(1),o=>n617);   -- data_assembly.v(191)
    Mux_480: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(12),
            data(3)=>trigger_type(1),data(2)=>n473,data(1)=>time_cnt(12),
            data(0)=>trigger_type(1),o=>n618);   -- data_assembly.v(191)
    Mux_481: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(11),
            data(3)=>trigger_type(1),data(2)=>n474,data(1)=>time_cnt(11),
            data(0)=>trigger_type(1),o=>n619);   -- data_assembly.v(191)
    Mux_482: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(10),
            data(3)=>trigger_type(1),data(2)=>n475,data(1)=>time_cnt(10),
            data(0)=>trigger_type(1),o=>n620);   -- data_assembly.v(191)
    Mux_483: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(9),
            data(3)=>trigger_type(1),data(2)=>n476,data(1)=>time_cnt(9),data(0)=>trigger_type(1),
            o=>n621);   -- data_assembly.v(191)
    Mux_484: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(8),
            data(3)=>trigger_type(1),data(2)=>n477,data(1)=>time_cnt(8),data(0)=>trigger_type(1),
            o=>n622);   -- data_assembly.v(191)
    Mux_485: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(7),
            data(3)=>trigger_type(1),data(2)=>n478,data(1)=>time_cnt(7),data(0)=>trigger_type(1),
            o=>n623);   -- data_assembly.v(191)
    Mux_486: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(6),
            data(3)=>trigger_type(0),data(2)=>n479,data(1)=>time_cnt(6),data(0)=>trigger_type(1),
            o=>n624);   -- data_assembly.v(191)
    Mux_487: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(5),
            data(3)=>trigger_type(0),data(2)=>n480,data(1)=>time_cnt(5),data(0)=>trigger_type(1),
            o=>n625);   -- data_assembly.v(191)
    Mux_488: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(4),
            data(3)=>trigger_type(1),data(2)=>n481,data(1)=>time_cnt(4),data(0)=>trigger_type(1),
            o=>n626);   -- data_assembly.v(191)
    Mux_489: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(3),
            data(3)=>trigger_type(0),data(2)=>n482,data(1)=>time_cnt(3),data(0)=>trigger_type(1),
            o=>n627);   -- data_assembly.v(191)
    Mux_490: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(2),
            data(3)=>trigger_type(1),data(2)=>n483,data(1)=>time_cnt(2),data(0)=>trigger_type(1),
            o=>n628);   -- data_assembly.v(191)
    Mux_491: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(1),
            data(3)=>trigger_type(1),data(2)=>n484,data(1)=>time_cnt(1),data(0)=>trigger_type(1),
            o=>n629);   -- data_assembly.v(191)
    Mux_492: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>data_channel_fifo_in(0),
            data(3)=>trigger_type(0),data(2)=>n485,data(1)=>time_cnt(0),data(0)=>trigger_type(1),
            o=>n630);   -- data_assembly.v(191)
    Mux_493: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(15),
            data(3)=>samping_count(15),data(2)=>n341,data(1)=>samping_count(15),
            data(0)=>trigger_type(1),o=>n631);   -- data_assembly.v(191)
    Mux_494: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(14),
            data(3)=>samping_count(14),data(2)=>n342,data(1)=>samping_count(14),
            data(0)=>trigger_type(1),o=>n632);   -- data_assembly.v(191)
    Mux_495: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(13),
            data(3)=>samping_count(13),data(2)=>n343,data(1)=>samping_count(13),
            data(0)=>trigger_type(1),o=>n633);   -- data_assembly.v(191)
    Mux_496: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(12),
            data(3)=>samping_count(12),data(2)=>n344,data(1)=>samping_count(12),
            data(0)=>trigger_type(1),o=>n634);   -- data_assembly.v(191)
    Mux_497: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(11),
            data(3)=>samping_count(11),data(2)=>n345,data(1)=>samping_count(11),
            data(0)=>trigger_type(1),o=>n635);   -- data_assembly.v(191)
    Mux_498: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(10),
            data(3)=>samping_count(10),data(2)=>n346,data(1)=>samping_count(10),
            data(0)=>trigger_type(1),o=>n636);   -- data_assembly.v(191)
    Mux_499: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(9),
            data(3)=>samping_count(9),data(2)=>n347,data(1)=>samping_count(9),
            data(0)=>trigger_type(1),o=>n637);   -- data_assembly.v(191)
    Mux_500: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(8),
            data(3)=>samping_count(8),data(2)=>n348,data(1)=>samping_count(8),
            data(0)=>trigger_type(1),o=>n638);   -- data_assembly.v(191)
    Mux_501: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(7),
            data(3)=>samping_count(7),data(2)=>n349,data(1)=>samping_count(7),
            data(0)=>trigger_type(1),o=>n639);   -- data_assembly.v(191)
    Mux_502: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(6),
            data(3)=>samping_count(6),data(2)=>n350,data(1)=>samping_count(6),
            data(0)=>trigger_type(1),o=>n640);   -- data_assembly.v(191)
    Mux_503: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(5),
            data(3)=>samping_count(5),data(2)=>n351,data(1)=>samping_count(5),
            data(0)=>trigger_type(1),o=>n641);   -- data_assembly.v(191)
    Mux_504: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(4),
            data(3)=>samping_count(4),data(2)=>n352,data(1)=>samping_count(4),
            data(0)=>trigger_type(1),o=>n642);   -- data_assembly.v(191)
    Mux_505: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(3),
            data(3)=>samping_count(3),data(2)=>n353,data(1)=>samping_count(3),
            data(0)=>trigger_type(1),o=>n643);   -- data_assembly.v(191)
    Mux_506: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(2),
            data(3)=>samping_count(2),data(2)=>n354,data(1)=>samping_count(2),
            data(0)=>trigger_type(1),o=>n644);   -- data_assembly.v(191)
    Mux_507: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(1),
            data(3)=>samping_count(1),data(2)=>n355,data(1)=>samping_count(1),
            data(0)=>trigger_type(1),o=>n645);   -- data_assembly.v(191)
    Mux_508: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>samping_count(0),
            data(3)=>samping_count(0),data(2)=>n356,data(1)=>samping_count(0),
            data(0)=>trigger_type(1),o=>n646);   -- data_assembly.v(191)
    Mux_509: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n487,
            data(3)=>sample_delay_count(15),data(2)=>sample_delay_count(15),
            data(1)=>sample_delay_count(15),data(0)=>trigger_type(1),o=>n647);   -- data_assembly.v(191)
    Mux_510: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n488,
            data(3)=>sample_delay_count(14),data(2)=>sample_delay_count(14),
            data(1)=>sample_delay_count(14),data(0)=>trigger_type(1),o=>n648);   -- data_assembly.v(191)
    Mux_511: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n489,
            data(3)=>sample_delay_count(13),data(2)=>sample_delay_count(13),
            data(1)=>sample_delay_count(13),data(0)=>trigger_type(1),o=>n649);   -- data_assembly.v(191)
    Mux_512: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n490,
            data(3)=>sample_delay_count(12),data(2)=>sample_delay_count(12),
            data(1)=>sample_delay_count(12),data(0)=>trigger_type(1),o=>n650);   -- data_assembly.v(191)
    Mux_513: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n491,
            data(3)=>sample_delay_count(11),data(2)=>sample_delay_count(11),
            data(1)=>sample_delay_count(11),data(0)=>trigger_type(1),o=>n651);   -- data_assembly.v(191)
    Mux_514: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n492,
            data(3)=>sample_delay_count(10),data(2)=>sample_delay_count(10),
            data(1)=>sample_delay_count(10),data(0)=>trigger_type(1),o=>n652);   -- data_assembly.v(191)
    Mux_515: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n493,
            data(3)=>sample_delay_count(9),data(2)=>sample_delay_count(9),
            data(1)=>sample_delay_count(9),data(0)=>trigger_type(1),o=>n653);   -- data_assembly.v(191)
    Mux_516: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n494,
            data(3)=>sample_delay_count(8),data(2)=>sample_delay_count(8),
            data(1)=>sample_delay_count(8),data(0)=>trigger_type(1),o=>n654);   -- data_assembly.v(191)
    Mux_517: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n495,
            data(3)=>sample_delay_count(7),data(2)=>sample_delay_count(7),
            data(1)=>sample_delay_count(7),data(0)=>trigger_type(1),o=>n655);   -- data_assembly.v(191)
    Mux_518: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n496,
            data(3)=>sample_delay_count(6),data(2)=>sample_delay_count(6),
            data(1)=>sample_delay_count(6),data(0)=>trigger_type(1),o=>n656);   -- data_assembly.v(191)
    Mux_519: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n497,
            data(3)=>sample_delay_count(5),data(2)=>sample_delay_count(5),
            data(1)=>sample_delay_count(5),data(0)=>trigger_type(1),o=>n657);   -- data_assembly.v(191)
    Mux_520: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n498,
            data(3)=>sample_delay_count(4),data(2)=>sample_delay_count(4),
            data(1)=>sample_delay_count(4),data(0)=>trigger_type(1),o=>n658);   -- data_assembly.v(191)
    Mux_521: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n499,
            data(3)=>sample_delay_count(3),data(2)=>sample_delay_count(3),
            data(1)=>sample_delay_count(3),data(0)=>trigger_type(1),o=>n659);   -- data_assembly.v(191)
    Mux_522: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n500,
            data(3)=>sample_delay_count(2),data(2)=>sample_delay_count(2),
            data(1)=>sample_delay_count(2),data(0)=>trigger_type(1),o=>n660);   -- data_assembly.v(191)
    Mux_523: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n501,
            data(3)=>sample_delay_count(1),data(2)=>sample_delay_count(1),
            data(1)=>sample_delay_count(1),data(0)=>trigger_type(1),o=>n661);   -- data_assembly.v(191)
    Mux_524: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>n502,
            data(3)=>sample_delay_count(0),data(2)=>sample_delay_count(0),
            data(1)=>sample_delay_count(0),data(0)=>trigger_type(1),o=>n662);   -- data_assembly.v(191)
    Mux_525: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>trigger_type(1),
            data(3)=>trigger_type(1),data(2)=>trigger_type(1),data(1)=>trigger_type(1),
            data(0)=>trigger_type(1),o=>n663);   -- data_assembly.v(191)
    Mux_526: entity work.Mux_3u_8u(INTERFACE)  port map (sel(2)=>sample_next_state(2),
            sel(1)=>sample_next_state(1),sel(0)=>sample_next_state(0),data(7)=>trigger_type(1),
            data(6)=>trigger_type(1),data(5)=>trigger_type(1),data(4)=>trigger_type(1),
            data(3)=>trigger_type(0),data(2)=>trigger_type(0),data(1)=>trigger_type(0),
            data(0)=>trigger_type(1),o=>n664);   -- data_assembly.v(191)
    n665 <= trigger_type(1) when reset_i_dly='1' else n503;   -- data_assembly.v(184)
    n666 <= trigger_type(1) when reset_i_dly='1' else n504;   -- data_assembly.v(184)
    n667 <= trigger_type(1) when reset_i_dly='1' else n505;   -- data_assembly.v(184)
    n668 <= trigger_type(1) when reset_i_dly='1' else n506;   -- data_assembly.v(184)
    n669 <= trigger_type(1) when reset_i_dly='1' else n507;   -- data_assembly.v(184)
    n670 <= trigger_type(1) when reset_i_dly='1' else n508;   -- data_assembly.v(184)
    n671 <= trigger_type(1) when reset_i_dly='1' else n509;   -- data_assembly.v(184)
    n672 <= trigger_type(1) when reset_i_dly='1' else n510;   -- data_assembly.v(184)
    n673 <= trigger_type(1) when reset_i_dly='1' else n511;   -- data_assembly.v(184)
    n674 <= trigger_type(1) when reset_i_dly='1' else n512;   -- data_assembly.v(184)
    n675 <= trigger_type(1) when reset_i_dly='1' else n513;   -- data_assembly.v(184)
    n676 <= trigger_type(1) when reset_i_dly='1' else n514;   -- data_assembly.v(184)
    n677 <= trigger_type(1) when reset_i_dly='1' else n515;   -- data_assembly.v(184)
    n678 <= trigger_type(1) when reset_i_dly='1' else n516;   -- data_assembly.v(184)
    n679 <= trigger_type(1) when reset_i_dly='1' else n517;   -- data_assembly.v(184)
    n680 <= trigger_type(1) when reset_i_dly='1' else n518;   -- data_assembly.v(184)
    n681 <= trigger_type(1) when reset_i_dly='1' else n519;   -- data_assembly.v(184)
    n682 <= trigger_type(1) when reset_i_dly='1' else n520;   -- data_assembly.v(184)
    n683 <= trigger_type(1) when reset_i_dly='1' else n521;   -- data_assembly.v(184)
    n684 <= trigger_type(1) when reset_i_dly='1' else n522;   -- data_assembly.v(184)
    n685 <= trigger_type(1) when reset_i_dly='1' else n523;   -- data_assembly.v(184)
    n686 <= trigger_type(1) when reset_i_dly='1' else n524;   -- data_assembly.v(184)
    n687 <= trigger_type(1) when reset_i_dly='1' else n525;   -- data_assembly.v(184)
    n688 <= trigger_type(1) when reset_i_dly='1' else n526;   -- data_assembly.v(184)
    n689 <= trigger_type(1) when reset_i_dly='1' else n527;   -- data_assembly.v(184)
    n690 <= trigger_type(1) when reset_i_dly='1' else n528;   -- data_assembly.v(184)
    n691 <= trigger_type(1) when reset_i_dly='1' else n529;   -- data_assembly.v(184)
    n692 <= trigger_type(1) when reset_i_dly='1' else n530;   -- data_assembly.v(184)
    n693 <= trigger_type(1) when reset_i_dly='1' else n531;   -- data_assembly.v(184)
    n694 <= trigger_type(1) when reset_i_dly='1' else n532;   -- data_assembly.v(184)
    n695 <= trigger_type(1) when reset_i_dly='1' else n533;   -- data_assembly.v(184)
    n696 <= trigger_type(1) when reset_i_dly='1' else n534;   -- data_assembly.v(184)
    n697 <= trigger_type(1) when reset_i_dly='1' else n535;   -- data_assembly.v(184)
    n698 <= trigger_type(1) when reset_i_dly='1' else n536;   -- data_assembly.v(184)
    n699 <= trigger_type(1) when reset_i_dly='1' else n537;   -- data_assembly.v(184)
    n700 <= trigger_type(1) when reset_i_dly='1' else n538;   -- data_assembly.v(184)
    n701 <= trigger_type(1) when reset_i_dly='1' else n539;   -- data_assembly.v(184)
    n702 <= trigger_type(1) when reset_i_dly='1' else n540;   -- data_assembly.v(184)
    n703 <= trigger_type(1) when reset_i_dly='1' else n541;   -- data_assembly.v(184)
    n704 <= trigger_type(1) when reset_i_dly='1' else n542;   -- data_assembly.v(184)
    n705 <= trigger_type(1) when reset_i_dly='1' else n543;   -- data_assembly.v(184)
    n706 <= trigger_type(1) when reset_i_dly='1' else n544;   -- data_assembly.v(184)
    n707 <= trigger_type(1) when reset_i_dly='1' else n545;   -- data_assembly.v(184)
    n708 <= trigger_type(1) when reset_i_dly='1' else n546;   -- data_assembly.v(184)
    n709 <= trigger_type(1) when reset_i_dly='1' else n547;   -- data_assembly.v(184)
    n710 <= trigger_type(1) when reset_i_dly='1' else n548;   -- data_assembly.v(184)
    n711 <= trigger_type(1) when reset_i_dly='1' else n549;   -- data_assembly.v(184)
    n712 <= trigger_type(1) when reset_i_dly='1' else n550;   -- data_assembly.v(184)
    n713 <= trigger_type(1) when reset_i_dly='1' else n551;   -- data_assembly.v(184)
    n714 <= trigger_type(1) when reset_i_dly='1' else n552;   -- data_assembly.v(184)
    n715 <= trigger_type(1) when reset_i_dly='1' else n553;   -- data_assembly.v(184)
    n716 <= trigger_type(1) when reset_i_dly='1' else n554;   -- data_assembly.v(184)
    n717 <= trigger_type(1) when reset_i_dly='1' else n555;   -- data_assembly.v(184)
    n718 <= trigger_type(1) when reset_i_dly='1' else n556;   -- data_assembly.v(184)
    n719 <= trigger_type(1) when reset_i_dly='1' else n557;   -- data_assembly.v(184)
    n720 <= trigger_type(1) when reset_i_dly='1' else n558;   -- data_assembly.v(184)
    n721 <= trigger_type(1) when reset_i_dly='1' else n559;   -- data_assembly.v(184)
    n722 <= trigger_type(1) when reset_i_dly='1' else n560;   -- data_assembly.v(184)
    n723 <= trigger_type(1) when reset_i_dly='1' else n561;   -- data_assembly.v(184)
    n724 <= trigger_type(1) when reset_i_dly='1' else n562;   -- data_assembly.v(184)
    n725 <= trigger_type(1) when reset_i_dly='1' else n563;   -- data_assembly.v(184)
    n726 <= trigger_type(1) when reset_i_dly='1' else n564;   -- data_assembly.v(184)
    n727 <= trigger_type(1) when reset_i_dly='1' else n565;   -- data_assembly.v(184)
    n728 <= trigger_type(1) when reset_i_dly='1' else n566;   -- data_assembly.v(184)
    n729 <= trigger_type(1) when reset_i_dly='1' else n567;   -- data_assembly.v(184)
    n730 <= trigger_type(1) when reset_i_dly='1' else n568;   -- data_assembly.v(184)
    n731 <= trigger_type(1) when reset_i_dly='1' else n569;   -- data_assembly.v(184)
    n732 <= trigger_type(1) when reset_i_dly='1' else n570;   -- data_assembly.v(184)
    n733 <= trigger_type(1) when reset_i_dly='1' else n571;   -- data_assembly.v(184)
    n734 <= trigger_type(1) when reset_i_dly='1' else n572;   -- data_assembly.v(184)
    n735 <= trigger_type(1) when reset_i_dly='1' else n573;   -- data_assembly.v(184)
    n736 <= trigger_type(1) when reset_i_dly='1' else n574;   -- data_assembly.v(184)
    n737 <= trigger_type(1) when reset_i_dly='1' else n575;   -- data_assembly.v(184)
    n738 <= trigger_type(1) when reset_i_dly='1' else n576;   -- data_assembly.v(184)
    n739 <= trigger_type(1) when reset_i_dly='1' else n577;   -- data_assembly.v(184)
    n740 <= trigger_type(1) when reset_i_dly='1' else n578;   -- data_assembly.v(184)
    n741 <= trigger_type(1) when reset_i_dly='1' else n579;   -- data_assembly.v(184)
    n742 <= trigger_type(1) when reset_i_dly='1' else n580;   -- data_assembly.v(184)
    n743 <= trigger_type(1) when reset_i_dly='1' else n581;   -- data_assembly.v(184)
    n744 <= trigger_type(1) when reset_i_dly='1' else n582;   -- data_assembly.v(184)
    n745 <= trigger_type(1) when reset_i_dly='1' else n583;   -- data_assembly.v(184)
    n746 <= trigger_type(1) when reset_i_dly='1' else n584;   -- data_assembly.v(184)
    n747 <= trigger_type(1) when reset_i_dly='1' else n585;   -- data_assembly.v(184)
    n748 <= trigger_type(1) when reset_i_dly='1' else n586;   -- data_assembly.v(184)
    n749 <= trigger_type(1) when reset_i_dly='1' else n587;   -- data_assembly.v(184)
    n750 <= trigger_type(1) when reset_i_dly='1' else n588;   -- data_assembly.v(184)
    n751 <= trigger_type(1) when reset_i_dly='1' else n589;   -- data_assembly.v(184)
    n752 <= trigger_type(1) when reset_i_dly='1' else n590;   -- data_assembly.v(184)
    n753 <= trigger_type(1) when reset_i_dly='1' else n591;   -- data_assembly.v(184)
    n754 <= trigger_type(1) when reset_i_dly='1' else n592;   -- data_assembly.v(184)
    n755 <= trigger_type(1) when reset_i_dly='1' else n593;   -- data_assembly.v(184)
    n756 <= trigger_type(1) when reset_i_dly='1' else n594;   -- data_assembly.v(184)
    n757 <= trigger_type(1) when reset_i_dly='1' else n595;   -- data_assembly.v(184)
    n758 <= trigger_type(1) when reset_i_dly='1' else n596;   -- data_assembly.v(184)
    n759 <= trigger_type(1) when reset_i_dly='1' else n597;   -- data_assembly.v(184)
    n760 <= trigger_type(1) when reset_i_dly='1' else n598;   -- data_assembly.v(184)
    n761 <= trigger_type(1) when reset_i_dly='1' else n599;   -- data_assembly.v(184)
    n762 <= trigger_type(1) when reset_i_dly='1' else n600;   -- data_assembly.v(184)
    n763 <= trigger_type(1) when reset_i_dly='1' else n601;   -- data_assembly.v(184)
    n764 <= trigger_type(1) when reset_i_dly='1' else n602;   -- data_assembly.v(184)
    n765 <= trigger_type(1) when reset_i_dly='1' else n603;   -- data_assembly.v(184)
    n766 <= trigger_type(1) when reset_i_dly='1' else n604;   -- data_assembly.v(184)
    n767 <= trigger_type(1) when reset_i_dly='1' else n605;   -- data_assembly.v(184)
    n768 <= trigger_type(1) when reset_i_dly='1' else n606;   -- data_assembly.v(184)
    n769 <= trigger_type(1) when reset_i_dly='1' else n607;   -- data_assembly.v(184)
    n770 <= trigger_type(1) when reset_i_dly='1' else n608;   -- data_assembly.v(184)
    n771 <= trigger_type(1) when reset_i_dly='1' else n609;   -- data_assembly.v(184)
    n772 <= trigger_type(1) when reset_i_dly='1' else n610;   -- data_assembly.v(184)
    n773 <= trigger_type(1) when reset_i_dly='1' else n611;   -- data_assembly.v(184)
    n774 <= trigger_type(1) when reset_i_dly='1' else n612;   -- data_assembly.v(184)
    n775 <= trigger_type(1) when reset_i_dly='1' else n613;   -- data_assembly.v(184)
    n776 <= trigger_type(1) when reset_i_dly='1' else n614;   -- data_assembly.v(184)
    n777 <= trigger_type(1) when reset_i_dly='1' else n615;   -- data_assembly.v(184)
    n778 <= trigger_type(1) when reset_i_dly='1' else n616;   -- data_assembly.v(184)
    n779 <= trigger_type(1) when reset_i_dly='1' else n617;   -- data_assembly.v(184)
    n780 <= trigger_type(1) when reset_i_dly='1' else n618;   -- data_assembly.v(184)
    n781 <= trigger_type(1) when reset_i_dly='1' else n619;   -- data_assembly.v(184)
    n782 <= trigger_type(1) when reset_i_dly='1' else n620;   -- data_assembly.v(184)
    n783 <= trigger_type(1) when reset_i_dly='1' else n621;   -- data_assembly.v(184)
    n784 <= trigger_type(1) when reset_i_dly='1' else n622;   -- data_assembly.v(184)
    n785 <= trigger_type(1) when reset_i_dly='1' else n623;   -- data_assembly.v(184)
    n786 <= trigger_type(1) when reset_i_dly='1' else n624;   -- data_assembly.v(184)
    n787 <= trigger_type(1) when reset_i_dly='1' else n625;   -- data_assembly.v(184)
    n788 <= trigger_type(1) when reset_i_dly='1' else n626;   -- data_assembly.v(184)
    n789 <= trigger_type(1) when reset_i_dly='1' else n627;   -- data_assembly.v(184)
    n790 <= trigger_type(1) when reset_i_dly='1' else n628;   -- data_assembly.v(184)
    n791 <= trigger_type(1) when reset_i_dly='1' else n629;   -- data_assembly.v(184)
    n792 <= trigger_type(1) when reset_i_dly='1' else n630;   -- data_assembly.v(184)
    n793 <= trigger_type(1) when reset_i_dly='1' else n631;   -- data_assembly.v(184)
    n794 <= trigger_type(1) when reset_i_dly='1' else n632;   -- data_assembly.v(184)
    n795 <= trigger_type(1) when reset_i_dly='1' else n633;   -- data_assembly.v(184)
    n796 <= trigger_type(1) when reset_i_dly='1' else n634;   -- data_assembly.v(184)
    n797 <= trigger_type(1) when reset_i_dly='1' else n635;   -- data_assembly.v(184)
    n798 <= trigger_type(1) when reset_i_dly='1' else n636;   -- data_assembly.v(184)
    n799 <= trigger_type(1) when reset_i_dly='1' else n637;   -- data_assembly.v(184)
    n800 <= trigger_type(1) when reset_i_dly='1' else n638;   -- data_assembly.v(184)
    n801 <= trigger_type(1) when reset_i_dly='1' else n639;   -- data_assembly.v(184)
    n802 <= trigger_type(1) when reset_i_dly='1' else n640;   -- data_assembly.v(184)
    n803 <= trigger_type(1) when reset_i_dly='1' else n641;   -- data_assembly.v(184)
    n804 <= trigger_type(1) when reset_i_dly='1' else n642;   -- data_assembly.v(184)
    n805 <= trigger_type(1) when reset_i_dly='1' else n643;   -- data_assembly.v(184)
    n806 <= trigger_type(1) when reset_i_dly='1' else n644;   -- data_assembly.v(184)
    n807 <= trigger_type(1) when reset_i_dly='1' else n645;   -- data_assembly.v(184)
    n808 <= trigger_type(1) when reset_i_dly='1' else n646;   -- data_assembly.v(184)
    n809 <= trigger_type(1) when reset_i_dly='1' else n647;   -- data_assembly.v(184)
    n810 <= trigger_type(1) when reset_i_dly='1' else n648;   -- data_assembly.v(184)
    n811 <= trigger_type(1) when reset_i_dly='1' else n649;   -- data_assembly.v(184)
    n812 <= trigger_type(1) when reset_i_dly='1' else n650;   -- data_assembly.v(184)
    n813 <= trigger_type(1) when reset_i_dly='1' else n651;   -- data_assembly.v(184)
    n814 <= trigger_type(1) when reset_i_dly='1' else n652;   -- data_assembly.v(184)
    n815 <= trigger_type(1) when reset_i_dly='1' else n653;   -- data_assembly.v(184)
    n816 <= trigger_type(1) when reset_i_dly='1' else n654;   -- data_assembly.v(184)
    n817 <= trigger_type(1) when reset_i_dly='1' else n655;   -- data_assembly.v(184)
    n818 <= trigger_type(1) when reset_i_dly='1' else n656;   -- data_assembly.v(184)
    n819 <= trigger_type(1) when reset_i_dly='1' else n657;   -- data_assembly.v(184)
    n820 <= trigger_type(1) when reset_i_dly='1' else n658;   -- data_assembly.v(184)
    n821 <= trigger_type(1) when reset_i_dly='1' else n659;   -- data_assembly.v(184)
    n822 <= trigger_type(1) when reset_i_dly='1' else n660;   -- data_assembly.v(184)
    n823 <= trigger_type(1) when reset_i_dly='1' else n661;   -- data_assembly.v(184)
    n824 <= trigger_type(1) when reset_i_dly='1' else n662;   -- data_assembly.v(184)
    n825 <= trigger_type(1) when reset_i_dly='1' else n663;   -- data_assembly.v(184)
    n826 <= trigger_type(1) when reset_i_dly='1' else n664;   -- data_assembly.v(184)
    i691: VERIFIC_DFFRS (d=>n666,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(126));   -- data_assembly.v(183)
    i692: VERIFIC_DFFRS (d=>n667,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(125));   -- data_assembly.v(183)
    i693: VERIFIC_DFFRS (d=>n668,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(124));   -- data_assembly.v(183)
    i694: VERIFIC_DFFRS (d=>n669,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(123));   -- data_assembly.v(183)
    i695: VERIFIC_DFFRS (d=>n670,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(122));   -- data_assembly.v(183)
    i696: VERIFIC_DFFRS (d=>n671,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(121));   -- data_assembly.v(183)
    i697: VERIFIC_DFFRS (d=>n672,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(120));   -- data_assembly.v(183)
    i698: VERIFIC_DFFRS (d=>n673,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(119));   -- data_assembly.v(183)
    i699: VERIFIC_DFFRS (d=>n674,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(118));   -- data_assembly.v(183)
    i700: VERIFIC_DFFRS (d=>n675,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(117));   -- data_assembly.v(183)
    i701: VERIFIC_DFFRS (d=>n676,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(116));   -- data_assembly.v(183)
    i702: VERIFIC_DFFRS (d=>n677,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(115));   -- data_assembly.v(183)
    i703: VERIFIC_DFFRS (d=>n678,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(114));   -- data_assembly.v(183)
    i704: VERIFIC_DFFRS (d=>n679,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(113));   -- data_assembly.v(183)
    i705: VERIFIC_DFFRS (d=>n680,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(112));   -- data_assembly.v(183)
    i706: VERIFIC_DFFRS (d=>n681,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(111));   -- data_assembly.v(183)
    i707: VERIFIC_DFFRS (d=>n682,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(110));   -- data_assembly.v(183)
    i708: VERIFIC_DFFRS (d=>n683,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(109));   -- data_assembly.v(183)
    i709: VERIFIC_DFFRS (d=>n684,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(108));   -- data_assembly.v(183)
    i710: VERIFIC_DFFRS (d=>n685,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(107));   -- data_assembly.v(183)
    i711: VERIFIC_DFFRS (d=>n686,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(106));   -- data_assembly.v(183)
    i712: VERIFIC_DFFRS (d=>n687,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(105));   -- data_assembly.v(183)
    i713: VERIFIC_DFFRS (d=>n688,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(104));   -- data_assembly.v(183)
    i714: VERIFIC_DFFRS (d=>n689,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(103));   -- data_assembly.v(183)
    i715: VERIFIC_DFFRS (d=>n690,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(102));   -- data_assembly.v(183)
    i716: VERIFIC_DFFRS (d=>n691,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(101));   -- data_assembly.v(183)
    i717: VERIFIC_DFFRS (d=>n692,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(100));   -- data_assembly.v(183)
    i718: VERIFIC_DFFRS (d=>n693,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(99));   -- data_assembly.v(183)
    i719: VERIFIC_DFFRS (d=>n694,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(98));   -- data_assembly.v(183)
    i720: VERIFIC_DFFRS (d=>n695,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(97));   -- data_assembly.v(183)
    i721: VERIFIC_DFFRS (d=>n696,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(96));   -- data_assembly.v(183)
    i722: VERIFIC_DFFRS (d=>n697,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(95));   -- data_assembly.v(183)
    i723: VERIFIC_DFFRS (d=>n698,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(94));   -- data_assembly.v(183)
    i724: VERIFIC_DFFRS (d=>n699,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(93));   -- data_assembly.v(183)
    i725: VERIFIC_DFFRS (d=>n700,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(92));   -- data_assembly.v(183)
    i726: VERIFIC_DFFRS (d=>n701,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(91));   -- data_assembly.v(183)
    i727: VERIFIC_DFFRS (d=>n702,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(90));   -- data_assembly.v(183)
    i728: VERIFIC_DFFRS (d=>n703,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(89));   -- data_assembly.v(183)
    i729: VERIFIC_DFFRS (d=>n704,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(88));   -- data_assembly.v(183)
    i730: VERIFIC_DFFRS (d=>n705,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(87));   -- data_assembly.v(183)
    i731: VERIFIC_DFFRS (d=>n706,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(86));   -- data_assembly.v(183)
    i732: VERIFIC_DFFRS (d=>n707,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(85));   -- data_assembly.v(183)
    i733: VERIFIC_DFFRS (d=>n708,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(84));   -- data_assembly.v(183)
    i734: VERIFIC_DFFRS (d=>n709,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(83));   -- data_assembly.v(183)
    i735: VERIFIC_DFFRS (d=>n710,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(82));   -- data_assembly.v(183)
    i736: VERIFIC_DFFRS (d=>n711,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(81));   -- data_assembly.v(183)
    i737: VERIFIC_DFFRS (d=>n712,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(80));   -- data_assembly.v(183)
    i738: VERIFIC_DFFRS (d=>n713,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(79));   -- data_assembly.v(183)
    i739: VERIFIC_DFFRS (d=>n714,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(78));   -- data_assembly.v(183)
    i740: VERIFIC_DFFRS (d=>n715,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(77));   -- data_assembly.v(183)
    i741: VERIFIC_DFFRS (d=>n716,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(76));   -- data_assembly.v(183)
    i742: VERIFIC_DFFRS (d=>n717,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(75));   -- data_assembly.v(183)
    i743: VERIFIC_DFFRS (d=>n718,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(74));   -- data_assembly.v(183)
    i744: VERIFIC_DFFRS (d=>n719,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(73));   -- data_assembly.v(183)
    i745: VERIFIC_DFFRS (d=>n720,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(72));   -- data_assembly.v(183)
    i746: VERIFIC_DFFRS (d=>n721,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(71));   -- data_assembly.v(183)
    i747: VERIFIC_DFFRS (d=>n722,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(70));   -- data_assembly.v(183)
    i748: VERIFIC_DFFRS (d=>n723,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(69));   -- data_assembly.v(183)
    i749: VERIFIC_DFFRS (d=>n724,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(68));   -- data_assembly.v(183)
    i750: VERIFIC_DFFRS (d=>n725,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(67));   -- data_assembly.v(183)
    i751: VERIFIC_DFFRS (d=>n726,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(66));   -- data_assembly.v(183)
    i752: VERIFIC_DFFRS (d=>n727,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(65));   -- data_assembly.v(183)
    i753: VERIFIC_DFFRS (d=>n728,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(64));   -- data_assembly.v(183)
    i754: VERIFIC_DFFRS (d=>n729,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(63));   -- data_assembly.v(183)
    i755: VERIFIC_DFFRS (d=>n730,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(62));   -- data_assembly.v(183)
    i756: VERIFIC_DFFRS (d=>n731,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(61));   -- data_assembly.v(183)
    i757: VERIFIC_DFFRS (d=>n732,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(60));   -- data_assembly.v(183)
    i758: VERIFIC_DFFRS (d=>n733,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(59));   -- data_assembly.v(183)
    i759: VERIFIC_DFFRS (d=>n734,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(58));   -- data_assembly.v(183)
    i760: VERIFIC_DFFRS (d=>n735,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(57));   -- data_assembly.v(183)
    i761: VERIFIC_DFFRS (d=>n736,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(56));   -- data_assembly.v(183)
    i762: VERIFIC_DFFRS (d=>n737,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(55));   -- data_assembly.v(183)
    i763: VERIFIC_DFFRS (d=>n738,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(54));   -- data_assembly.v(183)
    i764: VERIFIC_DFFRS (d=>n739,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(53));   -- data_assembly.v(183)
    i765: VERIFIC_DFFRS (d=>n740,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(52));   -- data_assembly.v(183)
    i766: VERIFIC_DFFRS (d=>n741,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(51));   -- data_assembly.v(183)
    i767: VERIFIC_DFFRS (d=>n742,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(50));   -- data_assembly.v(183)
    i768: VERIFIC_DFFRS (d=>n743,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(49));   -- data_assembly.v(183)
    i769: VERIFIC_DFFRS (d=>n744,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(48));   -- data_assembly.v(183)
    i770: VERIFIC_DFFRS (d=>n745,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(47));   -- data_assembly.v(183)
    i771: VERIFIC_DFFRS (d=>n746,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(46));   -- data_assembly.v(183)
    i772: VERIFIC_DFFRS (d=>n747,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(45));   -- data_assembly.v(183)
    i773: VERIFIC_DFFRS (d=>n748,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(44));   -- data_assembly.v(183)
    i774: VERIFIC_DFFRS (d=>n749,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(43));   -- data_assembly.v(183)
    i775: VERIFIC_DFFRS (d=>n750,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(42));   -- data_assembly.v(183)
    i776: VERIFIC_DFFRS (d=>n751,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(41));   -- data_assembly.v(183)
    i777: VERIFIC_DFFRS (d=>n752,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(40));   -- data_assembly.v(183)
    i778: VERIFIC_DFFRS (d=>n753,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(39));   -- data_assembly.v(183)
    i779: VERIFIC_DFFRS (d=>n754,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(38));   -- data_assembly.v(183)
    i780: VERIFIC_DFFRS (d=>n755,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(37));   -- data_assembly.v(183)
    i781: VERIFIC_DFFRS (d=>n756,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(36));   -- data_assembly.v(183)
    i782: VERIFIC_DFFRS (d=>n757,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(35));   -- data_assembly.v(183)
    i783: VERIFIC_DFFRS (d=>n758,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(34));   -- data_assembly.v(183)
    i784: VERIFIC_DFFRS (d=>n759,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(33));   -- data_assembly.v(183)
    i785: VERIFIC_DFFRS (d=>n760,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(32));   -- data_assembly.v(183)
    i786: VERIFIC_DFFRS (d=>n761,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(31));   -- data_assembly.v(183)
    i787: VERIFIC_DFFRS (d=>n762,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(30));   -- data_assembly.v(183)
    i788: VERIFIC_DFFRS (d=>n763,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(29));   -- data_assembly.v(183)
    i789: VERIFIC_DFFRS (d=>n764,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(28));   -- data_assembly.v(183)
    i790: VERIFIC_DFFRS (d=>n765,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(27));   -- data_assembly.v(183)
    i791: VERIFIC_DFFRS (d=>n766,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(26));   -- data_assembly.v(183)
    i792: VERIFIC_DFFRS (d=>n767,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(25));   -- data_assembly.v(183)
    i793: VERIFIC_DFFRS (d=>n768,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(24));   -- data_assembly.v(183)
    i794: VERIFIC_DFFRS (d=>n769,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(23));   -- data_assembly.v(183)
    i795: VERIFIC_DFFRS (d=>n770,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(22));   -- data_assembly.v(183)
    i796: VERIFIC_DFFRS (d=>n771,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(21));   -- data_assembly.v(183)
    i797: VERIFIC_DFFRS (d=>n772,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(20));   -- data_assembly.v(183)
    i798: VERIFIC_DFFRS (d=>n773,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(19));   -- data_assembly.v(183)
    i799: VERIFIC_DFFRS (d=>n774,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(18));   -- data_assembly.v(183)
    i800: VERIFIC_DFFRS (d=>n775,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(17));   -- data_assembly.v(183)
    i801: VERIFIC_DFFRS (d=>n776,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(16));   -- data_assembly.v(183)
    i802: VERIFIC_DFFRS (d=>n777,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(15));   -- data_assembly.v(183)
    i803: VERIFIC_DFFRS (d=>n778,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(14));   -- data_assembly.v(183)
    i804: VERIFIC_DFFRS (d=>n779,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(13));   -- data_assembly.v(183)
    i805: VERIFIC_DFFRS (d=>n780,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(12));   -- data_assembly.v(183)
    i806: VERIFIC_DFFRS (d=>n781,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(11));   -- data_assembly.v(183)
    i807: VERIFIC_DFFRS (d=>n782,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(10));   -- data_assembly.v(183)
    i808: VERIFIC_DFFRS (d=>n783,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(9));   -- data_assembly.v(183)
    i809: VERIFIC_DFFRS (d=>n784,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(8));   -- data_assembly.v(183)
    i810: VERIFIC_DFFRS (d=>n785,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(7));   -- data_assembly.v(183)
    i811: VERIFIC_DFFRS (d=>n786,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(6));   -- data_assembly.v(183)
    i812: VERIFIC_DFFRS (d=>n787,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(5));   -- data_assembly.v(183)
    i813: VERIFIC_DFFRS (d=>n788,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(4));   -- data_assembly.v(183)
    i814: VERIFIC_DFFRS (d=>n789,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(3));   -- data_assembly.v(183)
    i815: VERIFIC_DFFRS (d=>n790,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(2));   -- data_assembly.v(183)
    i816: VERIFIC_DFFRS (d=>n791,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(1));   -- data_assembly.v(183)
    i817: VERIFIC_DFFRS (d=>n792,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_in(0));   -- data_assembly.v(183)
    i818: VERIFIC_DFFRS (d=>n793,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(15));   -- data_assembly.v(183)
    i819: VERIFIC_DFFRS (d=>n794,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(14));   -- data_assembly.v(183)
    i820: VERIFIC_DFFRS (d=>n795,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(13));   -- data_assembly.v(183)
    i821: VERIFIC_DFFRS (d=>n796,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(12));   -- data_assembly.v(183)
    i822: VERIFIC_DFFRS (d=>n797,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(11));   -- data_assembly.v(183)
    i823: VERIFIC_DFFRS (d=>n798,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(10));   -- data_assembly.v(183)
    i824: VERIFIC_DFFRS (d=>n799,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(9));   -- data_assembly.v(183)
    i825: VERIFIC_DFFRS (d=>n800,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(8));   -- data_assembly.v(183)
    i826: VERIFIC_DFFRS (d=>n801,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(7));   -- data_assembly.v(183)
    i827: VERIFIC_DFFRS (d=>n802,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(6));   -- data_assembly.v(183)
    i828: VERIFIC_DFFRS (d=>n803,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(5));   -- data_assembly.v(183)
    i829: VERIFIC_DFFRS (d=>n804,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(4));   -- data_assembly.v(183)
    i830: VERIFIC_DFFRS (d=>n805,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(3));   -- data_assembly.v(183)
    i831: VERIFIC_DFFRS (d=>n806,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(2));   -- data_assembly.v(183)
    i832: VERIFIC_DFFRS (d=>n807,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(1));   -- data_assembly.v(183)
    i833: VERIFIC_DFFRS (d=>n808,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>samping_count(0));   -- data_assembly.v(183)
    i834: VERIFIC_DFFRS (d=>n809,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(15));   -- data_assembly.v(183)
    i835: VERIFIC_DFFRS (d=>n810,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(14));   -- data_assembly.v(183)
    i836: VERIFIC_DFFRS (d=>n811,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(13));   -- data_assembly.v(183)
    i837: VERIFIC_DFFRS (d=>n812,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(12));   -- data_assembly.v(183)
    i838: VERIFIC_DFFRS (d=>n813,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(11));   -- data_assembly.v(183)
    i839: VERIFIC_DFFRS (d=>n814,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(10));   -- data_assembly.v(183)
    i840: VERIFIC_DFFRS (d=>n815,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(9));   -- data_assembly.v(183)
    i841: VERIFIC_DFFRS (d=>n816,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(8));   -- data_assembly.v(183)
    i842: VERIFIC_DFFRS (d=>n817,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(7));   -- data_assembly.v(183)
    i843: VERIFIC_DFFRS (d=>n818,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(6));   -- data_assembly.v(183)
    i844: VERIFIC_DFFRS (d=>n819,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(5));   -- data_assembly.v(183)
    i845: VERIFIC_DFFRS (d=>n820,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(4));   -- data_assembly.v(183)
    i846: VERIFIC_DFFRS (d=>n821,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(3));   -- data_assembly.v(183)
    i847: VERIFIC_DFFRS (d=>n822,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(2));   -- data_assembly.v(183)
    i848: VERIFIC_DFFRS (d=>n823,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(1));   -- data_assembly.v(183)
    i849: VERIFIC_DFFRS (d=>n824,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count(0));   -- data_assembly.v(183)
    i850: VERIFIC_DFFRS (d=>n825,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_wren(1));   -- data_assembly.v(183)
    i851: VERIFIC_DFFRS (d=>n826,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>data_channel_fifo_wren(0));   -- data_assembly.v(183)
    i888: VERIFIC_DFFRS (d=>n1025,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(15));   -- data_assembly.v(248)
    reduce_nor_852: entity work.reduce_nor_3(INTERFACE)  port map (a(2)=>sample_current_state(2),
            a(1)=>sample_current_state(1),a(0)=>sample_current_state(0),o=>n990);   -- data_assembly.v(251)
    n991 <= start_adc_plus and n990;   -- data_assembly.v(251)
    add_854: entity work.add_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>trig_num(15),a(14)=>trig_num(14),a(13)=>trig_num(13),a(12)=>trig_num(12),
            a(11)=>trig_num(11),a(10)=>trig_num(10),a(9)=>trig_num(9),a(8)=>trig_num(8),
            a(7)=>trig_num(7),a(6)=>trig_num(6),a(5)=>trig_num(5),a(4)=>trig_num(4),
            a(3)=>trig_num(3),a(2)=>trig_num(2),a(1)=>trig_num(1),a(0)=>trig_num(0),
            b(15)=>trigger_type(1),b(14)=>trigger_type(1),b(13)=>trigger_type(1),
            b(12)=>trigger_type(1),b(11)=>trigger_type(1),b(10)=>trigger_type(1),
            b(9)=>trigger_type(1),b(8)=>trigger_type(1),b(7)=>trigger_type(1),
            b(6)=>trigger_type(1),b(5)=>trigger_type(1),b(4)=>trigger_type(1),
            b(3)=>trigger_type(1),b(2)=>trigger_type(1),b(1)=>trigger_type(1),
            b(0)=>trigger_type(0),o(15)=>n993,o(14)=>n994,o(13)=>n995,o(12)=>n996,
            o(11)=>n997,o(10)=>n998,o(9)=>n999,o(8)=>n1000,o(7)=>n1001,
            o(6)=>n1002,o(5)=>n1003,o(4)=>n1004,o(3)=>n1005,o(2)=>n1006,
            o(1)=>n1007,o(0)=>n1008);   -- data_assembly.v(252)
    n1009 <= n993 when n991='1' else trig_num(15);   -- data_assembly.v(251)
    n1010 <= n994 when n991='1' else trig_num(14);   -- data_assembly.v(251)
    n1011 <= n995 when n991='1' else trig_num(13);   -- data_assembly.v(251)
    n1012 <= n996 when n991='1' else trig_num(12);   -- data_assembly.v(251)
    n1013 <= n997 when n991='1' else trig_num(11);   -- data_assembly.v(251)
    n1014 <= n998 when n991='1' else trig_num(10);   -- data_assembly.v(251)
    n1015 <= n999 when n991='1' else trig_num(9);   -- data_assembly.v(251)
    n1016 <= n1000 when n991='1' else trig_num(8);   -- data_assembly.v(251)
    n1017 <= n1001 when n991='1' else trig_num(7);   -- data_assembly.v(251)
    n1018 <= n1002 when n991='1' else trig_num(6);   -- data_assembly.v(251)
    n1019 <= n1003 when n991='1' else trig_num(5);   -- data_assembly.v(251)
    n1020 <= n1004 when n991='1' else trig_num(4);   -- data_assembly.v(251)
    n1021 <= n1005 when n991='1' else trig_num(3);   -- data_assembly.v(251)
    n1022 <= n1006 when n991='1' else trig_num(2);   -- data_assembly.v(251)
    n1023 <= n1007 when n991='1' else trig_num(1);   -- data_assembly.v(251)
    n1024 <= n1008 when n991='1' else trig_num(0);   -- data_assembly.v(251)
    n1025 <= trigger_type(1) when reset_i_dly='1' else n1009;   -- data_assembly.v(249)
    n1026 <= trigger_type(1) when reset_i_dly='1' else n1010;   -- data_assembly.v(249)
    n1027 <= trigger_type(1) when reset_i_dly='1' else n1011;   -- data_assembly.v(249)
    n1028 <= trigger_type(1) when reset_i_dly='1' else n1012;   -- data_assembly.v(249)
    n1029 <= trigger_type(1) when reset_i_dly='1' else n1013;   -- data_assembly.v(249)
    n1030 <= trigger_type(1) when reset_i_dly='1' else n1014;   -- data_assembly.v(249)
    n1031 <= trigger_type(1) when reset_i_dly='1' else n1015;   -- data_assembly.v(249)
    n1032 <= trigger_type(1) when reset_i_dly='1' else n1016;   -- data_assembly.v(249)
    n1033 <= trigger_type(1) when reset_i_dly='1' else n1017;   -- data_assembly.v(249)
    n1034 <= trigger_type(1) when reset_i_dly='1' else n1018;   -- data_assembly.v(249)
    n1035 <= trigger_type(1) when reset_i_dly='1' else n1019;   -- data_assembly.v(249)
    n1036 <= trigger_type(1) when reset_i_dly='1' else n1020;   -- data_assembly.v(249)
    n1037 <= trigger_type(1) when reset_i_dly='1' else n1021;   -- data_assembly.v(249)
    n1038 <= trigger_type(1) when reset_i_dly='1' else n1022;   -- data_assembly.v(249)
    n1039 <= trigger_type(1) when reset_i_dly='1' else n1023;   -- data_assembly.v(249)
    n1040 <= trigger_type(1) when reset_i_dly='1' else n1024;   -- data_assembly.v(249)
    i889: VERIFIC_DFFRS (d=>n1026,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(14));   -- data_assembly.v(248)
    i890: VERIFIC_DFFRS (d=>n1027,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(13));   -- data_assembly.v(248)
    i891: VERIFIC_DFFRS (d=>n1028,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(12));   -- data_assembly.v(248)
    i892: VERIFIC_DFFRS (d=>n1029,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(11));   -- data_assembly.v(248)
    i893: VERIFIC_DFFRS (d=>n1030,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(10));   -- data_assembly.v(248)
    i894: VERIFIC_DFFRS (d=>n1031,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(9));   -- data_assembly.v(248)
    i895: VERIFIC_DFFRS (d=>n1032,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(8));   -- data_assembly.v(248)
    i896: VERIFIC_DFFRS (d=>n1033,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(7));   -- data_assembly.v(248)
    i897: VERIFIC_DFFRS (d=>n1034,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(6));   -- data_assembly.v(248)
    i898: VERIFIC_DFFRS (d=>n1035,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(5));   -- data_assembly.v(248)
    i899: VERIFIC_DFFRS (d=>n1036,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(4));   -- data_assembly.v(248)
    i900: VERIFIC_DFFRS (d=>n1037,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(3));   -- data_assembly.v(248)
    i901: VERIFIC_DFFRS (d=>n1038,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(2));   -- data_assembly.v(248)
    i902: VERIFIC_DFFRS (d=>n1039,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(1));   -- data_assembly.v(248)
    i903: VERIFIC_DFFRS (d=>n1040,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_num(0));   -- data_assembly.v(248)
    i992: VERIFIC_DFFRS (d=>n1161,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(15));   -- data_assembly.v(257)
    n1059 <= reset_i_dly or n357;   -- data_assembly.v(258)
    n1060 <= trig_latency_count(0) xor trig_latency_count_value_r(0);   -- data_assembly.v(260)
    n1061 <= trig_latency_count(1) xor trig_latency_count_value_r(1);   -- data_assembly.v(260)
    n1062 <= trig_latency_count(2) xor trig_latency_count_value_r(2);   -- data_assembly.v(260)
    n1063 <= trig_latency_count(3) xor trig_latency_count_value_r(3);   -- data_assembly.v(260)
    n1064 <= trig_latency_count(4) xor trig_latency_count_value_r(4);   -- data_assembly.v(260)
    n1065 <= trig_latency_count(5) xor trig_latency_count_value_r(5);   -- data_assembly.v(260)
    n1066 <= trig_latency_count(6) xor trig_latency_count_value_r(6);   -- data_assembly.v(260)
    n1067 <= trig_latency_count(7) xor trig_latency_count_value_r(7);   -- data_assembly.v(260)
    n1068 <= trig_latency_count(8) xor trig_latency_count_value_r(8);   -- data_assembly.v(260)
    n1069 <= trig_latency_count(9) xor trig_latency_count_value_r(9);   -- data_assembly.v(260)
    n1070 <= trig_latency_count(10) xor trig_latency_count_value_r(10);   -- data_assembly.v(260)
    n1071 <= trig_latency_count(11) xor trig_latency_count_value_r(11);   -- data_assembly.v(260)
    n1072 <= trig_latency_count(12) xor trig_latency_count_value_r(12);   -- data_assembly.v(260)
    n1073 <= trig_latency_count(13) xor trig_latency_count_value_r(13);   -- data_assembly.v(260)
    n1074 <= trig_latency_count(14) xor trig_latency_count_value_r(14);   -- data_assembly.v(260)
    n1075 <= trig_latency_count(15) xor trig_latency_count_value_r(15);   -- data_assembly.v(260)
    reduce_nor_922: entity work.reduce_nor_16(INTERFACE)  port map (a(15)=>n1075,
            a(14)=>n1074,a(13)=>n1073,a(12)=>n1072,a(11)=>n1071,a(10)=>n1070,
            a(9)=>n1069,a(8)=>n1068,a(7)=>n1067,a(6)=>n1066,a(5)=>n1065,
            a(4)=>n1064,a(3)=>n1063,a(2)=>n1062,a(1)=>n1061,a(0)=>n1060,
            o=>n1076);   -- data_assembly.v(260)
    n1077 <= not n53;   -- data_assembly.v(262)
    add_924: entity work.add_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>trig_latency_count(15),a(14)=>trig_latency_count(14),a(13)=>trig_latency_count(13),
            a(12)=>trig_latency_count(12),a(11)=>trig_latency_count(11),a(10)=>trig_latency_count(10),
            a(9)=>trig_latency_count(9),a(8)=>trig_latency_count(8),a(7)=>trig_latency_count(7),
            a(6)=>trig_latency_count(6),a(5)=>trig_latency_count(5),a(4)=>trig_latency_count(4),
            a(3)=>trig_latency_count(3),a(2)=>trig_latency_count(2),a(1)=>trig_latency_count(1),
            a(0)=>trig_latency_count(0),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(1),b(11)=>trigger_type(1),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(1),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(0),o(15)=>n1079,o(14)=>n1080,
            o(13)=>n1081,o(12)=>n1082,o(11)=>n1083,o(10)=>n1084,o(9)=>n1085,
            o(8)=>n1086,o(7)=>n1087,o(6)=>n1088,o(5)=>n1089,o(4)=>n1090,
            o(3)=>n1091,o(2)=>n1092,o(1)=>n1093,o(0)=>n1094);   -- data_assembly.v(263)
    n1095 <= not n50;   -- data_assembly.v(264)
    add_926: entity work.add_16u_16u(INTERFACE)  port map (cin=>trigger_type(0),
            a(15)=>trig_latency_count(15),a(14)=>trig_latency_count(14),a(13)=>trig_latency_count(13),
            a(12)=>trig_latency_count(12),a(11)=>trig_latency_count(11),a(10)=>trig_latency_count(10),
            a(9)=>trig_latency_count(9),a(8)=>trig_latency_count(8),a(7)=>trig_latency_count(7),
            a(6)=>trig_latency_count(6),a(5)=>trig_latency_count(5),a(4)=>trig_latency_count(4),
            a(3)=>trig_latency_count(3),a(2)=>trig_latency_count(2),a(1)=>trig_latency_count(1),
            a(0)=>trig_latency_count(0),b(15)=>trigger_type(0),b(14)=>trigger_type(0),
            b(13)=>trigger_type(0),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(0),b(9)=>trigger_type(0),b(8)=>trigger_type(0),
            b(7)=>trigger_type(0),b(6)=>trigger_type(0),b(5)=>trigger_type(0),
            b(4)=>trigger_type(0),b(3)=>trigger_type(0),b(2)=>trigger_type(0),
            b(1)=>trigger_type(0),b(0)=>trigger_type(1),o(15)=>n1097,o(14)=>n1098,
            o(13)=>n1099,o(12)=>n1100,o(11)=>n1101,o(10)=>n1102,o(9)=>n1103,
            o(8)=>n1104,o(7)=>n1105,o(6)=>n1106,o(5)=>n1107,o(4)=>n1108,
            o(3)=>n1109,o(2)=>n1110,o(1)=>n1111,o(0)=>n1112);   -- data_assembly.v(265)
    n1113 <= n1097 when n1095='1' else trig_latency_count(15);   -- data_assembly.v(264)
    n1114 <= n1098 when n1095='1' else trig_latency_count(14);   -- data_assembly.v(264)
    n1115 <= n1099 when n1095='1' else trig_latency_count(13);   -- data_assembly.v(264)
    n1116 <= n1100 when n1095='1' else trig_latency_count(12);   -- data_assembly.v(264)
    n1117 <= n1101 when n1095='1' else trig_latency_count(11);   -- data_assembly.v(264)
    n1118 <= n1102 when n1095='1' else trig_latency_count(10);   -- data_assembly.v(264)
    n1119 <= n1103 when n1095='1' else trig_latency_count(9);   -- data_assembly.v(264)
    n1120 <= n1104 when n1095='1' else trig_latency_count(8);   -- data_assembly.v(264)
    n1121 <= n1105 when n1095='1' else trig_latency_count(7);   -- data_assembly.v(264)
    n1122 <= n1106 when n1095='1' else trig_latency_count(6);   -- data_assembly.v(264)
    n1123 <= n1107 when n1095='1' else trig_latency_count(5);   -- data_assembly.v(264)
    n1124 <= n1108 when n1095='1' else trig_latency_count(4);   -- data_assembly.v(264)
    n1125 <= n1109 when n1095='1' else trig_latency_count(3);   -- data_assembly.v(264)
    n1126 <= n1110 when n1095='1' else trig_latency_count(2);   -- data_assembly.v(264)
    n1127 <= n1111 when n1095='1' else trig_latency_count(1);   -- data_assembly.v(264)
    n1128 <= n1112 when n1095='1' else trig_latency_count(0);   -- data_assembly.v(264)
    n1129 <= n1079 when n1077='1' else n1113;   -- data_assembly.v(262)
    n1130 <= n1080 when n1077='1' else n1114;   -- data_assembly.v(262)
    n1131 <= n1081 when n1077='1' else n1115;   -- data_assembly.v(262)
    n1132 <= n1082 when n1077='1' else n1116;   -- data_assembly.v(262)
    n1133 <= n1083 when n1077='1' else n1117;   -- data_assembly.v(262)
    n1134 <= n1084 when n1077='1' else n1118;   -- data_assembly.v(262)
    n1135 <= n1085 when n1077='1' else n1119;   -- data_assembly.v(262)
    n1136 <= n1086 when n1077='1' else n1120;   -- data_assembly.v(262)
    n1137 <= n1087 when n1077='1' else n1121;   -- data_assembly.v(262)
    n1138 <= n1088 when n1077='1' else n1122;   -- data_assembly.v(262)
    n1139 <= n1089 when n1077='1' else n1123;   -- data_assembly.v(262)
    n1140 <= n1090 when n1077='1' else n1124;   -- data_assembly.v(262)
    n1141 <= n1091 when n1077='1' else n1125;   -- data_assembly.v(262)
    n1142 <= n1092 when n1077='1' else n1126;   -- data_assembly.v(262)
    n1143 <= n1093 when n1077='1' else n1127;   -- data_assembly.v(262)
    n1144 <= n1094 when n1077='1' else n1128;   -- data_assembly.v(262)
    n1145 <= trig_latency_count(15) when n1076='1' else n1129;   -- data_assembly.v(260)
    n1146 <= trig_latency_count(14) when n1076='1' else n1130;   -- data_assembly.v(260)
    n1147 <= trig_latency_count(13) when n1076='1' else n1131;   -- data_assembly.v(260)
    n1148 <= trig_latency_count(12) when n1076='1' else n1132;   -- data_assembly.v(260)
    n1149 <= trig_latency_count(11) when n1076='1' else n1133;   -- data_assembly.v(260)
    n1150 <= trig_latency_count(10) when n1076='1' else n1134;   -- data_assembly.v(260)
    n1151 <= trig_latency_count(9) when n1076='1' else n1135;   -- data_assembly.v(260)
    n1152 <= trig_latency_count(8) when n1076='1' else n1136;   -- data_assembly.v(260)
    n1153 <= trig_latency_count(7) when n1076='1' else n1137;   -- data_assembly.v(260)
    n1154 <= trig_latency_count(6) when n1076='1' else n1138;   -- data_assembly.v(260)
    n1155 <= trig_latency_count(5) when n1076='1' else n1139;   -- data_assembly.v(260)
    n1156 <= trig_latency_count(4) when n1076='1' else n1140;   -- data_assembly.v(260)
    n1157 <= trig_latency_count(3) when n1076='1' else n1141;   -- data_assembly.v(260)
    n1158 <= trig_latency_count(2) when n1076='1' else n1142;   -- data_assembly.v(260)
    n1159 <= trig_latency_count(1) when n1076='1' else n1143;   -- data_assembly.v(260)
    n1160 <= trig_latency_count(0) when n1076='1' else n1144;   -- data_assembly.v(260)
    n1161 <= trigger_type(1) when n1059='1' else n1145;   -- data_assembly.v(258)
    n1162 <= trigger_type(1) when n1059='1' else n1146;   -- data_assembly.v(258)
    n1163 <= trigger_type(1) when n1059='1' else n1147;   -- data_assembly.v(258)
    n1164 <= trigger_type(1) when n1059='1' else n1148;   -- data_assembly.v(258)
    n1165 <= trigger_type(1) when n1059='1' else n1149;   -- data_assembly.v(258)
    n1166 <= trigger_type(1) when n1059='1' else n1150;   -- data_assembly.v(258)
    n1167 <= trigger_type(1) when n1059='1' else n1151;   -- data_assembly.v(258)
    n1168 <= trigger_type(1) when n1059='1' else n1152;   -- data_assembly.v(258)
    n1169 <= trigger_type(1) when n1059='1' else n1153;   -- data_assembly.v(258)
    n1170 <= trigger_type(1) when n1059='1' else n1154;   -- data_assembly.v(258)
    n1171 <= trigger_type(1) when n1059='1' else n1155;   -- data_assembly.v(258)
    n1172 <= trigger_type(1) when n1059='1' else n1156;   -- data_assembly.v(258)
    n1173 <= trigger_type(1) when n1059='1' else n1157;   -- data_assembly.v(258)
    n1174 <= trigger_type(1) when n1059='1' else n1158;   -- data_assembly.v(258)
    n1175 <= trigger_type(1) when n1059='1' else n1159;   -- data_assembly.v(258)
    n1176 <= trigger_type(1) when n1059='1' else n1160;   -- data_assembly.v(258)
    i993: VERIFIC_DFFRS (d=>n1162,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(14));   -- data_assembly.v(257)
    i994: VERIFIC_DFFRS (d=>n1163,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(13));   -- data_assembly.v(257)
    i995: VERIFIC_DFFRS (d=>n1164,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(12));   -- data_assembly.v(257)
    i996: VERIFIC_DFFRS (d=>n1165,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(11));   -- data_assembly.v(257)
    i997: VERIFIC_DFFRS (d=>n1166,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(10));   -- data_assembly.v(257)
    i998: VERIFIC_DFFRS (d=>n1167,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(9));   -- data_assembly.v(257)
    i999: VERIFIC_DFFRS (d=>n1168,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(8));   -- data_assembly.v(257)
    i1000: VERIFIC_DFFRS (d=>n1169,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(7));   -- data_assembly.v(257)
    i1001: VERIFIC_DFFRS (d=>n1170,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(6));   -- data_assembly.v(257)
    i1002: VERIFIC_DFFRS (d=>n1171,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(5));   -- data_assembly.v(257)
    i1003: VERIFIC_DFFRS (d=>n1172,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(4));   -- data_assembly.v(257)
    i1004: VERIFIC_DFFRS (d=>n1173,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(3));   -- data_assembly.v(257)
    i1005: VERIFIC_DFFRS (d=>n1174,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(2));   -- data_assembly.v(257)
    i1006: VERIFIC_DFFRS (d=>n1175,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(1));   -- data_assembly.v(257)
    i1007: VERIFIC_DFFRS (d=>n1176,clk=>adc_user_clk_c,s=>trigger_type(1),
            r=>trigger_type(1),q=>trig_latency_count(0));   -- data_assembly.v(257)
    i1282: VERIFIC_DFFRS (d=>n1399,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_reset);   -- data_assembly.v(270)
    n1194 <= not config_din_addr(4);   -- data_assembly.v(289)
    n1195 <= not config_din_addr(5);   -- data_assembly.v(289)
    n1196 <= not config_din_addr(6);   -- data_assembly.v(289)
    n1197 <= not config_din_addr(7);   -- data_assembly.v(289)
    reduce_nor_1012: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>n1197,
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>config_din_addr(1),a(0)=>config_din_addr(0),
            o=>n1198);   -- data_assembly.v(289)
    n1199 <= not config_din_addr(0);   -- data_assembly.v(293)
    reduce_nor_1018: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>n1197,
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>config_din_addr(1),a(0)=>n1199,
            o=>n1204);   -- data_assembly.v(293)
    reduce_nor_1023: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>config_din_addr(7),
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>config_din_addr(1),a(0)=>n1199,
            o=>n1209);   -- data_assembly.v(296)
    n1210 <= not config_din_addr(1);   -- data_assembly.v(299)
    reduce_nor_1029: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>n1197,
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>n1210,a(0)=>config_din_addr(0),
            o=>n1215);   -- data_assembly.v(299)
    reduce_nor_1034: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>config_din_addr(7),
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>n1210,a(0)=>config_din_addr(0),
            o=>n1220);   -- data_assembly.v(302)
    reduce_nor_1041: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>n1197,
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>n1210,a(0)=>n1199,o=>n1227);   -- data_assembly.v(305)
    reduce_nor_1047: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>config_din_addr(7),
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>config_din_addr(2),a(1)=>n1210,a(0)=>n1199,o=>n1233);   -- data_assembly.v(308)
    n1234 <= not config_din_addr(2);   -- data_assembly.v(311)
    reduce_nor_1053: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>n1197,
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>n1234,a(1)=>config_din_addr(1),a(0)=>config_din_addr(0),
            o=>n1239);   -- data_assembly.v(311)
    reduce_nor_1058: entity work.reduce_nor_32(INTERFACE)  port map (a(31)=>config_din_addr(31),
            a(30)=>config_din_addr(30),a(29)=>config_din_addr(29),a(28)=>config_din_addr(28),
            a(27)=>config_din_addr(27),a(26)=>config_din_addr(26),a(25)=>config_din_addr(25),
            a(24)=>config_din_addr(24),a(23)=>config_din_addr(23),a(22)=>config_din_addr(22),
            a(21)=>config_din_addr(21),a(20)=>config_din_addr(20),a(19)=>config_din_addr(19),
            a(18)=>config_din_addr(18),a(17)=>config_din_addr(17),a(16)=>config_din_addr(16),
            a(15)=>config_din_addr(15),a(14)=>config_din_addr(14),a(13)=>config_din_addr(13),
            a(12)=>config_din_addr(12),a(11)=>config_din_addr(11),a(10)=>config_din_addr(10),
            a(9)=>config_din_addr(9),a(8)=>config_din_addr(8),a(7)=>config_din_addr(7),
            a(6)=>n1196,a(5)=>n1195,a(4)=>n1194,a(3)=>config_din_addr(3),
            a(2)=>n1234,a(1)=>config_din_addr(1),a(0)=>config_din_addr(0),
            o=>n1244);   -- data_assembly.v(314)
    reduce_nor_1059: entity work.reduce_nor_9(INTERFACE)  port map (a(8)=>n1198,
            a(7)=>n1204,a(6)=>n1209,a(5)=>n1215,a(4)=>n1220,a(3)=>n1227,
            a(2)=>n1233,a(1)=>n1239,a(0)=>n1244,o=>n1245);   -- data_assembly.v(287)
    n1246 <= config_din_data(1) when n1198='1' else trigger_type(1);   -- data_assembly.v(287)
    n1248 <= config_din_data(0) when n1198='1' else sample_start;   -- data_assembly.v(287)
    n1249 <= config_din_data(15) when n1204='1' else sample_count_value_r(15);   -- data_assembly.v(287)
    n1250 <= config_din_data(14) when n1204='1' else sample_count_value_r(14);   -- data_assembly.v(287)
    n1251 <= config_din_data(13) when n1204='1' else sample_count_value_r(13);   -- data_assembly.v(287)
    n1252 <= config_din_data(12) when n1204='1' else sample_count_value_r(12);   -- data_assembly.v(287)
    n1253 <= config_din_data(11) when n1204='1' else sample_count_value_r(11);   -- data_assembly.v(287)
    n1254 <= config_din_data(10) when n1204='1' else sample_count_value_r(10);   -- data_assembly.v(287)
    n1255 <= config_din_data(9) when n1204='1' else sample_count_value_r(9);   -- data_assembly.v(287)
    n1256 <= config_din_data(8) when n1204='1' else sample_count_value_r(8);   -- data_assembly.v(287)
    n1257 <= config_din_data(7) when n1204='1' else sample_count_value_r(7);   -- data_assembly.v(287)
    n1258 <= config_din_data(6) when n1204='1' else sample_count_value_r(6);   -- data_assembly.v(287)
    n1259 <= config_din_data(5) when n1204='1' else sample_count_value_r(5);   -- data_assembly.v(287)
    n1260 <= config_din_data(4) when n1204='1' else sample_count_value_r(4);   -- data_assembly.v(287)
    n1261 <= config_din_data(3) when n1204='1' else sample_count_value_r(3);   -- data_assembly.v(287)
    n1262 <= config_din_data(2) when n1204='1' else sample_count_value_r(2);   -- data_assembly.v(287)
    n1263 <= config_din_data(1) when n1204='1' else sample_count_value_r(1);   -- data_assembly.v(287)
    n1264 <= config_din_data(0) when n1204='1' else sample_count_value_r(0);   -- data_assembly.v(287)
    reduce_or_1079: entity work.reduce_or_6(INTERFACE)  port map (a(5)=>n1198,
            a(4)=>n1204,a(3)=>n1215,a(2)=>n1227,a(1)=>n1233,a(0)=>n1239,
            o=>n1265);   -- data_assembly.v(287)
    Select_1080: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(15),data(2)=>sample_delay_count_value_r(15),
            data(1)=>trig_latency_count_value_r(15),data(0)=>config_daq2c(15),
            o=>n1266);   -- data_assembly.v(287)
    Select_1082: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(14),data(2)=>sample_delay_count_value_r(14),
            data(1)=>trig_latency_count_value_r(14),data(0)=>config_daq2c(14),
            o=>n1268);   -- data_assembly.v(287)
    Select_1084: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(13),data(2)=>sample_delay_count_value_r(13),
            data(1)=>trig_latency_count_value_r(13),data(0)=>config_daq2c(13),
            o=>n1270);   -- data_assembly.v(287)
    Select_1086: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(12),data(2)=>sample_delay_count_value_r(12),
            data(1)=>trig_latency_count_value_r(12),data(0)=>config_daq2c(12),
            o=>n1272);   -- data_assembly.v(287)
    Select_1088: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(11),data(2)=>sample_delay_count_value_r(11),
            data(1)=>trig_latency_count_value_r(11),data(0)=>config_daq2c(11),
            o=>n1274);   -- data_assembly.v(287)
    Select_1090: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(10),data(2)=>sample_delay_count_value_r(10),
            data(1)=>trig_latency_count_value_r(10),data(0)=>config_daq2c(10),
            o=>n1276);   -- data_assembly.v(287)
    Select_1092: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(9),data(2)=>sample_delay_count_value_r(9),
            data(1)=>trig_latency_count_value_r(9),data(0)=>config_daq2c(9),
            o=>n1278);   -- data_assembly.v(287)
    Select_1094: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(8),data(2)=>sample_delay_count_value_r(8),
            data(1)=>trig_latency_count_value_r(8),data(0)=>config_daq2c(8),
            o=>n1280);   -- data_assembly.v(287)
    Select_1096: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(7),data(2)=>sample_delay_count_value_r(7),
            data(1)=>trig_latency_count_value_r(7),data(0)=>config_daq2c(7),
            o=>n1282);   -- data_assembly.v(287)
    Select_1098: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(6),data(2)=>sample_delay_count_value_r(6),
            data(1)=>trig_latency_count_value_r(6),data(0)=>config_daq2c(6),
            o=>n1284);   -- data_assembly.v(287)
    Select_1100: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(5),data(2)=>sample_delay_count_value_r(5),
            data(1)=>trig_latency_count_value_r(5),data(0)=>config_daq2c(5),
            o=>n1286);   -- data_assembly.v(287)
    Select_1102: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(4),data(2)=>sample_delay_count_value_r(4),
            data(1)=>trig_latency_count_value_r(4),data(0)=>config_daq2c(4),
            o=>n1288);   -- data_assembly.v(287)
    Select_1104: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(3),data(2)=>sample_delay_count_value_r(3),
            data(1)=>trig_latency_count_value_r(3),data(0)=>config_daq2c(3),
            o=>n1290);   -- data_assembly.v(287)
    Select_1106: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(2),data(2)=>sample_delay_count_value_r(2),
            data(1)=>trig_latency_count_value_r(2),data(0)=>config_daq2c(2),
            o=>n1292);   -- data_assembly.v(287)
    Select_1108: entity work.Select_5(INTERFACE)  port map (sel(4)=>n1265,sel(3)=>n1209,
            sel(2)=>n1220,sel(1)=>n1244,sel(0)=>n1245,data(4)=>trigger_type(1),
            data(3)=>sample_count_value_r(1),data(2)=>sample_delay_count_value_r(1),
            data(1)=>trig_latency_count_value_r(1),data(0)=>config_daq2c(1),
            o=>n1294);   -- data_assembly.v(287)
    reduce_or_1109: entity work.reduce_or_5(INTERFACE)  port map (a(4)=>n1198,
            a(3)=>n1204,a(2)=>n1215,a(1)=>n1227,a(0)=>n1239,o=>n1295);   -- data_assembly.v(287)
    Select_1110: entity work.Select_6(INTERFACE)  port map (sel(5)=>n1295,sel(4)=>n1209,
            sel(3)=>n1220,sel(2)=>n1233,sel(1)=>n1244,sel(0)=>n1245,data(5)=>trigger_type(1),
            data(4)=>sample_count_value_r(0),data(3)=>sample_delay_count_value_r(0),
            data(2)=>extrig_en_r,data(1)=>trig_latency_count_value_r(0),data(0)=>config_daq2c(0),
            o=>n1296);   -- data_assembly.v(287)
    n1297 <= config_din_data(15) when n1215='1' else sample_delay_count_value_r(15);   -- data_assembly.v(287)
    n1298 <= config_din_data(14) when n1215='1' else sample_delay_count_value_r(14);   -- data_assembly.v(287)
    n1299 <= config_din_data(13) when n1215='1' else sample_delay_count_value_r(13);   -- data_assembly.v(287)
    n1300 <= config_din_data(12) when n1215='1' else sample_delay_count_value_r(12);   -- data_assembly.v(287)
    n1301 <= config_din_data(11) when n1215='1' else sample_delay_count_value_r(11);   -- data_assembly.v(287)
    n1302 <= config_din_data(10) when n1215='1' else sample_delay_count_value_r(10);   -- data_assembly.v(287)
    n1303 <= config_din_data(9) when n1215='1' else sample_delay_count_value_r(9);   -- data_assembly.v(287)
    n1304 <= config_din_data(8) when n1215='1' else sample_delay_count_value_r(8);   -- data_assembly.v(287)
    n1305 <= config_din_data(7) when n1215='1' else sample_delay_count_value_r(7);   -- data_assembly.v(287)
    n1306 <= config_din_data(6) when n1215='1' else sample_delay_count_value_r(6);   -- data_assembly.v(287)
    n1307 <= config_din_data(5) when n1215='1' else sample_delay_count_value_r(5);   -- data_assembly.v(287)
    n1308 <= config_din_data(4) when n1215='1' else sample_delay_count_value_r(4);   -- data_assembly.v(287)
    n1309 <= config_din_data(3) when n1215='1' else sample_delay_count_value_r(3);   -- data_assembly.v(287)
    n1310 <= config_din_data(2) when n1215='1' else sample_delay_count_value_r(2);   -- data_assembly.v(287)
    n1311 <= config_din_data(1) when n1215='1' else sample_delay_count_value_r(1);   -- data_assembly.v(287)
    n1312 <= config_din_data(0) when n1215='1' else sample_delay_count_value_r(0);   -- data_assembly.v(287)
    n1313 <= config_din_data(0) when n1227='1' else extrig_en_r;   -- data_assembly.v(287)
    n1314 <= trigger_type(1) when n1239='1' else trig_latency_count_value_r(15);   -- data_assembly.v(287)
    n1315 <= trigger_type(1) when n1239='1' else trig_latency_count_value_r(14);   -- data_assembly.v(287)
    n1316 <= trigger_type(1) when n1239='1' else trig_latency_count_value_r(13);   -- data_assembly.v(287)
    n1317 <= trigger_type(1) when n1239='1' else trig_latency_count_value_r(12);   -- data_assembly.v(287)
    n1318 <= trigger_type(1) when n1239='1' else trig_latency_count_value_r(11);   -- data_assembly.v(287)
    n1319 <= trigger_type(1) when n1239='1' else trig_latency_count_value_r(10);   -- data_assembly.v(287)
    n1320 <= config_din_data(9) when n1239='1' else trig_latency_count_value_r(9);   -- data_assembly.v(287)
    n1321 <= config_din_data(8) when n1239='1' else trig_latency_count_value_r(8);   -- data_assembly.v(287)
    n1322 <= config_din_data(7) when n1239='1' else trig_latency_count_value_r(7);   -- data_assembly.v(287)
    n1323 <= config_din_data(6) when n1239='1' else trig_latency_count_value_r(6);   -- data_assembly.v(287)
    n1324 <= config_din_data(5) when n1239='1' else trig_latency_count_value_r(5);   -- data_assembly.v(287)
    n1325 <= config_din_data(4) when n1239='1' else trig_latency_count_value_r(4);   -- data_assembly.v(287)
    n1326 <= config_din_data(3) when n1239='1' else trig_latency_count_value_r(3);   -- data_assembly.v(287)
    n1327 <= config_din_data(2) when n1239='1' else trig_latency_count_value_r(2);   -- data_assembly.v(287)
    n1328 <= config_din_data(1) when n1239='1' else trig_latency_count_value_r(1);   -- data_assembly.v(287)
    n1329 <= config_din_data(0) when n1239='1' else trig_latency_count_value_r(0);   -- data_assembly.v(287)
    n1330 <= not n1245;   -- data_assembly.v(287)
    n1331 <= n1330 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1332 <= n1246 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1333 <= n1248 when config_din_valid='1' else sample_start;   -- data_assembly.v(285)
    n1334 <= n1249 when config_din_valid='1' else sample_count_value_r(15);   -- data_assembly.v(285)
    n1335 <= n1250 when config_din_valid='1' else sample_count_value_r(14);   -- data_assembly.v(285)
    n1336 <= n1251 when config_din_valid='1' else sample_count_value_r(13);   -- data_assembly.v(285)
    n1337 <= n1252 when config_din_valid='1' else sample_count_value_r(12);   -- data_assembly.v(285)
    n1338 <= n1253 when config_din_valid='1' else sample_count_value_r(11);   -- data_assembly.v(285)
    n1339 <= n1254 when config_din_valid='1' else sample_count_value_r(10);   -- data_assembly.v(285)
    n1340 <= n1255 when config_din_valid='1' else sample_count_value_r(9);   -- data_assembly.v(285)
    n1341 <= n1256 when config_din_valid='1' else sample_count_value_r(8);   -- data_assembly.v(285)
    n1342 <= n1257 when config_din_valid='1' else sample_count_value_r(7);   -- data_assembly.v(285)
    n1343 <= n1258 when config_din_valid='1' else sample_count_value_r(6);   -- data_assembly.v(285)
    n1344 <= n1259 when config_din_valid='1' else sample_count_value_r(5);   -- data_assembly.v(285)
    n1345 <= n1260 when config_din_valid='1' else sample_count_value_r(4);   -- data_assembly.v(285)
    n1346 <= n1261 when config_din_valid='1' else sample_count_value_r(3);   -- data_assembly.v(285)
    n1347 <= n1262 when config_din_valid='1' else sample_count_value_r(2);   -- data_assembly.v(285)
    n1348 <= n1263 when config_din_valid='1' else sample_count_value_r(1);   -- data_assembly.v(285)
    n1349 <= n1264 when config_din_valid='1' else sample_count_value_r(0);   -- data_assembly.v(285)
    n1350 <= n1266 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1351 <= n1268 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1352 <= n1270 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1353 <= n1272 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1354 <= n1274 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1355 <= n1276 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1356 <= n1278 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1357 <= n1280 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1358 <= n1282 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1359 <= n1284 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1360 <= n1286 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1361 <= n1288 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1362 <= n1290 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1363 <= n1292 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1364 <= n1294 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1365 <= n1296 when config_din_valid='1' else trigger_type(1);   -- data_assembly.v(285)
    n1366 <= n1297 when config_din_valid='1' else sample_delay_count_value_r(15);   -- data_assembly.v(285)
    n1367 <= n1298 when config_din_valid='1' else sample_delay_count_value_r(14);   -- data_assembly.v(285)
    n1368 <= n1299 when config_din_valid='1' else sample_delay_count_value_r(13);   -- data_assembly.v(285)
    n1369 <= n1300 when config_din_valid='1' else sample_delay_count_value_r(12);   -- data_assembly.v(285)
    n1370 <= n1301 when config_din_valid='1' else sample_delay_count_value_r(11);   -- data_assembly.v(285)
    n1371 <= n1302 when config_din_valid='1' else sample_delay_count_value_r(10);   -- data_assembly.v(285)
    n1372 <= n1303 when config_din_valid='1' else sample_delay_count_value_r(9);   -- data_assembly.v(285)
    n1373 <= n1304 when config_din_valid='1' else sample_delay_count_value_r(8);   -- data_assembly.v(285)
    n1374 <= n1305 when config_din_valid='1' else sample_delay_count_value_r(7);   -- data_assembly.v(285)
    n1375 <= n1306 when config_din_valid='1' else sample_delay_count_value_r(6);   -- data_assembly.v(285)
    n1376 <= n1307 when config_din_valid='1' else sample_delay_count_value_r(5);   -- data_assembly.v(285)
    n1377 <= n1308 when config_din_valid='1' else sample_delay_count_value_r(4);   -- data_assembly.v(285)
    n1378 <= n1309 when config_din_valid='1' else sample_delay_count_value_r(3);   -- data_assembly.v(285)
    n1379 <= n1310 when config_din_valid='1' else sample_delay_count_value_r(2);   -- data_assembly.v(285)
    n1380 <= n1311 when config_din_valid='1' else sample_delay_count_value_r(1);   -- data_assembly.v(285)
    n1381 <= n1312 when config_din_valid='1' else sample_delay_count_value_r(0);   -- data_assembly.v(285)
    n1382 <= n1313 when config_din_valid='1' else extrig_en_r;   -- data_assembly.v(285)
    n1383 <= n1314 when config_din_valid='1' else trig_latency_count_value_r(15);   -- data_assembly.v(285)
    n1384 <= n1315 when config_din_valid='1' else trig_latency_count_value_r(14);   -- data_assembly.v(285)
    n1385 <= n1316 when config_din_valid='1' else trig_latency_count_value_r(13);   -- data_assembly.v(285)
    n1386 <= n1317 when config_din_valid='1' else trig_latency_count_value_r(12);   -- data_assembly.v(285)
    n1387 <= n1318 when config_din_valid='1' else trig_latency_count_value_r(11);   -- data_assembly.v(285)
    n1388 <= n1319 when config_din_valid='1' else trig_latency_count_value_r(10);   -- data_assembly.v(285)
    n1389 <= n1320 when config_din_valid='1' else trig_latency_count_value_r(9);   -- data_assembly.v(285)
    n1390 <= n1321 when config_din_valid='1' else trig_latency_count_value_r(8);   -- data_assembly.v(285)
    n1391 <= n1322 when config_din_valid='1' else trig_latency_count_value_r(7);   -- data_assembly.v(285)
    n1392 <= n1323 when config_din_valid='1' else trig_latency_count_value_r(6);   -- data_assembly.v(285)
    n1393 <= n1324 when config_din_valid='1' else trig_latency_count_value_r(5);   -- data_assembly.v(285)
    n1394 <= n1325 when config_din_valid='1' else trig_latency_count_value_r(4);   -- data_assembly.v(285)
    n1395 <= n1326 when config_din_valid='1' else trig_latency_count_value_r(3);   -- data_assembly.v(285)
    n1396 <= n1327 when config_din_valid='1' else trig_latency_count_value_r(2);   -- data_assembly.v(285)
    n1397 <= n1328 when config_din_valid='1' else trig_latency_count_value_r(1);   -- data_assembly.v(285)
    n1398 <= n1329 when config_din_valid='1' else trig_latency_count_value_r(0);   -- data_assembly.v(285)
    n1399 <= trigger_type(1) when reset_i_dly='1' else n1332;   -- data_assembly.v(271)
    n1400 <= trigger_type(0) when reset_i_dly='1' else n1333;   -- data_assembly.v(271)
    n1401 <= trigger_type(1) when reset_i_dly='1' else n1366;   -- data_assembly.v(271)
    n1402 <= trigger_type(1) when reset_i_dly='1' else n1367;   -- data_assembly.v(271)
    n1403 <= trigger_type(1) when reset_i_dly='1' else n1368;   -- data_assembly.v(271)
    n1404 <= trigger_type(1) when reset_i_dly='1' else n1369;   -- data_assembly.v(271)
    n1405 <= trigger_type(1) when reset_i_dly='1' else n1370;   -- data_assembly.v(271)
    n1406 <= trigger_type(1) when reset_i_dly='1' else n1371;   -- data_assembly.v(271)
    n1407 <= trigger_type(1) when reset_i_dly='1' else n1372;   -- data_assembly.v(271)
    n1408 <= trigger_type(1) when reset_i_dly='1' else n1373;   -- data_assembly.v(271)
    n1409 <= trigger_type(1) when reset_i_dly='1' else n1374;   -- data_assembly.v(271)
    n1410 <= trigger_type(1) when reset_i_dly='1' else n1375;   -- data_assembly.v(271)
    n1411 <= trigger_type(1) when reset_i_dly='1' else n1376;   -- data_assembly.v(271)
    n1412 <= trigger_type(1) when reset_i_dly='1' else n1377;   -- data_assembly.v(271)
    n1413 <= trigger_type(1) when reset_i_dly='1' else n1378;   -- data_assembly.v(271)
    n1414 <= trigger_type(1) when reset_i_dly='1' else n1379;   -- data_assembly.v(271)
    n1415 <= trigger_type(1) when reset_i_dly='1' else n1380;   -- data_assembly.v(271)
    n1416 <= trigger_type(1) when reset_i_dly='1' else n1381;   -- data_assembly.v(271)
    n1417 <= trigger_type(1) when reset_i_dly='1' else n1334;   -- data_assembly.v(271)
    n1418 <= trigger_type(1) when reset_i_dly='1' else n1335;   -- data_assembly.v(271)
    n1419 <= trigger_type(1) when reset_i_dly='1' else n1336;   -- data_assembly.v(271)
    n1420 <= trigger_type(1) when reset_i_dly='1' else n1337;   -- data_assembly.v(271)
    n1421 <= trigger_type(1) when reset_i_dly='1' else n1338;   -- data_assembly.v(271)
    n1422 <= trigger_type(1) when reset_i_dly='1' else n1339;   -- data_assembly.v(271)
    n1423 <= trigger_type(1) when reset_i_dly='1' else n1340;   -- data_assembly.v(271)
    n1424 <= trigger_type(1) when reset_i_dly='1' else n1341;   -- data_assembly.v(271)
    n1425 <= trigger_type(0) when reset_i_dly='1' else n1342;   -- data_assembly.v(271)
    n1426 <= trigger_type(1) when reset_i_dly='1' else n1343;   -- data_assembly.v(271)
    n1427 <= trigger_type(1) when reset_i_dly='1' else n1344;   -- data_assembly.v(271)
    n1428 <= trigger_type(1) when reset_i_dly='1' else n1345;   -- data_assembly.v(271)
    n1429 <= trigger_type(1) when reset_i_dly='1' else n1346;   -- data_assembly.v(271)
    n1430 <= trigger_type(1) when reset_i_dly='1' else n1347;   -- data_assembly.v(271)
    n1431 <= trigger_type(1) when reset_i_dly='1' else n1348;   -- data_assembly.v(271)
    n1432 <= trigger_type(1) when reset_i_dly='1' else n1349;   -- data_assembly.v(271)
    n1433 <= trigger_type(1) when reset_i_dly='1' else n1383;   -- data_assembly.v(271)
    n1434 <= trigger_type(1) when reset_i_dly='1' else n1384;   -- data_assembly.v(271)
    n1435 <= trigger_type(1) when reset_i_dly='1' else n1385;   -- data_assembly.v(271)
    n1436 <= trigger_type(1) when reset_i_dly='1' else n1386;   -- data_assembly.v(271)
    n1437 <= trigger_type(1) when reset_i_dly='1' else n1387;   -- data_assembly.v(271)
    n1438 <= trigger_type(1) when reset_i_dly='1' else n1388;   -- data_assembly.v(271)
    n1439 <= trigger_type(1) when reset_i_dly='1' else n1389;   -- data_assembly.v(271)
    n1440 <= trigger_type(1) when reset_i_dly='1' else n1390;   -- data_assembly.v(271)
    n1441 <= trigger_type(1) when reset_i_dly='1' else n1391;   -- data_assembly.v(271)
    n1442 <= trigger_type(1) when reset_i_dly='1' else n1392;   -- data_assembly.v(271)
    n1443 <= trigger_type(1) when reset_i_dly='1' else n1393;   -- data_assembly.v(271)
    n1444 <= trigger_type(0) when reset_i_dly='1' else n1394;   -- data_assembly.v(271)
    n1445 <= trigger_type(1) when reset_i_dly='1' else n1395;   -- data_assembly.v(271)
    n1446 <= trigger_type(1) when reset_i_dly='1' else n1396;   -- data_assembly.v(271)
    n1447 <= trigger_type(1) when reset_i_dly='1' else n1397;   -- data_assembly.v(271)
    n1448 <= trigger_type(1) when reset_i_dly='1' else n1398;   -- data_assembly.v(271)
    n1449 <= trigger_type(0) when reset_i_dly='1' else n1382;   -- data_assembly.v(271)
    n1450 <= trigger_type(1) when reset_i_dly='1' else n1350;   -- data_assembly.v(271)
    n1451 <= trigger_type(1) when reset_i_dly='1' else n1351;   -- data_assembly.v(271)
    n1452 <= trigger_type(1) when reset_i_dly='1' else n1352;   -- data_assembly.v(271)
    n1453 <= trigger_type(1) when reset_i_dly='1' else n1353;   -- data_assembly.v(271)
    n1454 <= trigger_type(1) when reset_i_dly='1' else n1354;   -- data_assembly.v(271)
    n1455 <= trigger_type(1) when reset_i_dly='1' else n1355;   -- data_assembly.v(271)
    n1456 <= trigger_type(1) when reset_i_dly='1' else n1356;   -- data_assembly.v(271)
    n1457 <= trigger_type(1) when reset_i_dly='1' else n1357;   -- data_assembly.v(271)
    n1458 <= trigger_type(1) when reset_i_dly='1' else n1358;   -- data_assembly.v(271)
    n1459 <= trigger_type(1) when reset_i_dly='1' else n1359;   -- data_assembly.v(271)
    n1460 <= trigger_type(1) when reset_i_dly='1' else n1360;   -- data_assembly.v(271)
    n1461 <= trigger_type(1) when reset_i_dly='1' else n1361;   -- data_assembly.v(271)
    n1462 <= trigger_type(1) when reset_i_dly='1' else n1362;   -- data_assembly.v(271)
    n1463 <= trigger_type(1) when reset_i_dly='1' else n1363;   -- data_assembly.v(271)
    n1464 <= trigger_type(1) when reset_i_dly='1' else n1364;   -- data_assembly.v(271)
    n1465 <= trigger_type(1) when reset_i_dly='1' else n1365;   -- data_assembly.v(271)
    n1466 <= trigger_type(1) when reset_i_dly='1' else n1331;   -- data_assembly.v(271)
    i1283: VERIFIC_DFFRS (d=>n1400,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_start);   -- data_assembly.v(270)
    i1284: VERIFIC_DFFRS (d=>n1401,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(15));   -- data_assembly.v(270)
    i1285: VERIFIC_DFFRS (d=>n1402,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(14));   -- data_assembly.v(270)
    i1286: VERIFIC_DFFRS (d=>n1403,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(13));   -- data_assembly.v(270)
    i1287: VERIFIC_DFFRS (d=>n1404,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(12));   -- data_assembly.v(270)
    i1288: VERIFIC_DFFRS (d=>n1405,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(11));   -- data_assembly.v(270)
    i1289: VERIFIC_DFFRS (d=>n1406,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(10));   -- data_assembly.v(270)
    i1290: VERIFIC_DFFRS (d=>n1407,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(9));   -- data_assembly.v(270)
    i1291: VERIFIC_DFFRS (d=>n1408,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(8));   -- data_assembly.v(270)
    i1292: VERIFIC_DFFRS (d=>n1409,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(7));   -- data_assembly.v(270)
    i1293: VERIFIC_DFFRS (d=>n1410,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(6));   -- data_assembly.v(270)
    i1294: VERIFIC_DFFRS (d=>n1411,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(5));   -- data_assembly.v(270)
    i1295: VERIFIC_DFFRS (d=>n1412,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(4));   -- data_assembly.v(270)
    i1296: VERIFIC_DFFRS (d=>n1413,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(3));   -- data_assembly.v(270)
    i1297: VERIFIC_DFFRS (d=>n1414,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(2));   -- data_assembly.v(270)
    i1298: VERIFIC_DFFRS (d=>n1415,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(1));   -- data_assembly.v(270)
    i1299: VERIFIC_DFFRS (d=>n1416,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_delay_count_value_r(0));   -- data_assembly.v(270)
    i1300: VERIFIC_DFFRS (d=>n1417,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(15));   -- data_assembly.v(270)
    i1301: VERIFIC_DFFRS (d=>n1418,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(14));   -- data_assembly.v(270)
    i1302: VERIFIC_DFFRS (d=>n1419,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(13));   -- data_assembly.v(270)
    i1303: VERIFIC_DFFRS (d=>n1420,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(12));   -- data_assembly.v(270)
    i1304: VERIFIC_DFFRS (d=>n1421,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(11));   -- data_assembly.v(270)
    i1305: VERIFIC_DFFRS (d=>n1422,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(10));   -- data_assembly.v(270)
    i1306: VERIFIC_DFFRS (d=>n1423,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(9));   -- data_assembly.v(270)
    i1307: VERIFIC_DFFRS (d=>n1424,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(8));   -- data_assembly.v(270)
    i1308: VERIFIC_DFFRS (d=>n1425,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(7));   -- data_assembly.v(270)
    i1309: VERIFIC_DFFRS (d=>n1426,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(6));   -- data_assembly.v(270)
    i1310: VERIFIC_DFFRS (d=>n1427,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(5));   -- data_assembly.v(270)
    i1311: VERIFIC_DFFRS (d=>n1428,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(4));   -- data_assembly.v(270)
    i1312: VERIFIC_DFFRS (d=>n1429,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(3));   -- data_assembly.v(270)
    i1313: VERIFIC_DFFRS (d=>n1430,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(2));   -- data_assembly.v(270)
    i1314: VERIFIC_DFFRS (d=>n1431,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(1));   -- data_assembly.v(270)
    i1315: VERIFIC_DFFRS (d=>n1432,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>sample_count_value_r(0));   -- data_assembly.v(270)
    i1316: VERIFIC_DFFRS (d=>n1433,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(15));   -- data_assembly.v(270)
    i1317: VERIFIC_DFFRS (d=>n1434,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(14));   -- data_assembly.v(270)
    i1318: VERIFIC_DFFRS (d=>n1435,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(13));   -- data_assembly.v(270)
    i1319: VERIFIC_DFFRS (d=>n1436,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(12));   -- data_assembly.v(270)
    i1320: VERIFIC_DFFRS (d=>n1437,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(11));   -- data_assembly.v(270)
    i1321: VERIFIC_DFFRS (d=>n1438,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(10));   -- data_assembly.v(270)
    i1322: VERIFIC_DFFRS (d=>n1439,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(9));   -- data_assembly.v(270)
    i1323: VERIFIC_DFFRS (d=>n1440,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(8));   -- data_assembly.v(270)
    i1324: VERIFIC_DFFRS (d=>n1441,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(7));   -- data_assembly.v(270)
    i1325: VERIFIC_DFFRS (d=>n1442,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(6));   -- data_assembly.v(270)
    i1326: VERIFIC_DFFRS (d=>n1443,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(5));   -- data_assembly.v(270)
    i1327: VERIFIC_DFFRS (d=>n1444,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(4));   -- data_assembly.v(270)
    i1328: VERIFIC_DFFRS (d=>n1445,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(3));   -- data_assembly.v(270)
    i1329: VERIFIC_DFFRS (d=>n1446,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(2));   -- data_assembly.v(270)
    i1330: VERIFIC_DFFRS (d=>n1447,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(1));   -- data_assembly.v(270)
    i1331: VERIFIC_DFFRS (d=>n1448,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>trig_latency_count_value_r(0));   -- data_assembly.v(270)
    i1332: VERIFIC_DFFRS (d=>n1449,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>extrig_en_r);   -- data_assembly.v(270)
    i1333: VERIFIC_DFFRS (d=>n1450,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(15));   -- data_assembly.v(270)
    i1334: VERIFIC_DFFRS (d=>n1451,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(14));   -- data_assembly.v(270)
    i1335: VERIFIC_DFFRS (d=>n1452,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(13));   -- data_assembly.v(270)
    i1336: VERIFIC_DFFRS (d=>n1453,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(12));   -- data_assembly.v(270)
    i1337: VERIFIC_DFFRS (d=>n1454,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(11));   -- data_assembly.v(270)
    i1338: VERIFIC_DFFRS (d=>n1455,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(10));   -- data_assembly.v(270)
    i1339: VERIFIC_DFFRS (d=>n1456,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(9));   -- data_assembly.v(270)
    i1340: VERIFIC_DFFRS (d=>n1457,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(8));   -- data_assembly.v(270)
    i1341: VERIFIC_DFFRS (d=>n1458,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(7));   -- data_assembly.v(270)
    i1342: VERIFIC_DFFRS (d=>n1459,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(6));   -- data_assembly.v(270)
    i1343: VERIFIC_DFFRS (d=>n1460,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(5));   -- data_assembly.v(270)
    i1344: VERIFIC_DFFRS (d=>n1461,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(4));   -- data_assembly.v(270)
    i1345: VERIFIC_DFFRS (d=>n1462,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(3));   -- data_assembly.v(270)
    i1346: VERIFIC_DFFRS (d=>n1463,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(2));   -- data_assembly.v(270)
    i1347: VERIFIC_DFFRS (d=>n1464,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(1));   -- data_assembly.v(270)
    i1348: VERIFIC_DFFRS (d=>n1465,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_daq2c(0));   -- data_assembly.v(270)
    i1349: VERIFIC_DFFRS (d=>n1466,clk=>init_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>config_dout_valid_c);   -- data_assembly.v(270)
    LessThan_1349: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>adc_raw_data_c(15),a(14)=>adc_raw_data_c(14),a(13)=>adc_raw_data_c(13),
            a(12)=>adc_raw_data_c(12),a(11)=>adc_raw_data_c(11),a(10)=>adc_raw_data_c(10),
            a(9)=>adc_raw_data_c(9),a(8)=>adc_raw_data_c(8),a(7)=>adc_raw_data_c(7),
            a(6)=>adc_raw_data_c(6),a(5)=>adc_raw_data_c(5),a(4)=>adc_raw_data_c(4),
            a(3)=>adc_raw_data_c(3),a(2)=>adc_raw_data_c(2),a(1)=>adc_raw_data_c(1),
            a(0)=>adc_raw_data_c(0),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(0),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(1),o=>n1535);   -- data_assembly.v(353)
    LessThan_1350: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>adc_raw_data_c(31),a(14)=>adc_raw_data_c(30),a(13)=>adc_raw_data_c(29),
            a(12)=>adc_raw_data_c(28),a(11)=>adc_raw_data_c(27),a(10)=>adc_raw_data_c(26),
            a(9)=>adc_raw_data_c(25),a(8)=>adc_raw_data_c(24),a(7)=>adc_raw_data_c(23),
            a(6)=>adc_raw_data_c(22),a(5)=>adc_raw_data_c(21),a(4)=>adc_raw_data_c(20),
            a(3)=>adc_raw_data_c(19),a(2)=>adc_raw_data_c(18),a(1)=>adc_raw_data_c(17),
            a(0)=>adc_raw_data_c(16),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(0),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(1),o=>n1536);   -- data_assembly.v(353)
    n1537 <= n1535 or n1536;   -- data_assembly.v(353)
    LessThan_1352: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>adc_raw_data_c(47),a(14)=>adc_raw_data_c(46),a(13)=>adc_raw_data_c(45),
            a(12)=>adc_raw_data_c(44),a(11)=>adc_raw_data_c(43),a(10)=>adc_raw_data_c(42),
            a(9)=>adc_raw_data_c(41),a(8)=>adc_raw_data_c(40),a(7)=>adc_raw_data_c(39),
            a(6)=>adc_raw_data_c(38),a(5)=>adc_raw_data_c(37),a(4)=>adc_raw_data_c(36),
            a(3)=>adc_raw_data_c(35),a(2)=>adc_raw_data_c(34),a(1)=>adc_raw_data_c(33),
            a(0)=>adc_raw_data_c(32),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(0),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(1),o=>n1538);   -- data_assembly.v(353)
    n1539 <= n1537 or n1538;   -- data_assembly.v(353)
    LessThan_1354: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>adc_raw_data_c(63),a(14)=>adc_raw_data_c(62),a(13)=>adc_raw_data_c(61),
            a(12)=>adc_raw_data_c(60),a(11)=>adc_raw_data_c(59),a(10)=>adc_raw_data_c(58),
            a(9)=>adc_raw_data_c(57),a(8)=>adc_raw_data_c(56),a(7)=>adc_raw_data_c(55),
            a(6)=>adc_raw_data_c(54),a(5)=>adc_raw_data_c(53),a(4)=>adc_raw_data_c(52),
            a(3)=>adc_raw_data_c(51),a(2)=>adc_raw_data_c(50),a(1)=>adc_raw_data_c(49),
            a(0)=>adc_raw_data_c(48),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(0),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(1),o=>n1540);   -- data_assembly.v(353)
    n1541 <= n1539 or n1540;   -- data_assembly.v(353)
    LessThan_1356: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>adc_raw_data_c(79),a(14)=>adc_raw_data_c(78),a(13)=>adc_raw_data_c(77),
            a(12)=>adc_raw_data_c(76),a(11)=>adc_raw_data_c(75),a(10)=>adc_raw_data_c(74),
            a(9)=>adc_raw_data_c(73),a(8)=>adc_raw_data_c(72),a(7)=>adc_raw_data_c(71),
            a(6)=>adc_raw_data_c(70),a(5)=>adc_raw_data_c(69),a(4)=>adc_raw_data_c(68),
            a(3)=>adc_raw_data_c(67),a(2)=>adc_raw_data_c(66),a(1)=>adc_raw_data_c(65),
            a(0)=>adc_raw_data_c(64),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(0),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(1),o=>n1542);   -- data_assembly.v(354)
    n1543 <= n1541 or n1542;   -- data_assembly.v(353)
    LessThan_1358: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>adc_raw_data_c(95),a(14)=>adc_raw_data_c(94),a(13)=>adc_raw_data_c(93),
            a(12)=>adc_raw_data_c(92),a(11)=>adc_raw_data_c(91),a(10)=>adc_raw_data_c(90),
            a(9)=>adc_raw_data_c(89),a(8)=>adc_raw_data_c(88),a(7)=>adc_raw_data_c(87),
            a(6)=>adc_raw_data_c(86),a(5)=>adc_raw_data_c(85),a(4)=>adc_raw_data_c(84),
            a(3)=>adc_raw_data_c(83),a(2)=>adc_raw_data_c(82),a(1)=>adc_raw_data_c(81),
            a(0)=>adc_raw_data_c(80),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(0),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(1),o=>n1544);   -- data_assembly.v(354)
    n1545 <= n1543 or n1544;   -- data_assembly.v(353)
    LessThan_1360: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>adc_raw_data_c(111),a(14)=>adc_raw_data_c(110),a(13)=>adc_raw_data_c(109),
            a(12)=>adc_raw_data_c(108),a(11)=>adc_raw_data_c(107),a(10)=>adc_raw_data_c(106),
            a(9)=>adc_raw_data_c(105),a(8)=>adc_raw_data_c(104),a(7)=>adc_raw_data_c(103),
            a(6)=>adc_raw_data_c(102),a(5)=>adc_raw_data_c(101),a(4)=>adc_raw_data_c(100),
            a(3)=>adc_raw_data_c(99),a(2)=>adc_raw_data_c(98),a(1)=>adc_raw_data_c(97),
            a(0)=>adc_raw_data_c(96),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(0),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(1),o=>n1546);   -- data_assembly.v(354)
    n1547 <= n1545 or n1546;   -- data_assembly.v(353)
    LessThan_1362: entity work.LessThan_16u_16u(INTERFACE)  port map (cin=>trigger_type(1),
            a(15)=>adc_raw_data_c(127),a(14)=>adc_raw_data_c(126),a(13)=>adc_raw_data_c(125),
            a(12)=>adc_raw_data_c(124),a(11)=>adc_raw_data_c(123),a(10)=>adc_raw_data_c(122),
            a(9)=>adc_raw_data_c(121),a(8)=>adc_raw_data_c(120),a(7)=>adc_raw_data_c(119),
            a(6)=>adc_raw_data_c(118),a(5)=>adc_raw_data_c(117),a(4)=>adc_raw_data_c(116),
            a(3)=>adc_raw_data_c(115),a(2)=>adc_raw_data_c(114),a(1)=>adc_raw_data_c(113),
            a(0)=>adc_raw_data_c(112),b(15)=>trigger_type(1),b(14)=>trigger_type(1),
            b(13)=>trigger_type(1),b(12)=>trigger_type(0),b(11)=>trigger_type(0),
            b(10)=>trigger_type(1),b(9)=>trigger_type(1),b(8)=>trigger_type(0),
            b(7)=>trigger_type(1),b(6)=>trigger_type(1),b(5)=>trigger_type(1),
            b(4)=>trigger_type(1),b(3)=>trigger_type(1),b(2)=>trigger_type(1),
            b(1)=>trigger_type(1),b(0)=>trigger_type(1),o=>n1548);   -- data_assembly.v(354)
    trig_out <= n1547 or n1548;   -- data_assembly.v(353)
    i28: VERIFIC_DFFRS (d=>n28,clk=>adc_user_clk_c,s=>trigger_type(1),r=>trigger_type(1),
            q=>reset_r(9));   -- data_assembly.v(59)
    
end architecture \.\;   -- data_assembly.v(21)

