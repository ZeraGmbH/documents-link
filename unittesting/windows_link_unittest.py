import unittest
import os
from document_links import windows_tool




class Test(unittest.TestCase):

    def test_1_windows_link(self):
        windows_link_obj = windows_tool.WindowsLink()
        search_result = windows_link_obj.windows_link("/home/d.kumar/Desktop", "*.docx")
        print("---",search_result)
        #self.assertIs(len(search_result))



if __name__ == '__main__':
    unittest.main(verbosity=2)
