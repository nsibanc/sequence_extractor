import sys
import mmap

sequence_file = open(sys.argv[1],"r")
names_file = open(sys.argv[2],"r")

out_file = open(sys.argv[3],"a")

for name_line in names_file:
    sequence_file.seek(0)
    for num, seq_line in enumerate(sequence_file,1):
        if num%2==1:
            trimed_name_line = name_line.replace('"','')
            trimed_seq_line = seq_line[1:]
            if trimed_name_line == trimed_seq_line:
                sequence = next(sequence_file);
                out_file.write(seq_line)
                out_file.write(sequence)
                print('found %s at %s next %s' % (trimed_name_line, num, sequence))
