*** Settings ***
Library  SeleniumLibrary
Library    Collections
Library     ../../../PythonSupports/DBconnection.py
Library     ../../../PythonSupports/CommonHandler.py
Resource    ../../../Handlers/Keywords.robot
Resource    ../../../Handlers/Variables.robot
Resource    ../../../API/APIVariables.robot


*** Variables ***
${SaturnOrderNumberContainer}         //div[@class='sc-jJMGnK bXUIQO']/strong

*** Keywords ***
Get Saturn Order number from order history and get prowess order number
    wait until element is visible    ${SaturnOrderNumberContainer}
    ${saturnOrdNumberText}=     get text    ${SaturnOrderNumberContainer}
    ${saturnOrderNumber}=   orderHistoryOrderSplitter    ${saturnOrdNumberText}
    Get Prowess Order Number from DB    ${saturnOrderNumber}

Get Prowess Order Number from DB
    [Arguments]    ${saturnOrderNumber}
    ${details}=     toGetProwessOrderNumberAlongWithWarehouse   ${saturnOrderNumber}
    log to console    ${details}

