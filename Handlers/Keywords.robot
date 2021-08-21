*** Settings ***
Library  SeleniumLibrary
Library    ../Python Supports/ExcelHandler.py
Resource    Variables.robot

*** Variables ***
${continueButton}   //button[contains(text(),'Continue')]

*** Keywords ***
Wait for Max time
    set selenium implicit wait    200seconds

initialize
    Create Webdriver     ${browser}  executable_path=C:/Users/848913/PycharmProjects/Driver/chromedriver.exe
    Go To   ${URL}
    Maximize Browser Window

teardown
    close browser

Click Continue Button
    Click Button    ${continueButton}

ReadExcel
    [Arguments]     ${sheetName}       ${row}     ${column}
    ${data}=        readcell    ${sheetName}       ${row}     ${column}
    [Return]    ${data}