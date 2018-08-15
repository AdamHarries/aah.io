/*Provided as is, no license, please steal this. Written by Adam Harries.*/
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
enum {
	PARSE_SUCCESS,
	UNMATCHED_PAREN,
	UNKNOWN_PARSE_FAIL
};
enum
{
	MATCH_FORWARD = 1,
	MATCH_BACKWARD = -1
};
char* mem;
int mem_size; int data_ptr = 0;
char* prog;
int prog_size; int ins_ptr = 0;
int match_paren(int direction)
{
	int stack = 0;
	while(1)
	{
		if(ins_ptr > prog_size || prog[ins_ptr] == '\0')
			return UNMATCHED_PAREN;
		if(prog[ins_ptr] == '[')
			stack++;
		if(prog[ins_ptr] == ']')
			stack--;
		if(stack==0)
			return PARSE_SUCCESS;
		ins_ptr+=direction;
	}
	return UNKNOWN_PARSE_FAIL;
}
int main(int argc, char** argv)
{
	mem_size = 64;
	mem = malloc(mem_size*sizeof(char));
	for(int i = 0;i<mem_size;i++)
		mem[i] = 0;
	prog = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.";
	prog_size = strlen(prog);
	while(1){
		int e=0; int old_is = ins_ptr;
		switch(prog[ins_ptr]){
			case '>': data_ptr++; break;
			case '<': data_ptr--; break;
			case '+': mem[data_ptr]++; break;
			case '-': mem[data_ptr]--; break;
			case '.': printf("%c", mem[data_ptr]); break;
			case ',': scanf("%c", &mem[data_ptr]); break;
			case '[': if(mem[data_ptr] == 0){ e=match_paren(MATCH_FORWARD); } break;
			case ']': if(mem[data_ptr] != 0){ e=match_paren(MATCH_BACKWARD); } break;
			default: ins_ptr--;	break;
		}
		ins_ptr++;
		if(ins_ptr>=prog_size|| ins_ptr<0){
			printf("\nComputation complete.\n"); break;
		}
		if(data_ptr>=mem_size || data_ptr<0){
			printf("\nData pointer out of range, aborting.\n"); break;
		}
		if(e==UNMATCHED_PAREN){
			printf("\nUnmatched parenthesis, at %d\n", old_is); break;
		}
		if(e==UNKNOWN_PARSE_FAIL){
			printf("\nParenthesis matching failed for unknown reason.\n"); break;
		}
	}
	free(mem);
	return 0;
}