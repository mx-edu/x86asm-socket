;made for course & instruction set practise, not perfect
xor eax, eax
mov al, 2 ; AF_INET
xor ebx, ebx
mov bl, 6 ; SOCK_STREAM
xor ecx, ecx
mov cx, 0x0501 ; IPPROTO_TCP

xor edx, edx
push edx ; sin_zero
push word 0x5c11 ; sin_port (port 4444 hex)
push word 2 ; sin_family
mov edx, esp

mov esi, eax
mov edi, ebx
mov ecx, ecx

push edx ; pointer to sockaddr
push ecx ; sizeof(sockaddr)
push ebx ; socket type
push eax ; socket domain
mov eax, 102 ; socketcall
mov ebx, 1 ; SYS_SOCKET
int 0x80

mov esi, eax ; save socket descriptor

xor eax, eax
mov al, 102 ; socketcall
mov ebx, 2 ; SYS_BIND

xor ecx, ecx
mov cl, 16 ; sizeof(sockaddr_in)
push ecx ; sizeof(sockaddr_in)
push edx ; pointer to sockaddr
push esi ; socket descriptor

mov ecx, esp
int 0x80

xor eax, eax
mov al, 102 ; socketcall
mov ebx, 4 ; SYS_LISTEN

xor ecx, ecx
mov cl, 10 ; backlog (10 connections)

push ecx ; backlog
push esi ; socket descriptor

mov ecx, esp
int 0x80

xor eax, eax
mov al, 102 ; socketcall
mov ebx, 5 ; SYS_ACCEPT

xor ecx, ecx
push ecx
push ecx ; null pointer
push esi ; socket descriptor

mov ecx, esp
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, message
mov edx, message_length
int 0x80

xor eax, eax
mov al, 1 ; exit
xor ebx, ebx ; return value (0)
int 0x80

section .data

message db 'accepted', 0x0a
message_length equ $ - message
