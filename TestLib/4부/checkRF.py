import os
 
checkRF = raw_input('install robotframework? (y/n) : ');

if(checkRF =="y"):
    os.system("pip install robotframework ");

checkRF = raw_input('install robotremoteserver? (y/n) : ');

if(checkRF =="y"):
    os.system("pip install robotremoteserver ");

checkRF = raw_input('install robotfixml? (y/n) : ');

if(checkRF =="y"):
    os.system("pip install robotfixml ");
