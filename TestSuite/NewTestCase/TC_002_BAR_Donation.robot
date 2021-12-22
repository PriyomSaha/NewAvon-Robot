*** Settings ***
Resource    ../../TestCase/SignUpandLogin/BAR.robot

*** Test Cases ***
BAR Donation
    initialize
    BAR With Donation Signup
    teardown