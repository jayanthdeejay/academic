command = input("> ")
command = str(command)
command = command.split()
if command[0] in ["GET", "SET", "UNSET", "NUMEQUALTO", "END"]:
    print ("Seems to work!")
