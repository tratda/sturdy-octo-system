#import dependencies
from flask import Flask
import subprocess
import os
import socket


app = Flask(__name__)

@app.route("/")

#Exec all commands in the /web directory
def command2exec():
    #Have git update the /web directory from the git repo
    subprocess.run(["git", "-C", "/web", "pull"])
    #Pull the shell scripts out of the /web directory
    scripts = subprocess.run(["ls","/web/"], stdout=subprocess.PIPE).stdout.decode()
    output = ''
    for script in scripts.split('\n')[:-1]:
	#execute each script and add to the output
        subprocess.run(["chmod", "+x", "/web/"+ script])
        print(script)
        output += subprocess.run(["/web/"+script], stdout=subprocess.PIPE, shell=True).stdout.decode()
        output += '\n'
    output = '<br/>'.join(output.split('\n'))
    return output

def hello():
    html = "{output} <br/>"
    return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(),output = command2exec())

if __name__ == "__main__":
    subprocess.run(["service", "ssh", "start"])
    subprocess.run(["ssh-keygen", "-b", "4096", "-t", "rsa", "-f" "/root/.ssh/id_rsa","-N", ""])
    subprocess.run(["cp", "/root/.ssh/id_rsa.pub", "/home/admin/.ssh/authorized_keys"])
    subprocess.run(["git", "clone", "admin@localhost:admin", "/web"])
    app.run(ssl_context="adhoc", host='0.0.0.0', port=443)

