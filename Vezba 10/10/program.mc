typedef struct str_Point
{
   int x;
   int y;
};

typedef struct str_TriDe
{
   int x;
   int y;
   int z;
};

int main()
{
  int x;
  int a;

  str_Point k;
  str_TriDe b;
  x = 2;
 

  k.x = 5;
  k.y = 1;
  b.y = 6;
  b.z = 11;
  b.x = 1;

  
  x = k.x + b.y + b.x + k.y - b.z;

  return x;
}
