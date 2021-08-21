*** Settings ***
Library    SeleniumLibrary
Library    ../../../Python Supports/FakeData.py

*** Variables ***
${firstNameInput}   xpath://input[@name='firstName']
${lastNameInput}    xpath://input[@name='lastName']
${emailInput}       xpath://input[@name='emailAddr']
${emailRenteredInput}   xpath://input[@name='emailAddrReEntered']
${pass}                 xpath://input[@name='password']
${mobInput}     xpath://input[@name='phoneNumber']


*** Keywords ***
Set First Name
    ${fname}=   getFirstName
    input text    ${firstnameinput}     ${fname}

Set Last Name
    ${lname}=   getLastName
    input text    ${lastNameInput}      ${lname}
