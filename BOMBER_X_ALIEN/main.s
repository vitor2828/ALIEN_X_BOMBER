.data

CHAR_POS:		.half 32, 64 # posicao do personagem
CHAR_ANIMACAO:	.word 0, 0
CHAR_SPEED:		.word 4, 0, 0 # informacao para o power-up de velocidade
MAPA:	.word 0
BOMB_POS:		.half 0, 0 # posicao da bomba
ENEMY_1:		.word 1, 64, 128, 0, 0, 0, 0, 0, 0# flag se o inimigo está vivo // posicao do inimigo // orientacao do inimigo // timer de andar // tipode de inimigo // timer de animacao // endereco do sprite
ENEMY_2:		.word 1, 512, 224, 0, 0, 0, 0, 0, 0
ENEMY_3:		.word 1, 160, 224, 0, 0, 1, 0, 0, 0
ENEMY_4:		.word 1, 488, 192, 0, 0, 1, 0, 0, 0
BOMB_TIMER:		.word 0 # timer para começar a explosao da bomba
EXPLOSION_TIMER:	.word 0 # timer para terminar a explosao da bomba
BOMB_FLAG:			.byte 0 #flag para a bomba
BOMB_SPRITE_COUNTER:	.byte 0
EXPLODE_BOMB_FLAG:	.byte 0
CHAR_LIVES:			.byte 3
BOMB_POWER:			.byte 1
WIN_FLAG:			.byte 0
CURRENT_LEVEL:		.byte 0
PLAYER_SCORE:	.byte 0, 0, 0, 0, 0


.text

# a0 -> endereco da imagem
# a1 -> x da imagem
# a2 -> y da imagem
# a3 -> frame mostrado no bitmap

# t0 -> endereco do bitmap
# t1 -> endereco da imagem
# t2 -> contador de linha
# t3 -> contador de coluna
# t4 -> altura
# t5 -> largura

## Obs: os registradores t podem assumir outros valores ao longo do código, desde que, posteriormente,
## voltem ao padrão

# s0 -> alterna entre os frames
# s1 -> 
# s2/s7 -> salva o ra para funções internas
# s3 -> forca das bombas

INICIO:

la a0, tela_inicio
li a1, 0
li a2, 0
li a3, 0
call PRINT
li a3, 1
call PRINT

MUSIC_MENU:

	jal s7, MUSIC_LOOP_MENU
	call KEYPOLL_MENU
	li a7, 32
	li a0, 30
	ecall
	j MUSIC_MENU




KEYPOLL_MENU: #espera o usuario apertar algum botao e realiza uma acao

	li t1, 0xFF200000
	lw t0, 0(t1)
	andi t0, t0, 0x0001
	beq t0, zero, FIM
	lw t2, 4(t1)

	li t0, '1'
	beq t2, t0, SET_LEVEL_1

	li t0, '0'
	beq t2, t0, EXIT_GAME_MENU

	j MUSIC_MENU

EXIT_GAME_MENU:

	la a7, 10
	ecall

	
SET_LEVEL_1: # prepara o mapa da primeira fase (versao beta)

	la a0, level_1
	li a1, 0
	li a2, 0
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT

	li a7, 32
	li a0, 3000
	ecall

	la a0, CHAR_LIVES
	lb a1, 0(a0)
	beq a1, zero, GAME_OVER

	la a0, CHAR_POS
	li a1, 32
	sh a1, 0(a0)
	li a1, 64
	sh a1, 2(a0)

	la a0, CHAR_ANIMACAO
	la a1, astronauta_frente
	sw a1, 4(a0)

	la a0, BOMB_TIMER
	sw zero, 0(a0)

	la a0, ENEMY_1
	li a1, 1
	sw a1, 0(a0)
	li a1, 64
	sw a1, 4(a0)
	li a1, 160
	sw a1, 8(a0)
	jal s9, SELECT_SPRITE_FACEHUGGER
	sw a1, 28(a0)

	la a0, ENEMY_2
	li a1, 1
	sw a1, 0(a0)
	li a1, 576
	sw a1, 4(a0)
	li a1, 416
	sw a1, 8(a0)
	li a1, 2
	sw a1, 12(a0)
	jal s9, SELECT_SPRITE_FACEHUGGER
	sw a1, 28(a0)

	la a0, ENEMY_3
	li a1, 1
	sw a1, 0(a0)
	li a1, 192
	sw a1, 4(a0)
	li a1, 192
	sw a1, 8(a0)
	li a1, 2
	sw a1, 12(a0)
	jal s9, SELECT_SPRITE_CHESTBUSTTER
	sw a1, 28(a0)

	la a0, ENEMY_4
	li a1, 1
	sw a1, 0(a0)
	li a1, 488
	sw a1, 4(a0)
	li a1, 192
	sw a1, 8(a0)
	li a1, 2
	sw a1, 12(a0)
	jal s9, SELECT_SPRITE_CHESTBUSTTER
	sw a1, 28(a0)

	la a1, mapa_final_1_tiled
	addi a0, a1, 308
	la a4, MAPA
	sw a1, 0(a4)
	li a2, 75
	li a3, 0
	jal s7, RESTART_MAP

	la a0, CURRENT_LEVEL
	li a1, 1
	sb a1, 0(a0)

	la a0, BOMB_SPRITE_COUNTER
	lb zero, 0(a0)

	la a1, ENEMY_1
	li a7, 30
	ecall
	sw a0, 16(a1)

	la a1, ENEMY_2
	li a7, 30
	ecall
	sw a0, 16(a1)

	la a0, BOMB_POWER
	li a1, 1
	sb a1, 0(a0)	
	
	la a0, BOMB_FLAG
	sb zero, 0(a0)


	li a1, 0
	li a2, 0
	li a3, 0
	jal s7, PRINT_MAP
	li a3, 1
	jal s7, PRINT_MAP

	j GAME_LOOP_1

