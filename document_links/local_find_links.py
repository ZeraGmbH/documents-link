import os
import re
import xml.etree.ElementTree as ET
from document_links.database import TextFile_database

def output_zip():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', "test_folder", "output_zip"))

def FileTable():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'test_folder','txt_file_database_test',"FileTable.txt"))


class LocalFindLinks():
    
    def local_find_links(self, source, destination):
        source = output_zip()
        xml_file = os.path.join(source, "word" , "document.xml")
        destination = []
        sub_string = "s-zera-stor01"
        root = ET.parse(xml_file).getroot()
        iteration_elements = root.iter()
        for elem in iteration_elements:
            if sub_string in str(elem.text):
                data_link = (elem.text).replace('\\', '/') # change window path to smb path.
                if "HYPERLINK" in data_link:
                    data_link = data_link.replace('//', '/')
                    data_link = (re.findall('\"([^"]*)\"', data_link))[0] # to remove text "HYPERLINK" from string.
                destination.append(data_link)
        return destination
