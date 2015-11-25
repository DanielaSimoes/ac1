	.eqv STR_MAX_SIZE, 10	
	.data
buf:    .space 11
str:    .asciiz "String too long. Nothing done!"
	.text
	.globl main
main:
#	Parametros de entrada: int argc, char *argv[]
	li $t9, 1
	move $s0, $a0
	move $s1, $a1
	beq $s0, $t9, if2
	
if2:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	lw $a2, ($a1)
	move $a0, $a2
	jal strlen
	
	bgt $v0, STR_MAX_SIZE, else
	
	la $a0, buf
	
	lw $a2, ($a1)
	move $a1, $a2
	
	jal strcpy
	move $a0, $v0
	li $v0, 4
	syscall
	
	j endif

else:
	li $v0, 4
	la $a0, str
	syscall
	
	#return 1
	move $v0, $t9
	j end
	
endif:
	move $v0, $0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
end:
	#return 0
	jr $ra
	
strcpy:
#	Parametros de entrada: *dst, *src
# 	Retorno: *dst

	# t0 => src
	move $t0, $a1
	#t1 => dst
	move $t1, $a0
	
	# i => t2
	li $t2, 0
	
do:
	add $t4, $t2, $t0 #src[i]
	add $t5, $t2, $t1 #dst[i]
	
	lb $t6, 0($t4)
	sb $t6, 0($t5)
	  
	lb $t8, 0($t4)
	beqz $t8, stopwhile
	addi $t2, $t2, 1 # i++
	
	j do
	
stopwhile:
	move $v0, $t1 #valor de retorno
	jr $ra
	
strlen:
	li $v0, 0
	li $t0, 0
	
loop:
	lb $t0, 0($a0)

	addiu $a0, $a0, 1
	beqz $t0, endLoop
	#len++
	addiu $v0, $v0, 1
	j loop
	
endLoop:
	jr $ra
	