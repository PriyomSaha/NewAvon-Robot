from faker import Faker
import random
from CommonHandler import birthDateSelector , cardExpiryDateSelector ,donationAmountSelector

fake = Faker()
fname = fake.first_name()
lname = fake.last_name()

def getFirstName():
    return fname


def getLastName():
    return lname

def getFullName():
    return fname+' '+lname

def getAddress():
    return fake.street_address()


def getRepEmail():
    return 'PS_'+fname + lname + fake.numerify(text='###%%%')+'@rep.com'


def getCustEmail():
    return 'PS_'+fname + lname + fake.numerify(text='###%%%')+'@cust.com'


# TODO add the ss and reports in a different folder and exclude that folder from git upload

def languageSelector():
    lang = ['en', 'es']
    return random.choice(lang)


def getBirthMonth():
    return birthDateSelector(random.randrange(1, 12))


def getBirthDay():
    return birthDateSelector(random.randrange(1, 28))


def getBirthYear():
    return birthDateSelector(random.randrange(1900, 2002))


def getCardExpiryMonth():
    return cardExpiryDateSelector(random.randrange(1,12))

def getCardExpiryYear():
    return cardExpiryDateSelector(random.randrange(2022,2040))

def getCVV():
    return random.randrange(100,999)

def getDonationAmount():
    return donationAmountSelector(random.randrange(1,4))
