;
; 
;
;

ldr r0,=Textfile
mov r1,#0
swi 0x66 ; open file
bcs Exit

ldr r1,=MyFileHandle
str r0,[r1]

ldr r4,=MyFileHandle

ldr r0,[r4] ;recall file handle from memory
ldr r1,=MyString ;set r1 to the location in memory where string will be copied
mov r2,#100 ;set number of chars to be read in operation
swi 0x6a ;read string
bcs Exit

; Close Input File
ldr r0,=MyFileHandle
ldr r0,[r0]
swi 0x68

ldr r1,=MyString
Loop0:
ldrb r6,[r1] ; load first character from MyString into r3

; Check and Replace Vowels
; 'a' -> 'A'
CMP r6,#0x61
movEQ r6,#0x41
; 'e' -> 'E'
CMP r6,#0x65
movEQ r6,#0x45
; 'i' -> 'I'
CMP r6,#0x69
movEQ r6,#0x49
; 'o' -> 'O'
CMP r6,#0x6f
movEQ r6,#0x4f
; 'u' -> 'U'
CMP r6,#0x75
movEQ r6,#0x55

; Check and Replace Puncuation
CMP r6,#0x19 ; 'EM' -> '*'
movEQ r6,#0x2a
CMP r6,#0x21 ; '!' -> '*'
movEQ r6,#0x2a
CMP r6,#0x22 ; '"' -> '*'
movEQ r6,#0x2a
CMP r6,#0x23 ; '#' -> '*'
movEQ r6,#0x2a
CMP r6,#0x24 ; '$' -> '*'
movEQ r6,#0x2a
CMP r6,#0x25 ; '%' -> '*'
movEQ r6,#0x2a
CMP r6,#0x26 ; '&' -> '*'
movEQ r6,#0x2a
CMP r6,#0x27 ; ''' -> '*'
movEQ r6,#0x2a
CMP r6,#0x28 ; '(' -> '*'
movEQ r6,#0x2a
CMP r6,#0x29 ; ')' -> '*'
movEQ r6,#0x2a
CMP r6,#0x2B ; '+' -> '*'
movEQ r6,#0x2a
CMP r6,#0x2C ; ',' -> '*'
movEQ r6,#0x2a
CMP r6,#0x2D ; '-' -> '*'
movEQ r6,#0x2a
CMP r6,#0x2E ; '.' -> '*'
movEQ r6,#0x2a
CMP r6,#0x2F ; '/' -> '*'
movEQ r6,#0x2a
CMP r6,#0x3A ; ':' -> '*'
movEQ r6,#0x2a
CMP r6,#0x3B ; ';' -> '*'
movEQ r6,#0x2a
CMP r6,#0x3C ; '<' -> '*'
movEQ r6,#0x2a
CMP r6,#0x3D ; '=' -> '*'
movEQ r6,#0x2a
CMP r6,#0x3E ; '>' -> '*'
movEQ r6,#0x2a
CMP r6,#0x3F ; '?' -> '*'
movEQ r6,#0x2a
CMP r6,#0x40 ; '@' -> '*'
movEQ r6,#0x2a
CMP r6,#0x5B ; '[' -> '*'
movEQ r6,#0x2a
CMP r6,#0x5C ; '\' -> '*'
movEQ r6,#0x2a
CMP r6,#0x5D ; ']' -> '*'
movEQ r6,#0x2a
CMP r6,#0x5E ; '^' -> '*'
movEQ r6,#0x2a
CMP r6,#0x5F ; '_' -> '*'
movEQ r6,#0x2a
CMP r6,#0x60 ; '`' -> '*'
movEQ r6,#0x2a
CMP r6,#0x7B ; '{' -> '*'
movEQ r6,#0x2a
CMP r6,#0x7C ; '|' -> '*'
movEQ r6,#0x2a
CMP r6,#0x7D ; '}' -> '*'
movEQ r6,#0x2a
CMP r6,#0x7E ; '~' -> '*'
movEQ r6,#0x2a

strb r6,[r1]


add r1,r1,#1 ; move to next memory address location

CMP r6,#0x00 ; compare char read to NULL
bEQ Output   ; if NULL break out of loop
b Loop0


Output:
; STDOUT: Print String
;mov r0,#1 ;set file handle to stdout
;ldr r1,=MyString
;swi 0x69

; Open file for output
swi 0x68 ; close 'input.txt' file
ldr r0,=OutFileName   ; set Name for output file
mov r1,#1             ; mode is output
swi 0x66              ; open file for output
bcs OutFileError      ; if error ?
ldr r1,=OutFileHandle ; load output file handle
str r0,[r1]

; Print String to 'output.txt'
ldr r0,=OutFileHandle ; load the output file handle
ldr r0,[r0]           ; R0 = file handle
ldr r1,=MyString      ; R1 = address of string
swi 0x69              ; output string to file


Exit:
swi 0x68
swi 0x11

OutFileError:
mov R0,#1
ldr R1,=exitStr
swi 0x69
mov R0,R4
swi 0x68
swi 0x11

MyFileHandle: .skip 4 ; file handle is an integer
MyInteger: .skip 4
Textfile: .asciz "input.txt"

OutFileName: .asciz "output.txt"
OutFileHandle:.word 0

MyString: .skip 100 ; allocate room for 100 characters
MyNewString: .skip 100 ; edite string

exitStr: .asciz "File Failed to Open!!! ***Exiting Now***"