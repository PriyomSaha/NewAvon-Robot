import pyodbc
import string
import random

conn = pyodbc.connect(
    "driver={SQL Server};"
    "server=rds-qa-thadb.ccj7tvd1f9lb.us-east-1.rds.amazonaws.com;"
    "Database=ACM;"
    "UID=prowessqa;"
    "PWD=NewAvon@Prowess_qa"
)
cursor = conn.cursor()
l = []


def validateOrderNumber(ordNum):
    queryForOrderStatus = "SELECT top 20 o.OrderNumber,ost.FriendlyName[Order Status] from [Order] o INNER JOIN OrderStatus ost ON ost.OrderStatusId = o.OrderStatusId INNER JOIN POEOrders po ON po.OrderId = o.OrderId ORDER BY o.OrderId DESC"
    cursor.execute(queryForOrderStatus)
    data = cursor.fetchall()
    for i in range(0, 20):
        l.append(list(data[i])[0])
    row = l.index(ordNum)

    return list(data[row])[1]


# ignore - not for frame work
def checkStatus(ordNum):
    queryForOrderNumbersWithStatus = "SELECT o.OrderNumber,os.FriendlyName AS [Order Status] FROM [Order] o	INNER JOIN OrderStatus os ON os.OrderStatusId = o.OrderStatusId where o.OrderNumber = '" + ordNum + "'"
    cursor.execute(queryForOrderNumbersWithStatus)
    data = cursor.fetchall()
    print(data[0][0] + " " + data[0][1])
    # if list(data[0])[1] == 'Submitted':
    #     print(data[0][0])


def toFetchLineNoAndQtyForOrder(ordNum):
    ordNum = str(ordNum)
    queryTogetLineNumber = "SELECT os.LineNumber,ex.LineNumber, os.Quantity, ex.BranchSetTag ,ex.MSetComponentTag FROM [Order] o INNER JOIN OrderSku os ON os.OrderId = o.OrderId INNER JOIN Sku s ON s.SkuId = os.SkuId INNER JOIN SkuEx_NAVSKU ex on ex.ObjectId = s.SkuId  WHERE  o.OrderNumber = '" + ordNum + "'"
    cursor.execute(queryTogetLineNumber)
    data = cursor.fetchall()

    # to load the data fetched from DB to a list
    for d in data:
        l.append(d)
    # to get the line numbers from list only if it is the SET (not Component) and normal prods
    lineWdQty = {}
    length = len(l)
    for i in range(0, length):
        if (l[i][4] == '' or l[i][4] == 'MS') and (l[i][3] == '' or l[i][3] == 'BS'):
            lineWdQty[str(l[i][1])] = str(l[i][2])

    return (lineWdQty)


def toGetRandomAccountFromDb(accType):
    c = random.choice(string.ascii_letters)
    queryForGettingRandomAcc = "select bc.EMAILADDRESS , bb.BEENUMBER, gc.LEVELID, gen.STATUSTEXT, gc.LevelName from BeeCommunication  bc INNER JOIN BEEBUSINESS bb ON bb.BeeEntityGuid = bc.BeeEntityGuid Join GENCOMPLEVEL gc on  gc.GENCOMPLEVELGUID = bb.GENCOMPLEVELGUID inner join GENSTATUS gen on gen.GENSTATUSGUID = bb.GENSTATUSGUID  where gc.LEVELID ='" + accType + "' and gen.STATUSTEXT = 'Active' and bc.EMAILADDRESS not like '%loadrunner.com' and bc.EMAILADDRESS not like '%mailinator%' and bc.EMAILADDRESS not in ('deanna.mannion@avonusa.com','srivastavasona12345@gmail.com' )and bc.EMAILADDRESS like '" + c + "%'"
    cursor.execute(queryForGettingRandomAcc)
    data = cursor.fetchall()
    return (data[0][0])


def toGetProwessOrderNumberAlongWithWarehouse(ordNum):
    query = "SELECT DISTINCT o.OrderNumber,w.code , Case when w.code = '128499' THEN 'HANES' WHEN w.code = '1000712' THEN 'ZANESVILLE' End AS [WarehouseName] FROM OrderAttribute oa INNER JOIN [Order] o ON o.OrderId = oa.OrderId INNER JOIN OrderSKU os ON os.OrderId =  o.OrderId INNER JOIN Warehouse w ON w.WarehouseId = os.WarehouseId where oa.[Value] in ('" + ordNum + "')"
    cursor.execute(query)
    data = cursor.fetchall()

    orderDetails = {}
    for d in data:
        l.append(d)
    for i in range(0, len(l)):
        orderDetails["Order Number" + str(i + 1)] = str(l[i][0])
        orderDetails["Ware House Code" + str(i + 1)] = str(l[i][1])
        orderDetails["Ware House Name" + str(i + 1)] = str(l[i][2])

    return orderDetails

# ignore - not for frame work
def getFinancials(ordNum):
    query = "select (TransactionCode +'.'+ TransactionBIDSCode) As [TransactionCode],tc.tranDesc from CST_FinancialTransactions ct LEFT JOIN CST_TranCodes tc ON ct.TransactionCode = tc.TranCode AND ct.TransactionBIDSCode = tc.SubCode where ct.OrderNumber IN ('" + ordNum + "')"
    cursor.execute(query)
    data = cursor.fetchall()
    return str(data)
# ignore - not for frame work
def getFinancialsAndStatusForReturn(rma):
    query = "SELECT rma.RMANumber,cdd.CodeId AS [RMAStatus],(cst.TransactionCode +'.'+ cst.TransactionBIDSCode) As [TransactionCode],tc.tranDesc from RMAMaster rma  full JOIN CddCode cdd ON cdd.CddCodeGuid = rma.CddCodeGuidRMAStatus full JOIN CST_FinancialTransactions cst ON cst.OrderNumber = rma.RMANumber full JOIN CST_TranCodes tc ON cst.TransactionCode = tc.TranCode AND cst.TransactionBIDSCode = tc.SubCode where rma.RMANumber = '" + rma + "'"
    cursor.execute(query)
    data = cursor.fetchall()
    return str(data)

def queryForGettingLineNumbers(camp):
    queryForGettingLineNumbers = "select top 1500 Line_No from CST_ImisData cid where Campaign_Id ='" + camp + "'and MSet_Component_Tag not like 'MC' and BSet_Component_Tag not like 'BC' and MSet_Component_Tag not like 'MS' and BSet_Component_Tag not like 'BS' and (Profile_Name like  '%ring%' or Profile_Name like '%perfume%') and Special_Handling1_Cd = '' and cid.Regular_Price > 10"
    cursor.execute(queryForGettingLineNumbers)
    data = cursor.fetchall()
    # to load the data fetched from DB to a list
    for d in data:
        l.append(d)
    length = len(l)
    prod=[]
    for i in range(0, length):
        prod.append(l[i][0])
    return prod