*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot

*** Variables ***
${signin}   xpath://button[contains(text(),'Sign In')]
${userid}   xpath://input[@name='signinId']
${passContainer}     xpath://input[@name='password']
${signinSubmit}     //button[@data-testid='signin-submit']
${textDropdownConatiner}  xpath://div[@data-testid='mfa-selectbox']
${textDropdown}             xpath://li[@data-testid='mfa-text']
${textDropdownInput}    xpath://input[@name = 'securityCode']

${wrongPass}        //p[@class='MuiFormHelperText-root MuiFormHelperText-contained Mui-error MuiFormHelperText-filled']

${forgotPassLink}       xpath://span[@class='sc-gKAaRy dnjXoY']
${confirmPass}          xpath://input[@name='confirmPassword']

${pass}     password@1

#TODO       login -> password change (with mobile no) -> final pass
#TODO       login -> enter pass -> wrong pass -> forgot pass -> password change (without mobile no) -> final pass
#TODO continue button -> email and pass in excel --- done
*** Keywords ***

Logging In
    [Arguments]     ${email}
    Enter email and continue    ${email}
    input text    ${passContainer}       password@1
    click button    ${signinSubmit}

    ${ifWrongPass}=     Run Keyword And Return Status    Element Should Be Visible      ${wrongPass}    10s
    Run Keyword If    ${ifWrongPass}   Change password
    otpHandler

Enter email and continue
    [Arguments]     ${email}
    Wait for Max time
    click element   ${signin}
    input text  ${userid}       ${email}
    Click Continue Button

Enter password and click signin
    input text    ${passContainer}         ${pass}
    click button    ${signinSubmit}

otpHandler
    click element       ${textDropdownConatiner}
    click element    ${textDropdown}
    Click Continue Button
    enter otp

Enter otp
    input text    ${textDropdownInput}  111111
    Click Continue Button

Change password
    wait for max time
    click element    ${forgotPassLink}
    otpHandler
    input text    ${passContainer}       password@1
    input text    ${confirmPass}    password@1
    Click Button    ${saveButton}
    sleep    ${timeout}
    wait until element is enabled       ${passContainer}
    input text    ${passContainer}         password@1
    click button    ${signinSubmit}
