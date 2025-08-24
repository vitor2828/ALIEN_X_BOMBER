##############
# 0 - paredes
# 1 - chao mod 1
# 2 - tile temporária da bomba
# 3 - tile parede destrutível
# 4 - chao mod 2
# 5 - fundo hud
# 6 - rosto personagem
# 7 - chao mod 3
# 8 - tile destrutivel 2
# 10 - número 0
# 11 - número 1
# 12 - número 2...
# 19 - número 9
# 20 - tile parede destrutível com power-up de forca (demonstração de power-up)
# 21 - tile ... com power-up de velocidade (demonstroação)
# 22 - power-up forca (randomizado)
# 23 - power-up velocidade (randomizado)
# 24 - coracao


.text


CHECK_LEFT:
	
	la a0, MAPA
	lw a0, 0(a0)
	lh t1, 0(t0)
	lh t2, 2(t0)
	la t3, CHAR_SPEED
	lw t3, 0(t3)
	li t4, 32
	sub t4, t4, t3
	add t1, t1, t4
	li t3, 32
	li t4, 20

	div t1, t1, t3
	div t2, t2, t3
	
	mul t2, t2, t4
	add t1, t1, t2
	
	addi a0, a0, 7
	add a0, a0, t1
	
	lb t1, 0(a0)
	beq t1, zero, NO_MOVE
	li t2, 2
	beq t1, t2, NO_MOVE
	li t2, 3
	beq t1, t2, NO_MOVE
	li t2, 8
	beq t1, t2, NO_MOVE

	lh t2, 2(t0)
	rem t1, t2, t3
	beq t1, zero, CONFIRM_LEFT


	la a0, MAPA
	lw a0, 0(a0)
	lh t1, 0(t0)
	lh t2, 2(t0)
	addi t1, t1, 24
	addi t2, t2, 32

	div t1, t1, t3
	div t2, t2, t3
	
	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 7
	add a0, a0, t1

	lb t1, 0(a0)
	beq t1, zero, NO_MOVE
	li t2, 2
	beq t1, t2, NO_MOVE
	li t2, 3
	beq t1, t2, NO_MOVE
	li t2, 8
	beq t1, t2, NO_MOVE

	
	j CONFIRM_LEFT

CHECK_RIGHT:

	la a0, MAPA
	lw a0, 0(a0)
	lh t1, 0(t0)
	lh t2, 2(t0)
	li t3, 32
	li t4, 20

	div t1, t1, t3
	div t2, t2, t3
	
	mul t2, t2, t4
	add t1, t1, t2
	
	addi a0, a0, 9
	add a0, a0, t1
	
	lb t1, 0(a0)
	beq t1, zero, NO_MOVE
	li t2, 2
	beq t1, t2, NO_MOVE
	li t2, 3
	beq t1, t2, NO_MOVE
	li t2, 8
	beq t1, t2, NO_MOVE


	lh t2, 2(t0)
	rem t1, t2, t3
	beq t1, zero, CONFIRM_RIGHT

	la a0, MAPA
	lw a0, 0(a0)
	lh t1, 0(t0)
	lh t2, 2(t0)

	addi t2, t2, 32

	div t1, t1, t3
	div t2, t2, t3

	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 9
	add a0, a0, t1

	lb t1, 0(a0)
	beq t1, zero, NO_MOVE
	li t2, 2
	beq t1, t2, NO_MOVE
	li t2, 3
	beq t1, t2, NO_MOVE
	li t2, 8
	beq t1, t2, NO_MOVE

	j CONFIRM_RIGHT
	
