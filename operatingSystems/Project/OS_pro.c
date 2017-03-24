#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#define MAX_LINE 80 /* The maximum length command */

int main(void)
{
    char hist[6]=".hist";
	char *args[MAX_LINE/2 + 1]; /* command line arguments */
	char temp[50];
	int i=0, j=0, k=0;
	int should_run = 1; /* flag to determine when to exit program */
	char *tok;
	pid_t pid, status;
	int num_cmd, fp = 0;
	char *commands[40];
    FILE *history= fopen(hist,"w");
    if(history==NULL){
        printf("Error with history file");
    }
	while (should_run) {

		printf("osh>");
		fflush(stdin);
		gets(temp);

		if(strcmp(temp, "history") == 0)
		{
            pid = fork();
//            temp="tail -10 .hist";
            if(pid == 0)
            {
                execvp("/bin/sh","tail -10 .hist");
                exit(1);
            }
            else if (pid > 0)
            {
                // parent should keep running        
                
            }
            
            
            
            
            
		/*	int t = 10, k=j;
			while(t>0)
			{
				if(k>=0)
				{
					printf("%d %s", k+1, commands[k]);
					k--;
				}
				t--;
			} 
		*/
	//	printf("%s %s %s %s", commands[0], commands[1], commands[2], commands[3]);	
		}
		else if (strcmp(temp, "!!")==0)
		{

		}
		else if(temp[0]=='!' && (temp[1]>1 && temp[1]<11 ))
		{

		}
		else
		{
			// Tokenizing Code

			tok = strtok (temp, " ");

			while(tok != NULL)
			{
				args[i] = tok;
				tok = strtok(NULL, " ");
				i++;
			}
			//		printf("%s %s %s %s", args[0], args[1], args[2], args[3]);
			// Checking for & 

			if(args[i-1][0] == '&')
			{
				pid = fork();
				if(pid == 0)
				{
					execvp(args[fp], args+fp);
					exit(1);
				}

				else if (pid > 0)
				{
					wait(NULL);

				}

			}
			else
			{
				pid = fork();

				if(pid == 0)
				{
					execvp(args[fp], args+fp);
					exit(1);
				}
				else if (pid > 0)
				{
					// parent should keep running        

				}
			}

			commands[j] = args[fp];
			fp = i;
			j++;
			printf("%s %s %s %s", commands[0], commands[1], commands[2], commands[3]);			
		}
	}
	return 0;
}
