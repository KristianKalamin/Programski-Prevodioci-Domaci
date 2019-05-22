int main()
{
  int state;
  state = 10;
  
  switch(state) {
    case 10: state = 1; break;
    case 20: state = 2; break;
    default: state = 0;
  }

  return state;
}
