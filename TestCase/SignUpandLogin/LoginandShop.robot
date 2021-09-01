*** Settings ***
Library  SeleniumLibrary
Resource    ../../Pages/Home/Shopping/Shopping.robot
Resource    ../../Pages/Home/Login_Signup/Login.robot
Resource    ./BAR.robot

*** Keywords ***
REP Login and Shop
    initialize
    Logging In      400508
    Shop By Line Number
    Sleep    60
    teardown

BAR With 30$ Signup and shop
    BAR With 30$ Kit Signup
    ${lasrRow}=   ExcelHandler.GetLastRow     Accounts
    ${beeNumber}=   ExcelHandler.ReadCell    Accounts   ${lasrRow}  1
    initialize
    Logging In  ${beeNumber}
    Shop By Line Number
    Sleep    60
    teardown

BAR With No Cost Signup and shop
    BAR With No Cost Signup
    ${lasrRow}=   ExcelHandler.GetLastRow     Accounts
    ${beeNumber}=   ExcelHandler.ReadCell    Accounts   ${lasrRow}  1
    initialize
    Logging In  ${beeNumber}
    Shop By Line Number
    Sleep    60
    teardown

BAR With donation Signup and shop
    BAR With Donation Signup
    ${lasrRow}=   ExcelHandler.GetLastRow     Accounts
    ${beeNumber}=   ExcelHandler.ReadCell    Accounts   ${lasrRow}  1
    initialize
    Logging In  ${beeNumber}
    Shop By Line Number
    Sleep    60
    teardown