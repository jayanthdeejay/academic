#include <iostream>
#include <string>
#include <fstream>
using namespace std;
 
int main() {
    const int SIZE = 235886;
    ifstream file("/usr/share/dict/words");
    if(file.is_open()) {
        string myArray[SIZE];
 
        for(int i = 0; i < SIZE; ++i) {
            file >> myArray[i];
            myArray[i][0]= tolower(myArray[i][0]);
        }
 
       cout << "Enter a search term:" ;
       string key;
       cin >> key;
       cout << "You entered the search term: " << key << endl;
 
       int lowerbound = -1;
       int upperbound = SIZE;
       int position = (lowerbound + upperbound) / 2;
       int count = 1;
 
       while((myArray[position] != key) && (lowerbound <= upperbound)) {
              cout << count << ":->  " << myArray[position] << " at position " << position <<  endl;
              if (myArray[position] > key) 
                    upperbound = position - 1;                             
              else                                 
                   lowerbound = position + 1;     
              position = (lowerbound + upperbound) / 2;
              count++;
       } // end of while
 
      if (lowerbound <= upperbound)
            cout<< "The string " << key << " was found in array at position "<< position<<endl<<endl; 
      else
            cout<< "Sorry, the string " << key << " is not in this dictionary." << endl;  
}
}
