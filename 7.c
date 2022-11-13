#include <stdio.h>
#include <stdlib.h>

char *get_string(FILE *input, int *length, int *flag) {
    *length = 0;
    *flag = 0;
    int size = 1;
    char *s = (char*) malloc(sizeof(char));
    char c = fgetc(input);
    if(c > 127){
      (*flag)++;
    }
    while (c != EOF) {
        s[(*length)++] = c;
        if (*length >= size) {
            size *= 2;
            s = (char*) realloc(s, size * sizeof(char));
        }

        c = fgetc(input);
	if(c > 127){
          (*flag)++;
        }
    }
    s[*length] = '\0';
    return s;
}
void counter(char *st, int length, int *a, int *A){
    for(int i = 0; i < length;i++){
        if((st[i] >= 65) && (st[i] <= 90)){
            (*A)++;
        }
        else if((st[i] >= 97) && (st[i] <= 122)){
            (*a)++;
        }
    }
}
int main(int argc, char * argv[]) {
  if (argc != 3){
	  printf("incorrect input\n");
	  return 0;
  }
  FILE *input = fopen(argv[1], "r");
  FILE *out = fopen(argv[2], "w");
  if ((input == NULL) || (out == NULL)){
	  printf("incorrect file\n");
	  return 0;
  }
  int len, test; 
  int a = 0;
  int A = 0;
  char *s = get_string(input, &len, &test); 
  if(test == 0){
      counter(s, len, &a, &A);
      fprintf(out, "lowercase: %d \nuppercase %d\n", a, A);
      free(s); 
      fclose(input);
      fclose(out);
      return 0; 
  }
  else{
      fprintf(out, "incorrect input");
      free(s); 
      fclose(input);
      fclose(out);
      return 0;
  } 
}