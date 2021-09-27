import requests
import json
from ApiHandler import orderNumberRandomizer

url = "https://qa-naws.avonnow.com:10001/authentication/client-credentials-token?X-Api-Key=AABBCCDDEEFF11000171.AVP"

payload = json.dumps({
    "clientId": "unittest.cc.client",
    "clientSecret": "RyDQ$h4!KGS=!rqb2Rtv"
})
headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Cookie': 'ss-id=CKFooV6soVvJyWSvyeTp; ss-pid=StDTDyA0UONUPPtGmn7r'
}

response = requests.request("POST", url, headers=headers, data=payload)
resp = json.loads(response.text)
token = "bearer " + resp["accessToken"]

url = "https://qa-naws.avonnow.com:10001/orders?format=json&X-Api-Key=AABBCCDDEEFF11000171.AVP"

headers = {
    'Authorization': token,
    'Cookie': 'ss-id=6Gjs7soliMHsJ3GFxuDr; ss-pid=StDTDyA0UONUPPtGmn7r'
}

# payload = {"ExternalOrderId":"12345679","OrderTypeId":"REP.ECOMM","OrderSource":"CC","GeoCode":"1544564","PCLevel":"4","PremierLevel":"2","PCLevelCurrentCycle":"1","PremierLevelCurrentCycle":"4","OrderWithinTimePeriod":1,"CreatedDateUTC":"2021-09-11T03:49:10.588Z","SubmittedDateUTC":"2021-09-17T15:16:14.852Z","BeeNumberCustomer":8,"BeeNumberPayee":8,"ShippingMethod":"NoCharge","SubTotal":100,"OrderTotal":20,"ShippingCost":0,"Tax":1.54,"ShippingTax":0,"SupplementalShippingFeeForHags":14.54,"WarehouseCode":"1000712","ShippingAddress":{"FirstName":"Carla","LastName":"Adams","AddressLine1":"55ShumanBlvd","AddressLine2":"Ste350","City":"Naperville","StateProvinceCode":"IL","CountryCode":"US","PostalCode":"60563"},"OrderSkus":[{"SkuCode":"202022US23850001354700010005","OrderLineNumber":1,"MarketSetLinkCode":"02","Quantity":1,"PricePaidPerUnit":50,"retailPriceperUnit":25,"TaxAmount":3,"CommissionableValueEarned":20,"QualifyingValueEarned":10,"VersionNumber":"1","ParentSkuCode":"ABC","VersionYear":"2020","FulfillmentIndicator":"YES","VehicleId":"02","OfferId":"23146","ParentSKUCode":"202022US578575423","SubmittedNetPrice":50}],"OrderPayments":[{"PaymentType":"CC","PaymentIdentifier1":"Visa","PaymentIdentifier2":"CARLAADAMS","PaymentIdentifier3":"****4684","PaymentIdentifier4":"122024","AuthorizationTime":"2021-09-17T15:16:14.852Z","AmountCharged":40.54,"billingAddress":{"firstName":"John","lastName":"Doe","addressLine1":"200Watersidedr","city":"FortLee","stateProvinceCode":"NJ","postalCode":"07024","countryCode":"KR"},"TransactionId":"123ABC"}],"OrderFees":[{"FeeSystemKeyword":"CUSTOMER.SUPPLEMENTALSHIPPING","FeeAmount":10.5,"TaxAmount":3.45,"FeeTotal":13.95}]}

f=open("C:/Users/848913/PycharmProjects/Avon/API/ApiDemoFiles/Order.txt",'r')
data =f.read()
jsn = orderNumberRandomizer(data)

response = requests.request("POST", url, headers=headers, json=jsn)

# t = json.load((response.status_code)
# print(json.dumps(t,indent=1))

print(response.status_code)
print(response.content)
# print(response.status_code)
