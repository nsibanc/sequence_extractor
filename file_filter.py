import sys, getopt
import os.path

def main(argv):
    seq_filename=''
    filter_filename=''
    out_filename=''

    try:
        opts, args = getopt.getopt(argv,"hi:o:",["base_file=","filter_file=","output_file="])
    except getopt.GetoptError:
        print ('file_filter.py -i <base file> -i <filter file> -o <output file>')
        sys.exit(2)

    if(len(opts)!=3):
        print ('file_filter.py -i <base file> -i <filter file> -o <output file>')
        sys.exit(1)

    cnt=0;
    for opt, arg in opts:
        if opt == '-h':
            print ('file_filter.py -i <base file> -i <filter file> -o <output file>')
            sys.exit(1)
        elif opt in ("-i", "--base_file") and cnt == 0:
            cnt=1
            seq_filename=arg
        elif opt in ("-i", "--filter_file"):
            filter_filename=arg
        elif opt in ("-o", "--output_file"):
            out_filename = arg

    sequence_file = open(seq_filename,"r")
    names_file = open(filter_filename,"r")
    if os.path.isfile(out_filename):
        print ('output file already exists')
        sys.exit(1)
    out_file = open(out_filename,"a")

    write_cnt = 0
    filter_cnt = 0
    for name_line in names_file:
        filter_cnt+=1
        sequence_file.seek(0)
        for num, seq_line in enumerate(sequence_file,1):
            if num%2==1:
                trimed_name_line = name_line.replace('"','')
                trimed_seq_line = seq_line[1:]
                if trimed_name_line == trimed_seq_line:
                    sequence = next(sequence_file);
                    out_file.write(seq_line)
                    out_file.write(sequence)
                    write_cnt+=2

    print('SUCESS :)')
    print('%s lines in filter' % (filter_cnt))
    print('%s lines in output' % (write_cnt))



if __name__=="__main__":
    main(sys.argv[1:])
