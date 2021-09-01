*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot
Resource    ../../Profile/Profile.robot

*** Variables ***
${barLink}      //a[contains(text(),'Become a Rep')]
${joinusLink}   //a[contains(text(),'Join Us!')]
${repAdditionalDetailsPage}     xpath://strong[contains(text(),'Language Preference')]
${connectWithAvonTeam}      xpath://strong[contains(text(),'Connect with an Avon Team')]
${selectButton}         //button[contains(text(),'Select')]
${signupTypeButton}     //button[contains(text(),'Continue to Your Signup')]
${lastStepContinueButton}   //button[contains(text(),'Continue to Last Step')]
${aggrement1Checkbox}       xpath://div[@direction='column']/div[1]/label/label/span[1]
${aggrement2Checkbox}       xpath://div[@direction='column']/div[2]/label/label/span[1]
${completeButton}   //button[contains(text(),'Complete')]
${repAccountInfo}   xpath://strong[contains(text(),'Your Representative Info')]
${emailContainer}        xpath://strong[contains(text(),'Email Address')]/following-sibling::div
${beeNumberContainer}    xpath://strong[contains(text(),'Avon Account Number')]/following-sibling::div
${kitRadio}   xpath://div[contains(text(),'New Representative Color Set')]
${donationRadio}    xpath://div[contains(text(),'Make a Contribution')]
#//div[@class='sc-eirqVv gZrHDm' and contains(text(),'Sign UP &  Make a Contribution')]
${donationAmountDropdown}   xpath://span[@class='sc-giAqHp irplsb' and contains(text(),'Select an Option')]

*** Keywords ***
Click BAR link
    Wait for Max time
    Click Element    ${barLink}
    Click Element    ${joinusLink}

Check if additional rep details page loaded
    wait until element is visible   ${repAdditionalDetailsPage}

Check if Connect with an Avon Team page loaded
    wait until element is visible   ${connectWithAvonTeam}

Click Select Button
    click button    ${selectButton}

Click Continue to your signup button
    Wait Until Element Is Enabled    ${signupTypeButton}
    click button    ${signupTypeButton}

Click 30$ radio button
    wait until element is enabled    ${kitradio}
    click element    ${kitradio}

click donation radio button and select donation amount
    Wait Until Element Is Enabled    ${donationRadio}
    click element    ${donationRadio}
    Wait Until Element Is Enabled    ${donationAmountDropdown}
    click element    ${donationAmountDropdown}
    ${donAmt}=  getDonationAmount
    click element    ${donAmt}


Click Continue to last step button
    Wait Until Element Is Enabled    ${lastStepContinueButton}
    click button    ${lastStepContinueButton}

Accept aggrements
    Scroll Element Into View    ${aggrement1Checkbox}
    click element   ${aggrement1Checkbox}
    click element    ${aggrement2checkbox}

Click Complete Button
    Wait Until Element Is Enabled   ${completeButton}
    click button    ${completeButton}

Check if account was created successfully
    wait until element is visible    ${repAccountInfo}

Save REP account Info to sheet
    [Arguments]    ${notes}
    ${lastRowNo}=   ExcelHandler.GetLastRowPlusOne     Accounts
    ${bee}=     Get Text    ${beeNumberContainer}
    ${email}=   Get Text    ${emailContainer}
    ExcelHandler.writecell    Accounts   ${lastRowNo}    1   ${email}
    ExcelHandler.writecell    Accounts   ${lastRowNo}    2   REP
    ExcelHandler.writecell    Accounts   ${lastRowNo}    3   ${bee}
    ExcelHandler.writecell    Accounts   ${lastRowNo}    4   ${notes}


