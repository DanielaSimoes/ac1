.text
.globl main

main:   ori $t0,$0,0x12345678
	sll $t2,$t0,1
	srl $t3,$t0,1
	sra $t4,$t0,1