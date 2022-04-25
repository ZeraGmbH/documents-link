from os.path import exists
from database import IDatabase
import io
import os

# def FileTable():
#     return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'database',"FileTable.txt"))

# def InvalidLinks():
#     return os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'database',"InvalidLinks.txt"))

class databaseOpenRequest:
    text_file_database_name : str
    invalid_link_database_name : str

class TextFileDatabase(IDatabase.IDatabase):

    def __init__(self):
        super().__init__()
        self.text_file_database = io.StringIO("")
        self.invalid_link_database = io.StringIO("")
        self.invalid_link_database.close()
        self.text_file_database.close()
    
    def open(self,database : databaseOpenRequest):
        if type(database) is not databaseOpenRequest:
            raise ValueError("Invalid database type")

        
        self.text_file_database = open(database.text_file_database_name, "r+")
        self.invalid_link_database = open(database.invalid_link_database_name, "r+")
        # self.text_file_database = open(database.text_file_database_name, "w+")
        # self.invalid_link_database = open(database.invalid_link_database_name, "w+")
        self.__reinit_file_access()
        return True

    def close(self):
        f1 = self.text_file_database
        f2 = self.invalid_link_database
        f1.close()
        f2.close()
        return True
        
    def isOpen(self):
        if not self.text_file_database.closed or not self.invalid_link_database.closed:
            return True
        else:
            return False
        
    def add_filePath(self,path):
        self.__throw_if_database_is_closed()
        if self.contains_filePath(path) == False:
            self.text_file_database.write(path + "\n")
        return path


    def remove_filePath(self,path):
        ##remove path
        self.__throw_if_database_is_closed()
        self.__reinit_file_access()
        if self.contains_filePath(path) == True:
            self.text_file_database.seek(0)
            lines = self.text_file_database.readlines()
            lines.remove(path + "\n")
            ##remove path
            self.__reinit_file_access()
            self.text_file_database.truncate()
            for line in lines:        
                self.text_file_database.write(line)

        ## remove invalid links assigned to this path
        self.__reinit_file_access()
        invalid_links = self.get_invalid_links(path)
        i = 0
        len_link = len(invalid_links)
        while i < len_link:
            lines = self.invalid_link_database.readlines()
            lines.remove(invalid_links[i] + "\n")
            self.__reinit_file_access()
            self.invalid_link_database.truncate()
            for line in lines:        
                self.invalid_link_database.write(line)
            if i == len_link:
                break
            i +=1
        return path

    def contains_filePath(self,path):
        self.__throw_if_database_is_closed()
        lines = self.text_file_database.readlines()
        for line in lines:
            if line == path + "\n":
                return True
        else:
            return False


    def get_all_Path(self):
        self.__throw_if_database_is_closed()
        self.__reinit_file_access()
        lines=self.text_file_database.readlines()
        return self.__remove_line_breaks(lines)


    def add_invalidLink(self,path,link):
        path_link = str(path) + "," + str(link)
        self.__throw_if_database_is_closed()
        if self.contains_filePath(link) == False:
            if not self.invalid_link_database.closed:
                if self.contains_invalidLink(path,link) == False:
                    self.invalid_link_database.write(path_link + "\n")
                return link


    def remove_invalidLink(self,path,link):
        """!
        Remove invalid link from database
        e.g. /s-zera-stor01/..../File1.docx

        contains_invlaidLInk will return false for this link and file combination
        get_invalid_links will not list this further for this path.

        Furthermore all invlaid links assigned to this file will be deleted as well.

        @Param path  The file the contained the invlaid link
        e.g. /s-zera-stor01/..../File1.docx
        @Param link  The once invlaid link itself
        e.g. /s-zera-stor01/..../File2.docx

        @return unique id to indentify link path. Can be link itself
        e.g /s-zera-stor01/..../File2.docx

        @throw RuntimeError if database is not open
        """
        pass


    def contains_invalidLink(self,path,link):
        self.__throw_if_database_is_closed()
        self.__reinit_file_access()
        path_link = str(path) + "," + str(link)
        if path_link in str([line.rstrip('\n') for line in self.invalid_link_database]):
            return True
        else:
            return False

    def get_invalid_links(self,path):
        self.__throw_if_database_is_closed()
        all_link = []
        self.__reinit_file_access()
        for line in self.invalid_link_database:
            if path in line:
                all_link.append(line)
        return set(self.__extract_invalid_links(self.__remove_line_breaks(all_link)))

    def get_all_invalid_links(self):
        self.__throw_if_database_is_closed()
        self.__reinit_file_access()
        lines=self.invalid_link_database.readlines()
        return set(self.__extract_invalid_links(self.__remove_line_breaks(lines)))
        


    def remove_all_occurence_of_invalid_link(self,link):
        """!
        Removes all occurences of an invlaid link from database

        Neither get_invalid_links nor get_all_invalid_links will return 
        this link after this function call

        @param the link to remove from the entire database
        e.g /s-zera-stor01/..../File2.docx
        
        @returns unique id of link. Can be link itself

        @throw RuntimeError if database is not open
        """
        pass

    def __remove_line_breaks(self,entries):
        result=[]
        for entry in entries:
            result.append(entry.rstrip('\n'))
        return result

    def __reinit_file_access(self):
        self.text_file_database.seek(0)
        self.invalid_link_database.seek(0)

    def __throw_if_database_is_closed(self):
        if self.isOpen() == False:
            raise RuntimeError("database is not open")

    def __extract_invalid_links(self,entries):
        result=[]
        try:
            for entry in entries:
                result.append(entry.split(r',')[1])
        except:
            reuslt=list()
        return result