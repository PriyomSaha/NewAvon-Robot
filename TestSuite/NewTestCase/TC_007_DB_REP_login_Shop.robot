*** Settings ***
Resource    ../../TestCase/ShoppingValidations/LoginandShop.robot

*** Test Cases ***
Take a REP from DB - login and shop
    initialize
    REP Login and Shop
    teardown