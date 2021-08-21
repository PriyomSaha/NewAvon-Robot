*** Settings ***
Library  SeleniumLibrary
Resource    ../../Pages/Home/Login_Signup/Signup/REP.robot

*** Keywords ***
BAR with 30$ kit
    wait for Max time
    initialize
    Click BAR Link
    Set First Name
    Set Last Name
    Sleep    20
    teardown
