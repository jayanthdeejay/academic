#include<iostream>
#include<fstream>
#include<cmath>
using namespace std;

bool isNotEven(int x) {
	if(x%2==0)
		return false;
	else
		return true;
}

bool isNotDiv2or3(int x) {
	if(x%2==0||x%3==0)
		return false;
	else
		return true;
}

bool isPrime(int x) {
	int p=sqrt(x);
	for(int k=2;k<p;k++){
		if(x%k==0)
			return false;
	}
	return true;
}

void updateTopk(int topk[], int k, int x){
	if(x<topk[0]){}
	else {
		int i=0;
		while(x>topk[i] && i<k) {
			topk[i]=topk[i+1];
			i++;
		}
		topk[i-1]=x;
	}
}

int main() {
	int x,count=0,odd=0,two3=0,primes=0;
	const int k=10;
	int topk[k]={0}, topkprimes[k]={0};
	ifstream file("/Users/jayanthdeejay/Documents/Dev/introCS/input.txt");
	if(file.is_open()){
		file>>x;
		while(x!=-1) {
			if(isNotEven(x))
				odd++;
			if(isNotDiv2or3(x))
				two3++;
			updateTopk(topk,k,x);
			if(isPrime(x)) {
				primes++;
				updateTopk(topkprimes,k,x);
			}
			count++;
			file>>x;
		}
	}
	cout<<"Numbers read in: "<<count<<endl;
	cout<<"Number of odd numbers: "<<odd<<endl;
	cout<<"Not Divisible by 2 or 3: "<<two3<<endl;
	cout<<"Prime numbers: "<<primes<<endl;
	cout<<"Largest K=10 numbers:"<<endl;
	for(int i=0;i<k;i++)
		cout<<topk[i]<<" ";
	cout<<endl;
	cout<<"Top K=10 prime numbers:"<<endl;
        for(int i=0;i<k;i++)
                cout<<topkprimes[i]<<" ";
        cout<<endl;
	return 0;
}
