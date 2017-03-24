#include<iostream>
#include"add.h"
using namespace std;
int main()
{
	int N1,N2;
	N1=readNumber();
	N2=readNumber();
	int result=add(N1,N2);
	writeNumber(result);
return 0;
}
