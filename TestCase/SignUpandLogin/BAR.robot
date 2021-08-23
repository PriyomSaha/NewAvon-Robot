*** Settings ***
Library  SeleniumLibrary
Library    ../../Python Supports/RandomData.py
Resource    ../../Pages/Home/Login_Signup/Signup/REP.robot

*** Variables ***
${spanish}     es

*** Keywords ***
BAR with 30$ kit
    initialize
    Click BAR Link
    Set Name
    Set Email
    Set password
    Set Mobile
    click continue button
    Check if additional rep details page loaded
    ${language}=    languageselector
    Run Keyword If  "${language}"=="${spanish}"    Set Language as Spanish
    Sleep    20
    teardown
