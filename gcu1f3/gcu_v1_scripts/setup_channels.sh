python setup_channel.py -c gcu_1_ch0.ini -a
python setup_channel.py -c gcu_1_ch1.ini -a
python setup_channel.py -c gcu_2_ch0.ini -a
python setup_channel.py -c gcu_2_ch1.ini -a
python setup_channel.py -c gcu_2_ch2.ini -a
python setup_channel.py -c gcu_3_ch0.ini -a
python setup_channel.py -c gcu_3_ch1.ini -a
python setup_channel.py -c gcu_3_ch2.ini -a

python setup_trg.py -b -e -s 1
python setup_trg.py -b -e -s 2
python setup_trg.py -b -s 3
