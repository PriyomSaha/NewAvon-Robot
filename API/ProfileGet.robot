*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    ../PythonSupports/ApiHandler.py
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
    ${body}=    apiTestDatarandomizer   ${data}
    ${resp}=    POST On Session    testsession    ${profileCreationUri}    data=${body}    headers=${header}    params=${ApiKeyParameter}
    log to console    ${resp.content}