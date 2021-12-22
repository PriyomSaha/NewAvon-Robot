*** Settings ***
Resource    ../../TestCase/SignUpandLogin/BAR.robot
Resource    ../../TestCase/ShoppingValidations/LoginandShop.robot

*** Test Cases ***
BAR Donation
    initialize
    BAR With Donation Signup
    REP shopping
    teardown