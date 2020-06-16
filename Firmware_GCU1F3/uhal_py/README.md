* be sure that your current shell is BASH
* exec:
```bash
source ipbus-software/uhal/tests/setup.sh

```
```bash
python enable_adu.py
python gcu_readout.py -c gcu_ch2.ini -t True -p True -s 100
```
