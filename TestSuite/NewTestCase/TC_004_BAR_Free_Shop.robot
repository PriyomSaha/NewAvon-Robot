*** Settings ***
Resource    ../../TestCase/SignUpandLogin/BAR.robot
Resource    ../../TestCase/ShoppingValidations/LoginandShop.robot

*** Test Cases ***
BAR free
    initialize
    BAR with no cost signup
    REP shopping
    teardown