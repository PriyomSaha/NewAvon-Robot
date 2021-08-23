from faker import Faker
import random

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


# print(getCustEmail())
# TODO add the ss and reports in a different folder and exclude that folder from git upload

def languageSelector():
    lang = ['en', 'es']
    return random.choice(lang)
