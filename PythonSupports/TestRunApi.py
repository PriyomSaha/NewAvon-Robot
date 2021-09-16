import requests
import json
from RandomData import getCustEmail,getFirstName,getLastName

email = getCustEmail()
fname = getFirstName()
lname = getLastName()


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

url = "https://qa-naws.avonnow.com:10001/profile/sign-up/?X-Api-Key=AABBCCDDEEFF11000171.AVP"

payload = json.dumps({"FirstName": fname, "LastName": lname, "EmailAddress": email, "CustomerType": "AE",
                      "phone": {"number": "6516516515", "codeidphonetype": "HOME", "countrycode": "US"}})
headers = {
    'Authorization': token,
    'Content-Type': 'application/json',
    'Cookie': 'ss-id=CKFooV6soVvJyWSvyeTp; ss-pid=StDTDyA0UONUPPtGmn7r'
}

response = requests.request("POST", url, data=payload, headers=headers)

print(response.content)
print(response.status_code)