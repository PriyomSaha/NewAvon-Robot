*** Settings ***
Library  SeleniumLibrary
Library    ../../PythonSupports/RandomData.py
Resource    ../../Pages/Home/Login_Signup/Signup/Cust.robot
Resource    ../../Handlers/Variables.robot

*** Keywords ***
Creating UE customer
    initialize
    Click Signin Link
    Click Create Account Link
    Set Name
    set cust email
    Set password
    Set Mobile
    Accept Customer agreement
    Click Create Account Button
    Check if cust account created successfully
    go to    ${myProfileUrl}
    Save Cust Account Info To Sheet     Unattached
    Sleep    20
    teardown

Creating AE customer
    initialize
    Click Signin Link
    Click Create Account Link
    Set Name
    set cust email
    Set password
    Set Mobile
    Accept Customer agreement
    Click Create Account Button
    Check if cust account created successfully
    Click find a rep button
    Enter Rep name
    Enter state name
    Click Search Button
    Click Shop with me and Start Shopping now button
    go to    ${myProfileUrl}
    Save Cust Account Info To Sheet     Attached
    Sleep    20
    teardown