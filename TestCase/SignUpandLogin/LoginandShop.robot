*** Settings ***
Library  SeleniumLibrary
Resource    ../../Pages/Home/Shopping/Shopping.robot
Resource    ../../Pages/Home/Login_Signup/Login.robot
Resource    ./BAR.robot
Resource    ./CustomerCreation.robot

*** Keywords ***
REP Login and Shop
    initialize
    Logging In      400508
    Shop By Line Number     rep
    Sleep    60
    teardown

BAR With 30$ Signup and shop
    BAR With 30$ Kit Signup
    ${lasrRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lasrRow}  1
    initialize
    Logging In  ${email}
    Shop By Line Number     rep
    Sleep    60
    teardown

BAR With No Cost Signup and shop
    BAR With No Cost Signup
    ${lasrRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lasrRow}  1
    initialize
    Logging In  ${email}
    Shop By Line Number     rep
    Sleep    60
    teardown

BAR With donation Signup and shop
    BAR With Donation Signup
    ${lasrRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lasrRow}  1
    initialize
    Logging In  ${email}
    Shop By Line Number     rep
    Sleep    60
    teardown

create AE cust then login and Shop
#    Creating AE customer
    ${lasrRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lasrRow}  1
    initialize
    Logging In      ${email}
    Shop By Line Number     AE
    Sleep    60
    teardown