CHECK_UP:

	la a0, MAPA
	lw a0, 0(a0)
	lh t1, 0(t0)
	lh t2, 2(t0)
	la t3, CHAR_SPEED
	lw t3, 0(t3)
	li t4, 32
	sub t4, t4, t3
	add t2, t2, t4
	li t3, 32
	li t4, 20
	
	div t1, t1, t3
	div t2, t2, t3
	
	mul t2, t2, t4
	add t1, t1, t2
	
	addi a0, a0, 8
	add a0, a0, t1
	addi a0, a0, -20
	
	lb t1, 0(a0)
	beq t1, zero, NO_MOVE
	li t2, 2
	beq t1, t2, NO_MOVE
	li t2, 3
	beq t1, t2, NO_MOVE
	li t2, 8
	beq t1, t2, NO_MOVE

	lh t2, 0(t0)
	rem t1, t2, t3
	beq t1, zero, CONFIRM_UP

	la a0, MAPA
	lw a0, 0(a0)
	lh t1, 0(t0)
	lh t2, 2(t0)
	addi t2, t2, 24

	addi t1, t1, 32

	div t1, t1, t3
	div t2, t2, t3
	
	mul t2, t2, t4
	add t1, t1, t2
	
	addi a0, a0, 8
	add a0, a0, t1
	addi a0, a0, -20
	
	lb t1, 0(a0)
	beq t1, zero, NO_MOVE
	li t2, 2
	beq t1, t2, NO_MOVE
	li t2, 3
	beq t1, t2, NO_MOVE
	li t2, 8
	beq t1, t2, NO_MOVE

	j CONFIRM_UP
	
CHECK_DOWN:

	la a0, MAPA
	lw a0, 0(a0)
	lh t1, 0(t0)
	lh t2, 2(t0)
	li t3, 32
	li t4, 20
	
	div t1, t1, t3
	div t2, t2, t3
	
	mul t2, t2, t4
	add t1, t1, t2
	
	addi a0, a0, 8
	addi a0, a0, 20
	add a0, a0, t1
	
	lb t1, 0(a0)
	beq t1, zero, NO_MOVE
	li t2, 2
	beq t1, t2, NO_MOVE
	li t2, 3
	beq t1, t2, NO_MOVE
	li t2, 8
	beq t1, t2, NO_MOVE

	lh t2, 0(t0)
	rem t1, t2, t3
	beq t1, zero, CONFIRM_DOWN

	la a0, MAPA
	lw a0, 0(a0)
	lh t1, 0(t0)
	lh t2, 2(t0)

	addi t1, t1, 32

	div t1, t1, t3
	div t2, t2, t3

	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 8
	addi a0, a0, 20
	add a0, a0, t1

	lb t1, 0(a0)
	beq t1, zero, NO_MOVE
	li t2, 2
	beq t1, t2, NO_MOVE
	li t2, 3
	beq t1, t2, NO_MOVE
	li t2, 8
	beq t1, t2, NO_MOVE

	j CONFIRM_DOWN
	
NO_MOVE:
	ret

CHECK_EXPLOSION_RIGHT:

	la a0, MAPA
	lw a0, 0(a0)
	li t3, 32
	li t4, 20

	div t1, a1, t3
	div t2, a2, t3

	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 8
	add a0, a0, t1

	lb t1, 0(a0)
	beq t1, zero, END_EXPLOSION_RIGHT
	li t2, 3
	beq t1, t2, DESTROY_BLOCK_RIGHT
	li t2, 4
	beq t1, t2, DESTROY_BLOCK_RIGHT
	li t2, 8
	beq t1, t2, DESTROY_BLOCK_RIGHT

	la a0, esp_dir
	mv ra, s7
	ret

DESTROY_BLOCK_RIGHT:

	li t2, 4
	mv s4, a0
	sb t2, 0(a0)
	la a0, esp_dir
	call PRINT
	xori a3, a3, 1
	call PRINT
	li t2, 1
	sb t2, 0(s4)
	la a0, CURRENT_LEVEL
	lb a0, 0(a0)
	li a1, 2
	bne a0, a1, NO_NEW_TILE_RIGHT
	li a1, 7
	sb a1, 0(s4)

NO_NEW_TILE_RIGHT:
	li a7, 42
	li a1, 101
	ecall
	li t2, 90
	ble a0, t2, TRY_SPEED_RIGHT
	li t2, 22	
	sb t2, 0(s4) 
	j END_EXPLOSION_RIGHT

