# -*- coding: cp949 -*-
import smtplib
from email.mime.text import MIMEText
 
smtp = smtplib.SMTP('smtp.gmail.com', 587)
smtp.ehlo()      # say Hello
smtp.starttls()  # TLS ���� �ʿ�
smtp.login('smjung8710@gmail.com', 'breakaleg2014')
 
msg = MIMEText('���� �׽�Ʈ �޽���')
msg['Subject'] = '�׽�Ʈ'
msg['To'] = 'jsm1111111@naver.com'
smtp.sendmail('smjung8710@gmail.com', 'jsm1111111@naver.com', msg.as_string())
 
smtp.quit()
