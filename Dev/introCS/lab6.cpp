#include <iostream>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <vector>
#include <string>
using namespace std;

void shuffle(vector<int> &, int);
void playorder(const vector<int> &, const vector<string> &, int);

int main()  {
   ifstream file("lab6_input.txt");
   vector<string> mysongs;
   if(file.is_open()){
	int count=0;
	string temp;
	while(!file.eof()){
		getline(file,temp);
		mysongs.push_back(temp);
		count++;
	}

   vector<int> songorder;
   srand(time(0));
   cout << "Original Song Order:" << endl;
   count--;
   for(int i=0;i<count;i++)
	songorder.push_back(i);
   for (int i= 1; i <= count; ++i)
         cout << i << ". " << mysongs[i-1] << "\n";
   cout << "\n\n"<< endl;
   cout << "Shuffled Order:" << endl;
   shuffle(songorder, count); 
   for (int i = 0; i < count ; ++i ) cout << i+1 << "->" << songorder[i] << "   " ;
   cout << endl<< endl;

   playorder(songorder, mysongs, count);
  




 return 0;
}
}
void shuffle(vector<int> & order, int count){
// places the numbers from 1 to 10 in random order in the array order
   int position;
   int  i;
   for (i= 1; i <= count; i++ ) {
      do {
         position = rand() % count;
      } while(order[position]!= 0);
      order[position] = i;
   }
}
void playorder(const vector<int> &order, const vector<string> &songlist, int count) {
// prints out the songs in order given by order
   for ( int song = 1; song <= count; song++ )
      for ( int position = 0; position < count; position++ )
            if ( order[position] == song )
               cout << song  << ". " << songlist[ position ] << "\n";
   cout<< endl;
}
