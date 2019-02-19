#include <stdio.h>
#include <ctype.h>

#define TRUE 1
#define FALSE 0

int isDot(int x)
{
    if (x == 46)
        return TRUE;
    return FALSE;
}

int whiteSpace(int x)
{
    if (x == 32 || x == 9 || x == 10 || x == '\000')
        return TRUE;
    else
        return FALSE;
}

int isIllegalChar(int x)
{
    if ((x >= 65 && x <= 90) || (x >= 97 && x <= 122) || x == 46)
        return FALSE;
    else
        return TRUE;
}

FILE *other(FILE *f)
{
    char c;
    while ((c = getc(f)) != EOF)
    {
        if (islower(c))
            printf("%c", c);
        else
            break;
    }
    ungetc(c, f);
    return f;
}

int checkInputChar(FILE *f)
{
    char c;
    while ((c = getc(f)) != EOF)
    {
        if (isIllegalChar(c) && !whiteSpace(c))
        {
            printf("\nGRESKA: %c", c);
            return FALSE;
        }
    }
    return TRUE;
}

int main(int argc, char *argv[])
{
    FILE *errorChar = fopen(argv[1], "r");

    if (checkInputChar(errorChar))
    {

        char *word = "WORD ";
        char *cword = "CWORD ";
        FILE *f = fopen(argv[1], "r");
        char c;
        int node = 0;
        while ((c = getc(f)) != EOF)
        {
            if (whiteSpace(c))
                continue;
            else if (isDot(c))
                node = 1;
            else if (isupper(c))
                node = 2;
            else
                node = 4;

            switch (node)
            {
                case 1: //DOT
                    printf("DOT - %c\n", c);
                    break;
                case 2: // CAPITAL_LETTER
                    printf("%c", c);
                    f = other(f);
                    printf(" - %s\n", cword);
                    break;
                case 4: //SMALL_LETTER
                    printf("%c", c);
                    f = other(f);
                    printf(" - %s\n", word);
                    break;
                default:
                    break;
            }
        }
        fclose(f);
    }
    fclose(errorChar);
    return 0;
}
