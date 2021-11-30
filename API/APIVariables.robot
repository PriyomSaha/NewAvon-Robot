*** Settings ***
Library           OperatingSystem
*** Variables ***
# URL / URI
${baseUrl}      https://qa-naws.avonnow.com:10001
${authReqUri}       /authentication/client-credentials-token?
${profileCreationUri}       /profile/sign-up/?
${orderUri}             /orders

# AuthCredentials
${ApiKeyParameter}       X-Api-Key=AABBCCDDEEFF11000171.AVP
${cookies}      ss-id=CKFooV6soVvJyWSvyeTp; ss-pid=StDTDyA0UONUPPtGmn7r
${getCookies}   ss-id=tuW05Z1g3eGaw8xg2ZAz; ss-pid=StDTDyA0UONUPPtGmn7r
${orderCookie}  ss-id=6Gjs7soliMHsJ3GFxuDr; ss-pid=StDTDyA0UONUPPtGmn7r
${clientId}         unittest.cc.client
${clientSecret}     RyDQ$h4!KGS=!rqb2Rtv

# Normal *** Variables ***
${formatParameter}      format=json
${tPre}    bearer
${contentType}      application/json
${beeNumber}    400790
${path}=    Output/GetProfileFor

*** Keywords ***
Beautify JSON
    [Arguments]    ${rawData}
    ${json}=             evaluate        json.loads('''${rawData}''')    json
    ${json_string}=      evaluate        json.dumps(${json},indent = 3)     json
    log to console       \n${json_string}
#    [Return]    ${json_string}

Store profile details in text file
    [Arguments]    ${fileName}      ${data}
    ${filePath}=    catenate    ${path}/${fileName}.txt
    Create File    ${filePath}      ${data}     SYSTEM

#TODO BLAZE METER AND j meter perfoncace tools api perfor taurus CI / CD