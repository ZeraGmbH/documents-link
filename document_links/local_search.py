import glob
import os
from document_links import I_search_file
from pathlib import Path


class LocalFileSearch(I_search_file.ISearchFileStrategy):

    def search_file(self, search_path, list_searchstring):
        self.search_path = search_path.replace('/', os.path.sep)
        self.search_path = search_path.replace('\\', os.path.sep)
        if not os.path.isdir(self.search_path):
            return None
        search_result = []
        
        for root, dirs, _files in os.walk(self.search_path):
            for directory in dirs:
                for search_string in list_searchstring:
                    globpath = os.path.join(root, directory, search_string)
                    try:
                        for filename in glob.glob(globpath):
                            if os.path.isdir(filename):
                                search_result = search_result + self.search_file(filename, list_searchstring)
                            else:
                                search_result.append(filename)
                            
                    except:
                        pass
        return search_result
        
   
        
        
