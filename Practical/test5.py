import platform

class SelfLibrary(object):
    def Get_ARCH(self):
        machine=platform.machine()
        if machine == "AMD64":
            machine = 'x64'
            return machine
        else:
            machine = 'x86'
            return machine

if __name__ == "__main__":
    test=SelfLibrary()
    print(test.Get_ARCH())
    
    


