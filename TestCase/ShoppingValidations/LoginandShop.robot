*** Settings ***
Library  SeleniumLibrary
Resource    ../../Pages/Home/Shopping/Shopping.robot
Resource    ../../Pages/Home/Login_Signup/Login.robot
Resource    ../SignUpandLogin/BAR.robot
Resource    ../SignUpandLogin/CustomerCreation.robot

*** Keywords ***
REP Login and Shop
    ${email}=   DBconnection.ToGetRandomAccountFromDb    REP
    Log To Console    logging in with ${email}
    Logging In      ${email}
    Shop By Line Number     rep

REP shopping
    ${lastRow}=   ExcelHandler.GetLastRow     Accounts
    ${email}=   ExcelHandler.ReadCell    Accounts   ${lastRow}  1
    Logging In  ${email}
    Shop By Line Number     rep
    Sleep    60

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
    ${email}=   DBconnection.ToGetRandomAccountFromDb    UE
    Log To Console    logging in with ${email}
    Logging In      ${email}
    Shop By Line Number     UE
    Sleep    30

AE cust login and shop
    ${email}=   DBconnection.ToGetRandomAccountFromDb    AE
    Log To Console    logging in with ${email}
    Logging In      ${email}
    Shop By Line Number     AE
    Sleep    30