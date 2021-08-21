import openpyxl
import os
from robot.api import logger

path = os.path.abspath("Resources/support.xlsx")

workbook = openpyxl.load_workbook(path)


def readCell(sheetName, r, c):
    sheet = workbook[sheetName]
    return sheet.cell(r, int(c)).value

def writeCell():
    sheet = workbook["line numbesrs"]

    sheet.cell(row=sheet.max_row + 1, column=1, value="jsdoc")
    workbook.save(path)


#print(readCell('line numbers',1, 1))
