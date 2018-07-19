# -*- coding: cp949 -*-
import smtplib
from email.mime.text import MIMEText
 
smtp = smtplib.SMTP('smtp.gmail.com', 587)
smtp.ehlo()      # say Hello
smtp.starttls()  # TLS 사용시 필요
smtp.login('smjung8710@gmail.com', 'breakaleg2014')
 
msg = MIMEText('본문 테스트 메시지')
msg['Subject'] = '테스트'
msg['To'] = 'jsm1111111@naver.com'
smtp.sendmail('smjung8710@gmail.com', 'jsm1111111@naver.com', msg.as_string())
 
smtp.quit()
