*** Settings ***
Library    SeleniumLibrary
Library    ../../Python Supports/RandomData.py
Library    ../Python Supports/CommonHandler.py
Library    ../Python Supports/ExcelHandler.py
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

*** Keywords ***
Add new Credit Card
    sleep    ${timeout}
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
    ${expYr}=  GetCardExpiryYear
    sleep    ${timeout}
    click element    ${expYr}

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






