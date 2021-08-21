*** Settings ***
Library  SeleniumLibrary
Resource    ../../Pages/Home/Shopping/Shopping.robot
Resource    ../../Pages/Home/Login_Signup/Login.robot

*** Keywords ***
REP Login and Shop
    initialize
    Logging In      qaps36@rep.com
    Shop By Line Number
    Sleep    20
    teardown


