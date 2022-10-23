











Exit:
swi 0x11

.data
InFileName: .asciz "input.txt"
InFileHandle: .skip 100
InFileError: .asciz "Unable to open input file\n"
OutFileName: .asciz "output.txt"
OutFileError: .asciz "Unable to open output file\n"

MyInteger: .skip 4




MyString: .skip 100