SET_LEVEL_2:

	la a0, level_2
	li a1, 0
	li a2, 0
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT

	li a7, 32
	li a0, 3000
	ecall

	la a0, CHAR_LIVES
	lb a1, 0(a0)
	beq a1, zero, GAME_OVER

	la a0, CHAR_POS
	li a1, 32
	sh a1, 0(a0)
	li a1, 64
	sh a1, 2(a0)

	la a0, BOMB_TIMER
	sw zero, 0(a0)

	la a0, ENEMY_1
	li a1, 1
	sw a1, 0(a0)
	li a1, 128
	sw a1, 4(a0)
	li a1, 64
	sw a1, 8(a0)

	la a0, ENEMY_2
	li a1, 1
	sw a1, 0(a0)
	li a1, 480
	sw a1, 4(a0)
	li a1, 192
	sw a1, 8(a0)
	li a1, 2
	sw a1, 12(a0)

	la a0, ENEMY_3
	li a1, 1
	sw a1, 0(a0)
	li a1, 32
	sw a1, 4(a0)
	li a1, 288
	sw a1, 8(a0)
	li a1, 2
	sw a1, 12(a0)
	jal s9, SELECT_SPRITE_CHESTBUSTTER
	sw a1, 28(a0)

	la a0, ENEMY_4
	li a1, 1
	sw a1, 0(a0)
	li a1, 480
	sw a1, 4(a0)
	li a1, 288
	sw a1, 8(a0)
	li a1, 2
	sw a1, 12(a0)
	jal s9, SELECT_SPRITE_CHESTBUSTTER
	sw a1, 28(a0)

	la a1, mapa_final_2_tiled
	addi a0, a1, 308
	li a2, 75
	li a3, 0
	la a4, MAPA
	sw a1, 0(a4)
	jal s7, RESTART_MAP

	la a0, CURRENT_LEVEL
	li a1, 2
	sb a1, 0(a0)

	la a0, BOMB_SPRITE_COUNTER
	lb zero, 0(a0)

	la a1, ENEMY_1
	li a7, 30
	ecall
	sw a0, 16(a1)

	la a1, ENEMY_2
	li a7, 30
	ecall
	sw a0, 16(a1)

	la a0, BOMB_POWER
	li a1, 1
	sb a1, 0(a0)
	
	la a0, BOMB_FLAG
	sb zero, 0(a0)

	li a1, 0
	li a2, 0
	li a3, 0
	jal s7, PRINT_MAP
	li a3, 1
	jal s7, PRINT_MAP

	j GAME_LOOP_1

		
GAME_LOOP_1: # game loop da primeira fase

	call KEYPOLL
	xori s0, s0, 1

	la a0, WIN_FLAG
	li a1, 1
	sb a1, 0(a0)

	jal s7, UPDATE_SCORE
	jal s7, CHECK_POWER_UP	
	jal s7, CHECK_SPEED
	jal UPDATE_BOMB
	jal UPDATE_EXPLOSION
	la s11, ENEMY_1
	jal s7, UPDATE_ENEMY
	la s11, ENEMY_2
	jal s7, UPDATE_ENEMY
	la s11, ENEMY_3
	jal s7, UPDATE_ENEMY
	la s11, ENEMY_4
	jal s7, UPDATE_ENEMY
	jal s7, MUSIC_LOOP

	la a0, WIN_FLAG
	lb a1, 0(a0)
	li a0, 1
	beq a1, a0, CHANGE_LEVEL

	mv a3, s0
	jal s7, PRINT_MAP

	la t0, CHAR_POS
	lh a1, 0(t0)
	lh a2, 2(t0)
	la t0, CHAR_ANIMACAO
	lw a0, 4(t0)
	li a4, 1032
	lw a5, 0(t0)
	mul a4, a4, a5
	add a0, a0, a4
	mv a3, s0
	call PRINT

	li t0, 0xFF200604
	sw s0, 0(t0)
		
#########LOOP DE DELAY##########
#	li a7,30
#	ecall
#	mv t0,a0
#	addi t0,t0,100
	

