class data:
    data = {}

    def SET(self, var, val):
        self.data[var] = val

    def GET(self, var):
        return self.data[var]

    def UNSET(self, var):
        del self.data[var]

    def NUMEQUALTO(self, val):
        count = 0
        for key, value in self.data.items():
            if value == val:
                count+=1
        return count

    def execute(self, command):
        switcher = {
            "SET": SET,
            "GET": GET,
            "UNSET": UNSET,
            "NUMEQUALTO": NUMEQUALTO
        }
        func = switcher.get(command[0])
        if len(command) > 2:
            return func(command[1],command[2])
        else:
            return func(command[1])


def main():
    data = {}
    depth = 0
    result = 0
    command=""
    setVals = {}
    unsetVals = {}
    while True:
        while True:
            command = input()
            command = command.split()
            if command[0] in ["GET", "SET", "UNSET", "NUMEQUALTO", "END", "BEGIN", "ROLLBACK", "COMMIT"]:
                break

        if command[0] == "BEGIN":
            depth+=1
            commit=main()
            if commit == True and depth > 0:
                depth-=1
                return True
    
        
        if command[0] == "END":
            break

        if depth > 0 and command[0] == "SET":
            tempCMD = []
            tempCMD.append("GET ")
            tempCMD.append(command[1])
            val = execute(tempCMD)
            setVals[command[1]] = val
            execute(command)
        
        elif depth > 0 and command[0] == "UNSET":
            tempCMD = []
            tempCMD.append("GET ")
            tempCMD.append(command[1])
            val = execute(tempCMD)
            unsetVals[command[1]] = val
            execute(command)

        elif depth > 0 and command[0] == "COMMIT":
            depth-=1
            return True

        elif depth == 0:
            result = execute(command)
            print(result)


global data

if __name__ == '__main__':
    main()















