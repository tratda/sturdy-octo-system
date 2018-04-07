
from flask import Flask
import subprocess
import os
import socket


app = Flask(__name__)

@app.route("/")

def command2exec():
	output = subprocess.run(["ls", "-al", "/admin/"], stdout=subprocess.PIPE).stdout
	return output

def hello():
    html = "<h3>Hello {name}!</h3>" \
           "<b>Hostname:</b> {hostname}<br/>" \
           "<b>Output:</b> {output} <br/>"
    return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(),output = command2exec())

if __name__ == "__main__":
    subprocess.run(["service", "ssh", "start"])
    app.run( host='0.0.0.0', port=80)

