*** Settings ***
Library  SeleniumLibrary
Resource    ResourceImports.robot

*** Test Cases ***
#SignUp and Login
#    BAR with no cost signup
#    BAR With 30$ kit Signup
#    BAR With Donation Signup
#    REP Login and Shop
#    BAR With donation Signup and shop
#    BAR With No Cost Signup and shop
#    BAR With 30$ Signup and shop
#    Creating UE customer
#    Creating AE Customer
#    create AE cust then login and Shop
#    create ue cust then login and shop


API
    ${token}=    Generate Token
#
    create order        ${token}
#    Create AE Cust      ${token}
#    get profile details     ${token}