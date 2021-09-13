*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot
Resource    ../../../Handlers/Variables.robot
Resource    ../../../Pages/Payments/Payments.robot

*** Variables ***
${shopByProductNumberUrl}   https://qa-ecom-aws.avon.com/shop-by-product-number
${productSearchTextbox}     xpath://input[@placeholder = 'Search Keyword']
${addQtyButton}            //button[@class='sc-jHNicF OPFfR'][2]
${addToOrderButton}     //button[contains(text(),'Add to Order')]
${shoppingCart}         //button[@class='CartIconButton___StyledButton-sc-1gpgp3y-0 cuyPQU']
${checkout1order}       //button[contains(text(),'Checkout 1 Order(s)')]
${brochureCheckoutButton}   //button[contains(text(),'Checkout Now')]
${submitOrderButton}        //button[@id='submit-order-button']

${orderNumberContainer}     //div[@class='OrderCompletePage___StyledDiv-sc-amwobz-1 kDAgCL']/div

${sheet}    line numbers
${Number of Products to add}    2

#TODO   Need to change to add to Cart for cust
#TODO VARIABLE SINGLE

*** Keywords ***
Shop By Line Number
    Wait for Max time
    Sleep    ${timeout}
    Go To       ${shopByProductNumberUrl}
    FOR     ${i}    IN RANGE    1   ${Number of Products to add}
        ${lineNo}=    ReadExcel      ${sheet}     ${i}    1
        ${quantity}=    ReadExcel      ${sheet}     ${i}    2
        input text      ${productsearchtextbox}     ${lineNo}
        repeat keyword      ${quantity}     Add Quantity
        click button    ${addToOrderButton}
        Sleep    ${timeout}
        click element   ${productsearchtextbox}
    END
    click button    ${shoppingCart}
    wait until element is enabled       ${checkout1order}     200
    click button    ${checkout1order}
    Wait Until Element Is Enabled       ${brochureCheckoutButton}
    click button    ${brochureCheckoutButton}
    click continue button
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