#LOOP_DELAY:

#	li a7,30
#	ecall
#	mv t1,a0
#	bgt t1,t0,FIM_DELAY
#	j LOOP_DELAY

#FIM_DELAY:

##########FUM DO LOOP###########

	j GAME_LOOP_1
	
KEYPOLL: #espera o usuario apertar algum botao e realiza uma acao

	li t1, 0xFF200000
	lw t0, 0(t1)
	andi t0, t0, 0x0001
	beq t0, zero, FIM
	lw t2, 4(t1)
	
	li t0, 'a'
	beq t2, t0, CHAR_LEFT
	
	li t0, 'w'
	beq t2, t0, CHAR_UP
	
	li t0, 's'
	beq t2, t0, CHAR_DOWN
	
	li t0, 'd'
	beq t2, t0, CHAR_RIGHT
	
	li t0, 'j'
	beq t2, t0, DROP_BOMB

	li t0, '='
	beq t2, t0, CHANGE_LEVEL

	li t0, '1'
	beq t2, t0, SET_LEVEL_1

	li t0, '2'
	beq t2, t0, SET_LEVEL_2

	li t0, '3'
	beq t2, t0, ADD_POWER

	li t0, '4'
	beq t2, t0, ADD_SPEED
	
FIM:

	ret
	
CHAR_LEFT:

	la t0, CHAR_POS
	la t2, CHAR_ANIMACAO
	la t3, astronauta_esquerda
	sw t3, 4(t2)
	lw t3, 0(t2)
	addi t3, t3, 1
	li t4, 8
	rem t3, t3, t4
	sw t3, 0(t2)
	
	mv t6, ra
	jal CHECK_LEFT
	mv ra, t6
	ret

CONFIRM_LEFT:
	

	lh t1, 0(t0)
	la t2, CHAR_SPEED
	lw t2, 0(t2)
	li t3, -1
	mul t2, t2, t3
	add t1, t1, t2
	sh t1, 0(t0)
	ret
	
CHAR_RIGHT:

	la t0, CHAR_POS
	la t2, CHAR_ANIMACAO
	la t3, astronauta_direita
	sw t3, 4(t2)
	lw t3, 0(t2)
	addi t3, t3, 1
	li t4, 8
	rem t3, t3, t4
	sw t3, 0(t2)
	
	mv t6, ra
	jal CHECK_RIGHT
	mv ra, t6
	ret
	
CONFIRM_RIGHT:

	lh t1, 0(t0)
	la t2, CHAR_SPEED
	lw t2, 0(t2)
	add t1, t1, t2
	sh t1, 0(t0)
	ret

CHAR_UP:

	la t0, CHAR_POS
	la t2, CHAR_ANIMACAO
	la t3, astronauta_costas
	sw t3, 4(t2)
	lw t3, 0(t2)
	addi t3, t3, 1
	li t4, 8
	rem t3, t3, t4
	sw t3, 0(t2)

	mv t6, ra
	jal CHECK_UP
	mv ra, t6
	ret
	
CONFIRM_UP:
	
	lh t1, 2(t0)
	la t2, CHAR_SPEED
	lw t2, 0(t2)
	li t3, -1
	mul t2, t2, t3
	add t1, t1, t2
	sh t1, 2(t0)
	ret
	
CHAR_DOWN:

	la t0, CHAR_POS
	la t2, CHAR_ANIMACAO
	la t3, astronauta_frente
	sw t3, 4(t2)
	lw t3, 0(t2)
	addi t3, t3, 1
	li t4, 8
	rem t3, t3, t4
	sw t3, 0(t2)
	
	mv t6, ra
	jal CHECK_DOWN
	mv ra, t6
	ret
	
CONFIRM_DOWN:

	
	lh t1, 2(t0)
	la t2, CHAR_SPEED
	lw t2, 0(t2)
	add t1, t1, t2
	sh t1, 2(t0)
	ret
	
DROP_BOMB:

	la t0, BOMB_FLAG
	lb t1, 0(t0)
	li t2, 1 # 1 = ja existe bomba
	beq t1, t2, DROP_BOMB_EXIT # se uma bomba ja estiver colocada, nao dropa a bomba
	
	sb t2, 0(t0) # fala que uma bomba existe
	
	la t0, CHAR_POS # pega o x e y do char 
	lh a1, 0(t0)
	lh a2, 2(t0)

	la a0, MAPA
	lw a0, 0(a0)
	
	mv t1, a1
	mv t2, a2
	li t3, 32
	li t4, 20

	div t1, t1, t3
	div t2, t2, t3
	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 8
	add a0, a0, t1

	li t5, 2
	sb t5, 0(a0)

	li t1, 32
	rem t2, a1, t1

	mv s2, ra

	beq t2, zero, FIX_Y_BOMB
	bge t2, t1, ADD_OFFSET_X
	blt t2, t1, SUB_OFFSET_X

