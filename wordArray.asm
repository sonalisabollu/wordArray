         .data
MAXARRAYSIZE = 6
array		.word		20,-5,31,-21,104,-64
largestMsg: 	.asciiz 	"\nThe largest integer is:"
smallestMsg: 	.asciiz 	"\nThe smallest integer is:"

# note that $t0 is to hold the smallest number and that $t1 is to hold the largest number
# so choose different variables than those for whatever else you need to hold onto
# let

		.code
		.globl main
main: 		lui 	$t0,0x7FFF 		# $t0 is to hold the smallest encountered integer
		ori 	$t0,$t0,0xFFFF 		# it is initialized to the most positive integer
		lui 	$t1,0x8000		# $t1 is to hold the largest encountered integer
		ori 	$t1,$t1,0x0000 		# it is initialized to the most negative integer

		# v-- YOUR CODE BEGINS HERE --v
initialize:	la	$t2,array		# load the base address into a register
		li	$t3,MAXARRAYSIZE	# load the maximum index of the array
		beq	$t3,$0,Exit		# if the array size is zero, exit
		
		li	$t4,0			# initialize index to zero
		bge	$t4,$t3,DoExit		# branch to test index against loop limit
top:		sll	$t5,$t4,2		# determine offset = index * dataSize
		add	$t5,$t2,$t5		# EA = BaseAddress + offset
		lw	$t6,($t5)		# load the data from the EA

CheckSmallest:	bge	$t6,$t0,CheckLargest	# compare array's data with the current smallest
		move	$t0,$t6			# if it is smaller, then save it as the smallest
CheckLargest:	ble	$t6,$t1,NextIndex	# compare array's data with the current largest
		move	$t1,$t6			# if it is larger, then save it as the largest
NextIndex:	addi	$t4,$t4,1		# increment index
test:		blt	$t4,$t3,top		# check that current index is less than max
		# ^-- YOUR CODE ENDS HERE --^
						# we're done looping through array
						# print out the results of what number is largest and smallest
DoExit:		la	$a0,largestMsg
		syscall $print_string
		move	$a0,$t1
		syscall	$print_int
		la	$a0,smallestMsg
		syscall	$print_string
		move	$a0,$t0
		syscall	$print_int
Exit:		syscall	$exit