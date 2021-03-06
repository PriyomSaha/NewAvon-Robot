*** Settings ***
Library  SeleniumLibrary
Resource    ../../../../Handlers/Keywords.robot
Resource    ../../Profile/Profile.robot
Resource    ../Login.robot
*** Variables ***
${createAccountLink}    xpath://div[@class='sc-jJMGnK caTACr']/button[contains(text(),'Create Account')]
${custAgreementCheckbox}    xpath://div[@class='sc-carFqZ hYYIhO']/div[2]/label/label
${createAccountButton}      xpath://div[@class='sc-iCoGMd gqXhCa']/button[contains(text(),'Create Account')]
${findARep}             xpath://div[@class='Headerstyles__UtilArea-sc-q5bcdd-14 hPbKBk']/ul/li/a
${stateCode}        xpath://input[@name='stateCode']
${searchButton}     xpath://button[contains(text(),'Search')]
${repFoundText}     xpath://div[@class='FindARepResultPagestyles__ListHead-sc-18mxffh-3 ftPYaE']/div
${shopWithMeButton}     xpath://button[contains(text(),'Shop With Me')]
${startShoppingNow}     xpath://a[contains(text(),'Start shopping now!')]
${isCustSignUpComplete}     xpath://div[starts-with(@class, 'SignUpCompletedPagestyles__Banner')]
${custEmailContainer}       xpath://div[@class='ProfilePagestyles__InfoItemWrapper-sc-w0j2vi-5 hqTpt']/div[3]/div/div[2]

*** Keywords ***
Click Signin Link
    wait for max time
    Wait Until Element Is Enabled    ${signin}
    click element    ${signin}
    wait until element is enabled    ${userid}

Click Create Account Link
    wait until element is enabled    ${createAccountLink}
    click element    ${createAccountLink}

Accept Customer agreement
    click element    ${custAgreementCheckbox}

Click Create Account Button
    wait until element is enabled    ${createAccountButton}
    click button    ${createAccountButton}

    enter otp

Click find a rep button
    sleep    ${timeout}
    wait until element is enabled   ${findARep}
    click element    ${findARep}

Enter Rep name
    wait until element is enabled       ${firstnameinput}
    input text    ${firstnameinput}     AVVION
    input text    ${lastNameInput}      JOHNSON

Enter state name
    input text    ${stateCode}      New York
    sleep    ${timeout}
    press keys    ${stateCode}      DOWN
    sleep    ${timeout}
    press keys    ${stateCode}      ENTER

Click Search Button
    wait until element is enabled    ${searchButton}
    click element    ${searchButton}

Click Shop with me and Start Shopping now button
    wait until element is visible   ${repfoundtext}
    scroll element into view    ${shopWithMeButton}
    click element    ${shopWithMeButton}
    wait until element is enabled    ${startShoppingNow}
    click element       ${startShoppingNow}

Check if cust account created successfully
    wait until element is visible    ${isCustSignUpComplete}


Save Cust Account Info To Sheet
    [Arguments]    ${notes}
    ${lastRowNo}=   ExcelHandler.GetLastRowPlusOne       Accounts
    ${email}=   Get Text    ${custEmailContainer}
    ExcelHandler.writecell    Accounts   ${lastRowNo}    1   ${email}
    ExcelHandler.writecell    Accounts   ${lastRowNo}    2   Cust
    ExcelHandler.writecell    Accounts   ${lastRowNo}    4   ${notes}