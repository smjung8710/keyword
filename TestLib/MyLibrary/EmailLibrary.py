# -*- coding: utf-8 -*-

import smtplib
from email.mime.text import MIMEText
from email.mime import base
from email.mime import multipart

import os

class EmailLibrary(object):

    ROBOT_LIBRARY_SCOPE = 'Global'

    def __init__(self):
        print 'send email utility'

    def send_mime_mail (self,from_user,from_password,to, subject, text, attach):
        msg = multipart()
        part = base('application', 'octet-stream')
         part.set_payload(open(attach, 'rb').read())  #파일 첨부
         part.add_header('Content-Disposition', 'attachment; filename="%s"' %os.path.basename(attach))
         msg.attach(part)  #메시지에 추가


    def send_mail_smtp(self,from_addr,from_password,to_addr, subject, text):

        #서버정보
        SMTPServer = smtplib.SMTP('smtp.gmail.com', 587)
        SMTPServer.ehlo()
        SMTPServer.starttls()
        SMTPServer.login(from_addr,from_password)

        #이메일 내용
        SMTPMessage = MIMEText(text)
        SMTPMessage ['Subject'] = subject
        SMTPMessage ['To'] = to_addr

        #메일전송
        SMTPServer.sendmail(from_addr, to_addr, SMTPMessage.as_string())

        #서버연결종료
        SMTPServer.quit()