FIX_Y_BOMB:

	la t0, CHAR_POS
	lh a2, 2(t0)
	li t1, 32

	rem t2, a2, t1
	li t1, 32

	beq t2, zero, CONTINUE_DROP_BOMB
	bge t2, t1, ADD_OFFSET_Y
	blt t2, t1, SUB_OFFSET_Y

CONTINUE_DROP_BOMB:
	
	la t1, BOMB_POS # passa o x e y para a bomba
	sh a1, 0(t1)
	sh a2, 2(t1)
	
	la t0, BOMB_TIMER
	li a7, 30 # syscall para pegar o tempo
	ecall
	sw a0, 0(t0) # seta o time em que a bomba foi colocada
	
	la a0, bomba # printa a bomba
	lh a1, 0(t1)
	lh a2, 2(t1)
	call PRINT
	mv ra, s2
	
DROP_BOMB_EXIT:
	
	ret

ADD_OFFSET_X:

	li t1, 32
	sub t3, t1, t2
	add a1, a1, t3
	j FIX_Y_BOMB

SUB_OFFSET_X:

	sub a1, a1, t2
	j FIX_Y_BOMB

ADD_OFFSET_Y:

	li t1, 32
	sub t3, t1, t2
	add a2, a2, t3
	j CONTINUE_DROP_BOMB

SUB_OFFSET_Y:

	sub a2, a2, t2
	j CONTINUE_DROP_BOMB
	
UPDATE_BOMB:
    la t0, BOMB_FLAG
    lb t1, 0(t0)
    beq t1, zero, UPDATE_BOMB_EXIT

    li a7, 30
    ecall
    mv s1, a0          

    la t0, BOMB_TIMER
    lw t2, 0(t0)         
    addi t3, t2, 2000    
    bge s1, t3, EXPLODE_BOMB

    sub t4, s1, t2    
    
    li t5, 125       
    div t4, t4, t5       
    
    li t5, 8
	rem t4, t4, t5
    
    la t0, BOMB_SPRITE_COUNTER
    sb t4, 0(t0)

    la a0, bomba
    lb t4, 0(t0)
    li t5, 1032          
    mul t5, t5, t4
    add a0, a0, t5    

    la t0, BOMB_POS
    lh a1, 0(t0)
    lh a2, 2(t0)
    mv s2, ra
    call PRINT
    mv ra, s2
	
	j UPDATE_BOMB_EXIT

EXPLODE_BOMB:

	la t1, BOMB_FLAG
	lb t2, 0(t0)
	beq t2, zero, UPDATE_BOMB_EXIT

	la t1, EXPLODE_BOMB_FLAG
	lb t2, 0(t0)
	li t3, 1
	beq t2, t3, UPDATE_BOMB_EXIT

	la t0, BOMB_POS
	lh a1, 0(t0)
	lh a2, 2(t0)

	la a0, MAPA
	lw a0, 0(a0)

	mv t1, a1
	mv t2, a2
	li t3, 32
	li t4, 20

	div t1, t1, t3
	div t2, t2, t3
	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 8
	add a0, a0, t1

	li t5, 1
	sb t5 , 0(a0)

	la t0, CURRENT_LEVEL
	lb t0, 0(t0)
	li t1, 2
	bne t0, t1, NO_NEW_TILE_EXPLOSION
	li t5, 7
	sb t5, 0(a0)

NO_NEW_TILE_EXPLOSION:

	la t0, EXPLOSION_TIMER
	li a7, 30
	ecall
	sw a0, 0(t0)

	la t0, BOMB_TIMER
	sw zero, 0(t0)

	la t0, EXPLODE_BOMB_FLAG
	li t1, 1
	sb t1, 0(t0)


UPDATE_EXPLOSION:

	la t0, EXPLOSION_TIMER 
	lw t1, 0(t0)
	beq t1, zero, UPDATE_EXPLOSION_EXIT # se o timer não estiver definido, não há bomba. Portanto, apenas volta para o gameloop
	
	li a7, 30
	ecall
	addi t1, t1, 500
	bge a0, t1, EXPLOSION_FINISHED # define o tempo de explosao na mesma lógica que a bomba

	la t1, BOMB_POS
	lh a1, 0(t1)
	lh a2, 2(t1)
	
# adicionar um loop para printar o sprite da explosao nos 4 tiles adjacentes

	la a0, explosao_centro # printa a explosao
	mv s2, ra
	mv a3, s0
	call PRINT
	xori a3, a3, 1
	call PRINT
	jal s7, CHECK_DAMAGE
	la t0, ENEMY_1
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_2
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_3
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_4
	jal s7, CHECK_ENEMY_DAMAGE

	la t0, BOMB_POWER
	lb s3, 0(t0)
	
	li a4, 0
	mv a3, s0
	