TRY_SPEED_RIGHT:

	la t4, CHAR_SPEED
	lw t5, 8(t4)
	bne zero, t5, END_EXPLOSION_RIGHT
	li a7, 42
	li a1, 101
	ecall

	li t2, 98
	ble a0, t2, END_EXPLOSION_RIGHT
	li t2, 23
	sb t2, 0(s4)
	j END_EXPLOSION_RIGHT


CHECK_EXPLOSION_LEFT:

	la a0, MAPA
	lw a0, 0(a0)
	li t3, 32
	li t4, 20

	div t1, a1, t3
	div t2, a2, t3

	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 8
	add a0, a0, t1

	lb t1, 0(a0)
	beq t1, zero, END_EXPLOSION_LEFT
	li t2, 3
	beq t1, t2, DESTROY_BLOCK_LEFT
	li t2, 4
	beq t1, t2, DESTROY_BLOCK_LEFT
	li t2, 8
	beq t1, t2, DESTROY_BLOCK_LEFT

	la a0, sprite_esp_esq
	mv ra, s7
	ret

DESTROY_BLOCK_LEFT:

	li t2, 4
	mv s4, a0
	sb t2, 0(a0)
	la a0, explosao
	call PRINT
	xori a3, a3, 1
	call PRINT
	li t2, 1
	sb t2, 0(s4)
	la a0, CURRENT_LEVEL
	lb a0, 0(a0)
	li a1, 2
	bne a0, a1, NO_NEW_TILE_LEFT
	li a1, 7
	sb a1, 0(s4)

NO_NEW_TILE_LEFT:

	li a7, 42
	li a1, 101
	ecall
	li t2, 90
	ble a0, t2, TRY_SPEED_LEFT
	li t2, 22	
	sb t2, 0(s4) 
	j END_EXPLOSION_LEFT

TRY_SPEED_LEFT:

	la t4, CHAR_SPEED
	lw t5, 8(t4)
	bne zero, t5, END_EXPLOSION_LEFT
	li a7, 42
	li a1, 101
	ecall

	li t2, 98
	ble a0, t2, END_EXPLOSION_LEFT
	li t2, 23
	sb t2, 0(s4)
	j END_EXPLOSION_LEFT

CHECK_EXPLOSION_UP:

	la a0, MAPA
	lw a0, 0(a0)
	li t3, 32
	li t4, 20

	div t1, a1, t3
	div t2, a2, t3

	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 8
	add a0, a0, t1

	lb t1, 0(a0)
	beq t1, zero, END_EXPLOSION_UP
	li t2, 3
	beq t1, t2, DESTROY_BLOCK_UP
	li t2, 4
	beq t1, t2, DESTROY_BLOCK_UP
	li t2, 8
	beq t1, t2, DESTROY_BLOCK_UP

	la a0, sprite_esp_cim
	mv ra, s7
	ret

DESTROY_BLOCK_UP:

	li t2, 4
	sb t2, 0(a0)
	mv s4, a0
	la a0, explosao
	call PRINT
	xori a3, a3, 1
	call PRINT
	li t2, 1
	sb t2, 0(s4)
	la a0, CURRENT_LEVEL
	lb a0, 0(a0)
	li a1, 2
	bne a0, a1, NO_NEW_TILE_UP
	li a1, 7
	sb a1, 0(s4)

NO_NEW_TILE_UP:
	li a7, 42
	li a1, 101
	ecall
	li t2, 90
	ble a0, t2, TRY_SPEED_UP
	li t2, 22	
	sb t2, 0(s4) 
	j END_EXPLOSION_UP

TRY_SPEED_UP:

	la t4, CHAR_SPEED
	lw t5, 8(t4)
	bne zero, t5, END_EXPLOSION_UP
	li a7, 42
	li a1, 101
	ecall

	li t2, 98
	ble a0, t2, END_EXPLOSION_UP
	li t2, 23
	sb t2, 0(s4)
	j END_EXPLOSION_UP


