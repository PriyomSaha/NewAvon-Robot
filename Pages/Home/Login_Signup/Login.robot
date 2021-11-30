*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot
Resource    ../Profile/Profile.robot

*** Variables ***
${signin}   xpath://button[contains(text(),'Sign In')]
${userid}   xpath://input[@name='signinId']
${passContainer}     xpath://input[@name='password']
${signinSubmit}     //button[@data-testid='signin-submit']
${textDropdownConatiner}  xpath://div[@data-testid='mfa-selectbox']
${textDropdown}             xpath://li[@data-testid='mfa-text']
${textDropdownInput}    xpath://input[@name = 'securityCode']

${waitUntilAccountActivated}    xpath://strong[contains(text(),'Welcome back, please sign in.')]

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

    ${accDeactivated}=  Run Keyword And Return Status    Element Should Be Visible      ${textDropdownInput}    ${timeout}
    Run Keyword If    ${accDeactivated}     Activate account and change password

    wait until element is enabled    ${passContainer}
    input text    ${passContainer}       password@1
    click button    ${signinSubmit}

    ${ifWrongPass}=     Run Keyword And Return Status    Element Should Be Visible      ${wrongPass}    ${timeout}
    Run Keyword If    ${ifWrongPass}   Change password

    ${otpHandlerPresent}=     Run Keyword And Return Status    Element Should Be Visible      ${textDropdownConatiner}    ${timeout}
    Run Keyword If    ${otpHandlerPresent}   otpHandler
    ...     ELSE    enter otp

Enter email and continue
    [Arguments]     ${email}
    Wait for Max time
    click element   ${signin}
    input text  ${userid}       ${email}
    Click Continue Button

Activate account and change password
    Enter Otp
    input text    ${passContainer}       password@1
    input text    ${confirmPass}    password@1
    Set Mobile
    Click Button    ${saveButton}
    sleep    ${timeout}


Enter password and click signin
    input text    ${passContainer}         ${pass}
    click button    ${signinSubmit}

otpHandler
    click element       ${textDropdownConatiner}
    click element    ${textDropdown}
    Click Continue Button
    enter otp

Enter Otp
    ${otpBoxPresent}=     Run Keyword And Return Status    Element Should Be Visible      ${textDropdownInput}    ${timeout}
    Run Keyword If    ${otpBoxPresent}   Input code

Input code
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
