from ExcelHandler import writeCell,getLastRowPlusOne


# def moveFiles():
#     source = ["log.html", "output.xml", "report.html", "selenium-screenshot-1.png"]
#     destination = "Output"
#     main = "../../../"
#     for file in source:
#         if os.path.exists(main + destination + "/" + file):
#             os.remove(main + destination + "/" + file)
#
#         if os.path.exists(main + file):
#             shutil.move(main + file, main + destination)
# moveFiles()

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
    writeCell('Order#',r,1,split[-1].replace('(','').replace(')',''))
    writeCell('Order#', r, 2, split[-2])
    return split[-1].replace('(','').replace(')','')