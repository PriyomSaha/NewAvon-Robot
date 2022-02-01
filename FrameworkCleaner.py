import shutil
import os

from PythonSupports.ExcelHandler import createAndDeleteSheet,writeNewDataToSheet

def deletingScreeShots():
    folder_path = (r'Output')
    images = os.listdir(folder_path)
    for image in images:
        if image.endswith(".png"):
            os.remove(os.path.join(folder_path, image))

deletingScreeShots()
# createAndDeleteSheet()
# writeNewDataToSheet('202204')