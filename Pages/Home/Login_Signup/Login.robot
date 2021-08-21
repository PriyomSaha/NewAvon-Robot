*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot
Resource    ../../../Handlers/Variables.robot

*** Variables ***
${signin}   xpath://button[contains(text(),'Sign In')]
${userid}   xpath://input[@name='signinId']
${pass}     xpath://input[@name='password']
${signinSubmit}     //button[@data-testid='signin-submit']
${textDropdownConatiner}  xpath://div[@data-testid='mfa-selectbox']
${textDropdown}             xpath://li[@data-testid='mfa-text']
${textDropdownInput}    xpath://input[@placeholder = 'Enter Code']


#TODO       login -> password change (with mobile no) -> final pass
#TODO       login -> enter pass -> wrong pass -> forgot pass -> password change (without mobile no) -> final pass
#TODO continue button -> email and pass in excel --- done
*** Keywords ***

Logging In
    [Arguments]     ${email}
    Wait for Max time
    click element   ${signin}
    input text  ${userid}       ${email}
    Click Continue Button
    input text    ${pass}       password@1
    click button    ${signinSubmit}
    otpHandler

otpHandler
    click element       ${textDropdownConatiner}
    click element    ${textDropdown}
    Click Continue Button
    input text    ${textDropdownInput}  111111
    Click Continue Button
