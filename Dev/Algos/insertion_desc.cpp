#include <iostream>
using namespace std;
int main(void){
	char ch='y';
	int i=0,j=0,key=0,length=0,A[100]={0};
	while(ch=='y'){
		cout<<"Enter a number:";
		cin>>A[length];
		length++;
		cout<<"Another number?(y/n):";
		cin>>ch;
	}
	for(j=1;j<length;j++){
		key=A[j];
		i=j-1;
		while(i>=0 && A[i]<key){
			A[i+1]=A[i];
			i=i-1;
		}
		A[i+1]=key;
	}
	cout<<endl<<"Sorted array in descending order: ";
	for(i=0;i<length;i++){
		cout<<A[i]<<" ";
	}
	return 0;
}
