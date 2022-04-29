import os
import shutil
from pathlib import Path
from document_links import I_copy_file

def output_copy():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', "test_folder", "output_copy"))

def test_link_data():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'test_link_data'))

docx_file_path_zip = os.path.join(test_link_data(), "TestLinkJenkins.docx")

class LocalCopyFile(I_copy_file.ICopyFileStrategy):

    def copy_file(self, source, destination, user_name, password):
        if not "smb://" in source:
            source = docx_file_path_zip
            destination = output_copy()
            shutil.copy(source, destination)
            base_file_name = Path(source).name
            output_copy_file = os.path.join(destination, base_file_name)
            return output_copy_file
        else:
            return False
