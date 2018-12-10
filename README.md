Requirement(s):
	-PIP for Python (reference: https://linuxize.com/post/how-to-install-pip-on-ubuntu-18.04/)

alumni_app.py = python 3.x with PIP installed
mariadb = database to be used

current config of user in mariadb
username: god
password:  cmsc127
(if you plan on using root, just update the corresponding python file)

Notes:
	- Instead of using mysqldump import, just open mariadb and create a database named alumrecords then use 'source 127projectdump.sql'
	- SELECT * is invalid in python. Always use SELECT <something> or enumerate everything so that everything can be indexed and accessed.
	-GUI is WIP. But mostly all functionalities and entries are covered in terminal.