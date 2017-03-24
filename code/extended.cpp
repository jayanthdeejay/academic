#include <iostream>
using namespace std;
//Given a and b, two positive integers, Calculate g, s, t such that g=gcd(a,b) and g=sa+tb
int main () {
    int a,b,s,t,x,y,q;
    cout << "Given a and b, two positive integers, Calculate g, s, t such that g=gcd(a,b) and g=sa+tb!"<<endl;
    cout << "Enter value for a: ";
    cin >> a; 
    cout << "Enter value for b: ";
    cin >> b;
    if (b>a)
        a^=b^=a^=b;
    x=t=0;
    y=s=1;
    while (b!=0) {
        q= a/b;
        a=a%b;
        b^=a^=b^=a;
        s^=x^=s^=x;
        x=x-q*s;
        t^=y^=t^=y;
        y=y-q*t;
    }

    cout << "gcd: " << a << endl;
    cout << "s: " << s << endl;
    cout << "t: " << t << endl;
    return 0;
}
