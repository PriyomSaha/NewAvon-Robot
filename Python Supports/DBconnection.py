# import mysql.connector as connection
#
# # DBconnectionURL = jdbc:sqlserver://rds-qa-thadb.ccj7tvd1f9lb.us-east-1.rds.amazonaws.com;user=prowessqa;password=NewAvon@Prowess_qa
#
# mydb = connection.connect(host='rds-qa-thadb.ccj7tvd1f9lb.us-east-1.rds.amazonaws.com',
#                           user='prowessqa', password='NewAvon@Prowess_qa',
#                           database='ACM')

import pyodbc

conn = pyodbc.connect(
    "driver={SQL Server};"
    "server=rds-qa-thadb.ccj7tvd1f9lb.us-east-1.rds.amazonaws.com;"
    "Database=ACM;"
    "UID=prowessqa;"
    "PWD=NewAvon@Prowess_qa"
)
cursor = conn.cursor()
cursor.execute("SELECT * FROM CST_ImisData cid")
data = cursor.fetchall()
print(data[:1])