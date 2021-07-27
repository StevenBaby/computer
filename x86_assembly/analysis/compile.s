	.file	"compile.c"
	.text
	.globl	function
	.type	function, @function
function:
	nop
	ret
	.size	function, .-function
	.globl	main
	.type	main, @function
main:
	call	function
#APP
# 11 "compile.cc" 1
	movl $1, %eax
movl $0, %ebx
int $0x80

# 0 "" 2
#NO_APP
	movl	$0, %eax
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
