//
//  main.cpp
//  HW
//
//  Created by Jayanth Deejay on 23/11/13.
//  Copyright (c) 2013 Jayanth Deejay. All rights reserved.
//

#include <iostream>
#include <fstream>
#include <string>

int square(int arr[430][21], int loc)
{
    int sum[2][20];
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<20;j++)
        {
            sum[i][j]=0;
        }
    }
    for(int i=0;i<arr[loc][0];i++)
    {
        int x=0;
        for(int j=0;j<21;j++)
        {
            x=x+arr[loc+i+1][j];
        }
        sum[0][i]=x;
    }
    int k=0;
    for(int i=0;i<21;i++)
    {
        int x=0;
        for(int j=0;j<arr[loc][0];j++)
        {
            x=x+arr[loc+j+1][k];
        }
        sum[1][k]=x;
        k++;
    }
    k=0;
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<20;j++)
        {
            if(sum[i][i]>k)
            {
                k=sum[i][j];
            }
        }
    }
    for(int i=0;i<2;i++)
    {
        for(int j=0;j<arr[loc][0];j++)
        {
            if(k>sum[i][j] && sum[i][j]!=0)
            {
                return 0;
            }
        }
    }
    return 1;
}
int main(int argc, const char * argv[])
{
    std::ifstream in("/Users/jayanthdeejay/gcc/HW/HW/sd.txt");
    if(in.is_open())
    {
        std::string contents((std::istreambuf_iterator<char>(in)), std::istreambuf_iterator<char>());
        char * ch=new char(contents.length());
        std::strcpy(ch,contents.c_str());
        int arr[430][21];
        for(int i=0;i<430;i++)
        {
            for(int j=0;j<21;j++)
            {
                arr[i][j]=0;
            }
        }
        int rows=0;
        int cols=0;
        for(int i=0;i<contents.length();i++)
        {
            if(ch[i]=='\n')
            {
                rows++;
                cols=0;
            }
            else
            {
                if(ch[i]=='#')
                {
                    ch[i]=int(1);
                }
                if(ch[i]=='.')
                {
                    ch[i]=int(0);
                }
                if(int(ch[i])>=48)
                {
                    arr[rows][cols]=int(ch[i])-48;
                }
                else
                {
                arr[rows][cols]=(int)ch[i];
                }
                cols++;
            }
        }
        for(int i=0;i<430;i++)
        {
            for(int j=0;j<21;j++)
            {
                std::cout<<arr[i][j];
            }
            std::cout<<"\n";
        }
        int track=1;
        int caseno=1;
        for(int i=1;i<=20;i++)
        {
            int result=-1;
            result=square(arr,track);
            if(result == 0)
            {
                std::cout<<"Case #"<<caseno<<": NO\n";
            }
            if(result == 1)
            {
                std::cout<<"Case #"<<caseno<<": YES\n";
            }
            track=track+arr[track][0]+1;
            caseno++;
        }
        
    }
    in.close();
    return 0;
}

