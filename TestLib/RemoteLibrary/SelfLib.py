# -*- coding: utf-8 -*-
#!/usr/bin/env python

import platform
import ConfigParser
import ftplib
import os
from ftplib import FTP
import hashlib
from datetime import datetime
import urllib
import urllib2
import zlib
import re
import string
import locale
import subprocess
import time
import re
import threading
import binascii

if ( "Windows" in platform.platform() or "windows" in platform.platform()) :
    from win32com.client import Dispatch

class SubThread(threading.Thread):
    def __init__(self, run_command):
        self.stdout = None
        self.stderr = None
        self.cmd = run_command
        threading.Thread.__init__(self)

    def run(self):
        p = subprocess.Popen(self.cmd.split(),
                             shell=False,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)

        self.stdout, self.stderr = p.communicate()
    
class SelfLib(object):

    log_file_path = ""
    isWindows = False
    if ( "Windows" in platform.platform() or "windows" in platform.platform()) :
        log_file_path = r'C:\BuFF\update_library.log'
        isWindows = True
    else :
        log_file_path = r'/BuFF/update_library.log'


    def _write_log(self, s_log) :    
        with open(self.log_file_path, 'a') as f :
            f.write ( time.strftime("%d/%m/%y %H:%M:%S") + " " + s_log + "\n")

    def Get_OS_Info(self):
        return platform.platform()

    def ConfigParser_get(self, filename, section, option):
        """ ini 파일의 해당 section의 option 값을 가져온다.\n
            Example:\n
            -------------------------\n
            config.ini\n
            [update]\n
            ProductPath = tmp/SUarez\n
            -------------------------\n
            | ${value}= | ConfigParser_get | config.ini | update | ProductPath |
        
        """

        values = []
        b_index = False
        with open(filename, "r") as f :
            lines = f.readlines()
            p = re.compile((r'\[\w*\]'))
            section = "["+section+"]"
            
            for line in lines :
                line = string.replace(line,'\n', '')
                line = string.replace(line,'\r', '')
                if (line == '') :
                    continue
                #if (line.find(section) == 0 ):
                if (line == section):
                    b_index = True
                    continue
                if (p.match(line)):
                    b_index = False
                    continue
                if (b_index) :
                    temp = line.split('=')
                    if (temp[0] == option) :
                        values.append(temp[1])
        
        return values

    def ConfigParser_set(self, filename, section, option, value):
        """ ini 파일의 해당 section의 option 값을 수정 혹은 넣어준다.
            = Example =
            -------------------------\n
            config.ini\n
            [update]\n
            ProductPath = tmp/SUarez\n
            -------------------------\n
            | ${value}= | ConfigParser_set | config.ini | update | ProductPath | tmp/user/SUarez |
        
        """
        config = ConfigParser.RawConfigParser()
        config.optionxform = str
        config.read(filename)
        config.set(section, option, value.strip())
        with open(filename, 'wb') as configfile:
            config.write(configfile)

    def ConfigParser_options(self, filename, section) :
        """ ini 파일의 section 명시 되어있는 모든 option list를 가져온다.
            = Example =
            -------------------------\n
            config.ini\n
            [update]\n
            ProductPath = tmp/SUarez\n
            -------------------------\n
            | @{options}= | ConfigParser_options | config.ini | update |
        """
        config = ConfigParser.RawConfigParser()
        config.optionxform = str
        config.read(filename)

        return config.options(section)

    def ConfigParser_options_non_strict(self, filename, section) :
        """ ini 파일의 section 명시 되어있는 모든 옵션 (중복된 옵션도 포함)option list를 가져온다.
            = Example =
            -------------------------\n
            config.ini\n
            [update]\n
            ProductPath = tmp/SUarez\n
            -------------------------\n
            | @{options}= | ConfigParser_options_non_strict | config.ini | update |
        """
        options = []
        b_index = False
        with open(filename, "r") as f :
            lines = f.readlines()
            p = re.compile((r'\[\w*\]'))
            section = "["+section+"]"
            
            for line in lines :
                line = string.replace(line,'\n', '')
                line = string.replace(line,'\r', '')
                if (line == '') :
                    continue
                if (line.find(section) == 0 ):
                    b_index = True
                    continue
                if (p.match(line)):
                    b_index = False
                    continue
                if (b_index) :
                    temp = line.split('=')
                    options.append(temp[0])
        
        return options

    def ConfigParser_Sections(self, filename) :
        """ ini 파일의 모든 section list를 가져온다.

            = Example =
            -------------------------\n
            config.ini\n
            [update]\n
            ProductPath = tmp/SUarez\n
            -------------------------\n
            | @{sections}= | ConfigParser_Sections | config.ini |
        """
        config = ConfigParser.RawConfigParser()
        config.optionxform = str
        config.read(filename)
        return config.sections()

    def ConfigParser_Add_Sections(self, filename, section) :
        """ ini 파일의 section을 추가한다.

            = Example =
            -------------------------\n
            config.ini\n
            [update]\n
            ProductPath = tmp/SUarez\n
            -------------------------\n
            | ConfigParser_Add_Sections | \BuFF\config.ini | ProductPath |
            
        """
        config = ConfigParser.RawConfigParser()
        config.optionxform = str
        config.read(filename)
        config.add_section(section)
        with open(filename, 'wb') as configfile:
            config.write(configfile)

    def FTP_getFile(self, ip_address, filename, path, local, username, pwd):
        """ FTP 서버에서 파일을 다운 로드 받는다.
            참고: QANAS의 경우 IP당 동시접속 수 제한이 있기에 해당 키워드 사용이 불가

            path : ftp 서버에 path
            local : local 머신에 다운로드 받을 path

            = Example =
            | FTP_getFile | 192.168.111.111 | filename.txt | Project\Update | /BuFF/local | ahnlab | !ahnalb0 |
            
        """
        ftp = FTP(ip_address, username, pwd)
        ftp.cwd(path)
        local_filename = os.path.join(local, filename)
        lf = open(local_filename, "wb")
        ftp.retrbinary("RETR "+ filename, lf.write, 8*1024)
        lf.close()
        ftp.quit()

    def FTP_getDirectory(self, ip_address, path, local, username, pwd):
        """ FTP 서버에서 디렉토리 전체를 다운로드 받는다.

            = Example =
            | FTP_getDirectory | 192.168.111.111 | Project\Update | /BuFF/local | ahnlab | !ahnalb0 |
            
        """
        ftp = FTP(ip_address, username, pwd)
        ftp.cwd(path)
        filenames = ftp.nlst() # get filenames within the directory
        
        for filename in filenames:
            local_filename = os.path.join( local, filename)
            file = open(local_filename, 'wb')
            ftp.retrbinary('RETR '+ filename, file.write)
            file.close()

        ftp.quit() # This is the “polite” way to close a connection
        
    def Get_File_from_QANAS(self, filename, path, local) :
        """ QANAS 서버로 부터 file을 다운로드 받는다.

            = Example =
            | Get File From QANAS | logviewer2.exe | /BuFF/BuFF_TestData/tool | D://tool |
            
        """
        self.FTP_getFile("10.2.8.3", filename, path, local, "nlkim", "ahnlab")

    def Get_File_Hash (self, filePath) :
        """
            Get MD5 Hash of File
        """
        with open(filePath, 'rb') as fh:
            m = hashlib.md5()
            while True:
                data = fh.read(8192)
                if not data:
                    break
                m.update(data)
            return m.hexdigest()

    def Get_File_CRC32(self, filePath) :
        """ File CRC 값을 구한다.
            filePath : CRC를 구할 file 
            = Example =
            | ${crc} = | Get File CRC32 | /BuFF/BuFF_TestData/tool/logviewer2.exe | 
            
        """
        crc = 0x19950315
        buf = open(filename, 'rb').read()
        crc = (binascii.crc32(buf, crc) & 0xFFFFFFFF)
        return "%08X" % crc

    def Get_File_Time (self, filePath) :
        """
            Returns the time file was last modifiled
            use file which is local, and URL both

            = Example =
            | ${file_time} = | Get File Time | tmp/user/SUarez/config.ini |
            | ${file_time} = | Get File Time | http://192.168.111.161/totalengine/Total_A/patch/ahnpatch.ui |
            =>
            ${file_time} = '2015-05-21 09:01:00'
        """
        if "http://" in filePath :
            u = urllib.urlopen(filePath)
            meta = u.info()

            file_time = datetime.strptime(str(meta.getheaders("Last-Modified")[0]), "%a, %d %b %Y %H:%M:%S %Z")
            return file_time.strftime("%Y-%m-%d %H:%M:%S")

        else :
            mtime = os.path.getmtime(filePath)
            return datetime.fromtimestamp(mtime).strftime("%Y-%m-%d %H:%M:%S")

    def Download_File_from_URL (self, file_url, local_path) :
        """
            URL로 부터 file을 다운로드 받는다.

            = Example =
            | Download File from URL | http://192.168.111.161/totalengine/Total_A/patch/ahnpatch.ui | /BuFF/local/ahnpatch.ui |
        """
        urllib.urlretrieve(file_url, local_path)


    def Get_File_Size_from_URL (self, filePath) :
        """
            Returns the file size(in byte) from URL header(with out downloading)

            = Example =
            | ${file_size} = | Get File Size from URL | "http://192.168.111.161/totalengine/Total_A/patch/ahnpatch.ui" |
            
        """
        u = urllib.urlopen(filePath)
        meta = u.info()

        return str(meta.getheaders("Content-Length")[0])

    def Get_section_data (self, filename, section) :
        """
            해당 section의 하위의 전체 Data를 return 한다.
            -------------------------\n
            config.ini\n
            [update]\n
            ProductPath = tmp/SUarez\n
            -------------------------\n
            = Example =
            | ${data} = | Get Section Data | config.ini |

            => ${data} = "ProductPath = tmp/SUarez"

        """
                
        data = []
        b_index = False
        with open(filename, "r") as f :
            lines = f.readlines()
            p = re.compile((r'\[\w*\]'))
            section = "["+section+"]"
            for line in lines :
                line = string.replace(line,'\n', '')
                line = string.replace(line,'\r', '')
                if (line == '' or line.find('<') == 0) :
                    continue
                if (p.match(line) and line.find(section) == 0 ):
                    b_index = True
                    continue
                if (p.match(line) and line.find(section) < 0 ):
                    if (b_index):
                        break
                    b_index = False
                    continue
                if (b_index) :
                    data.append(line)
        
        return data
    
    def Get_OS_num (self, String):
        """
            BuFF 경로에 저장한 OS.ini에서 os_num을 읽어온다.
            Library 내부에서 사용
        """
        os_num = 0
        if ( self.isWindows ) :
            config = ConfigParser.RawConfigParser()
            config.optionxform = str
            config.read('C:\BuFF\OS.ini')
            os_num = config.get('info', 'os_num')        
        else :
            config = ConfigParser.RawConfigParser()
            config.optionxform = str
            config.read('/BuFF/OS.ini')
            os_num = config.get('info', 'os_num')

        self._write_log ("[info][Get_OS_num] os num: " + os_num )
        return os_num

    def Get_Codepage_num(self, String):
        """
            BuFF 경로에 저장한 OS.ini에서 codepage_num을 읽어온다.
            Library 내부에서 사용
        """
        codepage_num = 0
        #get codepage...

        if ( self.isWindows ) :
            config = ConfigParser.RawConfigParser()
            config.optionxform = str
            config.read('C:\BuFF\OS.ini')
            codepage_num = config.get('info', 'codepage_num')        
        else :
            config = ConfigParser.RawConfigParser()
            config.optionxform = str
            config.read('/BuFF/OS.ini')
            codepage_num = config.get('info', 'codepage_num')
        self._write_log ("[info][Get_Codepage_num] codepage_num: " + codepage_num )
        return codepage_num

    def Get_FileVersion(self, filePath):
        """
            해당 file의 버전정보를 가져온다.
            
            = Example =
            | ${version} = | Get FileVersion| C:/BuFF/notepad.exe |
        """
        ver_parser = Dispatch('Scripting.FileSystemObject')
        fileVersion = ver_parser.GetFileVersion(filePath)
        if fileVersion != '':
            return fileVersion
        else:
            return "none"

    def Compare_file_version(self, filepath, er_version):
        """
            해당 file의 버전과 er_version을 비교한다.
            
            er_version과 file의 version 이 동일하면 return True
            다를 경우 file의 버전이 return된다.
            
            = Example =
            | ${ret} = | Compare File Version| C:/BuFF/notepad.exe | 1.0.0.2 |
        """
        file_version = self.Get_FileVersion (filepath)
        self._write_log ("[info][Compare_file_version]"+ filepath +" version : " + file_version )

        if( file_version.find (er_version) >= 0 or er_version.find(file_version) >= 0 or er_version.find('none') >= 0) :
            return "True"
        else :
            return file_version

    def Compare_file_time(self, filepath, er_time):
        """
            해당 file의 시간과 er_time을 비교한다.
            
            er_time과 file의 time이 동일하면 return True
            er_time보다 file의 time 더 크면 return True
            er_time보다 file의 time 작으면 return file time
            
            = Example =
            | ${ret} = | Compare File Time | C:/BuFF/notepad.exe | 2015-11-12 17:51 |
        """
        tmp_time = self.Get_File_Time (filepath)
        tmp_time_list = tmp_time.rsplit(':',1)
        file_time = tmp_time_list[0]
        
        self._write_log ("[info][Compare_file_time]"+ filepath +" time : " + file_time )

        timestamp = time.mktime(time.strptime(file_time, "%Y-%m-%d %H:%M"))
        er_timestamp = time.mktime(time.strptime(er_time, "%Y-%m-%d %H:%M"))

        if(timestamp == er_timestamp) :
            return "True"

        if(timestamp > er_timestamp) :
            self._write_log ("[warnning][Compare_file_time]"+ filepath +" newer than update server : " + file_time )
            return "True"

        if(timestamp < er_timestamp) :
            self._write_log ("[fail][Compare_file_time]"+ filepath +" is past time : " + file_time )
            return file_time

    def Compare_file_size(self, filepath, er_size):
        """
            해당 file의 size와 er_size을 비교한다.
            
            er_size와 file의 size가 동일하면 return True
            다를 경우 file의 size return된다.
            
            = Example =
            | ${ret} = | Compare File Size| C:/BuFF/notepad.exe | 844999 |
        """
        file_size = str(os.path.getsize(filepath))
        self._write_log ("[info][Compare_file_size]"+ filepath +" size : " + str(file_size) )

        if( file_size != er_size) :
            return file_size
        else :
            return "True"
    

        
    def Compare_File_client (self, productpath, filename, value) :
        """
            ahn.ui, ahn.unix data와 해당 파일을 비교한다. - Client mode

            productpath : suarez.conf 에 정의 된 productpath
            file name : ahn.ui/unix에 key로 정의 된 파일 이름
            value : ahn.ui/unix 에 파일 정보 data
            
            = Example =
            | Compare File Client | /Buff/suarez/ | suare- | 1034262,2015-11-27 09:34,./bin,suarez,,169A3A0F,1998580,C7D47F8F |
        """
        file_info = value.split(',')
        info_size = len (file_info)
        file_name = filename        
        size_info = file_info[0]

        if (info_size == 8) :
            file_name = file_info[3]
            size_info = file_info[6]

        r_result = file_name
        
        file_path = file_info[2]
        file_path = string.replace(file_path,'./', productpath+'/')
        file_path = re.sub("^winsystem",'C:\\Windows\\System32', file_path)
        if(file_path.endswith('\\') or file_path.endswith('/') ) :
            file_path = file_path + file_name

        else :
            if ( self.isWindows ) :
                file_path = file_path + '\\' + file_name
            else :
                file_path = file_path + '/' + file_name

        if( os.path.exists(file_path)) :
            self._write_log ("[Compare_File_client] start compare : "+ file_path)
        else:
            r_result += "[Compare_file_version]" + file_path + ": file not exist"
            return r_result


        if ( self.isWindows ) :
            ret = self.Compare_file_version (file_path, file_info[4])
            if (ret != "True") :
                r_result += "[Compare_file_version] local:"+ ret+', server:'+file_info[4]
        

        ret = self.Compare_file_time (file_path, file_info[1])

        self._write_log ("[Compare_file_time] debug")
        if (ret != "True") :
            r_result += "[Compare_file_time] local:"+ ret+', server:'+file_info[1]
            
        ret = self.Compare_file_size (file_path, size_info)
        if (ret != "True") :
            r_result += "[Compare_file_size] local:"+ ret+', server: '+size_info          

        
        if (r_result == file_name) :
            self._write_log ("[PASS][Compare_File_client]"+ file_name)
            return "PASS"
        else :
            self._write_log ("[fail][Compare_File_client]"+ file_name)
            return r_result
        
        
    def Compare_File_with_ahn_client (self, productpath, ahnfile, section, productId) :
        """
            ahn.ui, ahn.unix에 명시된 해당 section 에 모든 file을 비교한다.

            productpath : suarez.conf 에 정의 된 productpath
            ahnfile: ahn.ui/unix file
            section : 비교 대상 section
            productId : 제품 ID (명시하지 않아도 됨)

            ahn.ui/unix 의 data와 다른 file 에 대해 정보를 포함한 배열이 return 된다.
            
            = Example =
            | ${ret}= | Compare File With Ahn Client | /Buff/suarez/ | /BuFF/down/ahn.unix | _UDZ_SUAREZ_COMMON | 05 |
            | ${n_ret}= | Get Length | ${ret} |
            | Should Be Equal |	${n_ret} | ${0} | there is file not updated :${ret} |
        """
        self._write_log ("[Compare_File_with_ahn_client]"+ "section : "+ section + "path: "  + productpath)
        ahn_data = self.Get_section_data(ahnfile, section)
        base = ""
        OS_flag = False
        CodePage_flag = False
        op = re.compile((r'^\.'))
        r_file_list = list()

        #get os type and locale
        os_num = self.Get_OS_num( platform.platform()) 
        codepage_num = self.Get_Codepage_num( locale.getdefaultlocale())
        
        for ahn_line in ahn_data :
            
            if (ahn_line == '') :
                continue

            temp_data = ahn_line.split ('=')
            
            if ( op.match(ahn_line) and ahn_line.find("OS") > 0 ) :
                if(temp_data[1]  == '0' or temp_data[1]  == os_num  ) :
                    OS_flag = True
                else :
                    OS_flag = False
                continue
        
            if ( op.match(ahn_line) and ahn_line.find("CODEPAGE") > 0 ) :
                if(temp_data[1] == '0' or temp_data[1] == codepage_num ) :
                    CodePage_flag = True
                else :
                    CodePage_flag = False
                continue

            if ( op.match(ahn_line) and ahn_line.find("BASE") > 0 ) :
                base = temp_data[1];
                continue

            if(OS_flag and CodePage_flag) :
                self._write_log ("[Compare_File_with_ahn_client]"+ ahn_line)
                ret = self.Compare_File_client ( productpath, temp_data[0], temp_data[1])
                if(ret != "PASS") :
                    r_file_list.append (ret)

        return r_file_list
         
    def Compare_File_server (self, downloadpath, filename, value) :
        """
            ahn.ui, ahn.unix data와 해당 파일을 비교한다. - Server mode

            downloadpath : suarez.conf 에 정의 된 downloadpath (일반적으로 product path 하위의 /down)
            file name : ahn.ui/unix에 key로 정의 된 파일 이름
            value : ahn.ui/unix 에 파일 정보 data

            해당 파일이 ahn.ui/unix에 명시된 정보와 동일할 경우 return "PASS"
            다를경우 다른 항목에 local , update server정보에 대해 명시한 문자열이 return된다.
            
            = Example =
            | Compare File Server | /Buff/suarez/down | suare- | 1034262,2015-11-27 09:34,./bin,suarez,,169A3A0F,1998580,C7D47F8F |
        """
        file_info = value.split(',')
        file_name = filename        
        size_info = file_info[0]
        file_path = downloadpath
        r_result = file_name

        if ( self.isWindows ) :
            self._write_log ("[Compare_File_server] start compare : "+ file_path + ":" + file_name)
            file_path = string.replace(file_path,'/', '\\')
            file_path = file_path + '\\' + file_name
        else :
            file_path = string.replace(file_path,'\\', '/')
            file_path = file_path + '/' + file_name

        if( os.path.exists(file_path)) :
            self._write_log ("[Compare_File_server] start compare : "+ file_path)
        else:
            r_result += "[Compare_File_server]" + file_path + ": file not exist"
            return r_result


        ret = self.Compare_file_time (file_path, file_info[1])

        self._write_log ("[Compare_file_time] debug")
        if (ret != "True") :
            r_result += "[Compare_file_time] local:"+ ret+', server:'+file_info[1]
            
        ret = self.Compare_file_size (file_path, size_info)
        if (ret != "True") :
            r_result += "[Compare_file_size] local:"+ ret+', server: '+size_info          

        
        if (r_result == file_name) :
            self._write_log ("[PASS][Compare_File_server]"+ file_name)
            return "PASS"
        else :
            self._write_log ("[fail][Compare_File_server]"+ file_name)
            return r_result
        


    def Compare_File_with_ahn_server (self, downloadpath, ahnfile, section, productId) :
        """
            ahn.ui, ahn.unix에 명시된 해당 section 에 모든 file을 비교한다. -Server mode

            downloadpath : suarez.conf 에 정의 된 downloadpath (일반적으로 product path 하위의 /down)
            ahnfile: ahn.ui/unix file
            section : 비교 대상 section
            productId : 제품 ID (엔진의 경우 ${empty})

            ahn.ui/unix 의 data와 다른 file 에 대해 정보를 포함한 배열이 return 된다.
            
            = Example =
            | ${ret}= | Compare File With Ahn Server | /Buff/suarez/down | /BuFF/down/ahn.unix | _UDZ_SUAREZ_COMMON | 05 |
            | ${n_ret}= | Get Length | ${ret} |
            | Should Be Equal |	${n_ret} | ${0} | there is file not updated :${ret} |
        """
        ahn_data = self.Get_section_data(ahnfile, section)
        base = ""
        OS_flag = False
        CodePage_flag = False
        op = re.compile((r'^\.'))
        r_file_list = list()
        
        for ahn_line in ahn_data :
            
            if (ahn_line == '') :
                continue
            
            temp_data = ahn_line.split ('=')

            if ( op.match(ahn_line) and ahn_line.find("BASE") > 0 ) :
                base = temp_data[1]
                continue

            
            if ( op.match(ahn_line)) :
                continue
            

            self._write_log ("[Compare_File_with_ahn_server]"+ ahn_line)
            temp_path = downloadpath +"\\"+ base

            ret = self.Compare_File_server ( temp_path, temp_data[0], temp_data[1])
            if(ret != "PASS") :
                r_file_list.append (ret)

        return r_file_list

    def Compare_delta_server (self, file_path, value) :
        """
            dltlist.ui/dltlist.unix 에 정보와 해당 file을 비교 한다.

            file_path : 비교할 delta file의 Full path
            value : dltlist.ui/dltlist.unix에 명시된 해당 파일 정보

            정보가 동일 할 경우 "PASS" return
            정보가 다를 경우 다른 항목에 대해 명시한 문자열이 return 된다.
            
            = Example =
            | ${ret}= | Compare Delta Server | unix\p\suarez\suarez_hpux\suarez_2013.1.29.8_2015.12.1.10 | 998241,2015-12-01 16:08,66AAE96E |
        """
        file_info = value.split(',')    
        size_info = file_info[0]
        

        if ( self.isWindows ) :
            file_path = string.replace(file_path,'/', '\\')
            self._write_log ("[Compare_delta_server] start compare : "+ file_path)
        else :
            file_path = string.replace(file_path,'\\', '/')
            self._write_log ("[Compare_delta_server] start compare : "+ file_path)

        r_result = file_path
         
        if( os.path.exists(file_path)) :
            self._write_log ("[Compare_delta_server] start compare : "+ file_path)
        else:
            r_result += "[Compare_delta_server]" + file_path + ": file not exist"
            return r_result


        ret = self.Compare_file_time (file_path, file_info[1])

        self._write_log ("[Compare_file_time] debug")
        if (ret != "True") :
            r_result += "[Compare_file_time] local:"+ ret+', server:'+file_info[1]
            
        ret = self.Compare_file_size (file_path, size_info)
        if (ret != "True") :
            r_result += "[Compare_file_size] local:"+ ret+', server: '+size_info          

        
        if (r_result == file_path) :
            self._write_log ("[PASS][Compare_delta_server]"+ file_path)
            return "PASS"
        else :
            self._write_log ("[fail][Compare_delta_server]"+ file_path)
            return r_result

    def Compare_delta_with_server (self, downloadpath, dltlist, productId) :
        """
            dltlist.ui/dltlist.unix 에 정보와 dlownloadpath 하위의 file을 비교 한다.

            downloadpath : 해당 delta file이 받아 지는 위
            dltlist : 비교할 delta file의 Full path
            productId : 제품 코드 번

            정보가 동일 할 경우 빈 문자열 return
            정보가 다를 경우 해당 파일과 다른 항목에 대한 정보를 포함한 배열이 return
            
            = Example =
            | ${ret}= |	Compare Delta With Server | /BuFF/suarez/down/patch/05/delta | /BuFF/suarez/down/patch/05/dltlist.unix | 05 |
            | ${n_ret}= | Get Length | ${ret} |
            | Should Be Equal | ${n_ret} | ${0} | there is file not updated :${ret} |
        """
        dlt_data = self.Get_section_data(dltlist, "LIST")
        base = ""
        OS_flag = False
        CodePage_flag = False
        op = re.compile((r'^\.'))
        r_file_list = list()
        
        for dlt_line in dlt_data :
            
            if ( dlt_line == '') :
                continue
            
            temp_data = dlt_line.split ('=')
            
            self._write_log ("[Compare_delta_with_server]"+ temp_data[0])
            temp_path = downloadpath +"\\"+ temp_data[0]

            ret = self.Compare_delta_server(temp_path, temp_data[1])
            if(ret != "PASS") :
                r_file_list.append (ret)

        return r_file_list
    
    def Run_Process_No_Redirect(self, run_command):
        """
            결과 값을 기다리지 않고 command를 실행 함

            특정 프로세스를 수행하고 종료, 혹은 return 값에 상관 없이 다른 기능을 수행하고 싶을때,
            혹은 해당 프로세스가 구동 되는 동안 다른 command를 수행해야 할때 사용
        """    
        try:
            sub_process = SubThread(run_command)
            sub_process.start()
            self._write_log ("[Run_Process_No_Redirect]"+ run_command)
            return True
        except Exception as e:
            self._write_log ("[ERROR][Run_Process_No_Redirect]"+ run_command+ repr(e))
            return e


if __name__ == '__main__' :
    name = UpdateLib().Compare_File_with_ahn_client("C:\Program Files\AhnLab\V3IS80\Update","C:/Update/Ahnui/b9/ahn.ui", "_WOZ_V3IS80_RES_MO_IMG", "b9")
