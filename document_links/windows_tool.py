from getpass import getpass
import glob
import os
from zipfile import ZipFile
import re
import xml.etree.ElementTree as ET
from pathlib import Path


def FileTable():
        return os.path.abspath(os.path.join(os.path.dirname( __file__ ),'windows_tool_data',"FileTable.txt"))

print("---",FileTable())
def InvalidLinks():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), 'windows_tool_data',"InvalidLinks.txt"))

def output_zip():
    return os.path.join(os.path.dirname( __file__ ), 'test_folder','output_zip')

def test_link_data():
    return os.path.join(os.path.dirname( __file__ ), 'test_link_data')

class WindowsLink():
    def windows_link(self, source, destination):
        self.source = source.replace('/', os.path.sep)
        self.source = source.replace('\\', os.path.sep)
        for path in Path(self.source).rglob(destination):
            #print(path)
            total_link_path = []
            try:
                ZipFile(path).extractall(output_zip())
                xml_file = os.path.join(output_zip(),"word","document.xml")
                #print(xml_file)
                sub_string = "s-zera-stor01"
                root = ET.parse(xml_file).getroot()
                iteration_elements = root.iter()
                for elem in iteration_elements:
                    if sub_string in str(elem.text):
                        #print(path)
                        #print(elem.text)
                        data_link = elem.text
                        if "HYPERLINK" in data_link:
                            data_link = data_link.replace('//', '/')
                            data_link = (re.findall('\"([^"]*)\"', data_link))[0] # to remove HYPERLINK from string.
                        link_path = data_link
                        total_link_path.append(link_path)
                        #print(total_link_path)  
                        return total_link_path              
                        
            except:
                pass
        
                    