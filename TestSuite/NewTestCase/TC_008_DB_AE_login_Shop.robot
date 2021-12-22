*** Settings ***
Resource    ../../TestCase/ShoppingValidations/LoginandShop.robot

*** Test Cases ***
Take an AE customer from DB - Login and Shop
    initialize
    AE cust login and shop
    teardown