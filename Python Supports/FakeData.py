from faker import Faker

fake = Faker()


def getFirstName():
    return fake.first_name()


def getLastName():
    return fake.last_name()


def getAddress():
    return fake.street_address()


def getRepEmail():
    return getFirstName() + getLastName() + '@rep.com'


def getCustEmail():
    return getFirstName() + getLastName() + '@cust.com'


print(getCustEmail())
