*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot
Resource    ../../../Handlers/Variables.robot
Resource    ../../../Pages/Payments/Payments.robot
Resource    ../../../Pages/Home/Profile/Profile.robot


*** Variables ***
${productSearchTextbox}     xpath://input[@placeholder = 'Search Keyword']
${addQtyButton}            //button[@class='sc-jHNicF OPFfR'][2]
${addToOrderButton}     //button[contains(text(),'Add to Order')]
${addToBagButton}       //button[contains(text(),'Add to Bag')]
${shoppingCart}         //button[@class='CartIconButton___StyledButton-sc-1gpgp3y-0 cuyPQU']
${checkout1order}       //button[contains(text(),'Checkout 1 Order(s)')]
${brochureCheckoutButton}   //button[contains(text(),'Checkout Now')]
${submitOrderButton}        //button[@id='submit-order-button']
${oldShippingContainer}     //div[@class='AddressPicker__Content-sc-hvmr1h-1 fGdJJs']
${useAsBillingAddressCheckbox}      //label[starts-with(@class, 'MuiFormControlLabel-root-')]
${billingAddressSameAsShippingCheckbox}     (//label[starts-with(@class, 'MuiFormControlLabel-root-')])[position()=3]
${orderNumberContainer}     //div[@class='OrderCompletePage___StyledDiv-sc-amwobz-1 kDAgCL']/div

${sheet}    line numbers
${Number of Products to add}    2

#TODO   Need to change to add to Cart for cust
#TODO VARIABLE SINGLE

*** Keywords ***
Shop By Line Number
    [Arguments]    ${userType}
    Wait for Max time
    Sleep    ${timeout}
    Go To       ${shopByProductNumberUrl}
    FOR     ${i}    IN RANGE    1   ${Number of Products to add}
        ${lineNo}=    ReadExcel      ${sheet}     ${i}    1
        ${quantity}=    ReadExcel      ${sheet}     ${i}    2
        input text      ${productsearchtextbox}     ${lineNo}
        repeat keyword      ${quantity}     Add Quantity

        Run Keyword If    '${userType}' == 'rep'    click add to cart button for rep
        ...     ELSE    click add to cart button for cust

        Sleep    ${timeout}
        click element   ${productsearchtextbox}
    END
    click button    ${shoppingCart}
    wait until element is enabled       ${checkout1order}     200
    click button    ${checkout1order}

    Run Keyword If    '${userType}' == 'rep'    Checkout steps for REP
    ...     ELSE    Checkout steps for Cust

    Check if Old Card Present else add new card
#    ADD NEW CREDIT CARD
    execute javascript    window.scrollTo(0,0)
    click button    ${submitOrderButton}
#    Handling 3DS secure
    wait until element is visible   ${orderNumberContainer}   20
    ${ordConfirmationText}=   Get Text    ${orderNumberContainer}

     FOR    ${i}    IN RANGE    ${timeout}
        sleep    ${timeout}
        ${ordConf}=     Get Text    ${orderNumberContainer}
        ${temp}=   Evaluate    "${ordConfirmationText}" == "${ordConf}"
        exit for loop if    '${temp}' == 'false'
     END
    ordernumberextractor    ${ordConf}

Add Quantity
    wait until element is enabled       ${addQtyButton}
    click element    ${addQtyButton}

click add to cart button for rep
    click button    ${addToOrderButton}

click add to cart button for cust
    click button    ${addToBagButton}

Checkout steps for REP
    ${present}=  Run Keyword And Return Status    Element Should Be Visible     ${brochureCheckoutButton}     10s
    Run Keyword If    ${present}    click brochure button
    click continue button


click brochure button
    click button    ${brochureCheckoutButton}


Checkout steps for Cust
    Click Continue Button
    ${notPresent}=  Run Keyword And Return Status    Element Should not Be Visible     ${oldShippingContainer}     10s
    Run Keyword If    ${notPresent}   set up shipment details

set up shipment details
    Set shipping details
    click element    ${useAsBillingAddressCheckbox}
    Click Continue Button2
    sleep    ${timeout}
    click save button
#    click element    ${billingAddressSameAsShippingCheckbox}
    sleep    10
    execute javascript    window.scrollTo(0,50)