CHECK_EXPLOSION_DOWN:

	la a0, MAPA
	lw a0, 0(a0)
	li t3, 32
	li t4, 20

	div t1, a1, t3
	div t2, a2, t3

	mul t2, t2, t4
	add t1, t1, t2

	addi a0, a0, 8
	add a0, a0, t1

	lb t1, 0(a0)
	beq t1, zero, END_EXPLOSION_DOWN
	li t2, 3
	beq t1, t2, DESTROY_BLOCK_DOWN
	li t2, 4
	beq t1, t2, DESTROY_BLOCK_DOWN
	li t2, 8
	beq t1, t2, DESTROY_BLOCK_DOWN

	la a0, sprite_esp_baixo
	mv ra, s7
	ret

DESTROY_BLOCK_DOWN:

	li t2, 4
	sb t2, 0(a0)
	mv s4, a0
	la a0, explosao
	call PRINT
	xori a3, a3, 1
	call PRINT
	li t2, 1
	sb t2, 0(s4)
	la a0, CURRENT_LEVEL
	lb a0, 0(a0)
	li a1, 2
	bne a0, a1, NO_NEW_TILE_DOWN
	li a1, 7
	sb a1, 0(s4)

NO_NEW_TILE_DOWN:

	li a7, 42
	li a1, 101
	ecall
	li t2, 90
	ble a0, t2, TRY_SPEED_DOWN
	li t2, 22	
	sb t2, 0(s4) 
	j END_EXPLOSION_DOWN

TRY_SPEED_DOWN:

	la t4, CHAR_SPEED
	lw t5, 8(t4)
	bne zero, t5, END_EXPLOSION_DOWN
	li a7, 42
	li a1, 101
	ecall

	li t2, 98
	ble a0, t2, END_EXPLOSION_DOWN
	li t2, 23
	sb t2, 0(s4)
	j END_EXPLOSION_DOWN

CHECK_DAMAGE:

	la t0, CHAR_POS
	lh t1, 0(t0)
	lh t2, 2(t0)

	li t3, 32
	rem t3, t1, t3

	beq t3, zero, FIX_Y_CHAR
	li t4, 16
	bgt t3, t4, ADD_OFFSET_X_CHAR
	ble t3, t4, SUB_OFFSET_X_CHAR

FIX_Y_CHAR:

	li t3, 32
	rem t3, t2, t3

	beq t3, zero, CHECK_COORDS_X
	li t4, 16
	bge t3, t4, ADD_OFFSET_Y_CHAR
	blt t3, t4, SUB_OFFSET_Y_CHAR

ADD_OFFSET_X_CHAR:

	li t4, 32
	sub t6, t4, t3
	add t1, t1, t6
	j FIX_Y_CHAR

SUB_OFFSET_X_CHAR:

	sub t1, t1, t3
	j FIX_Y_CHAR

ADD_OFFSET_Y_CHAR:

	li t4, 32
	sub t6, t4, t3
	add t2, t2, t6
	j CHECK_COORDS_X

SUB_OFFSET_Y_CHAR:

	sub t2, t2, t3
	j CHECK_COORDS_X

CHECK_COORDS_X:

	beq t1, a1, CHECK_COORDS_Y
	mv ra, s7
	ret

CHECK_COORDS_Y:

	beq t2, a2, KILL_CHAR
	mv ra, s7
	ret

KILL_CHAR:

	la t0, CHAR_LIVES
	lb t1, 0(t0)
	addi t1, t1, -1
	li a7, 32
	li a0, 2000
	ecall
	sb t1, 0(t0)
	la a0, MAPA
	lw a0, 0(a0)
	addi a0, a0, 308
	add a0, a0, t1
	li a1, 5
	sb a1, 11(a0)
	addi a0, a0, 616
	sb a1, 11(a0)
	la a0, CURRENT_LEVEL
	lb a1, 0(a0)
	li a2, 1
	bne a1, a2, SET_LEVEL_2
	j SET_LEVEL_1

