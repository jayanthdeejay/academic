C-x b Switch/Create the buffer
C-x k Kill the current buffer
C-x C-f Open/create a new file
C-x C-s Save the buffer to a file
M-x {function-name} We can give a command in place of function name. Eg M-x package-install
C-c C-k Load the current buffer into REPL and compile it
C-a Move cursor to the beginning of the current line
C-e Move cursor to the end of the line
C-f Move cursor forward by one character
C-b Move cursor backward by one character
M-f Move forward one word
M-b Move backward one word
C-s {some_text} This will regex the current buffer and moves the cursor the matching text. Hit C-s again and will find the next matching text
C-j New line and indent (~= return and tab)
M-x cider-jack-in will start REPL for me 
C-x o Switch cursor to new window
C-x 1 Delete all other windows. Don't worry, you won't lose your work
C-x 2 Split window horizontally
C-x 3 Split window vertically
C-x 0 Delete current window
C-x C-e Send the expression preceeding the cursor to REPL for execution