EXPLOSION_RIGHT:

	addi a1, a1, 32
	jal s7, CHECK_EXPLOSION_RIGHT
	call PRINT
	xori a3, a3, 1
	call PRINT
	jal s7, CHECK_DAMAGE
	la t0, ENEMY_1
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_2
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_3
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_4
	jal s7, CHECK_ENEMY_DAMAGE
	addi a4, a4, 1
	bge a4, s3, END_EXPLOSION_RIGHT
	j EXPLOSION_RIGHT
	
END_EXPLOSION_RIGHT:

	li a4, 0
	la t1, BOMB_POS
	lh a1, 0(t1)
	lh a2, 2(t1)
	mv a3, s0

EXPLOSION_LEFT:
	
	addi a1, a1, -32
	jal s7, CHECK_EXPLOSION_LEFT
	call PRINT
	xori a3, a3, 1
	call PRINT
	jal s7, CHECK_DAMAGE
	la t0, ENEMY_1
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_2
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_3
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_4
	jal s7, CHECK_ENEMY_DAMAGE
	
	addi a4, a4, 1
	bge a4, s3, END_EXPLOSION_LEFT
	j EXPLOSION_LEFT
	
END_EXPLOSION_LEFT:
	
	li a4, 0
	la t1, BOMB_POS
	lh a1, 0(t1)
	lh a2, 2(t1)
	mv a3, s0
	
EXPLOSION_UP:

	addi a2, a2, -32
	jal s7, CHECK_EXPLOSION_UP
	call PRINT
	xori a3, a3, 1
	call PRINT
	jal s7, CHECK_DAMAGE
	la t0, ENEMY_1
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_2
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_3
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_4
	jal s7, CHECK_ENEMY_DAMAGE
	addi a4, a4, 1
	bge a4, s3, END_EXPLOSION_UP
	j EXPLOSION_UP
	
END_EXPLOSION_UP:

	li a4, 0
	la t1, BOMB_POS
	lh a1, 0(t1)
	lh a2, 2(t1)
	mv a3, s0
	
EXPLOSION_DOWN:
	
	addi a2, a2, 32
	jal s7, CHECK_EXPLOSION_DOWN
	call PRINT
	xori a3, a3, 1
	call PRINT
	jal s7, CHECK_DAMAGE
	la t0, ENEMY_1
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_2
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_3
	jal s7, CHECK_ENEMY_DAMAGE
	la t0, ENEMY_4
	jal s7, CHECK_ENEMY_DAMAGE
	addi a4, a4, 1
	bge a4, s3, END_EXPLOSION_DOWN
	j EXPLOSION_DOWN
	
END_EXPLOSION_DOWN:
	
	mv ra, s2
	
	j UPDATE_EXPLOSION_EXIT
	
EXPLOSION_FINISHED:
	
	la t0, EXPLOSION_TIMER # reseta o timer da explosao
	sw zero, 0(t0)
	
	la t1, BOMB_FLAG
	sb zero, 0(t1)

	la t2, EXPLODE_BOMB_FLAG
	sb zero, 0(t2)

UPDATE_ENEMY:

	mv t0, s11
	lw a1, 0(t0)
	beq a1, zero, UPDATE_ENEMY_EXIT

	la a0, WIN_FLAG
	sb zero, 0(a0)

	li a7, 30
	ecall
	mv s1, a0

	lw t2, 24(t0)

	sub t4, s1, t2

	li t5, 250
	div t4, t4, t5

	li t5, 4
	rem t4, t4, t5

	sw t4, 32(t0)

	 
	lw a0, 28(t0)
	lb t4, 32(t0)
	li t5, 1032
	mul t5, t5, t4
	add a0, a0, t5
	lw a1, 4(t0)
	lw a2, 8(t0)
	mv a3, s0
	mv s2, ra
	call PRINT
	xori a3, a3, 1
	call PRINT
	mv ra, s2

	mv t0, s11

	mv s2, ra
	lw t1, 4(t0)
	lw t2, 8(t0)
	call CHECK_DAMAGE_1
	mv ra, s2

	mv t0, s11
	lw t1, 16(t0)
	addi t1, t1, 25
	li a7, 30
	ecall
	bge a0, t1, CHECK_ENEMY_WALK

	j UPDATE_ENEMY_EXIT

SELECT_SPRITE_FACEHUGGER:

	lw t0, 12(a0)
	beq t0, zero, DIR_FACEHUGGER
	li t1, 1
	beq t0, t1, CIM_FACEHUGGER
	li t1, 2
	beq t0, t1, ESQ_FACEHUGGER
	li t1, 3
	beq t0, t1, BAIXO_FACEHUGGER

	mv ra, s9
	ret

DIR_FACEHUGGER:

	la a1, sprite_facehugger_dir
	mv ra, s9
	ret

CIM_FACEHUGGER:

	la a1, sprite_facehugger_cima
	mv ra, s9
	ret

ESQ_FACEHUGGER:

	la a1, sprite_facehugger_esq
	mv ra, s9
	ret

BAIXO_FACEHUGGER:

	la a1, sprite_facehugger_baixo
	mv ra, s9
	ret

