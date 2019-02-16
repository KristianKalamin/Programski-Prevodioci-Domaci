#include <ctype.h>
#include <stdio.h>

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
    if (x == 32 || x == 9 || x == 10 || x == '\000' || x == EOF)
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

int checkInputChar(FILE *f)
{
    char c, d;
    while ((c = getc(f)) != EOF)
    {

        if (isIllegalChar(c) && !whiteSpace(c))
        {
            printf("\nGRESKA: %c", c);
            return FALSE;
        }
        d = c;
    }
    if (!isDot(d))
    {
        printf("\nGreska recenica mora da se zavrsi sa tackom!\n");
        return FALSE;
    }
    return TRUE;
}

void findDotPosition(FILE *f, int *startOfWord)
{
    for (int i = 0;; i++)
    {
        if ((isDot(f->_ptr[i])) || (f->_ptr[i] == '\000'))
        {
            while ((!whiteSpace(f->_ptr[i])) && (i > 0))
            {
                i--;
            }
            (*startOfWord) = i;
            return;
        }
    }
}

FILE *printStartWord(FILE *f)
{
    char c;
    printf("\nRecenica pocinje sa: ");
    while ((c = getc(f)) != EOF)
    {
        if (whiteSpace(c))
            break;
        else if (isDot(c))
        {
            ungetc(c, f);
            break;
        }
        else
            printf("%c", c);
    }

    return f;
}

FILE *printEndWord(FILE *f, int *start)
{
    char c;
    printf("\nRecenica se zavrsava sa: ");
    while ((c = getc(f)) != EOF)
    {
        if (isDot(c))
        {
            break;
        }
        else
            printf("%c", c);
    }

    return f;
}

int main(int argc, char *argv[])
{
    FILE *errorChar = fopen(argv[1], "r");

    if (checkInputChar(errorChar))
    {
        FILE *f = fopen(argv[1], "r");
        char c;
        int startOfWord = 0;

        f = printStartWord(f);

        while ((c = getc(f)) != EOF)
        {
            ungetc(c, f);
            findDotPosition(f, &startOfWord);
            for (int i = 0; i <= startOfWord; i++)
                c = getc(f);

            if (startOfWord > 0)
                f = printEndWord(f, &startOfWord);
              if (isDot(c) || whiteSpace(c))
                c = getc(f); 
            if (c == EOF)
                break;
            else
                f = printStartWord(f);
        }
    }

    return 0;
}