CHECK_ENEMY_RIGHT:

	la a0, MAPA
	lw a0, 0(a0)
	addi t1, t1, 32
	li t3, 32
	li t4, 20

	div t1, t1, t3
	div t2, t2, t3

	mul t2, t2, t4
	add t1, t1, t2

	add a0, a0, t1
	addi a0, a0, 8

	lb t1, 0(a0)

	beq t1, zero, CHANGE_ORIENTATION_RIGHT_UP
	li t2, 2
	beq t1, t2, CHANGE_ORIENTATION_RIGHT_UP
	li t2, 3
	beq t1, t2, CHANGE_ORIENTATION_RIGHT_UP
	li t2, 8
	beq t1, t2, CHANGE_ORIENTATION_RIGHT_UP
	j WALK_ENEMY_RIGHT

CHANGE_ORIENTATION_RIGHT_UP:

	mv a0, s11
	lw a1, 20(a0)
	bne a1, zero, RANDOMIZE_ORIENTATION
	lw a1, 12(a0)
	addi a1, a1, 1
	sw a1, 12(a0)
	la a1, sprite_facehugger_cima
	sw a1, 28(a0)

	li a7, 30
	ecall
	mv a1, s11
	lw a0, 24(a1)

	j RETURN_ENEMY_RIGHT

CHECK_ENEMY_UP:

	la a0, MAPA
	lw a0, 0(a0)
	addi t2, t2, -1
	li t3, 32
	li t4, 20

	div t1, t1, t3
	div t2, t2, t3

	mul t2, t2, t4
	add t1, t1, t2

	add a0, a0, t1
	addi a0, a0, 8

	lb t1, 0(a0)

	beq t1, zero, CHANGE_ORIENTATION_UP_LEFT
	li t2, 2
	beq t1, t2, CHANGE_ORIENTATION_UP_LEFT
	li t2, 3
	beq t1, t2, CHANGE_ORIENTATION_UP_LEFT
	li t2, 8
	beq t1, t2, CHANGE_ORIENTATION_UP_LEFT
	j WALK_ENEMY_UP

CHANGE_ORIENTATION_UP_LEFT:

	mv a0, s11
	lw a1, 20(a0)
	bne a1, zero, RANDOMIZE_ORIENTATION
	lw a1, 12(a0)
	addi a1, a1, 1
	sw a1, 12(a0)
	la a1, sprite_facehugger_esq
	sw a1, 28(a0)

	li a7, 30
	ecall
	mv a1, s11
	lw a0, 24(a1)

	j RETURN_ENEMY_UP

CHECK_ENEMY_LEFT:

	la a0, MAPA
	lw a0, 0(a0)
	addi t1, t1, -2
	li t3, 32
	li t4, 20

	div t1, t1, t3
	div t2, t2, t3

	mul t2, t2, t4
	add t1, t1, t2

	add a0, a0, t1
	addi a0, a0, 8

	lb t1, 0(a0)

	beq t1, zero, CHANGE_ORIENTATION_LEFT_DOWN
	li t2, 2
	beq t1, t2, CHANGE_ORIENTATION_LEFT_DOWN
	li t2, 3
	beq t1, t2, CHANGE_ORIENTATION_LEFT_DOWN
	li t2, 8
	beq t1, t2, CHANGE_ORIENTATION_LEFT_DOWN
	j WALK_ENEMY_LEFT

CHANGE_ORIENTATION_LEFT_DOWN:

	mv a0, s11
	lw a1, 20(a0)
	bne a1, zero, RANDOMIZE_ORIENTATION
	lw a1, 12(a0)
	addi a1, a1, 1
	sw a1, 12(a0)
	la a1, sprite_facehugger_baixo
	sw a1, 28(a0)

	li a7, 30
	ecall
	mv a1, s11
	lw a0, 24(a1)

	j RETURN_ENEMY_LEFT

CHECK_ENEMY_DOWN:

	la a0, MAPA
	lw a0, 0(a0)
	addi t2, t2, 32
	li t3, 32
	li t4, 20

	div t1, t1, t3
	div t2, t2, t3

	mul t2, t2, t4
	add t1, t1, t2

	add a0, a0, t1
	addi a0, a0, 8

	lb t1, 0(a0)

	beq t1, zero, RESTART_ORIENTATION
	li t2, 2
	beq t1, t2, RESTART_ORIENTATION
	li t2, 3
	beq t1, t2, RESTART_ORIENTATION
	li t2, 8
	beq t1, t2, RESTART_ORIENTATION
	j WALK_ENEMY_DOWN

