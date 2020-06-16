python setup_channel.py -c traces_for_agnese/gcu_1_ch0.ini -a
python setup_channel.py -c traces_for_agnese/gcu_1_ch1.ini -a
python setup_channel.py -c traces_for_agnese/gcu_2_ch0.ini -a
python setup_channel.py -c traces_for_agnese/gcu_2_ch1.ini -a
python setup_channel.py -c traces_for_agnese/gcu_2_ch2.ini -a
python setup_channel.py -c traces_for_agnese/gcu_3_ch0.ini -a
python setup_channel.py -c traces_for_agnese/gcu_3_ch1.ini -a
python setup_channel.py -c traces_for_agnese/gcu_3_ch2.ini -a

python setup_trg.py -s 1
python setup_trg.py -s 2
python setup_trg.py -s 3
