import platform

class SelfLibrary(object):
    def Get_ARCH(self):
        machine=platform.machine()
        if machine == "AMD64":
            machine = 'x64'
        else:
            machine = 'x86'
        print(machine)

if __name__ == "__main__":
    test=SelfLibrary()
    test.Get_ARCH()
    
