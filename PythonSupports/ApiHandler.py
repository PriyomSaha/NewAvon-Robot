import json

import RandomData as rd
import random
import datetime

from ExcelHandler import writeCell, getLastRowPlusOne

email = rd.getCustEmail()
fname = rd.getFirstName()
lname = rd.getLastName()
ordNum = random.randint(100000001,999999999)
date = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%SZ")
    # .split(".", 1)

def createAccountDatarandomizer(data):
    updatedData = data.replace('{{fname}}',fname).replace('{{lname}}',lname).replace('{{email}}',email)
    return updatedData

def orderNumberRandomizer(data):
    updatedData = data.replace('{{externalOrderId}}',str(ordNum)).replace('{{currentDate}}',date)
    r = getLastRowPlusOne('API Order#')
    writeCell('API Order#', r, 1,str(ordNum))
    return json.loads(updatedData)
