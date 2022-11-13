#include <stdio.h>
#include <stdlib.h>

char *get_string(int *length, int *flag) {
    *length = 0;
    *flag = 0;
    int size = 1;
    char *s = (char*) malloc(sizeof(char)); 
    char c = getchar();
    if(c > 127){
      (*flag)++;
    }  
    while (c != '\n') {
        s[(*length)++] = c;
        if (*length >= size) {
            size *= 2;
            s = (char*) realloc(s, size * sizeof(char));
        }

        c = getchar();
	if(c > 127){
          (*flag)++;
        }          
    }
    s[*length] = '\0';
    return s; 
}

int main() {
    int length, flag;
    int a = 0;
    int A = 0;
    char *s = get_string(&length, &flag);
    if(flag == 0){
      for(int i = 0; i < length;i++){
        if((s[i] >= 65) && (s[i] <= 90)){
          A++;
        }
        else if((s[i] >= 97) && (s[i] <= 122)){
          a++;
        }
      }
      printf("lowercase: %d \nuppercase %d\n", a, A);
      return 0; 
    }
    else{
      printf("incorrect input");
      return 0;
    }
    free(s); 
    return 0;
}