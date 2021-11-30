from ExcelHandler import writeCell, getLastRowPlusOne
from DBconnection import checkStatus, getFinancials, getFinancialsAndStatusForReturn


def birthDateSelector(value):
    xpath = "xpath://li[contains(text(),'"
    return xpath + str(value) + "')]"


def cardExpiryDateSelector(value):
    xpath = "xpath://li[contains(text(),'"
    value = str(value)
    if len(value) == '1':
        value = '0' + value
    return xpath + str(value) + "')]"


def donationAmountSelector(value):
    xpath = "//div[@class='sc-bYwzuL fDDjHD']/div/li["
    return xpath + str(value) + "]"


def orderNumberExtractor(value):
    split = value.split()
    r = getLastRowPlusOne('Order#')
    writeCell('Order#', r, 1, split[-1].replace('(', '').replace(')', ''))
    writeCell('Order#', r, 2, split[-2])
    return split[-1].replace('(', '').replace(')', '')


def toCheckOrders():
    l = ["AVR2110210083105 (100092415)",
         "AVR2110210083112 (100092418",
         " AVR2110210083119 (100092421)",
         "AVR2110210083129 (100092424)",
         "",
         "AVR2110210083131 (100092425)",
         "AVR2110210083133 (100092426)",
         "AVR2110210083135 (100092427)",
         "AVR2110210083201 (100092461)",
         "",
         "AVR2110210083196 (100092458)",
         "AVC2110210083137 (100092428)",
         "AVC2110210083140 (100092430)",
         "AVC2110210083188 (100092454)",
         "AVC2110210083143 (100092432)",
         "",
         "AVC2110210083146 (100092434)",
         "AVC2110210083151 (100092436)",
         "AVC2110210083154 (100092438)",
         "AVG2110210083158 (100092440)",
         "AVG2110210083161 (100092442)",
         ]

    for value in l:
        split = value.split()
        # To check the order Status
        # checkStatus(split[-1].replace('(', '').replace(')', ''))

        # To get the financial transactions
        sheet = 'Fin Trans R3'
        r = getLastRowPlusOne(sheet)

        if len(split) == 0:
            writeCell(sheet, r, 1, '')
        else:
            trans = getFinancials(split[-1].replace('(', '').replace(')', ''))
            writeCell(sheet, r, 1, split[-1].replace('(', '').replace(')', ''))
            writeCell(sheet, r, 2, trans)


# toCheckOrders()

def toCheckReturn():
    sheet = 'Fin Trans R3'
    l = ["RMA# 0000002205",
         "RMA# 0000002207",
         "RMA# 0000002214",
         "RMA# 0000002204",
         "RMA# 0000002211",
         "RMA# 0000002212",
         "RMA #0000002209",
         "RMA #0000002206",
         "RMA #0000002215",
         "RMA #0000002208",
         "RMA #0000002213",
         "RMA #0000002210",
         "",
         "RMA #0000002221",
         "RMA #0000002204",
         "RMA #0000002223",
         "RMA #0000002225",
         "RMA #0000002227",
         "",
         "RMA #0000002228",
         "RMA #0000002226",
         "",
         "RMA #0000002231",
         "RMA #0000002236",
         "",
         "",
         "",
         "RMA #0000002224",
         "RMA #0000002233",
         "RMA #0000002229",
         "RMA #0000002234",
         "RMA #0000002235",
         "RMA #0000002230",
         "RMA #0000002232"
         ]
    for value in l:
        r = getLastRowPlusOne(sheet)
        if len(value) == 0:
            writeCell(sheet, r, 1, '')
            # print()
        else:
            split = value.replace('RMA', '').replace('#', '').replace(' ', '')
            trans = getFinancialsAndStatusForReturn(split)
            writeCell(sheet, r, 1, split)
            writeCell(sheet, r, 2, trans)
            # print(trans)


toCheckReturn()


def lineNumberExtractor(value):
    return value.replace('-', '')


def qtyExtractor(value):
    return value.replace('QTY ', '')


def creatingProductDetails(productsList, qtysList):
    length = len(productsList)
    productDetails = {}
    for i in range(0, length):
        productDetails[productsList[i]] = qtysList[i]

    return productDetails


def validateDBandSaturnProductDetails(prodDetailsSaturn, prodDetailsDB):
    isPresent = True
    for key, val in prodDetailsSaturn.items():
        if prodDetailsDB[key] != val:
            isPresent = False

    return isPresent


def orderHistoryOrderSplitter(value):
    split = value.split()
    return split[-1]
