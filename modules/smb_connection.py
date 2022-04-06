from smb.SMBConnection import SMBConnection
import socket
from getpass import getpass
from urllib.parse import urlparse

class Singleton_smb_connection(type): # metaclass
    _instances = {}
    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super(Singleton_smb_connection, cls).__call__(*args, **kwargs)
        else:
            cls._instances[cls].__init__(*args, **kwargs)
        return cls._instances[cls]


class SmbServerConnectionHandler(metaclass=Singleton_smb_connection):
    def __init__(self): # Initializing
        self.dict_conn = {}

    def get_connection(self, path_name):
        url_parsed  = urlparse(path_name)
        server_name = url_parsed.netloc
        return self._get_connection(server_name)

    def _get_connection(self, server_name):
        if not server_name in self.dict_conn:
            user_name           = getpass(prompt = 'Give your user_name: ')
            password            = getpass(prompt = 'Give your password: ')
            server_IP           = socket.gethostbyname(server_name)
            conn                = SMBConnection(user_name, password, "", server_name)
            assert conn.connect(server_IP, 139)
            self.dict_conn[server_name] = conn
        return self.dict_conn[server_name]

    def get_connection_count(self):
        return len(self.dict_conn)

    def __del__(self): # Calling destructor
        self.dict_conn.clear()
