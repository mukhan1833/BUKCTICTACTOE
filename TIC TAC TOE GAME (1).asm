
# CAO GROUP PORJECT
# MEMBER LIST:
# MUHAMMAD USMAN KHAN 02-131192-061
# MUHAMMAD HASSAM 02-131192-019
# MUSTAFA HUSSAIN 02-131192-004
# MUHAMMAD AAKIF AIJAZ 02-131192-007


######COMPUTER ARCHITECTURE AND ORGANIZATION LAB PROJECT###########
###################################################################
.data

des: .asciiz "****************************************\n"
TICTACTOE:.asciiz "\t\tTIC TAC TOE\n"
name: .asciiz "ENTER YOUR NAME: "
p1name:.asciiz "PLAYER 1, ENTER YOUR NAME: "
p2name:.asciiz "PLAYER 2, ENTER YOUR NAME: "
INPUT: .space 20
INPUT2: .space 20
input: .space 20
intro: .asciiz "ENTER THE NUMBER OF GAMES YOU WANT TO PLAY:\n "
invintro: .asciiz "YOU HAVE ENTERED WRONG NUMBER OF MATCHES:\n "
again: .asciiz"DO YOU WANT TO PLAY MORE MATCHES:\n\tPRESS 1 FOR YES\n\tPRESS 0 TO QUIT\n"
choice: .asciiz "DO YOU WANT TO PLAY WITH PLAYER OR COMPUTER? \n\1)PRESS 0 FOR PLAYER\n2)PRESS 1 FOR COMPUTER\n"
GAMENUMBER: .asciiz "\tGAME # "
nl: .asciiz "\n"
col: .asciiz ":"
line: .asciiz ""
design: .asciiz "\t|_|" 
player: .asciiz "\t|X|"
computer: .asciiz "\t|+|"
p1turn: .asciiz "ENTER VALUE FROM ( 1-9):  "
p2turn: .asciiz "ENTER VALUE FROM ( 1-9):  "
turn: .asciiz "ENTER VALUE FROM ( 1-9):\n "
invturn: .asciiz "\tINVALID VALUE IS ENTERED!\n"
fill: .asciiz "\tTHE CELL IS ALREADY FILLED!\n"
tie: .asciiz "\t\tTIE!\n"
X_WINS: .asciiz "\tWINNER IS "
O_WINS: .asciiz "\tWINNER IS COMPUTER\n"
RESULT: .asciiz "\tRESULT: "
dash: .asciiz "-"  
board: .byte 1,1,0,2,1,2,0,0,1
row_preferences: .space 8 
row_preference_state_lookup_table: .byte 1, 3, 2, 5, 6, 5, 5, 4, 5, 7, 5, 5
cell_to_rows: .byte 0, 3, 6, 8,    0, 4, 8, 8,    0, 5, 7, 8,
                    1, 3, 8, 8,    1, 4, 6, 7,    1, 5, 8, 8,
                    2, 3, 7, 8,    2, 4, 8, 8,    2, 5, 6, 8
row_to_cells: .byte 0, 1, 2,    3, 4, 5,    6, 7, 8,    0, 3, 6,    1, 4, 7,    2, 5, 8,    0, 4, 8,    2, 4, 6

.text
main:

la $a0, des
li $v0, 4
syscall

la $a0, TICTACTOE
li $v0, 4
syscall

la $a0, des
li $v0, 4
syscall

CHOICE:
li $v0, 4
la $a0, choice
syscall

li $v0,5
syscall


beq $v0,0,PLAYER
beq $v0,1,COMPUTER

COMPUTER:
la $a0, name
li $v0, 4
syscall

li $v0,8
la $a0,input
li $a1,20
syscall

la $a0, des
li $v0, 4
syscall

b computergame
CONTINUE:	
la $a0, des
li $v0, 4
syscall

li $v0, 4
la $a0, again
syscall

li $v0,5
syscall

beq $v0,1,CHOICE
beq $v0,0,exit

computergame:
computergame_enter_number:
la $a0, intro
li $v0, 4
syscall
li $v0, 5
syscall
blt $v0, 1, computerinput_invalid_amount 
nop
move $s0, $v0
j computergame_matches
nop
computerinput_invalid_amount:
la $a0, invintro
li $v0, 4
syscall
j  computergame_enter_number
nop
computergame_matches:

li $s1, 0

li $s2, 0

li $s3, 0
computergame_match:

beq $s1, $s0, computergame_print_scores

la $a0, GAMENUMBER
li $v0, 4
syscall

