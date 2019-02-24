#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int whiteSpace(int x)
{
    if (x == ' ' || x == '\t' || x == '\n')
        return 1;
    else
        return 0;
}

int main(int argc, char *argv[])
{
    FILE *f = fopen(argv[1], "r");

    int state = 0, i = 0;
    char c;
    char *word = (char *)malloc(256 * sizeof(char));

    while (1)
    {
        switch (state)
        {
        case 0:
        {
            c = getc(f);
            if (c == ' ' || c == '\t' || c == '\n')
                state = 0;
            else if (c == '.')
                state = 1;
            else if (isupper(c))
            {
                state = 2;
                word[i] = c;
                i++;
            }
            else if (islower(c))
            {
                state = 4;
                word[i] = c;
                i++;
            }
            else if (c == EOF)
                return 0;
            else
                state = 6;
        };
        break;
        case 1:
        {
            printf("DOT - %c\n", c);
            c = getc(f);
            if (c == ' ' || c == '\t' || c == '\n')
                state = 0;
            else if (c == '.')
                state = 1;
            else if (isupper(c))
            {
                state = 2;
                word[i] = c;
                i++;
            }
            else if (islower(c))
            {
                state = 4;
                word[i] = c;
                i++;
            }
            else if (c == EOF)
                return 0;
            else
                state = 6;
        };
        break;
        case 2:
        {
            c = getc(f);
            if (c == ' ' || c == '\t' || c == '\n')
                state = 3;
            else if (c == '.')
            {
                ungetc(c,f);
                state = 3;
            }

            else if (isupper(c))
            {
                state = 3;
                ungetc(c,f);
            }
            else if (islower(c))
            {
                state = 2;
                word[i] = c;
                i++;
            }
            else if (c == EOF)
                return 0;
            else
                state = 6;
        };
        break;
        case 3:
        {
            printf("CWORD - ");
            for(int j = 0; j < i; j++)
                printf("%c", word[j]);
            printf("\n");

            free(word);
            word = (char *)malloc(265 * sizeof(char));
            i = 0;
            c = getc(f);
            if (c == ' ' || c == '\t' || c == '\n')
                state = 0;
            else if (c == '.')
                state = 1;
            else if (isupper(c))
            {
                state = 2;
                word[i] = c;
                i++;
            }
            else if (islower(c))
            {
                state = 4;
                word[i] = c;
                i++;
            }
            else if (c == EOF)
                return 0;
            else
                state = 6;
        };
        break;
        case 4:
        {
            c = getc(f);
            if (c == ' ' || c == '\t' || c == '\n')
                state = 5;
            else if (c == '.')
            {
                ungetc(c,f);
                state = 5;
            }
            else if (isupper(c))
            {
                state = 5;
                ungetc(c,f);
            }
            else if (islower(c))
            {
                state = 4;
                word[i] = c;
                i++;
            }
            else if (c == EOF)
                return 0;
            else
                state = 6;
        };
        break;
        case 5:
        {
            printf("WORD - ");
            for(int j = 0; j < i; j++)
                printf("%c", word[j]);
            printf("\n");

            free(word);
            word = (char *)malloc(265 * sizeof(char));
            i = 0;
            c = getc(f);
            if (c == ' ' || c == '\t' || c == '\n')
                state = 0;
            else if (c == '.')
                state = 1;
            else if (isupper(c))
            {
                state = 2;
                word[i] = c;
                i++;
            }
            else if (islower(c))
            {
                state = 4;
                word[i] = c;
                i++;
            }
            else if (c == EOF)
                return 0;
            else
                state = 6;
        };
        break;
        case 6:
        {
            printf("GRESKA - %c", c);
            return 0;
        };
        break;
        default:
            break;
        }
    }
}
