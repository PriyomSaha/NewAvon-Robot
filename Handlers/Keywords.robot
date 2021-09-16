*** Settings ***
Library  SeleniumLibrary
Library    ../PythonSupports/ExcelHandler.py
Library    ../PythonSupports/CommonHandler.py
Resource    Variables.robot

*** Variables ***
${continueButton}   //button[contains(text(),'Continue')]
${continueButton2}  (//button[contains(text(),'Continue')])[position()=2]
${continueButton3}  (//button[contains(text(),'Continue')])[position()=3]
${saveButton}    //button[contains(text(),'Save')]

*** Keywords ***
Wait for Max time
    set selenium implicit wait    20seconds

initialize
#    moveFiles
    Create Webdriver     ${browser}  executable_path=C:/Users/848913/PycharmProjects/Driver/chromedriver.exe
    Go To   ${URL}
    Maximize Browser Window
    Sleep   ${timeout}

teardown
    close browser

Click Continue Button
    Wait Until Element Is Enabled    ${continueButton}      200
    Click Button    ${continueButton}

Click Continue Button2
    Wait Until Element Is Enabled    ${continueButton2}      200
    Click Button    ${continueButton2}

Click Continue Button3
    Wait Until Element Is Enabled    ${continueButton3}      200
    Click Button    ${continueButton3}

ReadExcel
    [Arguments]     ${sheetName}       ${row}     ${column}
    ${data}=        readcell    ${sheetName}       ${row}     ${column}
    [Return]    ${data}