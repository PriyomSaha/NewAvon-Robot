*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot
Resource    ../../../Handlers/Variables.robot

*** Variables ***
${shopByProductNumberUrl}   https://qa-ecom-aws.avon.com/shop-by-product-number
${productSearchTextbox}     xpath://input[@placeholder = 'Search Keyword']
${addQtyButton}            //button[@class='sc-jHNicF OPFfR'][2]
${addToOrderButton}     //button[contains(text(),'Add to Order')]
${shoppingCart}         //button[@class='CartIconButton___StyledButton-sc-1gpgp3y-0 cuyPQU']
${checkout1order}       //button[contains(text(),'Checkout 1 Order(s)')]

${sheet}    line numbers
${Number of Products to add}    3

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
#    Execute JavaScript    window.document.evaluate("//div[@class='Cartstyles__Container-sc-1spxt9b-0 jPtlBq']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    wait until element is enabled       ${checkout1order}     200
    click button    ${checkout1order}
    click continue button


Add Quantity
    wait until element is enabled       ${addQtyButton}
    click element    ${addQtyButton}