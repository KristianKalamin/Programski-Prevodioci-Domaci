int main()
{

  int a;
  int b;
  int c;
  a = 1;
  b = 2;
  c = 4;

  if (a==1 && c>3) a = b + 1;
  if (a==1 || c==b) a = c + 2;

  return a;
}
