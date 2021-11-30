*** Settings ***
Library  SeleniumLibrary
Library    Collections
Library     ../../../PythonSupports/DBconnection.py
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
${checkoutOrder}       (//button[contains(text(),'Checkout')])[position()=2]
${brochureCheckoutButton}   //button[contains(text(),'Checkout Now')]
${submitOrderButton}        //button[@id='submit-order-button']
${oldShippingContainer}     //div[@class='AddressPicker__Content-sc-hvmr1h-1 fGdJJs']
${useAsBillingAddressCheckbox}      //label[starts-with(@class, 'MuiFormControlLabel-root-')]
${billingAddressSameAsShippingCheckbox}     (//label[starts-with(@class, 'MuiFormControlLabel-root-')])[position()=3]
${orderNumberContainer}     //div[contains(@class,'OrderCompletePage___StyledDiv-sc-amwobz')]/div

${sheet}    line numbers
${Number of Products to add}    5

${seeMoreLineNoButton}  //button[contains(text(),'See More')]
${lineNoContainer}      xpath://div[contains(@class, 'Item___StyledDiv5-sc-1ldjd0n-15')]
${qtyContainer}     xpath://div[contains(@class, 'Item__Quentity')]

${payAvonPopup}     xpath://h3[contains(text(),'Pay Avon')]
${makePaymentButtonFinal}    //button[contains(text(),'Make a Payment')]
${makePaymentButton}    //button[contains(text(),'Make A Payment')]
${payAvonContinueButton}    //span[contains(text(),'Continue')]
${payAvonSubmitButton}    //button[contains(text(),'Submit')]
${payAvonOkButton}      //button[contains(text(),'Ok')]


*** Keywords ***
Shop By Line Number
    [Arguments]    ${userType}
    Wait for Max time
    Sleep    ${timeout}
    Go To       ${shopByProductNumberUrl}
    FOR     ${i}    IN RANGE    0   ${Number of Products to add}
        ${row}=     Evaluate    ${i}+1
        ${lineNo}=    ReadExcel      ${sheet}   ${row}    1
        ${quantity}=    ReadExcel      ${sheet}     ${row}    2
        ${quantity}=    Evaluate    ${quantity}-1

        input text      ${productsearchtextbox}     ${lineNo}

        ${addQtyEnabled}=   Run Keyword And Return Status    wait until element is enabled      ${addQtyButton}

        Run Keyword If    ${addQtyEnabled}   repeat keyword      ${quantity}    Add Quantity

        Run Keyword If    '${userType}' == 'rep'    click add to cart button for rep
        ...     ELSE    click add to cart button for cust
        Sleep    ${timeout}
        click element   ${productsearchtextbox}
    END
    Complete the checkout flow  ${userType}

Complete the checkout flow
    [Arguments]    ${userType}
    click button    ${shoppingCart}
    wait until element is enabled       ${checkoutOrder}     200
    click button    ${checkoutOrder}

    Run Keyword If    '${userType}' == 'rep'    Checkout steps for REP
    ...     ELSE    Checkout steps for Cust

    Check if Old Card Present else add new card

    execute javascript    window.scrollTo(0,0)

    ${productDetailsSaturn}=    store line numbers and quantity before placing order

    execute javascript    window.scrollTo(0,0)
    wait until element is enabled    ${submitOrderButton}
    click button    ${submitOrderButton}
#    Handling 3DS secure
    wait until element is visible   ${orderNumberContainer}   300
    ${ordConfirmationText}=   Get Text    ${orderNumberContainer}

     FOR    ${i}    IN RANGE    ${timeout}
        sleep    ${timeout}
        ${ordConf}=     Get Text    ${orderNumberContainer}
        ${temp}=   Evaluate    "${ordConfirmationText}" == "${ordConf}"
        exit for loop if    '${temp}' == 'false'
     END
    ${ordNumber}=  ordernumberextractor    ${ordConf}
    ${isOrderPresentInDB}=  validateOrderNumber     ${ordNumber}
    log to console    The order# ${ordNumber} is in ${isOrderPresentInDB} status

    Log To Console    Validating if all the products from Saturn are present in DB...

    ${productDetailsProwess}=   toFetchLineNoAndQtyForOrder     ${ordNumber}

    ${isAvailable}=    validateDBandSaturnProductDetails       ${productDetailsSaturn}     ${productDetailsProwess}
    Log To Console      All Products available? : ${isAvailable}


Add Quantity
    click element    ${addQtyButton}


click add to cart button for rep
    ${addtocartenabled}=    Run Keyword And Return Status    Element Should Be Visible  ${addToOrderButton}
    Run Keyword If    ${addtocartenabled}   click button    ${addToOrderButton}

click add to cart button for cust
    ${addtocartenabled}=    Run Keyword And Return Status    Element Should Be Visible  ${addToBagButton}
    Run Keyword If    ${addtocartenabled}   click button    ${addToBagButton}

Checkout steps for REP
    ${brochurePresent}=  Run Keyword And Return Status    Element Should Be Visible     ${brochureCheckoutButton}     10s
    Run Keyword If    ${brochurePresent}    click brochure button

    ${pastDuePresent}=  Run Keyword And Return Status    Element Should Be Visible      ${payAvonPopup}     10s
    Run Keyword If    ${pastDuePresent}    clear the past due

    click continue button

clear the past due
    click button    ${makePaymentButton}
    wait until element is enabled    ${makePaymentButtonFinal}
    click button    ${makePaymentButtonFinal}

    Check if Old Card Present else add new card

    click element    ${payAvonContinueButton}

    wait until element is enabled    ${payAvonSubmitButton}
    click element    ${payAvonSubmitButton}

    Wait Until Element Is Enabled   ${payAvonOkButton}
    click element    ${payAvonOkButton}

    Complete the checkout flow  rep


click brochure button
    click button    ${brochureCheckoutButton}

Checkout steps for Cust
    Click Continue Button
    ${notPresent}=  Run Keyword And Return Status    Element Should not Be Visible     ${oldShippingContainer}     10s
    Run Keyword If    ${notPresent}   set up shipment details
    ...     ELSE    Click Continue Button2

set up shipment details
    Set shipping details
    click element    ${useAsBillingAddressCheckbox}
    Click Continue Button2
    sleep    ${timeout}
    click save button
#    click element    ${billingAddressSameAsShippingCheckbox}
    sleep    10
    execute javascript    window.scrollTo(0,50)


click See more products if present
    click button    ${seeMoreLineNoButton}
    sleep    ${timeout}

store line numbers and quantity before placing order

    ${seeMorePresent}=  Run Keyword And Return Status    Element Should Be Visible     ${seeMoreLineNoButton}     1s
    Run Keyword If    ${seeMorePresent}   click See more products if present

    #For fetching and storing Line Numbers (including free prods) from front end
    @{productsList}=    Create List
    ${lineNoElements}=    Get WebElements    ${lineNoContainer}
    FOR    ${element}    IN    @{lineNoElements}
        ${text}=    get text    ${element}
        ${lineNo}=  lineNumberExtractor     ${text}
        Append To List    ${productsList}   ${lineNo}
    END
    #For fetching and storing Quantity for Line Numbers (including free prods) from front end
    @{qtysList}=    Create List
    ${qtyElements}=    Get WebElements    ${qtyContainer}
    FOR    ${element}    IN    @{qtyElements}
        ${text}=    get text    ${element}
        ${qty}=  qtyExtractor     ${text}
        Append To List    ${qtysList}   ${qty}
    END

    ${prodDetails}=     creatingProductDetails  ${productsList}     ${qtysList}

    [Return]    ${prodDetails}