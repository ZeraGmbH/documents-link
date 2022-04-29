import sys
from document_links import document_links
import getopt
import os
from document_links.database import TextFile_database
from document_links.database.TextFile_database import TextFileDatabase

def FileTable():
        return os.path.abspath(os.path.join(os.path.dirname( __file__ ),'windows_tool_data',"FileTable.txt"))

def InvalidLinks():
    return os.path.abspath(os.path.join(os.path.dirname( __file__ ), 'windows_tool_data',"InvalidLinks.txt"))

def show_help():
    #TODO
    print("TODO show help")
    pass

def isCommand(commandlist,command):
    commandlist=[
        'update-filetable',
        'clean-filetable',
        'check-links',
        'windows-check-links',
        'store-credentials'
    ]
    return command in commandlist


def main(args):
    request = TextFile_database.databaseProperties()
    request.text_file_database_name = FileTable()
    request.invalid_link_database_name = InvalidLinks()
    textFileDatabase = TextFileDatabase(request)
    document_links_api=document_links.DocumentLinks(textFileDatabase)
    commandlist={
        'update-filetable' : document_links_api.update_filetable,
        'clean-filetable' : document_links_api.clean_filetable,
        'check-links' : document_links_api.check_links,
        'windows-check-links' : document_links_api.windows_check_links,
        'store-credentials' : document_links_api.store_credentials
    }

    options, remainder = getopt.getopt(sys.argv[1:2], '', ['help'])
    for opt, arg in options:
        if opt in ('--help'):
            show_help()
            return

    if len(args) == 0:
        show_help()
        return show_help()

    if isCommand(commandlist.keys,args[0]):
        commandlist[args[0]](args[1:])

if __name__ == '__main__':
    main(sys.argv[1:])