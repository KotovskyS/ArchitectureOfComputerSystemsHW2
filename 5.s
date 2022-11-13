	.file	"5.c"
	.text
	.globl	get_string
	.type	get_string, @function
get_string:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)		#int *length
	movq	%rsi, -32(%rbp)		#int *flag
	movq	-24(%rbp), %rax
	movl	$0, (%rax)		#*length = 0
	movq	-32(%rbp), %rax
	movl	$0, (%rax)		#*flag = 0
	movl	$1, -12(%rbp)
	movl	$1, %edi		#size = 1
	call	malloc@PLT
	movq	%rax, -8(%rbp)		#*s
	call	getchar@PLT
	movb	%al, -13(%rbp)		#c
	jmp	.L2
.L4:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %ecx
	movq	-24(%rbp), %rdx
	movl	%ecx, (%rdx)
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-13(%rbp), %eax
	movb	%al, (%rdx)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -12(%rbp)
	jg	.L3
	sall	-12(%rbp)
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT
	movq	%rax, -8(%rbp)
.L3:
	call	getchar@PLT
	movb	%al, -13(%rbp)
.L2:
	cmpb	$10, -13(%rbp)
	jne	.L4
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-8(%rbp), %rax			#return s
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	get_string, .-get_string
	.globl	counter
	.type	counter, @function
counter:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)			#*s
	movl	%esi, -28(%rbp)			#length
	movq	%rdx, -40(%rbp)			#*a
	movq	%rcx, -48(%rbp)			#*A
	movl	$0, -4(%rbp)
	jmp	.L7
.L10:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$64, %al
	jle	.L8
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$90, %al
	jg	.L8
	movq	-48(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-48(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L9
.L8:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$96, %al
	jle	.L9
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$122, %al
	jg	.L9
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
.L9:
	addl	$1, -4(%rbp)
.L7:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L10
	nop					#void function
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	counter, .-counter
	.section	.rodata
.LC0:
	.string	"lowercase: %d \nuppercase %d\n"
.LC1:
	.string	"incorrect input"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -24(%rbp)			#int a = 0
	movl	$0, -20(%rbp)			#int A = 0
	leaq	-28(%rbp), %rdx			#length to func get_string
	leaq	-32(%rbp), %rax			#flag to func get_string
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	get_string
	movq	%rax, -16(%rbp)			#*s from get_string
	movl	-28(%rbp), %eax
	testl	%eax, %eax
	jne	.L12
	movl	-32(%rbp), %esi			#s to func counter
	leaq	-20(%rbp), %rcx			#length to func counter
	leaq	-24(%rbp), %rdx			#a to func counter
	movq	-16(%rbp), %rax			#A to func counter
	movq	%rax, %rdi
	call	counter
	movl	-20(%rbp), %edx			#a to func printf
	movl	-24(%rbp), %eax			
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi		#string to printf
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	jmp	.L14
.L12:
	leaq	.LC1(%rip), %rdi		#string to printf
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
.L14:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L15
	call	__stack_chk_fail@PLT
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