SELECT_SPRITE_CHESTBUSTTER:

	lw t0, 12(a0)
	beq t0, zero, DIR_CHESTBUSTTER
	li t1, 1
	beq t0, t1, CIM_CHESTBUSTTER
	li t1, 2
	beq t0, t1, ESQ_CHESTBUSTTER
	li t1, 3
	beq t0, t1, BAIXO_CHESTBUSTTER

	mv ra, s9
	ret

DIR_CHESTBUSTTER:

	la a1, chestbustter_dir
	mv ra, s9
	ret

CIM_CHESTBUSTTER:

	la a1, chestbustter_costas
	mv ra, s9
	ret

ESQ_CHESTBUSTTER:

	la a1, chestbustter_esq
	mv ra, s9
	ret

BAIXO_CHESTBUSTTER:

	la a1, chestbustter_frente
	mv ra, s9
	ret


CHECK_ENEMY_WALK:

	mv t0, s11
	lw t1, 4(t0)
	lw t2, 8(t0)
	lw t3, 12(t0)

	beq t3, zero, CHECK_ENEMY_RIGHT

RETURN_ENEMY_RIGHT:

	li t4, 1
	beq t3, t4, CHECK_ENEMY_UP

RETURN_ENEMY_UP:

	li t4, 2
	beq t3, t4, CHECK_ENEMY_LEFT

RETURN_ENEMY_LEFT:

	li t4, 3
	beq t3, t4, CHECK_ENEMY_DOWN

	j UPDATE_ENEMY_EXIT


WALK_ENEMY_RIGHT:

	mv t0, s11
	lw t1, 4(t0)
	addi t1, t1, 1
	sw t1, 4(t0)

	li a7, 30
	ecall

	sw a0, 16(t0)

	j UPDATE_ENEMY_EXIT

WALK_ENEMY_UP:

	mv t0, s11
	lw t2, 8(t0)
	addi t2, t2, -1
	sw t2, 8(t0)

	li a7, 30
	ecall

	sw a0, 16(t0)

	j UPDATE_ENEMY_EXIT

WALK_ENEMY_LEFT:

	mv t0, s11
	lw t1, 4(t0)
	addi t1, t1, -1
	sw t1, 4(t0)

	li a7, 30
	ecall

	sw a0, 16(t0)

	j UPDATE_ENEMY_EXIT

WALK_ENEMY_DOWN:

	mv t0, s11
	lw t2, 8(t0)
	addi t2, t2, 1
	sw t2, 8(t0)

	li a7, 30
	ecall

	sw a0, 16(t0)

	j UPDATE_ENEMY_EXIT


UPDATE_EXPLOSION_EXIT:

	ret
	
UPDATE_BOMB_EXIT:

	ret

UPDATE_ENEMY_EXIT:

	mv ra, s7
	ret
	
	
PRINT: # seta o endereco do bitmap e ajusta os registradores de imagem

	li t0, 0xFF0
	add t0, t0, a3
	slli t0, t0, 20
	
	add t0, t0, a1
	li  t1, 640
	mul t1, t1, a2
	add t0, t0, t1
	
	addi t1, a0, 8
	
	mv t2, zero
	mv t3, zero
	
	lw t4, 0(a0)
	lw t5, 4(a0)
	
PRINT_LINHA: #loop que printa tinha por linha até o fim da imagem

	lw t6, 0(t1)
	sw t6, 0(t0)
	
	addi t0, t0, 4
	addi t1, t1, 4
	
	addi t3, t3, 4
	blt t3, t4, PRINT_LINHA
	
	addi t0, t0, 640
	sub t0, t0, t4
	
	mv t3, zero
	addi t2, t2, 1
	bgt t5, t2, PRINT_LINHA
	
	ret

PRINT_MAP:
	la s8, MAPA
	lw s8, 0(s8)
	addi s8, s8, 8  		# Endereço do mapa
    li s5, 0                # Contador de linhas (Y)

    # Configura dimensões
    li t3, 20               # Largura do mapa (colunas)
    li t4, 15               # Altura do mapa (linhas)

PRINT_MAP_LINE:
    li s4, 0                # Contador de colunas (X)