add $a0, $s1, 1
li $v0, 1
syscall

la $a0, col
li $v0, 4
syscall

la $a0, nl
li $v0, 4
syscall

addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
jal computermatch
nop
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
addi $sp, $sp, 20
addi $s1, $s1, 1
add $s2, $s2, $v0
add $s3, $s3, $v1
or $t1, $v0, $v1
beqz $t1, computergame_match_result_tie
nop

beqz $v0, computergame_match_result_o_won
nop
computergame_match_result_x_won:

la $a0, X_WINS
li $v0, 4
syscall

li $v0, 4
la $a0, input
syscall


j computergame_match
nop

computergame_match_result_o_won:
la $a0, O_WINS
li $v0, 4
syscall
j computergame_match
nop
computergame_match_result_tie:
la $a0, tie
li $v0, 4
syscall
j computergame_match
nop
computergame_print_scores:

la $a0, des
li $v0, 4
syscall

la $a0, RESULT
li $v0, 4
syscall

move $a0, $s2
li $v0, 1
syscall

la $a0, dash
li $v0, 4
syscall

move $a0, $s3
li $v0, 1
syscall

la $a0, nl
li $v0, 4
syscall

la $a0, des
li $v0, 4
syscall

la $a0, nl
li $v0, 4
syscall
b CONTINUE
computergame_return:
jr $ra
nop

computermatch:
addi $sp, $sp, -4

sw $ra, 0($sp)

li $t0, 0

li $t1, 0
computermatch_clear_board:

beq $t0, 9, computermatch_clear_preferences
nop
sb $zero, board($t0)
addi $t0, $t0, 1
j computermatch_clear_board
nop
computermatch_clear_preferences:

beq $t1, 8, computermatch_preturn
nop
sb $zero, row_preferences($t1)
addi $t1, $t1, 1
j computermatch_clear_preferences
nop
computermatch_preturn:

li $s0, 0
computermatch_turn:
addi $sp, $sp, -4

sw $s0, 0($sp)
jal board_print
nop

jal computerplayer_move
nop

li $t0, 1
sb $t0, board($v0)

move $a0, $v0

li $a1, 0
jal computerupdate_row_preference_state
nop
beq $v0, 1, computermatch_turn_x_win
nop
lw $s0, 0($sp)
addi $sp, $sp, 4

beq $s0, 8, computermatch_turn_tie
nop

addi $s0, $s0, 1
addi $sp, $sp, -4

sw $s0, 0($sp)

jal ai_move
nop

li $t0, 2
sb $t0, board($v0)

move $a0, $v0
li $a1, 1
jal computerupdate_row_preference_state
nop
beq $v0, 1, computermatch_turn_o_win
nop
lw $s0, 0($sp)
addi $sp, $sp, 4

addi $s0, $s0, 1
j computermatch_turn
nop
computermatch_turn_tie:

jal board_print
nop
li $v0, 0
li $v1, 0
j computermatch_return
nop
computermatch_turn_x_win:

addi $sp, $sp, 4

jal board_print
nop
li $v0, 1
li $v1, 0
j computermatch_return
nop
computermatch_turn_o_win:

addi $sp, $sp, 4

jal board_print
nop
li $v0, 0
li $v1, 1
computermatch_return:
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
nop


computerupdate_row_preference_state:
mul $t0, $a0, 4

li $t1, 0

li $v0, 0
computerupdate_row_preference_state_get_row:

beq $t1, 4, computerupdate_row_preference_state_return
nop

add $t2, $t0, $t1

lb $t3, cell_to_rows($t2)

bne $t3, 8, computerupdate_row_preference_state_update
nop

addi $t1, $t1, 1
j computerupdate_row_preference_state_get_row
nop
computerupdate_row_preference_state_update:

addi $t1, $t1, 1

lb $t4, row_preferences($t3)
mul $t4, $t4, 2

add $t4, $t4, $a1

lb $t5, row_preference_state_lookup_table($t4)

sb $t5, row_preferences($t3)

bge $t5, 6, computerupdate_row_preference_state_update_win_occured
nop
j computerupdate_row_preference_state_get_row
nop

computerupdate_row_preference_state_update_win_occured:

li $v0, 1
j computerupdate_row_preference_state_get_row
nop

computerupdate_row_preference_state_return:
jr $ra
nop

computerplayer_move:

computerplayer_move_enter_number:

la $a0, turn
li $v0, 4
syscall

li $v0, 5
syscall

blt $v0, 1, computerplayer_move_invalid_index
nop

