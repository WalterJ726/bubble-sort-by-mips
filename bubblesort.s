.data
.align 4
Array: .space 200
# welcome page
LF: .asciiz "\n"
welcome:.asciiz	"
              =======================================
              *                                     *
                    * 输入n个数字，冒泡排序后输出*                              
              *                                     *
              =======================================
			  "
tips: .asciiz "请输入数组元素个数n:"
msg1: .asciiz "请输入数组元素: "
msg2: .asciiz " "
msg3: .asciiz "\n排序后结果: "

.text
.globl main
main:
	# welcome界面
    li $v0, 4
    la $a0, welcome
    syscall 
    # 换行显示
    li $v0, 4
    la $a0, LF         # 输出换行LF
    syscall
	# 输出整数n提示信息
    li $v0, 4
    la $a0, tips
    syscall
    #接收元素个数n
	li $v0, 5
    syscall
	# addi $v0,$zero,-1
    move $s0, $v0
	addi $s0,$s0,-1
	# addi $s0,$zero,6
	addi $t0,$zero,0
# 读入数组
inputArray:
	li $v0,4
	la $a0,msg1 
	syscall
	li $v0,5
	syscall
	add $t1,$t0,$zero
	sll $t1,$t0,2
	add $t3,$v0,$zero
	sw $t3,Array ( $t1 )
	addi $t0,$t0,1
	slt $t1,$s0,$t0
	beq $t1,$zero,inputArray

	la $a0,Array
	addi $a1,$s0,1 #a1=6
# 读入数组后执行冒泡排序	
jal buble_sort

# 把冒泡排序后的结果输出
	li $v0,4
	la $a0,msg3
	syscall
	la $t0,Array
	#s0=5
	add $t1,$zero,$zero

# 输出数组
printArray:
	lw $a0,0($t0) # 将输入信息放到a0 这个寄存器上
	li $v0,1
	syscall
	li $v0,4
	la $a0,msg2
	syscall
	addi $t0,$t0,4
	addi $t1,$t1,1
	slt $t2,$s0,$t1
	beq $t2,$zero,printArray
	li $v0,10
	syscall




# 冒泡排序
buble_sort:
	# a0 = 数组首地址
	# a1 = 数组大小
	add $t0,$zero,$zero #counter1( i )=0
loop1:
	addi $t0,$t0,1 # i++
	bgt $t0,$a1,endloop1 # if t0 > a1, goto endloop1,else goto next line
	add $t1,$a1,$zero # counter2 = size = 数组元素个数
loop2:
	bge $t0,$t1,loop1 # branch to loop1 if  $t0 >= $t1 如果t0>=t1，就去执行loop1
	addi $t1,$t1,-1 # j--
	mul $t4,$t1,4 # t4 + a0=Array[j]
	addi $t3,$t4,-4 # t3 + a0 = Array[j-1]
	add $t7,$t4,$a0 # t7 = Array[j]
	add $t8,$t3,$a0 # t8 = Array[j-1]
	lw $t5,0($t7)
	lw $t6,0($t8)
	bgt $t5,$t6,loop2

	# 交换t5,t6
	sw $t5,0($t8)
	sw $t6,0($t7)
	j loop2

	endloop1:
	jr $ra
