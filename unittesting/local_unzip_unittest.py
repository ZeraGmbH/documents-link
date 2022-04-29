import unittest
import os
from document_links import local_unzip


def output_copy():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', "test_folder", "output_copy", "TestLinkJenkins.docx"))

class Test(unittest.TestCase):

    def setUp(self):
        self.file_path_object = local_unzip.LocalUnzip()
        return super().setUp()

    def test_1_local_copy_file_unittest(self):
        search_result = self.file_path_object.local_unzip(output_copy(),"" )
        print("---1",search_result)
        self.assertIsNotNone(search_result)

if __name__ == '__main__':
    unittest.main(verbosity=2)