bgt $v0, 9, computerplayer_move_invalid_index
nop

addi $v0, $v0, -1
lb $t0, board($v0)

bnez $t0, computerplayer_move_cell_occupied
nop

j computerplayer_move_return
nop

computerplayer_move_cell_occupied:

la $a0,fill
li $v0, 4
syscall

j computerplayer_move_enter_number
nop

computerplayer_move_invalid_index:

la $a0, invturn
li $v0, 4
syscall

j computerplayer_move_enter_number
nop

computerplayer_move_return:
jr $ra
nop

ai_move:

ai_move_attack:
li $t0, 0

ai_move_attack_loop:
beq $t0, 8, ai_move_defend
nop

lb $t1, row_preferences($t0)

beq $t1, 4, ai_move_lethal_found
nop

addiu $t0, $t0, 1
j ai_move_attack_loop
nop

ai_move_defend:
li $t0, 0

ai_move_defend_loop:
beq $t0, 8, random_cell
nop
lb $t1, row_preferences($t0)
beq $t1, 2, ai_move_lethal_found
nop
addiu $t0, $t0, 1
j ai_move_defend_loop
nop

ai_move_lethal_found:
mul $t0, $t0, 3
lb $v0, row_to_cells+0($t0)
lb $t2, board($v0)
beqz $t2, ai_move_return
nop

lb $v0, row_to_cells+1($t0)
lb $t2, board($v0)
beqz $t2, ai_move_return
nop

lb $v0, row_to_cells+2($t0)
lb $t2, board($v0)
beqz $t2, ai_move_return
nop

random_cell:
li $a0, 0
li $a1, 8
li $v0, 42
syscall

lb $t0, board($a0)
bnez $t0, random_cell
nop
move $v0, $a0

ai_move_return:
jr $ra
nop

board_print:
li $t0, 0

board_print_collumn:
li $t1, 0
beq $t0, 9, board_print_end

board_print_row:

lbu $t2, board($t0)
beq $t2, 1, board_print_x
nop

beq $t2, 2, board_print_o
nop

board_print_space:
li $v0, 4
la $a0, design
syscall

j board_print_skip
nop

board_print_x:
li $v0, 4
la $a0, player
syscall

j board_print_skip
nop

board_print_o:
li $v0, 4
la $a0, computer
syscall

board_print_skip:
addiu $t0, $t0, 1
addiu $t1, $t1, 1
blt $t1, 3, board_print_newline_skip
nop

li $v0, 4
la $a0, nl
syscall

j board_print_collumn
nop

board_print_newline_skip:
j board_print_row
nop

board_print_end:
jr $ra
nop
b exit


PLAYER:
la $a0, p1name
li $v0, 4
syscall

li $v0,8
la $a0,INPUT
li $a1,20
syscall


la $a0, p2name
li $v0, 4
syscall

li $v0,8
la $a0,INPUT2
li $a1,20
syscall

la $a0, des
li $v0, 4
syscall

b game
game:
game_enter_number:
la $a0, intro
li $v0, 4
syscall
li $v0, 5
syscall
blt $v0, 1, input_invalid_amount 
nop
move $s0, $v0
j game_matches
nop
input_invalid_amount:
la $a0, invintro
li $v0, 4
syscall
j game_enter_number
nop
game_matches:

li $s1, 0

li $s2, 0

li $s3, 0
game_match:

beq $s1, $s0, game_print_scores

la $a0, GAMENUMBER
li $v0, 4
syscall

add $a0, $s1, 1
li $v0, 1
syscall

la $a0, col
li $v0, 4
syscall

la $a0, nl
li $v0, 4
syscall

addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
jal match
nop
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
addi $sp, $sp, 20
addi $s1, $s1, 1
add $s2, $s2, $v0
add $s3, $s3, $v1
or $t1, $v0, $v1
beqz $t1, game_match_result_tie
nop

beqz $v0, game_match_result_o_won
nop
game_match_result_x_won:
la $a0, X_WINS
li $v0, 4
syscall

li $v0, 4
la $a0, INPUT
syscall


j game_match
nop

game_match_result_o_won:
la $a0, X_WINS
li $v0, 4
syscall

li $v0, 4
la $a0, INPUT2
syscall
j game_match
nop
game_match_result_tie:
la $a0, tie
li $v0, 4
syscall
j game_match
nop
game_print_scores:

la $a0, des
li $v0, 4
syscall

la $a0, RESULT
li $v0, 4
syscall

move $a0, $s2
li $v0, 1
syscall

