*** Settings ***
Library  SeleniumLibrary
Resource    ../../Pages/Home/Login_Signup/Login.robot
Resource    ../../Pages/Home/Shopping/OrderHistoryKeyword.robot
Library     ../../PythonSupports/DBconnection.py

*** Keywords ***
Order number validation between saturn and prowess
    initialize
    ${email}=   ToGetRandomAccountFromDb    REP
    Logging In      17698726
    Sleep    ${timeout}
    Go To       ${orderHistoryUrl}
    Get Saturn Order number from order history and get prowess order number
