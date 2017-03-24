#include<stdio.h>
#include<string.h>
#include<sys/types.h>
#include<unistd.h>
#include<stdlib.h>
int main(){
	char command[100];
    //char *breakdown;
	while(1){
		printf("\n~# ");
		scanf("%s",command);
        /*breakdown=strtok(command," ");
        while (breakdown != NULL) {
            
            breakdown = strtok(NULL, " ");
        }*/
		if(strcmp(command,"exit")==0 || strcmp(command,"quit")==0){
			exit(0);
		}
		else {
			printf("Entered command: %s",command);
		}
	}
return 0;
}
