import pyodbc

# query = "SELECT top 20 o.OrderNumber,ost.FriendlyName[Order Status] from [Order] o INNER JOIN OrderStatus ost ON ost.OrderStatusId = o.OrderStatusId INNER JOIN POEOrders po ON po.OrderId = o.OrderId ORDER BY o.OrderId DESC"
query = "SELECT o.OrderNumber,os.FriendlyName AS [Order Status] FROM [Order] o	INNER JOIN OrderStatus os ON os.OrderStatusId = o.OrderStatusId"
conn = pyodbc.connect(
    "driver={SQL Server};"
    "server=rds-qa-thadb.ccj7tvd1f9lb.us-east-1.rds.amazonaws.com;"
    "Database=ACM;"
    "UID=prowessqa;"
    "PWD=NewAvon@Prowess_qa"
)
cursor = conn.cursor()

# data = cursor.fetchall()
# print(data[:1])

def validateOrderNumber(ordNum):
    cursor.execute(query)
    data = cursor.fetchall()
    l = []
    for i in range(0, 1):
        l.append(list(data[i])[0])
        l.append(type(list(data[i])[0]))
    row = l.index(ordNum)

    return list(data[row])[1]

def checkStatus(ordNum):
    query = "SELECT o.OrderNumber,os.FriendlyName AS [Order Status] FROM [Order] o	INNER JOIN OrderStatus os ON os.OrderStatusId = o.OrderStatusId where o.OrderNumber = '"+ordNum+"'"
    cursor.execute(query)
    data = cursor.fetchall()
    print(data[0][0] +" " +data[0][1])
    # if list(data[0])[1] == 'Submitted':
    #     print(data[0][0])
