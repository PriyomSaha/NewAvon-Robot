*** Settings ***
Resource    ../../TestCase/SignUpandLogin/BAR.robot
Resource    ../../TestCase/ShoppingValidations/LoginandShop.robot

*** Test Cases ***
BAR 30$
    initialize
    BAR With 30$ kit Signup
    REP shopping
    teardown