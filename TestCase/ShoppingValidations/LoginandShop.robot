*** Settings ***
Library  SeleniumLibrary
Resource    ../../Pages/Home/Shopping/Shopping.robot
Resource    ../../Pages/Home/Login_Signup/Login.robot
Resource    ../SignUpandLogin/BAR.robot
Resource    ../SignUpandLogin/CustomerCreation.robot

*** Keywords ***
REP Login and Shop
    initialize
    ${email}=   DBconnection.ToGetRandomAccountFromDb    REP
    Logging In      ${email}
    Shop By Line Number     rep
    teardown

BAR With 30$ Signup and shop
    BAR With 30$ Kit Signup
    ${lastRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lastRow}  1
    initialize
    Logging In  ${email}
    Shop By Line Number     rep
    Sleep    60
    teardown

BAR With No Cost Signup and shop
    BAR With No Cost Signup
    ${lastRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lastRow}  1
    initialize
    Logging In  ${email}
    Shop By Line Number     rep
    Sleep    60
    teardown

BAR With donation Signup and shop
    BAR With Donation Signup
    ${lastRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lastRow}  1
    initialize
    Logging In  ${email}
    Shop By Line Number     rep
    Sleep    60
    teardown

create AE cust then login and Shop
    Creating AE customer
    ${lastRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lastRow}  1
    initialize
    Logging In      ${email}
    Shop By Line Number     AE
    Sleep    30
    teardown

create ue cust then login and shop
    Creating UE customer
    ${lastRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lastRow}  1
    initialize
    Logging In      ${email}
    Shop By Line Number     UE
    Sleep    30
    teardown

UE cust login and shop
    initialize
    ${email}=   DBconnection.ToGetRandomAccountFromDb    UE
    Logging In      ${email}
    Shop By Line Number     UE
    Sleep    30
    teardown

AE cust login and shop
    initialize
    ${email}=   DBconnection.ToGetRandomAccountFromDb    AE
    Logging In      ${email}
    Shop By Line Number     AE
    Sleep    30
    teardown