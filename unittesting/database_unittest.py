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
<<<<<<< HEAD
=======
        # TODO create tmp folder
>>>>>>> b3ecdf422f05be63cfd61ed070362ffb814d53da
        os.mkdir('test_folder/txt_file_database_test/tmp')
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
<<<<<<< HEAD
        shutil.rmtree('test_folder/txt_file_database_test/tmp')
=======
        shutil.rmtree(r'test_folder/txt_file_database_test/tmp')
        #os.remove(FileTableCopy())
        #os.remove(InvalidLinksCopy())
>>>>>>> b3ecdf422f05be63cfd61ed070362ffb814d53da
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
    
    def test_9_RemoveFilePathWhenDatabaseIsOpen(self):
        DatabaseIsOpen = self.db.open(self.request)
        self.assertTrue(DatabaseIsOpen)
        RemoveFilePath = self.db.remove_filePath(self.path)
        self.assertEqual(RemoveFilePath, self.path)
    
    def test_10_RemoveFilePathThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.remove_filePath("/path/"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

<<<<<<< HEAD
    def test_11_ContainsFilePathWhenDatabaseOpenFileThere(self):
=======
    #TODO proper test
    def test_10_ContainsFilePathWhenDatabaseOpenFileThere(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFile = self.db.contains_filePath(self.path)
        self.assertIn(ContainsFile, [True, False])

    #TODO proper test
    def test_10_ContainsFilePathWhenDatabaseOpenFileNotThere(self):
>>>>>>> b3ecdf422f05be63cfd61ed070362ffb814d53da
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFileTrue = self.db.contains_filePath(self.path)
        self.assertTrue(ContainsFileTrue)

    def test_12_ContainsFilePathWhenDatabaseOpenFileNotThere(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFileFalse = self.db.contains_filePath("foo")
        self.assertFalse(ContainsFileFalse)

    def test_13_ContainsFilePathThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.contains_filePath("/path"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_14_GetAllPathListPathWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        expected=[
            "/s-zera-stor01/File1.docx",
            "/s-zera-stor01/File2.docx",
            "/s-zera-stor01/File3.docx"
        ]
        self.assertTrue(DatabaseOpen)
        filelist = self.db.get_all_Path()
        self.assertEqual(filelist, expected)
        filelist = self.db.get_all_Path()
        self.assertEqual(filelist, expected)

    def test_15_GetAllPathThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.get_all_Path())
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_16_AddInvalidLinkPathWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        InvalidLink = self.db.add_invalidLink(self.path, self.link)
        self.assertEqual(InvalidLink, self.link)

    def test_17_AddInvalidLinkThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.add_invalidLink("",""))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

<<<<<<< HEAD
    def test_18_RemoveInvalidLinkWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        InvalidLink = self.db.remove_invalidLink(self.path, self.link)
        self.assertEqual(InvalidLink, self.link)
=======
    def test_16_ContainsInvalidLinkWhenDatabaseOpenLinkThere(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFile = self.db.contains_invalidLink(self.path, self.link)
        self.assertTrue(ContainsFile)
    
    def test_16_ContainsInvalidLinkWhenDatabaseOpenLinkNotThere(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFile = self.db.contains_invalidLink(self.path, "foo")
        self.assertFalse(ContainsFile)
>>>>>>> b3ecdf422f05be63cfd61ed070362ffb814d53da

    def test_19_RemoveInvalidLinkThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.remove_invalidLink("",""))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)
   
    def test_20_ContainsInvalidLinkWhenDatabaseOpenLinkThere(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFileTrue = self.db.contains_invalidLink(self.path, self.link)
        self.assertTrue(ContainsFileTrue)
    
    def test_21_ContainsInvalidLinkWhenDatabaseOpenLinkNotThere(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        ContainsFileFalse = self.db.contains_invalidLink(self.path, "foo")
        self.assertFalse(ContainsFileFalse)

    def test_22_ContainsInvalidLinkThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.contains_invalidLink("/path","/link"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_23_GetInvalidLinksWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        expected=set(
            [
                "/s-zera-stor01/File_0.txt"
            ]
        )
        invalidLinks = self.db.get_invalid_links(self.path)
        self.assertEqual(expected, invalidLinks)

    def test_24_GetInvalidLinkThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.get_invalid_links("/path"))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_25_GetAllInvalidLinkSetPathWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        expected=set(
            [
                "/s-zera-stor01/File_0.txt",
                "/s-zera-stor01/File_1.txt"
            ]
        )
        invalidLinks= self.db.get_all_invalid_links()
        self.assertEqual(expected, invalidLinks)

    def test_26_GetAllInvalidLinksThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.get_all_invalid_links())
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)

    def test_27_RemoveAllOccurenceOfInvalidLinkWhenDatabaseOpen(self):
        DatabaseOpen = self.db.open(self.request)
        self.assertTrue(DatabaseOpen)
        InvalidLink = self.db.remove_all_occurence_of_invalid_link(self.link)
        self.assertEqual(InvalidLink, self.link)

    def test_28_RemoveAllOccurenceOfInvalidLinkThrowsIfDatabaseIsNotOpen(self):
        with self.assertRaises(RuntimeError) as context:
            self.assertTrue(self.db.remove_all_occurence_of_invalid_link(self.link))
        the_exception = context.exception
        self.assertTrue("database is not open" in the_exception.args)


if __name__ == '__main__':
    unittest.main(verbosity=2)