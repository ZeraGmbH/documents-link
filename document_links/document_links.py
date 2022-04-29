import getopt
import os
from document_links import local_search
from document_links import local_copy_file
from document_links import local_unzip
from document_links import local_find_links
from document_links import windows_tool




from document_links.database.IDatabase import IDatabase

class DocumentLinks():

    def __init__(self, db : IDatabase):
        self.db = db
        pass

    # find all files on drive and write to filetable form here
    def update_filetable(self,args):
        print("update_filetable called " + args[0])
        options, remainder = getopt.getopt(args, '', ['help'])
        for opt, arg in options:
            if opt in ('--help'):
                self.__show_update_filetable_help()
                return
            else:
                self.__show_update_filetable_help()
                return
        
        ## local file
        local_search_object = local_search.LocalFileSearch()
        local_file = local_search_object.search_file(args[0], "*")
        ## database
        self.db.open()
        for file in local_file:
            self.db.add_filePath(file)
        return True


    ## todo done :new function in database.py z.B clean database.
    def clean_filetable(self,args):
        print("check-links called")
        self.db.open()
        self.db.clean_clean_text_file_database()
        return True
    

    def check_links(self,args):
        print("check-links called " + args[0])
        # step 1 open database
        #self.db.open()
        
        # 2 copy file
        local_copy_file_object = local_copy_file.LocalCopyFile()
        local_copy_file_result = local_copy_file_object.copy_file(args[0], " ","","")

        # 3 unzip file
        local_unzip_object = local_unzip.LocalUnzip()
        local_unzip_result = local_unzip_object.local_unzip(local_copy_file_result,"")

        # 4 check links
        local_find_links_object = local_find_links.LocalFindLinks()
        local_find_links_result = local_find_links_object.local_find_links(local_unzip_result,"")
        
        for link in local_find_links_result:
            if self.db.contains_filePath(link) == False:
                self.db.add_invalidLink(args[0], link)
                print(args[0] + "," + link)
        return True
            
            

        """!
        print("check_links called")
        # belows given for one data, but try to do iterate through all arguments for more data.
        # document-links check-links .../file1.docx .../foder/folder2/
        ## todo : start first with one data, then check with folder then file of that folder.
        # step 1 open database
        # 2 copy file
        # 3 unzip file
        # 4 check links
        # 5 insert invalid link to data base.
        # 6 print invalid links.(check with return?)
        !"""
        pass

    def windows_check_links(self, args):
        print("windows-check-links called " + args[0])
        windows_tool_obj = windows_tool.WindowsLink()
        windows_tool_result = windows_tool_obj.windows_link(args[0],"*.docx")
        print(windows_tool_result)

        return True


    def store_credentials(self,args):
        print("store_crednetials called")
        pass

    def __show_update_filetable_help(self):
        print("document-links update-filetable <path>")


        

# python document-links.py update-filetable