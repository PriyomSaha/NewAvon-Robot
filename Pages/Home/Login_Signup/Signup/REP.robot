*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot
Resource    ../../Profile/Profile.robot

*** Variables ***
${barLink}      //a[contains(text(),'Become a Rep')]
${joinusLink}   //a[contains(text(),'Join Us!')]
${repAdditionalDetailsPage}     xpath://strong[contains(text(),'Language Preference')]


*** Keywords ***
Click BAR link
    Wait for Max time
    Click Element    ${barLink}
    Click Element    ${joinusLink}

Check if additional rep details page loaded
    wait until element is visible   ${repAdditionalDetailsPage}