#-*-coding: utf-8 -*-
import csv

testfile= open('testdata.csv', 'w', encoding='utf-8', newline='')

a = csv.writer(testfile)
a.writerow([1, "서울", True])
a.writerow([2, "대전", False])
a.writerow([3, "제주", True])

testfile.close()
