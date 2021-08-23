*** Settings ***
Library    SeleniumLibrary
Library    ../../../Python Supports/RandomData.py
Resource    ../../../Handlers/Keywords.robot

*** Variables ***
${firstNameInput}   xpath://input[@name='firstName']
${lastNameInput}    xpath://input[@name='lastName']
${emailInput}       xpath://input[@name='emailAddr']
${emailRenteredInput}   xpath://input[@name='emailAddrReEntered']
${pass}                 xpath://input[@name='password']
${mobInput}     xpath://input[@name='phoneNumber']
${spanishRadioButton}   xpath://div[contains(text(),'Español')]


*** Keywords ***
Set Name
    Wait for Max time
    ${fname}=   getFirstName
    input text    ${firstnameinput}     ${fname}
    ${lname}=   getLastName
    input text    ${lastNameInput}      ${lname}

Set Email
    ${email}=   GetRepEmail
    input text      ${emailInput}           ${email}
    input text      ${emailRenteredInput}   ${email}

Set Password
    input text    ${pass}       password@1

Set Mobile
    input text    ${mobInput}   8777777777

Set Language as Spanish
    Wait for Max time
    click element    ${spanishradiobutton}