PRINT_MAP_COLUMN:
    # Carrega tile atual
    lb t1, 0(s8)

    # Calcula coordenadas (sem offsets)
    slli a1, s4, 5          # X = coluna * 16 (equivalente a mul por 16)
    slli a2, s5, 5         # Y = linha * 16


    # Seleciona tile baseado no valor
    beq t1, zero, PRINT_U_WALL    # Se tile == 0
    li t2, 1
    beq t1, t2, PRINT_TILE  # Se tile == 1
	li t2, 3
	beq t1, t2, PRINT_B_WALL_1
	li t2, 4
	beq t1, t2, PRINT_TILE_2
	li t2, 5
	beq t1, t2, PRINT_PRETO
	li t2, 6
	beq t1, t2, PRINT_ROSTO
	li t2, 7
	beq t1, t2, PRINT_TILE_3
	li t2, 8
	beq t1, t2, PRINT_B_WALL_2
	li t2, 10
	beq t1, t2, PRINT_ZERO
	li t2, 11
	beq t1, t2, PRINT_ONE
	li t2, 12
	beq t1, t2, PRINT_TWO
	li t2, 13
	beq t1, t2, PRINT_THREE
	li t2, 14
	beq t1, t2, PRINT_FOUR
	li t2, 15
	beq t1, t2, PRINT_FIVE
	li t2, 16
	beq t1, t2, PRINT_SIX
	li t2, 17
	beq t1, t2, PRINT_SEVEN
	li t2, 18
	beq t1, t2, PRINT_EIGHT
	li t2, 19
	beq t1, t2, PRINT_NINE
	li t2, 22
	beq t1, t2, PRINT_POWER
	li t2, 23
	beq t1, t2, PRINT_SPEED
	li t2, 24
	beq t1, t2, PRINT_HEART

	la t2, CURRENT_LEVEL
	lb t2, 0(t2)
	beq t1, t2, PRINT_TILE_3
	j PRINT_TILE

PRINT_U_WALL:
    la a0, parede
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_B_WALL_1:
	la a0, tile_destrutivel1
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_B_WALL_2:
	la a0, tile_destrutivel2
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE
	
PRINT_TILE:
    la a0, tile2
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_TILE_2:
	la a0, tile2_2
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_PRETO:
	la a0, preto
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_ROSTO:
	la a0, rosto
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_TILE_3:
	la a0, tile_fase2
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_B_WALL:
	la a0, tile_destrutivel1
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_ZERO:
	la a0, ZERO
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_ONE:
	la a0, um
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_TWO:
	la a0, dois
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_THREE:
	la a0, tres
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_FOUR:
	la a0, quatro
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_FIVE:
	la a0, cinco
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_SIX:
	la a0, seis
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_SEVEN:
	la a0, sete
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_EIGHT:
	la a0, oito
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_NINE:
	la a0, nove
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

PRINT_POWER:
	la a0, tile2
	la a1, CURRENT_LEVEL
	lb a1, 0(a1)
	li a2, 2
	bne a1, a2, NO_NEW_TILE_POWER
	la a0, tile_fase2

NO_NEW_TILE_POWER:
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	la a0, power
	call PRINT
	j NEXT_TILE

PRINT_SPEED:
	la a0, tile2
	la a1, CURRENT_LEVEL
	lb a1, 0(a1)
	li a2, 2
	bne a1, a2, NO_NEW_TILE_SPEED
	la a0, tile_fase2

NO_NEW_TILE_SPEED:
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	la a0, speed
	call PRINT
	j NEXT_TILE

PRINT_HEART:
	la a0, heart
	slli a1, s4, 5
	slli a2, s5, 5
	call PRINT
	j NEXT_TILE

NEXT_TILE:
    # Avança para próximo tile
	li t3, 20
    addi s4, s4, 1          # Próxima coluna
    addi s8, s8, 1          # Próximo byte do mapa
    
    blt s4, t3, PRINT_MAP_COLUMN  # Continua na mesma linha

    # Próxima linha
	li t4, 15
    addi s5, s5, 1
    blt s5, t4, PRINT_MAP_LINE

	mv ra, s7

    ret

RESTART_MAP:

	lw t0, 0(a0)
	sw t0, 0(a1)
	addi a3, a3, 1
	addi a0, a0, 4
	addi a1, a1, 4
	blt a3, a2, RESTART_MAP
	mv ra, s7
	ret

CHANGE_LEVEL:

	la a0, CURRENT_LEVEL
	lb a1, 0(a0)
	li a2, 1
	bne a1, a2, GAME_OVER
	li a7, 32
	li a0, 2000
	ecall
	j SET_LEVEL_2

GAME_OVER:


	li a0, 2000
	li a7, 32
	ecall

	la a0, CHAR_LIVES
	lb a1, 0(a0)

	la a0, tela_vitoria
	bgt a1, zero, TELA_VITORIA
	la a0, tela_derrota

TELA_VITORIA:

	li a1, 0
	li a2, 0
	li a3, 0
	call PRINT
	li a3, 1
	call PRINT
	li a0, 5000
	li a7, 32
	ecall

	j INICIO

UPDATE_SCORE:

	la t0, PLAYER_SCORE
	la t2, MAPA
	lw t2, 0(t2)

	lb t1, 0(t0)
	addi t1, t1, 10
	sb t1, 19(t2)
	lb t1, 1(t0)
	addi t1, t1, 10
	sb t1, 20(t2)
	lb t1, 2(t0)
	addi t1, t1, 10
	sb t1, 21(t2)
	lb t1, 3(t0)
	addi t1, t1, 10
	sb t1, 22(t2)
	lb t1, 4(t0)
	addi t1, t1, 10
	sb t1, 23(t2)

	mv ra, s7
	ret

