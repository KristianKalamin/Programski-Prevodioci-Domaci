#include <ctype.h>
#include <stdio.h>

#define TRUE 1
#define FALSE 0

int error = FALSE;
char *word = "WORD ";
char *cword = "CWORD ";

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

int checkInputChar(FILE *f)
{
    char c;
    while ((c = getc(f)) != EOF)
    {
        if (isIllegalChar(c) && !whiteSpace(c))
        {
            error = TRUE;
            printf("\nGRESKA: %c", c);
            return FALSE;
        }
    }
    return TRUE;
}

int main()
{
    FILE *errorChar = fopen("test2.txt", "r");

    if (checkInputChar(errorChar))
    {

        FILE *f = fopen("test2.txt", "r");
        char c;
        int numOfCword,x, itn = 0;
        while ((c = getc(f)) != EOF)
        {
            if (itn <= 0)
            {
                numOfCword = 0;
                x = 0;
                itn = 0;
                ungetc(c, f);
                for (int i = 0;; i++)
                {
                    if (whiteSpace(f->_ptr[i]) || isDot(f->_ptr[i]))
                        break;

                    if (islower(f->_ptr[i]) && (x == 0))
                    {
                        printf("%s", word);
                        x++;
                        itn++;
                    }
                    else if (isupper(f->_ptr[i]))
                    {
                        numOfCword++;
                        x++;
                        itn++;
                    }
                    else
                    {
                        itn++;
                        continue;
                    }
                }
                for (int i = 0; i < numOfCword; i++)
                    printf("%s", cword);

                getc(f);
            }

            if (isDot(c))
            {
                printf("\nDOT %c\n", c);
                itn--;
            }
            else if (!whiteSpace(c))
            {
                printf("%c", c);
                itn--;
            }
            else
                itn--;

            if(whiteSpace(c))
                printf("\n");
        }
        fclose(f);
    }
    fclose(errorChar);
    return 0;
}
