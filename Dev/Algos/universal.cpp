#include<iostream>
using namespace std;
int main(){
    for(int i=1;i<4;i++){
        for(int j=1;j<4;j++){
            for(int k=1;k<4;k++){
                for(int l=1;l<4;l++){
                    if(i+j+k+l>9) cout<<i<<j<<k<<l<<endl;
                }
            }
        }
    }
return 0;
}
