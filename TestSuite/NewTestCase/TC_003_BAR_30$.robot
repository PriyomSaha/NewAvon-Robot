*** Settings ***
Resource    ../../TestCase/SignUpandLogin/BAR.robot

*** Test Cases ***
BAR 30$
    initialize
    BAR With 30$ kit Signup
    teardown