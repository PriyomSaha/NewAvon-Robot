import RandomData as rd

email = rd.getCustEmail()
fname = rd.getFirstName()
lname = rd.getLastName()

def apiTestDatarandomizer(data):
    updatedData = data.replace('{{fname}}',fname).replace('{{lname}}',lname).replace('{{email}}',email)
    return updatedData