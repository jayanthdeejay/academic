#include <iostream>
using namespace std;
long long int power_comp(int, int);
int main() {
	int X,Y;
	cout<<"Enter X, Y to compute X raised to power Y: ";
	cin>>X>>Y;
	cout<<power_comp(X,Y)<<endl;
	return 0;
}
long long int power_comp(int x, int p) {
	unsigned short bin[64];
	int index=0;
	long long int pow=x;
	for(int i=p; i>0;) {
		bin[index]=i%2;
		i=i/2;
		index++;
	}
	for(int i=index-2;i>=0;i--){
		if(bin[i]==1) {
                        pow=pow*pow*x;
                }
                else {
                        pow=pow*pow;
                }
	}
	return pow;
}
