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


${payload}=     {"ExternalOrderId":"123456799","OrderTypeId":"REP.ECOMM","OrderSource":"CC","GeoCode":"1544564","PCLevel":"4","PremierLevel":"2","PCLevelCurrentCycle":"1","PremierLevelCurrentCycle":"4","OrderWithinTimePeriod":1,"CreatedDateUTC":"2021-09-11T03:49:10.588Z","SubmittedDateUTC":"2021-09-17T15:16:14.852Z","BeeNumberCustomer":8,"BeeNumberPayee":8,"ShippingMethod":"NoCharge","SubTotal":100,"OrderTotal":20,"ShippingCost":0,"Tax":1.54,"ShippingTax":0,"SupplementalShippingFeeForHags":14.54,"WarehouseCode":"1000712","ShippingAddress":{"FirstName":"Carla","LastName":"Adams","AddressLine1":"55ShumanBlvd","AddressLine2":"Ste350","City":"Naperville","StateProvinceCode":"IL","CountryCode":"US","PostalCode":"60563"},"OrderSkus":[{"SkuCode":"202022US23850001354700010005","OrderLineNumber":1,"MarketSetLinkCode":"02","Quantity":1,"PricePaidPerUnit":50,"retailPriceperUnit":25,"TaxAmount":3,"CommissionableValueEarned":20,"QualifyingValueEarned":10,"VersionNumber":"1","ParentSkuCode":"ABC","VersionYear":"2020","FulfillmentIndicator":"YES","VehicleId":"02","OfferId":"23146","ParentSKUCode":"202022US578575423","SubmittedNetPrice":50}],"OrderPayments":[{"PaymentType":"CC","PaymentIdentifier1":"Visa","PaymentIdentifier2":"CARLAADAMS","PaymentIdentifier3":"****4684","PaymentIdentifier4":"122024","AuthorizationTime":"2021-09-17T15:16:14.852Z","AmountCharged":40.54,"billingAddress":{"firstName":"John","lastName":"Doe","addressLine1":"200Watersidedr","city":"FortLee","stateProvinceCode":"NJ","postalCode":"07024","countryCode":"KR"},"TransactionId":"123ABC"}],"OrderFees":[{"FeeSystemKeyword":"CUSTOMER.SUPPLEMENTALSHIPPING","FeeAmount":10.5,"TaxAmount":3.45,"FeeTotal":13.95}]}


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
