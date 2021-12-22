*** Settings ***
Library  SeleniumLibrary
Library    ../../PythonSupports/RandomData.py
Resource    ../../Pages/Home/Login_Signup/Signup/REP.robot
Resource    ../../Pages/Payments/Payments.robot

*** Variables ***
${spanish}     es

*** Keywords ***
Common Steps For BAR
    Click BAR Link
    Remove Side Menu Button
    Set Name
    set rep email
    Set password
    Set Mobile
    click continue button
    Check if additional rep details page loaded
    ${language}=    languageselector
    Run Keyword If  "${language}"=="${spanish}"    Set Language as Spanish
    Set Additional profile details for rep
    Set Address
    Accept age aggrement
    click continue button
    Click Save Button
    Check if Connect with an Avon Team page loaded
    Click Select Button
    Click Continue to your signup button

BAR with no cost signup
    Common Steps For BAR
    Click Continue to last step button
    Accept aggrements
    Click Complete Button
    Check if account was created successfully
    Save REP account Info to sheet  'No Cost Signup'
    Sleep    20

BAR With 30$ kit Signup
    Common Steps For BAR
    Click 30$ radio button
    Click Continue to last step button
    Add new Credit Card
    Accept aggrements
    Click Complete Button
#    Handling 3DS secure
    Check if account was created successfully
    Save REP account Info to sheet  '30$ kit Signup'
    Sleep    20

BAR With Donation Signup
    Common Steps For BAR
    click donation radio button and select donation amount
    Click Continue to last step button
    Add new Credit Card
    Accept aggrements
    Click Complete Button
#    Handling 3DS secure
    Check if account was created successfully
    Save REP account Info to sheet  'Donation Signup'
    Sleep    20