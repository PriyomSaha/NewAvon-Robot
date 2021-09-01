*** Settings ***
Library  SeleniumLibrary
Library    ../Python Supports/ExcelHandler.py
Library    ../Python Supports/CommonHandler.py
Resource    Variables.robot

*** Variables ***
${continueButton}   //button[contains(text(),'Continue')]

*** Keywords ***
Wait for Max time
    set selenium implicit wait    200seconds

initialize
    moveFiles
    Create Webdriver     ${browser}  executable_path=C:/Users/848913/PycharmProjects/Driver/chromedriver.exe
    Go To   ${URL}
    Maximize Browser Window
    Sleep   ${timeout}

teardown
    close browser

Click Continue Button
    Wait Until Element Is Enabled    ${continueButton}      200
    Click Button    ${continueButton}

ReadExcel
    [Arguments]     ${sheetName}       ${row}     ${column}
    ${data}=        readcell    ${sheetName}       ${row}     ${column}
    [Return]    ${data}