RESTART_ORIENTATION:

	mv a0, s11
	lw a1, 20(a0)
	bne a1, zero, RANDOMIZE_ORIENTATION
	sw zero, 12(a0)
	la a1, sprite_facehugger_dir
	sw a1, 28(a0)

	li a7, 30
	ecall
	mv a1, s11
	lw a0, 24(a1)
	
	j UPDATE_ENEMY_EXIT

RANDOMIZE_ORIENTATION:

	mv a0, s11
	lw a1, 20(a0)
	beq a1, zero, UPDATE_ENEMY_EXIT

	li a7, 42
	li a0, 0
	li a1, 4
	ecall

	mv a1, s11
	sw a0, 12(a1)

	mv a0, s11
	jal s9, SELECT_SPRITE_CHESTBUSTTER
	sw a1, 28(a0)

	j UPDATE_ENEMY_EXIT

CHECK_ENEMY_DAMAGE:

	lh t1, 4(t0)
	lh t2, 8(t0)

	li t3, 32
	rem t3, t1, t3

	beq t3, zero, FIX_Y_ENEMY
	li t4, 16
	bgt t3, t4, ADD_OFFSET_X_ENEMY
	ble t3, t4, SUB_OFFSET_X_ENEMY

FIX_Y_ENEMY:

	li t3, 32
	rem t3, t2, t3

	beq t3, zero, CHECK_COORDS_X_ENEMY
	li t4, 16
	bge t3, t4, ADD_OFFSET_Y_ENEMY
	blt t3, t4, SUB_OFFSET_Y_ENEMY

ADD_OFFSET_X_ENEMY:

	li t4, 32
	sub t6, t4, t3
	add t1, t1, t6
	j FIX_Y_ENEMY

SUB_OFFSET_X_ENEMY:

	sub t1, t1, t3
	j FIX_Y_ENEMY

ADD_OFFSET_Y_ENEMY:

	li t4, 32
	sub t6, t4, t3
	add t2, t2, t6
	j CHECK_COORDS_X_ENEMY

SUB_OFFSET_Y_ENEMY:

	sub t2, t2, t3
	j CHECK_COORDS_X_ENEMY

CHECK_COORDS_X_ENEMY:

	beq t1, a1, CHECK_COORDS_Y_ENEMY
	mv ra, s7
	ret

CHECK_COORDS_Y_ENEMY:

	beq t2, a2, KILL_ENEMY
	mv ra, s7
	ret

KILL_ENEMY:


	lw t1, 0(t0)
	bne t1, zero, CONTINUE_KILL
	mv ra, s7
	ret

CONTINUE_KILL:
	sw zero, 0(t0)
	la t0, PLAYER_SCORE
	lb t1, 2(t0)
	addi t1, t1, 1
	li t2, 10
	blt t1, t2, CONTINUE_HUD
	addi t1, t1, -10
	lb t2, 1(t0)
	sb t1, 2(t0)
	addi t2, t2, 1
	sb t2, 1(t0)

CONTINUE_HUD:

	sb t1, 2(t0)
	mv ra, s7
	ret

CHECK_DAMAGE_1: # a1 = x enemy // a2 = y

	la t0, CHAR_POS
	lh t3, 0(t0)
	lh t4, 2(t0)
	addi t5, t1, -16
	addi t6, t1, 16

CHECK_COORDS_X_1:

	bge t3, t5, CHECK_COORDS_X_2
	ret

CHECK_COORDS_X_2:

	ble t3, t6, CHECK_COORDS_Y_1
	ret

CHECK_COORDS_Y_1:

	addi t5, t2, -16
	addi t6, t2, 16
	bge t4, t5, CHECK_COORDS_Y_2
	ret	

CHECK_COORDS_Y_2:

	ble t4, t6, KILL_CHAR
	ret













	
	