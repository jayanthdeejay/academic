#include<iostream>
using namespace std;
int x=10;
int main()
{
	int x=15;
	cout<<"local x:"<<x<<"\tglobal x:"<<(::x)<<endl;
	return 0;
}
