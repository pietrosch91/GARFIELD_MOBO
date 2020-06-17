


cd uhal_py
mkdir tmp
cp $1 tmp/
cd tmp
mv $1 gcu1f3.xml
gen_ipbus_addr_decode gcu1f3.xml
cd ..
cd ..
mv src/user/ipbus_utils/ipbus_decode_gcu1f3.vhd src/user/ipbus_utils/ipbus_decode_gcu1f3.vhd_old
mv uhal_py/tmp/ipbus_decode_gcu1f3.vhd src/user/ipbus_utils/ipbus_decode_gcu1f3.vhd
rm -r uhal_py/tmp/*
cp uhal_py/$1 ../gcu1f3/gcu_v1_scripts/CppTest/bin/gcu1f3.xml
