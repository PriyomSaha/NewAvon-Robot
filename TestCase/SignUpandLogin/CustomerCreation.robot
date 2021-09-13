*** Settings ***
Library  SeleniumLibrary
Library    ../../PythonSupports/RandomData.py
Resource    ../../Pages/Home/Login_Signup/Signup/Cust.robot

*** Keywords ***
Creating UE customer
    initialize
    Click Signin Link
    Click Create Account Link
    Set Name
    Set Email
    Set password
    Set Mobile
    Accept Customer agreement
    Click Create Account Button
    Sleep    20
    teardown

Creating AE customer
    initialize
    Click Signin Link
    Click Create Account Link
    Set Name
    Set Email
    Set password
    Set Mobile
    Accept Customer agreement
    Click Create Account Button
    Click find a rep button
    Enter Rep name
    Enter state name
    Click Search Button
    Click Shop with me and Start Shopping now button
    Sleep    20
    teardown