import subprocess
from subprocess import Popen
from subprocess import Popen, CREATE_NEW_CONSOLE, PIPE, STDOUT
import platform


class Server:
    def __init__(self):
        # subprocess.call('/k','robot-selenium')
        pass

    def run_robotfiles(self, terminal, command1):
        if platform.system() == 'Windows':
            self.terminal = terminal
            self.command1 = command1
            self.command_server1 = self.terminal + ' ' + self.command1
            self.server1_start = Popen(self.command_server1, creationflags=CREATE_NEW_CONSOLE)


abc = Server()
# you can give path till the robot file or you can use a batch file
# K option tells cmd to run the command and keep the command window from closing. You may use /C instead to close the command window after the command finishes.
abc.run_robotfiles('cmd', '/K robot --outputdir "Output" TestSuite/NewTestCase/TC_007_DB_REP_login_Shop.robot')
