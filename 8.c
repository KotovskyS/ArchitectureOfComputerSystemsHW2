#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

char *get_string(FILE *input, int *length, int *flag) {
    *length = 0;
    *flag = 0;
    int size = 1;
    char *s = (char *) malloc(sizeof(char));
    char c = fgetc(input);
    if (c > 127) {
        (*flag)++;
    }
    while (c != EOF) {
        s[(*length)++] = c;
        if (*length >= size) {
            size *= 2;
            s = (char *) realloc(s, size * sizeof(char));
        }

        c = fgetc(input);
        if (c > 127) {
            (*flag)++;
        }
    }
    s[*length] = '\0';
    return s;
}

char *get_string2(int *length, int *flag) {
    *length = 0;
    *flag = 0;
    int size = 1;
    char *s = (char *) malloc(sizeof(char));
    char c = getchar();
    if (c > 127) {
        (*flag)++;
    }
    while (c != '\n') {
        s[(*length)++] = c;
        if (*length >= size) {
            size *= 2;
            s = (char *) realloc(s, size * sizeof(char));
        }

        c = getchar();
        if (c > 127) {
            (*flag)++;
        }
    }
    s[*length] = '\0';
    return s;
}

void counter(char *s, int length, int *a, int *A) {
    for (int j = 0; j < 100000; j++) {
        *a = 0;
        *A = 0;
        for (int i = 0; i < length; i++) {
            if ((s[i] >= 65) && (s[i] <= 90)) {
                (*A)++;
            } else if ((s[i] >= 97) && (s[i] <= 122)) {
                (*a)++;
            }
        }
    }

}

char *get_random_string(int *length) {
    srand(time(NULL));
    *length = rand() % 10000;
    char *s = (char *) malloc(*length * sizeof(char));
    for (int i = 0; i < *length; i++) {
        if (i % 2 == 0) {
            s[i] = rand() % 26 + 'A';
        } else {
            s[i] = rand() % 26 + 'a';
        }
    }
    return s;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("incorrect input\n");
        return 0;
    }
    clock_t start, end;
    int length, flag;
    if (strcmp(argv[1], "-r") == 0) {
        int a = 0;
        int A = 0;
        char *s = get_random_string(&length);
        printf("%s \n %d \n", s, length);
        start = clock();
        counter(s, length, &a, &A);
        end = clock();
        printf("lowercase: %d \nuppercase %d\n", a, A);
        printf("time: %.4lf\n", (double) (end - start) / (CLOCKS_PER_SEC));
        free(s);
    } else if (strcmp(argv[1], "-h") == 0) {
        printf("-h Список функций\n");
        printf("-r Сгенерировать случайную строку\n");
        printf("-f считать входные данные из input.txt и вывести результат в output.txt\n");
        printf("-s считать строку из терминала и вывести в него результат\n");
    } else if (strcmp(argv[1], "-f") == 0) {
        FILE *input = fopen("input.txt", "r");
        FILE *out = fopen("output.txt", "w");
        if ((input == NULL) || (out == NULL)) {
            printf("missing files!\n");
            return 0;
        }
        int length;
        int a = 0;
        int A = 0;
        char *s = get_string(input, &length, &flag);
        start = clock();
        counter(s, length, &a, &A);
        end = clock();
        fprintf(out, "lowercase: %d \nuppercase %d\n", a, A);
        printf("time: %.4lf\n", (double) (end - start) / (CLOCKS_PER_SEC));
        free(s);
        fclose(input);
        fclose(out);
    } else if (strcmp(argv[1], "-s") == 0) {
        int a = 0;
        int A = 0;
        char *s = get_string2(&length, &flag);
        start = clock();
        counter(s, length, &a, &A);
        end = clock();
        printf("lowercase: %d \nuppercase %d\n", a, A);
        printf("time: %.4lf\n", (double) (end - start) / (CLOCKS_PER_SEC));
        free(s);
    }
    return 0;
}