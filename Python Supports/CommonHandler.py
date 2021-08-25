import shutil
import os


def moveFiles():
    source = ["log.html", "output.xml", "report.html", "selenium-screenshot-1.png"]
    destination = "Output"
    main = "../"
    for file in source:
        if os.path.exists(main + destination + "/" + file):
            os.remove(main + destination + "/" + file)

        if os.path.exists(main + file):
            shutil.move(main + file, main + destination)

moveFiles()

def birthDateSelector(value):
    xpath = "xpath://li[contains(text(),'"
    return xpath + str(value) + "')]"