la $a0, dash
li $v0, 4
syscall

move $a0, $s3
li $v0, 1
syscall

la $a0, nl
li $v0, 4
syscall

la $a0, des
li $v0, 4
syscall

la $a0, nl
li $v0, 4
syscall
b CONTINUE
game_return:
jr $ra
nop

match:
addi $sp, $sp, -4

sw $ra, 0($sp)

li $t0, 0

li $t1, 0
match_clear_board:

beq $t0, 9, match_clear_preferences
nop
sb $zero, board($t0)
addi $t0, $t0, 1
j match_clear_board
nop
match_clear_preferences:

beq $t1, 8, match_preturn
nop
sb $zero, row_preferences($t1)
addi $t1, $t1, 1
j match_clear_preferences
nop
match_preturn:

li $s0, 0
match_turn:
addi $sp, $sp, -4

sw $s0, 0($sp)
jal board_print
nop

jal player_move
nop

li $t0, 1
sb $t0, board($v0)

move $a0, $v0

li $a1, 0
jal update_row_preference_state
nop
beq $v0, 1, match_turn_x_win
nop
lw $s0, 0($sp)
addi $sp, $sp, 4

beq $s0, 8, match_turn_tie
nop

addi $s0, $s0, 1
addi $sp, $sp, -4

sw $s0, 0($sp)

jal secondplayer_move
nop

li $t0, 2
sb $t0, board($v0)

move $a0, $v0
li $a1, 1
jal update_row_preference_state
nop
beq $v0, 1, match_turn_o_win
nop
lw $s0, 0($sp)
addi $sp, $sp, 4

addi $s0, $s0, 1
j match_turn
nop
match_turn_tie:

jal board_print
nop
li $v0, 0
li $v1, 0
j match_return
nop
match_turn_x_win:

addi $sp, $sp, 4

jal board_print
nop
li $v0, 1
li $v1, 0
j match_return
nop
match_turn_o_win:

addi $sp, $sp, 4

jal board_print
nop
li $v0, 0
li $v1, 1
match_return:
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
nop


update_row_preference_state:
mul $t0, $a0, 4

li $t1, 0

li $v0, 0
update_row_preference_state_get_row:

beq $t1, 4, update_row_preference_state_return
nop

add $t2, $t0, $t1

lb $t3, cell_to_rows($t2)

bne $t3, 8, update_row_preference_state_update
nop

addi $t1, $t1, 1
j update_row_preference_state_get_row
nop
update_row_preference_state_update:

addi $t1, $t1, 1

lb $t4, row_preferences($t3)
mul $t4, $t4, 2

add $t4, $t4, $a1

lb $t5, row_preference_state_lookup_table($t4)

sb $t5, row_preferences($t3)

bge $t5, 6, update_row_preference_state_update_win_occured
nop
j update_row_preference_state_get_row
nop

update_row_preference_state_update_win_occured:

li $v0, 1
j update_row_preference_state_get_row
nop

update_row_preference_state_return:
jr $ra
nop

player_move:

player_move_enter_number:

la $a0, p1turn
li $v0, 4
syscall

la $a0, INPUT
li $v0, 4
syscall

li $v0, 5
syscall

blt $v0, 1, player_move_invalid_index
nop

bgt $v0, 9, player_move_invalid_index
nop

addi $v0, $v0, -1
lb $t0, board($v0)

bnez $t0, player_move_cell_occupied
nop

j player_move_return
nop

player_move_cell_occupied:

la $a0,fill
li $v0, 4
syscall

j player_move_enter_number
nop

player_move_invalid_index:

la $a0, invturn
li $v0, 4
syscall

j player_move_enter_number
nop

player_move_return:
jr $ra
nop

secondplayer_move:

secondplayer_move_enter_number:

la $a0, p2turn
li $v0, 4
syscall

la $a0, INPUT2
li $v0, 4
syscall

li $v0, 5
syscall

blt $v0, 1, secondplayer_move_invalid_index
nop

bgt $v0, 9, secondplayer_move_invalid_index
nop

addi $v0, $v0, -1
lb $t0, board($v0)

bnez $t0, secondplayer_move_cell_occupied
nop

j secondplayer_move_return
nop

secondplayer_move_cell_occupied:

la $a0,fill
li $v0, 4
syscall

j secondplayer_move_enter_number
nop

secondplayer_move_invalid_index:

la $a0, invturn
li $v0, 4
syscall

j secondplayer_move_enter_number
nop

secondplayer_move_return:
jr $ra
nop

exit:
li $v0,10
syscall

