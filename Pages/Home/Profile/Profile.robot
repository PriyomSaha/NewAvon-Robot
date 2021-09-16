*** Settings ***
Library    SeleniumLibrary
Library    ../../../PythonSupports/RandomData.py
Resource    ../../../Handlers/Keywords.robot

*** Variables ***
${firstNameInput}   xpath://input[@name='firstName']
${shipppingfirstNameInput}         xpath://input[@name='shippingAddress.firstName']
${lastNameInput}    xpath://input[@name='lastName']
${shipppinglastNameInput}         xpath://input[@name='shippingAddress.lastName']
${emailInput}       xpath://input[@name='emailAddr']
${emailRenteredInput}   xpath://input[@name='emailAddrReEntered']
${pass}                 xpath://input[@name='password']
${mobInput}     xpath://input[@name='phoneNumber']
${spanishRadioButton}   xpath://div[contains(text(),'Español')]
${birthMonthConatiner}       xpath://span[contains(text(),'MM')]
${birthDayConatiner}        xpath://span[contains(text(),'DD')]
${birthYearConatiner}       xpath://span[contains(text(),'YYYY')]
${addr1Input}    xpath://input[@name='address1']
${shippingaddr1Input}    xpath://input[@name='shippingAddress.address1']
${pinInput}      xpath://input[@name='zipCode']
${shippingpinInput}     xpath://input[@name='shippingAddress.zipCode']

*** Keywords ***
Set Name
    wait until element is visible   ${firstnameinput}
    ${fname}=   getFirstName
    input text    ${firstnameinput}     ${fname}
    ${lname}=   getLastName
    input text    ${lastNameInput}      ${lname}

set rep email
    ${email}=   GetRepEmail
    input text      ${emailInput}           ${email}
    input text      ${emailRenteredInput}   ${email}

set cust email
    ${email}=   GetCustEmail
    input text      ${emailInput}           ${email}
    input text      ${emailRenteredInput}   ${email}

Set Password
    input text    ${pass}       password@1

Set Mobile
    input text    ${mobInput}   8777777777

Set Language as Spanish
    Wait for Max time
    click element    ${spanishradiobutton}

Set Address
    ${addr1}=   getAddress
    input text    ${addr1Input}  ${addr1}
    input text    ${pinInput}   10001

Click Save Button
    Sleep    ${timeout}
    Click Button    ${saveButton}


Set Additional profile details for rep
    click element    ${birthMonthConatiner}
    ${birthMonth}=  getBirthMonth
    sleep    ${timeout}
    click element   ${birthMonth}
    log to console  ${birthMonth}

    click element    ${birthDayConatiner}
    ${birthDay}=  getBirthDay
    sleep    ${timeout}
    click element   ${birthDay}

    click element    ${birthYearConatiner}
    ${birthYear}=  getBirthYear
    sleep    ${timeout}
    click element   ${birthYear}

Set shipping details
    wait until element is visible   ${shipppingfirstNameInput}
    ${fname}=   getFirstName
    input text    ${shipppingfirstNameInput}     ${fname}
    ${lname}=   getLastName
    input text    ${shipppinglastNameInput}      ${lname}
    ${addr1}=   getAddress
    input text    ${shippingaddr1Input}  ${addr1}
    input text    ${shippingpinInput}   10001