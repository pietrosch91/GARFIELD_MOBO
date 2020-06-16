import re
from tempfile import mkstemp
from os import fdopen, remove
from shutil import move
import argparse

string_to_look = "setup_trg.py"

parser = argparse.ArgumentParser()
parser.add_argument('-a', action='store', dest='auto_vec',
                    help='write gcu number that you want to set in autotriger, separeted by a comma')
results = parser.parse_args()

numbers = results.auto_vec

num_to_look=numbers.split(",")

fh, abs_path = mkstemp();
with fdopen(fh, 'w') as new_file:
    with open('setup_channels.sh') as old_file:
        for line in old_file:
            if all(x in line for x in string_to_look):
                if any(x in line for x in num_to_look):
                    replace = re.sub("-e ", "", line)
                    new_file.write(replace)
                else:
                    new_file.write(line)
            else:
                new_file.write(line)

remove("setup_channels.sh")
move(abs_path, "setup_channels.sh")
