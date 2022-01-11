*** Settings ***
Library  SeleniumLibrary
Library  ../PythonSupports/DriverManager.py
Library    ../PythonSupports/ExcelHandler.py
Library    ../PythonSupports/CommonHandler.py
Resource    ./Variables.robot

*** Variables ***
${continueButton}   //button[contains(text(),'Continue')]
${continueButton2}  (//button[contains(text(),'Continue')])[position()=2]
${continueButton3}  (//button[contains(text(),'Continue')])[position()=3]
${saveButton}    //button[contains(text(),'Save')]
${sideMenuButton}   //button[@class='MuiButtonBase-root MuiFab-root MuiSpeedDial-fab MuiFab-extended MuiFab-secondary']

*** Keywords ***
Wait for Max time
    set selenium implicit wait    20seconds

initialize
    ${chromedriver_path}=   DriverManager.Get Chromedriver Path
    Create Webdriver     ${browser}   executable_path=${chromedriver_path}
    Log To Console    chrome driver executed
    Go To   ${URL}
    Maximize Browser Window
    Sleep   ${timeout}
    Remove Side Menu Button

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

Remove Side Menu Button
    ${sideMenuButtonVisible}=   Run Keyword And Return Status   wait until element is visible    ${sideMenuButton}      10s
    Run Keyword If    ${sideMenuButtonVisible}      execute javascript
    ...  var elements=document.getElementsByClassName('MuiButtonBase-root MuiFab-root MuiSpeedDial-fab MuiFab-extended MuiFab-secondary');
    ...  elements[0].parentNode.removeChild(elements[0]);