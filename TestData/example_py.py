import os

os.system('pip freeze > req.txt')

with open('req.txt', 'r') as file :
    filedata = file.read()

# Replace the target string
filedata = filedata.replace('==', '>=')

# Write the file out again
with open('req.txt', 'w') as file:
    file.write(filedata)

#pip update 
os.system('pip install -r req.txt --upgrade')
