import RandomData as rd
import random
import datetime

email = rd.getCustEmail()
fname = rd.getFirstName()
lname = rd.getLastName()
ordNum = random.randint(100000001,999999999)
date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S").split(".", 1)

def createAccountDatarandomizer(data):
    updatedData = data.replace('{{fname}}',fname).replace('{{lname}}',lname).replace('{{email}}',email)
    return updatedData

def orderNumberRandomizer(data):
    updatedData = data.replace('{{externalOrderId}}',str(ordNum)).replace('{{currentDate}}',date[0])
    return updatedData
