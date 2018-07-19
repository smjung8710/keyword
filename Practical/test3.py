import platform

machine=platform.machine()
if machine == "AMD64":
    machine = 'x64'
else:
    machine = 'x86'
print(machine)
