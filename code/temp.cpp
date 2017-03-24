#include <iostream>
using namespace std;
int private_key(int e, int p, int q);
int main () {
    int e,p,q;
    cout << "Given p and q, two prime numbers and a public key e, this program calculates private key d!"<<endl;
    cout << "Enter public key (e): ";
    cin >> e;
    cout << "Enter prime (p): ";
    cin >> p;
    cout << "Enter prime (q): ";
    cin >> q;
    return private_key(e,p,q);
}
int private_key(int e, int p, int q) {
    int s,t,x,y,g;
    int phi=(p-1)*(q-1);
    if (e>phi)
        e^=phi^=e^=phi; //e,phi values are being swapped
    x=t=0;
    y=s=1;
    while (e!=0) {
        g= phi/e;
        phi=phi%e;
        e^=phi^=e^=phi; //e,phi values are being swapped
        s^=x^=s^=x;     //s,x values are being swapped
        x=x-g*s;
        t^=y^=t^=y;
        y=y-g*t;
    }
    if(phi!=1){
	cout<<"Public key and Phi are not co-primes, choose a different value for e!"<<endl;
	return 0;
    }
    phi=(p-1)*(q-1);
    if(t<0)
        t=t+phi;
    cout<<"Private key (d): "<<t<<endl;
    return t;
}
