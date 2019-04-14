int main() {
    int x;
    x = 2;
    {
      int z;
      x = 5;
    }

    return x + z;   
  }