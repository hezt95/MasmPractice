.386
data	segment use16
x 		dw -1
y 		dw 0
z 		dw 0
w 		dw 0
q 		dw -2
t 		dd 0;t is a double word type
hz      db 0ah, 0dh,'T=(X-Y*Z+W)/Q > 0! $'
lz      db 0ah, 0dh,'T=(X-Y*Z+W)/Q < 0! $' 
ez      db 0ah, 0dh,'T=(X-Y*Z+W)/Q = 0! $'
errorz   db 0ah, 0dh,'Invalid input Q! $'
data 	ends

stack 	segment use16 stack
	  	db 200 dup(0)
stack 	ends

code 	segment use16
	 	assume ds:data, ss:stack, cs:code;
start:	mov ax, data
		mov ds, ax
		cmp q,0
		jz error1
		mov ax,y ;ax = y
		mov bx,z ;bx = z
		imul ax,bx ;ax = y*z
		mov bx,x ;bx = x
		sub bx,ax ;bx = x-y*z
		mov ax,w ;ax = w
		add ax,bx ;ax = x-y*z+w
		cwd
		mov bx,q
		idiv bx
		mov word ptr t+2,dx
		mov word ptr t,ax
		cmp t,0
		jz equalz;result is 0
		cmp word ptr t,0
		jz judge;shang is 0,don't know yushu
		jg highz
		jl lowz
judge:  cmp q,0
		jg judge1
		jl judge2
judge1: cmp word ptr t+2,0
		jg highz
		jl lowz
judge2: cmp word ptr t+2,0
		jg lowz
		jl highz
highz:	lea dx,hz
		mov ah,9
		int 21h
		mov ah,4ch
		int 21h
lowz:	lea dx,lz
		mov ah,9
		int 21h
		mov ah,4ch
		int 21h
equalz: lea dx,ez
		mov ah,9
		int 21h
		mov ah,4ch
		int 21h
error1:	lea dx,errorz
		mov ah,9
		int 21h
		mov ah,4ch
		int 21h
code	ends
		end start

		

