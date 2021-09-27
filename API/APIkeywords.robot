*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    ../PythonSupports/ApiHandler.py
Library    ../PythonSupports/ExcelHandler.py
Resource    APIVariables.robot

*** Keywords ***
Generate Token
    Create Session      testsession        ${baseUrl}       verify=true
    ${body}=    create dictionary    clientId=${clientId}        clientSecret=${clientSecret}
    ${header}=  create dictionary    Content-Type=${contentType}
    ${resp}=    POST On Session    testsession    ${authReqUri}    json=${body}    headers=${header}    params=${ApiKeyParameter}
    ${source data}=    Evaluate     json.loads("""${resp.content}""")    json
    ${token}=   Catenate   ${tPre} ${source data['accessToken']}
    [Return]    ${token}

Create AE Cust
    [Arguments]    ${token}
    ${header}=  create dictionary       Authorization=${token}      Content-Type=${contentType}   Cookie=${cookies}
    ${data}=    get file    API/ApiDemoFiles/CreateCust.txt
    ${body}=    createAccountDatarandomizer   ${data}
    ${resp}=    POST On Session    testsession    ${profileCreationUri}    data=${body}    headers=${header}    params=${ApiKeyParameter}
    Beautify JSON       ${resp.content}

get profile details
    [Arguments]    ${token}
    ${lasrRow}=   ExcelHandler.GetLastRow     Accounts
    ${beeNumber}=   ExcelHandler.ReadCell    Accounts   ${lasrRow}  3
    ${header}=  create dictionary       Authorization=${token}      Cookie=${getCookies}
    ${resp}=    get on session    testsession       /profile/${beeNumber}      headers=${header}       params=${ApiKeyParameter}&${formatParameter}
    ${profDetails}=   Beautify JSON       ${resp.content}
    Store profile details in text file      ${beeNumber}        ${profDetails}

create order
    [Arguments]    ${token}
    ${header}=  create dictionary       Authorization=${token}      Content-Type=${contentType}     Cookie=${orderCookie}
    ${data}=    get file    API/ApiDemoFiles/Order.txt
    ${body}=    orderNumberRandomizer   ${data}
    ${resp}=    POST On Session    testsession    ${orderUri}   headers=${header}   json=${body}    params=${ApiKeyParameter}
    Beautify JSON       ${resp.content}