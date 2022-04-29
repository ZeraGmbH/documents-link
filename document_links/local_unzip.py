import os
from zipfile import ZipFile

def output_zip():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', "test_folder", "output_zip"))

class LocalUnzip():
    
    def local_unzip(self, source, destination):
        ZipFile(source).extractall(output_zip())
        destination = (output_zip())
        return destination
