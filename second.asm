.386
stack segment use16 stack
      db 200 dup(0)
stack ends
data segment use16
buf1 db 0,1,2,3,4,5,6,7,8,9
buf2 db 10 dup(0)
buf3 db 10 dup(0)
buf4 db 10 dup(0)
data ends
code segment use16
     assume cs:code, ds:data, ss:stack
start: mov ax, data
       mov ds, ax
       mov si, 0
       mov di, 0
       mov bx, 0
       mov bp, 0
       mov cx, 10
lopa:  mov al,[si+buf1]
	   mov [di+buf2], al
	   inc al
	   mov [bx+buf3], al
	   add al, 3
	   mov ds:[bp+buf4], al
	   inc si
	   inc di
	   inc bp
	   inc bx
	   dec cx 
	   jnz lopa
	   mov ah, 4ch
	   int 21h
code   ends
       end start