CHECK_POWER_UP:

	la t0, MAPA
	lw t0, 0(t0)

	la t1, CHAR_POS
	lh t2, 0(t1)
	lh t3, 2(t1)

	li t4, 32
	li t5, 20

	div t2, t2, t4
	div t3, t3, t4

	mul t3, t3, t5
	add t2, t2, t3

	addi t0, t0, 8
	add t0, t0, t2

	lb t1, 0(t0)

	li t2, 22
	beq t1, t2, ADD_POWER
	li t2, 23
	beq t1, t2, ADD_SPEED
	j CHECK_POWER_UP_EXIT

ADD_POWER:

	la t2, BOMB_POWER
	lb t1, 0(t2)
	addi t1, t1, 1
	sb t1, 0(t2)

	li t1, 1
	sb t1, 0(t0)
	la t1, CURRENT_LEVEL
	lb t1, 0(t1)
	li t2, 2
	bne t1, t2, CHECK_POWER_UP_EXIT
	li t1, 7
	sb t1, 0(t0)
	j CHECK_POWER_UP_EXIT

ADD_SPEED:

	la t2, CHAR_SPEED
	lb t1, 0(t2)
	addi t1, t1, 4
	sw t1, 0(t2)
	li t1, 1
	sw t1, 8(t2)

	li a7, 30
	ecall
	addi a0, a0, 5000
	addi a0, a0, 5000
	sw a0, 4(t2)

	li a1, 0

	li t1, CHAR_POS
	lh t2, 0(t1)
	lh t3, 2(t1)

	li t4, 32

	rem t4, t2, t4

	beq t3, zero, FIX_Y_SPEED
	li t5, 16
	bgt t4, t5, ADD_OFFSET_X_SPEED
	ble t3, t4, SUB_OFFSET_X_SPEED

FIX_Y_SPEED:

	li t4, 32
	rem t4, t3, t4

	beq t4, zero, END_SPEED
	li t5, 16
	bge t4, t5, ADD_OFFSET_Y_SPEED
	blt t4, t5, SUB_OFFSET_Y_SPEED

ADD_OFFSET_X_SPEED:

	li t5, 32
	sub t6, t5, t4
	add t2, t2, t6
	sh t2, 0(t1)
	j FIX_Y_SPEED

SUB_OFFSET_X_SPEED:

	sub t2, t2, t4
	sh t2, 0(t1)
	j FIX_Y_CHAR

ADD_OFFSET_Y_SPEED:

	li t5, 32
	sub t6, t5, t4
	add t3, t3, t6
	sh t3, 2(t1)
	j END_SPEED

SUB_OFFSET_Y_SPEED:

	sub t3, t3, t4
	sh t3, 2(t1)
	j END_SPEED

END_SPEED:

	li t1, 1
	sb t1, 0(t0)
	la t1, CURRENT_LEVEL
	lb t1, 0(t1)
	li t2, 2
	bne t1, t2, CHECK_POWER_UP_EXIT
	li t1, 7
	sb t1, 0(t0)
	j CHECK_POWER_UP_EXIT

CHECK_POWER_UP_EXIT:

	mv ra, s7
	ret

CHECK_SPEED:

	la t0, CHAR_SPEED
	lw t1, 8(t0)
	li t2, 1
	bne t1, t2, CHECK_SPEED_EXIT
	li a7, 30
	ecall

	lw t2, 4(t0)
	blt a0, t2, CHECK_SPEED_EXIT
	sw zero, 8(t0)
	sw zero, 4(t0)
	lw t2, 0(t0)
	addi t2, t2, -4
	sw t2, 0(t0)
	
CHECK_SPEED_EXIT:

	mv ra, s7
	ret



.data

.include "hitbox.s"
.include "musica.s"
.include "sprites/zero.data"
.include "sprites/1.data"
.include "sprites/2.data"
.include "sprites/3.data"
.include "sprites/4.data"
.include "sprites/5.data"
.include "sprites/6.data"
.include "sprites/7.data"
.include "sprites/8.data"
.include "sprites/9.data"
.include "sprites/power.data"
.include "sprites/speed.data"
.include "explosao.s"
.include "bomba.s"
.include "sprites/explosao.data"
.include "sprites/tile_novo.data"
.include "sprites/tile_destrutivel1.data"
.include "sprites/tile_destrutivel2.data"
.include "sprites/tile_fase2.data"
.include "sprites/tile2.data"
.include "sprites/parede.data"
.include "sprites/preto.data"
.include "sprites/tile1.data"
.include "sprites/tile2_2.data"
.include "sprites/rosto.data"
.include "facehugger.s"
.include "astronauta.s"
.include "sprites/heart.data"
.include "sprites/mapa.s"
.include "chestbustter.s"
.include "sprites/tela_inicio.data"
.include "sprites/level_1.data"
.include "sprites/level_2.data"
.include "sprites/tela_vitoria.data"
.include "sprites/tela_derrota.data"