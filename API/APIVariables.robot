*** Variables ***
# URL / URI
${baseUrl}      https://qa-naws.avonnow.com:10001
${authReqUri}       /authentication/client-credentials-token?
${profileCreationUri}       /profile/sign-up/?

# AuthCredentials
${ApiKeyParameter}       X-Api-Key=AABBCCDDEEFF11000171.AVP
${cookies}      ss-id=CKFooV6soVvJyWSvyeTp; ss-pid=StDTDyA0UONUPPtGmn7r
${clientId}         unittest.cc.client
${clientSecret}     RyDQ$h4!KGS=!rqb2Rtv

# Normal *** Variables ***
${formatParameter}      format=json
${tPre}    bearer
${contentType}      application/json
