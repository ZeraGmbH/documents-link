import os
from zipfile import ZipFile
import xml.etree.ElementTree as ET
from document_links import local_search

def output_zip():
    return os.path.join(os.path.dirname( __file__ ), 'test_folder','output_zip')

class WindowsLink():
    
    def windows_link(self, source, destination):
        self.source = source.replace('/', os.path.sep)
        self.source = source.replace('\\', os.path.sep)
        local_search_object = local_search.LocalFileSearch()
        local_file = local_search_object.search_file(self.source, destination)
        total_link = []
        for path in local_file:
            try:
                ZipFile(path).extractall(output_zip())
                xml_file = os.path.join(output_zip(),"word","document.xml")
                sub_string = "s-zera-stor01"
                root = ET.parse(xml_file).getroot()
                iteration_elements = root.iter()
                for elem in iteration_elements:
                    if sub_string in str(elem.text):
                        total_link.append(path + "," + elem.text)           
            except:
                pass
            
        return total_link
        