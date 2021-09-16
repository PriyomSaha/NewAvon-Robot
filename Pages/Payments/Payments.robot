*** Settings ***
Library    SeleniumLibrary
Library    ../../PythonSupports/RandomData.py
Library    ../PythonSupports/CommonHandler.py
Library    ../PythonSupports/ExcelHandler.py
Resource    ../../Handlers/Variables.robot
Resource    ../../Handlers/Keywords.robot



*** Variables ***
${isOldCardPresent}     xpath://p[contains(text(),'Please confirm that your billing address is tied t')]
${savedCard}        xpath://div[@class='sc-eGJWMs gQYBcx']/div/div/div/div/div
${creditCardCheckbox}   xpath://div[contains(text(),'Save credit card information to My Account')]
${addCreditCardButton}      xpath://div[@role='button' and @class='CreditManagement__AddNewCreditCardButton-sc-1sd78gv-0 hUwcSA']
${creditCardNumberInput}    xpath://input[@placeholder='Enter Card Number']
${cvvInput}                 xpath://input[@placeholder='CVV']
${creditCardNameInput}      xpath://input[@name = 'card.cardName']
${expiryMonthContainer}     xpath://span[contains(text(),'MM')]
${expiryYearContainer}      xpath://span[contains(text(),'Year')]

${cardNumberFrame}  xpath://div[@id='number-container']/iframe
${cardCVVFrame}      xpath://div[contains(@id,'securityCode-container')]/iframe

${threedsframeAvailable}    xpath://h3[contains(text(),'3DS Secure')]
${threeDsframe1}        step-up-iframe
${threeDsframe2}        xpath://div[@id='stepUpView']/div/iframe
${authCode}         xpath://div[@id='page-wrapper']/section/div[2]/form/input
${submit}           xpath://div[@id='page-wrapper']/section/div[2]/form/input[2]
${cancel}          xpath://div[@id='page-wrapper']/section/div[2]/form[3]/input[2]

*** Keywords ***
Add new Credit Card
    sleep    ${timeout}
    wait until element is enabled    ${addCreditCardButton}
    click element    ${addCreditCardButton}
    sleep    10

    select frame    ${cardNumberFrame}
    input text      ${creditCardNumberInput}        4111 1111 1111 1111
    unselect frame

    ${name}=    getFullName
    input text    ${creditCardNameInput}    ${name}

    click element    ${expiryMonthContainer}
    ${expMon}=  getCardExpiryMonth
    sleep    ${timeout}
    click element    ${expMon}

    click element    ${expiryYearContainer}
    sleep    ${timeout}
    ${expYr}=  GetCardExpiryYear
    sleep    ${timeout}
    click element    ${expYr}
    sleep    ${timeout}

    select frame    ${cardCVVFrame}
    ${cvv}=     getCVV
    input text    ${cvvInput}   ${cvv}
    Unselect Frame

    click element    ${creditCardCheckbox}



click old card
    click element    ${savedCard}
    sleep    ${timeout}

    select frame    ${cardCVVFrame}
    ${cvv}=     getCVV
    input text    ${cvvInput}   ${cvv}
    Unselect Frame
#    click continue button

Check if Old Card Present else add new card
    ${present}=  Run Keyword And Return Status    Element Should Be Visible     ${isOldCardPresent}     10s
    Run Keyword If    ${present}   click old card
    ...     ELSE    Add New Credit Card

Handling 3DS secure
    wait until element is visible       ${threedsframeAvailable}    200s
    sleep    10
    Select Frame    id:${threeDsframe1}
    select frame    ${threeDsframe2}
    wait until element is enabled    ${authCode}    10s
    input text      ${authCode}     1234
#    sleep    10
    scroll element into view    ${cancel}
    wait until element is enabled    ${submit}    10s
    click button    ${submit}
    unselect frame
    unselect frame





