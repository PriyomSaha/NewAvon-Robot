*** Settings ***
Resource    ../../TestCase/ShoppingValidations/LoginandShop.robot

*** Test Cases ***
Take an UE customer from DB - Login and Shop
    initialize
    Guest cust shop
    teardown