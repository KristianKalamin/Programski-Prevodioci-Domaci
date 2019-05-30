int main()
{

  int a;
  int prviNiz[5];
  int b;
  int c;
  a = 1;
  b = 2;

  prviNiz[0] = 5;
  prviNiz[1] = 1;
 
  prviNiz[1] = prviNiz[0];

  c = a - b;

  a = a + prviNiz[0] + prviNiz[1];

  return a;
}
