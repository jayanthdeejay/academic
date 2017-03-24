#include<iostream>
#include<cstdlib>
using namespace std;
int rollDie();
int main(){
	int point,die1,die2,die3,win=0,lose=0;
	cout<<endl<<"Let's play Game of Chance!"<<endl;
	cout<<endl<<"Choose a number between 1 and 6 (anything else to quit): ";
	cin>>point;
	while(point>0 && point<7){
		cout<<"Rolling die three times and... ";
		die1=rollDie();
		cout<<die1<<" ";
		die2=rollDie();
		cout<<die2<<" ";
		die3=rollDie();
		cout<<die3<<endl<<endl;
		if((die1==point)||(die2==point)||(die3==point)){
			cout<<"You just won a dollar!";
			win++;
		}
		else{
			cout<<"You just lost a dollar!";
			lose++;
		}
		cout<<endl<<endl<<"Choose a number between 1 and 6 (anything else to quit): ";
		cin>>point;
	}
	cout<<"# of games won: "<<win<<endl<<"# of games lost: "<<lose<<endl;
return 0;
}
int rollDie(){
	return rand()%6+1;
}
