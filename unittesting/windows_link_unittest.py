import unittest
import os
from document_links import windows_tool
from unittesting.spy.db_spy import db_spy


class Test(unittest.TestCase):
    def setUp(self):
            self.db = db_spy()
            self.path='M:\Zusammenarbeit\Transferordner\EW\DKU'
            return super().setUp()

    def test_1_windows_link(self):
        windows_link_obj = windows_tool.WindowsLink(self.db)
        search_result = windows_link_obj.windows_link(self.path, ["*.docx"])
        #print("---",search_result)
        #self.assertIs(len(search_result))



if __name__ == '__main__':
    unittest.main(verbosity=2)
