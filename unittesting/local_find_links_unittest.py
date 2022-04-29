import unittest
import os
from document_links import local_find_links

def output_xml():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', "test_folder", "output_zip","word" , "document.xml"))



class Test(unittest.TestCase):

    def setUp(self):
        self.file_path_object = local_find_links.LocalFindLinks()
        return super().setUp()

    def test_1_local_copy_file_unittest(self):
        search_result = self.file_path_object.local_find_links(output_xml(),"")
        print("A",search_result)
        self.assertIsNotNone(search_result)


if __name__ == '__main__':
    unittest.main(verbosity=2)