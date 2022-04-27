import sys
from document_links import document_links
import getopt

def show_help():
    #TODO
    print("TODO show help")
    pass

def isCommand(commandlist,command):
    commandlist=[
        'update-filetable',
        'clean-filetable',
        'check-links',
        'store-credentials'
    ]
    return command in commandlist


def main(args):
    document_links_api=document_links.DocumentLinks()
    commandlist={
        'update-filetable' : document_links_api.update_filetable,
        'clean-filetable' : document_links_api.clean_filetable,
        'check-links' : document_links_api.check_links,
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