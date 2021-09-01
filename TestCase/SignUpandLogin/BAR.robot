*** Settings ***
Library  SeleniumLibrary
Library    ../../Python Supports/RandomData.py
Resource    ../../Pages/Home/Login_Signup/Signup/REP.robot
Resource    ../../Pages/Payments/Payments.robot

*** Variables ***
${spanish}     es

*** Keywords ***
BAR with no cost signup
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
    Set Additional profile details for rep
    Set Address
    click continue button
    Click Save Button
    Check if Connect with an Avon Team page loaded
    Click Select Button
    Click Continue to your signup button
    Click Continue to last step button
    Accept aggrements
    Click Complete Button
    Check if account was created successfully
    Save REP account Info to sheet  'No Cost Signup'
    Sleep    20
    teardown

BAR With 30$ kit Signup
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
    Set Additional profile details for rep
    Set Address
    click continue button
    Click Save Button
    Check if Connect with an Avon Team page loaded
    Click Select Button
    Click Continue to your signup button
    Click 30$ radio button
    Click Continue to last step button
    Add new Credit Card
    Accept aggrements
    Click Complete Button
    Check if account was created successfully
    Save REP account Info to sheet  '30$ kit Signup'
    Sleep    20
    teardown

BAR With Donation Signup
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
    Set Additional profile details for rep
    Set Address
    click continue button
    Click Save Button
    Check if Connect with an Avon Team page loaded
    Click Select Button
    Click Continue to your signup button
    click donation radio button and select donation amount
    Click Continue to last step button
    Add new Credit Card
    Accept aggrements
    Click Complete Button
    Check if account was created successfully
    Save REP account Info to sheet  'Donation Signup'
    Sleep    20
    teardown