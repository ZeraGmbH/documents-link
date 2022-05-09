import unittest
import os
import sys
from document_links import document_links
from unittesting.spy.db_spy import db_spy


#def test_link_data():
    #return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'test_folder'))

def test_link_data():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'test_link_data'))

docx_file_path_zip = os.path.join(test_link_data(), "TestLinkJenkins.docx")

class Test(unittest.TestCase):

    def setUp(self):
        self.db = db_spy()
        self.path='/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test'
        return super().setUp()

    def test_1_update_filetable(self):
        file_path_object = document_links.DocumentLinks(self.db)
        update_filetable = file_path_object.update_filetable([self.path])
        self.assertTrue(update_filetable)
        expectedResult={
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/notfound/nichtexit.doc',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder12/text21a.txt',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder12/text21.txt',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder11/text11.txt',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder2/folder21', 
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder11/text11a.txt',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder2/folder21/text21.txt',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder2/foo2.txt',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder2/folder22',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder2/folder22/text22.txt',
        '/home/d.kumar/data/gitproject/zera/documents-link/test_folder/folder_test/folder1/foo1.txt'
        }
        self.assertEqual(expectedResult,self.db.fileTable)

    def test_2_clean_filetable(self):
         file_path_object = document_links.DocumentLinks(self.db)
         clean_filetable = file_path_object.clean_filetable("args")
         self.assertTrue(clean_filetable)

    def test_3_check_links(self):
         file_path_object = document_links.DocumentLinks(self.db)
         check_links = file_path_object.check_links(docx_file_path_zip)
         print("--->>> 3", check_links)
         self.assertTrue(check_links)
         
    def test_4_windowslink(self):
         file_path_object = document_links.DocumentLinks(self.db)
         check_links = file_path_object.check_links(docx_file_path_zip)
         print("--->>> 3", check_links)
         self.assertTrue(check_links)


if __name__ == '__main__':
    unittest.main(verbosity=2)