	.globl	change
	.type	change, @function
counter:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	pushq	%r15				#*s
	pushq	%r14				#len
	pushq	%r13				#*a
	pushq	%r12				#*A
	pushq	%rbx				#int i
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, %r15			#*s
	movq	%rsi, %r14			#len
	movq	%rdx, %r13			#*a
	movq	%rcx, %r12			#*A
	movq	$0, %rbx			#int i = 0
	jmp	.L7
.L10:
	movq	%rbx, %rax
	movslq	%eax, %rdx
	movq	%r15, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$64, %al
	jle	.L8
	movq	%rbx, %rax
	movslq	%eax, %rdx
	movq	%r15, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$90, %al
	jg	.L8
	movq	%r12, %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	%r12, %rax
	movl	%edx, (%rax)
	jmp	.L9
.L8:
	movq	%rbx, %rax
	movslq	%eax, %rdx
	movq	%r15, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$96, %al
	jle	.L9
	movq	%rbx, %rax
	movslq	%eax, %rdx
	movq	%r15, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$122, %al
	jg	.L9
	movq	%r13, %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	%r13, %rax
	movl	%edx, (%rax)
.L9:
	addq	$1, %rbx
.L7:
	movq	%rbx, %rax
	cmpq	%r14, %rax
	jl	.L10
	nop					#void function
	movq	%rbp, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
	leaq	-28(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	get_string
	movq	%rax, -16(%rbp)			#*s
	movl	-28(%rbp), %eax
	testl	%eax, %eax
	jne	.L12
	movl	-32(%rbp), %esi
	leaq	-20(%rbp), %rcx
	leaq	-24(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	counter
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	jmp	.L14
.L12:
	leaq	.LC1(%rip), %rdi
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
