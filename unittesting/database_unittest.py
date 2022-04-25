import unittest
import os
import shutil
from database import TextFile_database


def FileTableCopy():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'test_folder','txt_file_database_test','tmp',"FileTable.txt"))

def InvalidLinksCopy():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'test_folder','txt_file_database_test','tmp',"InvalidLinks.txt"))

def FileTable():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'test_folder','txt_file_database_test',"FileTable.txt"))

def InvalidLinks():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'test_folder','txt_file_database_test',"InvalidLinks.txt"))
class Test(unittest.TestCase):

    def setUp(self):
        # TODO create tmp folder
        shutil.copyfile(FileTable(), FileTableCopy())
        shutil.copyfile(InvalidLinks(), InvalidLinksCopy())

        self.request = TextFile_database.databaseOpenRequest()
        self.request.text_file_database_name = FileTableCopy()
        self.request.invalid_link_database_name = InvalidLinksCopy()
        self.db = TextFile_database.TextFileDatabase()
        self.path = "/s-zera-stor01/File1.docx"
        self.link = "/s-zera-stor01/File_0.txt"
        return super().setUp()

    def tearDown(self):
        #TODO delete tmp folder
        #os.remove(FileTableCopy())
        #os.remove(InvalidLinksCopy())
        return super().tearDown()

    def test_1_OpenDatabase(self):
        self.assertTrue(self.db.open(self.request))
    
    def test_2_OpenDatabaseWithWrongTypeThrowsException(self):
        with self.assertRaises(ValueError) as context:
            request="/file/path/file.txt"
            self.assertTrue(self.db.open(request))
        the_exception = context.exception
        self.assertTrue("Invalid database type" in the_exception.args)
    
    def test_3_IsOpenReturnsFalse(self):
        self.assertFalse(self.db.isOpen())

    def test_4_IsOpenReturnsTrueWhenDatabaseOpenWasCalled(self):
        OpenWasCalled = self.db.open(self.request)
        self.assertTrue(OpenWasCalled)
        self.assertTrue(self.db.isOpen())

    def test_5_CloseDatabase(self):
        self.assertTrue(self.db.close())

    def test_6_IsOpenReturnsFalseWhenDatabaseOpenAndCloseWasCalled(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        CloseWasCalled = self.db.close()
        self.assertTrue(CloseWasCalled)
        IsOpenReturnsFalse = self.db.isOpen()
        self.assertFalse(IsOpenReturnsFalse)

    def test_7_AddFilePathThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.add_filePath("/path/"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_8_AddFilePathWhenDatabaseIsOpen(self):
        DatabaseIsOpen = self.db.open(self.request)
        self.assertTrue(DatabaseIsOpen)
        AddFilePath = self.db.add_filePath(self.path)
        self.assertEqual(AddFilePath, self.path)
    
    def test_8a_RemoveFilePathWhenDatabaseIsOpen(self):
        DatabaseIsOpen = self.db.open(self.request)
        self.assertTrue(DatabaseIsOpen)
        path = "/s-zera-stor01/File1.docx" 
        RemoveFilePath = self.db.remove_filePath(path)
        self.assertEqual(RemoveFilePath, path)
    
    def test_9_RemoveFilePathThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.remove_filePath("/path/"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_10_ContainsFilePathWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFile = self.db.contains_filePath(self.path)
        self.assertIn(ContainsFile, [True, False])

    def test_11_ContainsFilePathThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.contains_filePath("/path/"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_12_GetAllFilePathListPathWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFileTrue = self.db.get_all_Path()
        self.assertEqual(type(ContainsFileTrue), list)
        ContainsFileTrue = self.db.get_all_Path()
        self.assertEqual(type(ContainsFileTrue), list)

    def test_13_GetAllFilePathThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.get_all_Path())
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_14_AddInvalidListPathWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        InvalidLink = self.db.add_invalidLink(self.path, self.link)
        self.assertEqual(InvalidLink, str(self.path)+","+str(self.link))

    def test_15_AddInvalidLinkThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.add_invalidLink("",""))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_16_ContainsInvalidLinkWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFile = self.db.contains_invalidLink(self.path, self.link)
        self.assertIn(ContainsFile, [True, False])

    def test_17_ContainsInvalidLinkThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.contains_invalidLink("/path","/link"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_18_GetInvalidLinksListWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        GetInvalidLinks = self.db.get_invalid_links(self.path)
        self.assertEqual(type(GetInvalidLinks), list)

    def test_19_GetInvalidLinkThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.get_invalid_links("/path"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_20_GetAllInvalidLinkSetPathWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        GetAllInvalidLink = self.db.get_all_invalid_links()
        self.assertEqual(type(GetAllInvalidLink), set)

    def test_21_GetAllInvalidLinksThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.get_all_invalid_links())
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)




if __name__ == '__main__':
    unittest.main(verbosity=2)
