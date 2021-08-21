*** Settings ***
Library  SeleniumLibrary
Resource    ../../../Handlers/Keywords.robot
Resource    ../../Profile/Profile.robot

*** Variables ***
${barLink}      //a[contains(text(),'Become a Rep')]
${joinusLink}   //a[contains(text(),'Join Us!')]



*** Keywords ***
Click BAR link
    Wait For Max Time
    Click Element    ${barLink}
    Click Element    ${joinusLink}
