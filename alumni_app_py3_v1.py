def creators():
    # text = ""
    result = 'CMSC 127 project\n\nAguila\nFlores\nAbaca'
    # for c in text:
        # result = result + c + '\u0336'
    return result


'''CODE PROPER'''

##################################
#                                #
#        CMSC 127 PROJECT        #
#                                #
#================================#
#                                #
#   AGUILA, JANZEN CHRISTIAN D.  #
#          (2015-08200)          #
#       FLORES, DAIMLER T.       #
#          (2015-10007)          #
#    ABACA, HANZ CHRISTIAN C.    #
#          (2015-09327)          #
#                                #
#         CMSC 127 S-2L          #
##################################

import MySQLdb as mariadb # import mysql.connector as mariadb. Required module to connect the database to the python program.
import datetime
from tkinter import * # this is required for GUI purposes in python 3.
from tkinter import font as tkfont # optional, but this is used to distinguish headers from content.

# Connecting the database to the python code
mariadb_conn = mariadb.connect(user='god', passwd='cmsc127', db='alumrecords') # establish connection. User is named 'god' (without apostrophes), and password is 'cmsc127'
cursor = mariadb_conn.cursor() # use this to interact with the database

loggedIn = 0; # Checks if user is logged in
glblemail = '' # global email setter. Used for keeping the user logged in
bdayentries = '' # empty string initialization for birthday. Will be used later on in the birthday's GUI entry.

# these two will set whether the user logged in is an alumni or an admin. (Only one should be turned on at a time)
active_admin = False; 
active_alumni = False;

timenow = datetime.datetime.now() # gets the current date based on your computer's config.

# Code reference for changing between frames:
# https://stackoverflow.com/questions/7546050/switch-between-two-frames-in-tkinter

class SampleApp(Tk):

    def __init__(self, *args, **kwargs):
        Tk.__init__(self, *args, **kwargs)

        self.title_font = tkfont.Font(family="Arial", size=18, weight="bold")
        # self.title_font = tkfont.Font(family="Arial", size=18, weight="bold", slant="italic")

        # the container is where we'll stack a bunch of frames
        # on top of each other, then the one we want visible
        # will be raised above the others
        container = Frame(self)
        container.pack(side="top", fill="both", expand=True)
        container.grid_rowconfigure(0, weight=1)
        container.grid_columnconfigure(0, weight=1)

        self.frames = {}
        for F in (StartPage, PageOne, PageTwo, PageThree, PageThree_logged, PageFour, PageFive, LoggedIn, LoggedInAdmin, ProfileAlum, ProfileAdmin):
            page_name = F.__name__
            frame = F(parent=container, controller=self)
            self.frames[page_name] = frame

            # put all of the pages in the same location;
            # the one on the top of the stacking order
            # will be the one that is visible.
            frame.grid(row=0, column=0, sticky="nsew")

        self.show_frame("StartPage")

    def show_frame(self, page_name):
        # Show a frame for the given page name
        frame = self.frames[page_name]
        frame.tkraise()

    def authenticateAlumni(self, frame, email, pw):
        print("Email is:",  email)
        print("Password is:", pw)

        # SELECT the required checking materials from client and alumni tables.
        sql = "SELECT cl.email, cl.password, cl.user_id, al.alumni_user_id from client cl, alumni al where cl.email = %s and cl.password = %s and cl.user_id = al.alumni_user_id"
        args = (email, pw)
        cursor.execute(sql, args)

        if (cursor.rowcount != 0): # This just checks if there are entries returned. Basically says that there is an existing user with such credentials.
            # This block might need a lambda function, so that it will not be called when program starts.
            # The global keyword uses the global variable in the function, and any change done is reflected in the global variable.
        	global loggedIn
        	loggedIn = True
        	global glblemail
        	glblemail = email
        	active_alumni = True; # sets a user as logged in.
        	print("SUCCESSFULLY LOGGED IN!\nEmail:", email)
        	self.show_frame("LoggedIn")
        else:
            label = Label(frame, text="Invalid user credentials", fg="red")
            label.pack()
            print("F. None found") # Terminal checking purposes.

    # This function just does the same thing as authenticating an alumni, but using the admin table(instead of the alumni table) to verify the credentials instead.
    def authenticateAdmin(self, frame, email, pw):
        print("Email is:",  email)
        print("Password is:", pw)

        sql = "SELECT cl.email, cl.password, cl.user_id, ad.admin_user_id from client cl, admin ad where cl.email = %s and cl.password = %s and cl.user_id = ad.admin_user_id"
        args = (email, pw)
        cursor.execute(sql, args)

        if (cursor.rowcount != 0):
        	global loggedIn
        	loggedIn = True
        	global glblemail
        	glblemail = email
        	active_admin = True
        	print("SUCCESSFULLY LOGGED IN!\nEmail:", email)
        	self.show_frame("LoggedIn")
        else:
            label = Label(frame, text="Invalid user credentials", fg="red")
            label.pack()
            print("F. None found")

    # logs out the user
    def logout(self, user):
    	global loggedIn
    	loggedIn = False
    	global glblemail
    	glblemail = ""
    	if (user == "Alumni"):
    		active_alumni = False
    		print("SUCCESSFULLY LOGGED OUT ALUMNI")
    	else:
    		active_admin = False
    		print("SUCCESSFULLY LOGGED OUT ADMIN")
    	self.show_frame("StartPage")

    def add_admin(self, fn, ln, mn, ext, mail, pw, cursor):
        sql = "INSERT into client (firstname, lastname, middlename, extension, email, password) values (%s, %s, %s, %s, %s, %s);"
        args = fn, ln, mn, ext, mail, pw
        cursor.execute(sql, args)
        sql = "SELECT user_id from client where firstname = %s and lastname = %s;"
        args = fn, ln
        cursor.execute(sql, args)
        for uid in cursor:
            adminid = uid
        cursor.execute("INSERT into admin (admin_user_id) values (%s);", adminid)
        if (ext != ''):
            sql = "UPDATE client SET extension = %s WHERE user_id = %s;"
            args = ext, adminid
            cursor.execute(sql, args)
        else:
            sql = "UPDATE client SET extension = %s WHERE user_id = %s;"
            args = None, adminid
            cursor.execute(sql, args)
        print("Added", fn, " ", ln, " as admin!")

    def add_alum(self, sn, fn, ln, mn, ext, mail, pw, year, month, day, sex, batch, grad, num, comp, compcity, compcountry, pos, cursor):
        bday = "%s-%s-%s" % (year, month, day)

        sql = "INSERT into client (firstname, lastname, middlename, extension, email, password) values (%s, %s, %s, %s, %s, %s);"
        args = fn, ln, mn, ext, mail, pw
        cursor.execute(sql, args)
        sql = "SELECT user_id from client where firstname = %s and lastname = %s;"
        args = fn, ln
        cursor.execute(sql, args)
        for uid in cursor:
            alumid = uid
        sql = "INSERT into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (%s, %s, %s, %s, %s, %s);"
        args = sn, bday, sex, batch, grad, alumid
        cursor.execute(sql, args)

        sql = "INSERT into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (%s, %s, %s, %s, %s);"
        args = sn, comp, compcity, compcountry, pos
        cursor.execute(sql, args)

        sql = "INSERT into contact_num (alumni_student_number, phone_number) values (%s, %s);"
        args = sn, num
        cursor.execute(sql, args)

        if (ext != ''):
            sql = "UPDATE client SET extension = %s WHERE user_id = %s;"
            args = ext, alumid
            cursor.execute(sql, args)
        else:
            sql = "UPDATE client SET extension = %s WHERE user_id = %s;"
            args = None, alumid
            cursor.execute(sql, args)
        print("Added", fn, " ", ln, " as alumni!")

    def change_login(self):
    	global loggedIn
    	loggedIn = True
    	print(loggedIn)

class ProfileAlum(Frame): # Profile page of alumni once logged in.

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        global glblemail
        arg = (glblemail,)
        cursor.execute("SELECT cl.firstname, cl.lastname, cl.middlename, cl.extension, cl.email, al.student_number, al.alumni_user_id FROM client cl, alumni al where cl.email = %s and cl.user_id = al.alumni_user_id", arg)
        txt = ''
        for fn, ln, mn, ex, email, sn, uid in cursor:
            initials = mn[0] + '.';
            if (ex is None):
                txt = str(fn) + str(initials) + str(ln) + "(" + str(email) + ") Alumni's ID:" + str(sn) + "\tUser ID:" + str(uid)
            else:
                txt = str(fn) + str(initials) + str(ln) + str(ex) + "(" + str(email) + ") Alumni's ID:" + str(sn) + "\tUser ID:" + str(uid)

        label = Label(self, text=txt, font=controller.title_font)
        label.pack(side="bottom", fill="x", pady=10)
        button1 = Button(self, text="Edit your profile",
                            command=lambda: controller.show_frame("ProfileAlum"))
        button2 = Button(self, text="Back to main",
                            command=lambda: controller.show_frame("LoggedIn"))
        button1.pack()
        button2.pack()

class ProfileAdmin(Frame): # Profile page of admin once logged in.

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller

        label = Label(self, text="Welcome!", font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)

        button1 = Button(self, text="Edit your profile",
                            command=lambda: controller.show_frame("ProfileAdmin"))
        button2 = Button(self, text="Back to main",
                            command=lambda: controller.show_frame("LoggedInAdmin"))
        button1.pack()
        button2.pack()

class LoggedIn(Frame): # Main page of alumni once logged in.

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        label = Label(self, text="Welcome!", font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)

        button1 = Button(self, text="Show profile",
                            command=lambda: controller.show_frame("ProfileAlum"))
        button2 = Button(self, text="Search alumni",
                            command=lambda: controller.show_frame("PageTwo"))
        lambda: controller.change_login
        if (loggedIn == True):
        	button3 = Button(self, text="About",
                            command=lambda: controller.show_frame("PageThree_logged"))
        else:
        	button3 = Button(self, text="About",
                            command=lambda: controller.show_frame("PageThree"))
        button4 = Button(self, text="Logout",
                            command=lambda: controller.logout("Alumni")) # Logs out user
        button1.pack()
        button2.pack()
        button3.pack()
        button4.pack()

class LoggedInAdmin(Frame): # Main page of admin once logged in.

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        label = Label(self, text="Welcome!", font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)

        button1 = Button(self, text="Show profile",
                            command=lambda: controller.show_frame("ProfileAdmin"))
        lambda: controller.change_login
        if (loggedIn == True):
        	button2 = Button(self, text="About",
                            command=lambda: controller.show_frame("PageThree_logged"))
        else:
        	button2 = Button(self, text="About",
                            command=lambda: controller.show_frame("PageThree"))
        button3 = Button(self, text="Logout",
                            command=lambda: controller.logout("Admin")) # Logs out user
        button1.pack()
        button2.pack()
        button3.pack()

class StartPage(Frame): # First window showing up when GUI is started.

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller

        label = Label(self, text="This is the start page", font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)

        button1 = Button(self, text="Alumni",
                            command=lambda: controller.show_frame("PageOne")) # Alumni login page.
        button2 = Button(self, text="Administrator",
                            command=lambda: controller.show_frame("PageTwo")) # Admin login page.
        button3 = Button(self, text="Sign up as admin",
                            command=lambda: controller.show_frame("PageFour"))# Admin sign up page.
        button4 = Button(self, text="Sign up as alumni",
                            command=lambda: controller.show_frame("PageFive")) # # Alumni sign up page.
        button5 = Button(self, text="About",
                            command=lambda: controller.show_frame("PageThree")) # About the creators page.
        button6 = Button(self, text="Exit",
                            command=lambda: controller.destroy()) # Destroys the window
        button1.pack(side="top", fill="x", pady=10)
        button2.pack(side="top", fill="x", pady=10)
        button3.pack(side="top", fill="x", pady=10)
        button4.pack(side="top", fill="x", pady=10)
        button5.pack(side="top", fill="x", pady=10)
        button6.pack(side="top", fill="x", pady=10)

class PageOne(Frame): #Alumni

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        label = Label(self, text="Log in as alumni", font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)

        label = Label(self, text="Email")
        label.pack(side="top", fill="x", pady=10)
        email = Entry(self, width=15);
        email.pack(side="top", fill="x", pady=10)

        label = Label(self, text="Password")
        label.pack(side="top", fill="x", pady=10)
        password = Entry(self, show="*", width=15)
        password.pack(side="top", fill="x", pady=10)

        frame = Frame(self, parent)

        button1 = Button(frame, text="Log in",
                           command=lambda: controller.authenticateAlumni(frame, email.get(), password.get()))

        button2 = Button(frame, text="Go to the main page",
                           command=lambda: controller.show_frame("StartPage"))
        button1.pack()
        button2.pack()
        frame.pack()

class PageTwo(Frame): #Administrator

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        label = Label(self, text="Log in as administrator", font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)

        label = Label(self, text="Email")
        label.pack(side="top", fill="x", pady=10)
        email = Entry(self, width=15);
        email.pack(side="top", fill="x", pady=10)

        label = Label(self, text="Password")
        label.pack(side="top", fill="x", pady=10)
        password = Entry(self, show="*", width=15)
        password.pack(side="top", fill="x", pady=10)

        frame = Frame(self, parent)

        button1 = Button(frame, text="Log in",
                           command=lambda: controller.authenticateAdmin(frame, email.get(), password.get()))

        button2 = Button(frame, text="Go to the main page",
                           command=lambda: controller.show_frame("StartPage"))
        button1.pack()
        button2.pack()
        frame.pack()

class PageThree(Frame): # About the creators page (if no one is logged in)

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        label = Label(self, text=creators(), font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)
        button = Button(self, text="Go to the main page",
                           command=lambda: controller.show_frame("StartPage"))
        button.pack()

class PageThree_logged(Frame): # About the creators page for logged in users (The go to the main page returns them to their main acct page instead of the start page).

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        label = Label(self, text=creators(), font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)
        if (active_admin == True):
            button = Button(self, text="Go to the main page",
                               command=lambda: controller.show_frame("LoggedInAdmin"))
        else:
            button = Button(self, text="Go to the main page",
                               command=lambda: controller.show_frame("LoggedIn"))
        button.pack()

class PageFour(Frame): # Admin sign up page

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        label = Label(self, text="Sign up as admin", font=controller.title_font)
        label.pack(side="top", pady=10)

        label1 = Label(self, text="First name")
        label1.pack()
        adfn = Entry(self)
        adfn.pack()

        label2 = Label(self, text="Middle name")
        label2.pack()
        admn = Entry(self)
        admn.pack()

        label3 = Label(self, text="Last name")
        label3.pack()
        adln = Entry(self)
        adln.pack()

        label4 = Label(self, text="Name extension")
        label4.pack()
        adext = Entry(self)
        adext.pack()

        label5 = Label(self, text="E-mail address")
        label5.pack()
        admail = Entry(self)
        admail.pack()

        label6 = Label(self, text="Password")
        label6.pack()
        adpw = Entry(self, show="*")
        adpw.pack()

        buttonad_add = Button(self, text="Add admin", command=lambda: controller.add_admin(adfn.get(), adln.get(), admn.get(), adext.get(), admail.get(), adpw.get(), cursor))
        buttonad_add.pack()

        buttonb = Button(self, text="Go to the main page",
                           command=lambda: controller.show_frame("StartPage"))
        buttonb.pack(side="bottom", pady=10)

class PageFive(Frame): # Alumni sign up page.

    def __init__(self, parent, controller):
        Frame.__init__(self, parent)
        self.controller = controller
        label = Label(self, text="Sign up as alumni", font=controller.title_font)
        label.pack(side="top", fill="x", pady=10)

        fmain = Frame(self, parent)

        f =  Frame(fmain, parent)

        label7 = Label(f, text="Student number (20XXXXXXX)")
        label7.pack()
        alsn = Entry(f)
        alsn.pack()	

        label8 = Label(f, text="First name")
        label8.pack()
        alfn = Entry(f)
        alfn.pack()

        label9 = Label(f, text="Middle name")
        label9.pack()
        almn = Entry(f)
        almn.pack()

        label10 = Label(f, text="Last name")
        label10.pack()
        alln = Entry(f)
        alln.pack()

        label11 = Label(f, text="Name extension")
        label11.pack()
        alext = Entry(f)
        alext.pack()

        label12 = Label(f, text="E-mail address")
        label12.pack()
        almail = Entry(f)
        almail.pack()

        label13 = Label(f, text="Password")
        label13.pack()
        alpw = Entry(f, show="*")
        alpw.pack()

        label14 = Label(f, text="Birthday")
        label14.pack()

        # There is a separate frame for the birthday itself so that it lines up equally well with other frame components.
        f1 = Frame(f, parent, width=100, height=300)
        f2 = Frame(f, parent, width=100, height=100)

        bdmm = Entry(f1, width=2)
        bdlabel_1 = Label(f1, text='-')
        bddd = Entry(f1, width=2)
        bdlabel_2 = Label(f1, text='-')
        bdyy = Entry(f1, width=4)

        bday = Label(f2, text='Birthday (mm-dd-yyyy)')
        bday.pack(side="left")
        bdmm.pack(padx = 5, side="left")
        bdlabel_1.pack(padx = 5, side="left")
        bddd.pack(padx = 5, side="left")
        bdlabel_2.pack(padx = 5, side="left")
        bdyy.pack(padx = 5, side="left")

        f2.pack()
        f1.pack()
        f.pack(side="left")

        f3 = Frame(fmain, parent)

        label14_1 = Label(f3, text="Sex")
        label14_1.pack()
        alsex = Entry(f3)
        alsex.pack()

        label15 = Label(f3, text="Batch")
        label15.pack()
        albatch = Entry(f3)
        albatch.pack()

        label16 = Label(f3, text="Year of graduation")
        label16.pack()
        algrad = Entry(f3)
        algrad.pack()

        label17 = Label(f3, text="Contact number (9XXXXXXXXX)")
        label17.pack()
        alcn = Entry(f3)
        alcn.pack()

        label18 = Label(f3, text="Job")
        label18.pack()
        
        label19 = Label(f3, text="Company name")
        label19.pack()
        alcmp = Entry(f3)
        alcmp.pack()

        label20 = Label(f3, text="City where company is")
        label20.pack()
        alcmpcity = Entry(f3)
        alcmpcity.pack()

        label21 = Label(f3, text="Country where company is")
        label21.pack()
        alcmpcountry = Entry(f3)
        alcmpcountry.pack()

        label22 = Label(f3, text="Position in job")
        label22.pack()
        alpos = Entry(f3)
        alpos.pack()

        f3.pack()
        fmain.pack(side="top")

        f4 = Frame(self, parent)

        buttonal_add = Button(self, text="Add alumni", command=lambda: controller.add_alum(alsn.get(), alfn.get(), alln.get(), almn.get(), alext.get(), almail.get(), alpw.get(), bdyy.get(), bdmm.get(), bddd.get(),  alsex.get(), albatch.get(), algrad.get(), alcn.get(), alcmp.get(), alcmpcity.get(), alcmpcountry.get(), alpos.get(), cursor))
        buttonal_add.pack()

        buttonb = Button(self, text="Go to the main page",
                           command=lambda: controller.show_frame("StartPage"))
        buttonb.pack()

        f4.pack(side="bottom", fill="both", expand="yes")

def glblInit(): # initialization of main window
	if __name__ == "__main__":
	    app = SampleApp()
	    app.title("127 Alumni app")
	    app.mainloop()

# Definition of functions
def isNum(x): #checks if the input is a number 
	while x.isdigit() == False:
		x = input("Invalid input. Enter a number: ")
	return int(x)

def hasJob(x): #checks if alumni enters the correct input when asked if he/she has a job
	while x != 'Y' and x != 'y' and x != 'N' and x != 'n':
		x = input("Invalid input. Enter Y(yes) or N(no)")
	return x

def isNotEmpty(x): #checks if the input is null
	while x == '':
		x = input("Invalid input. Enter a valid input: ")
	return x

def print_menu(): # prints main terminal menu
	print("(0) Exit")
	print("(1) Manage admins")
	print("(2) Manage alumni")
	print("(3) Manage activity log")
	print("(4) View admins")
	print("(5) View alumni")
	print("(6) View activities")
	print("(7) Save database")
	print("(8) Re-open login window")
	print("(9) Alumni per batch")
	print("(10) Alumni per class")
	print("(11) Alumni per 5 years")
	print("(12) Find one alumni")
	print("(13) Find one admin")
	print("(14) Find one activity")

	x = isNum(input("Choice: ")) # choice to navigate through the menu
	return x

# ADMIN FUNCS -------------------------------

def add_admin(fn, ln, mn, ext, mail, pw, cursor): #add admin
	sql = "INSERT into client (firstname, lastname, middlename, extension, email, password) values (%s, %s, %s, %s, %s, %s);"
	args = fn, ln, mn, ext, mail, pw
	cursor.execute(sql, args)
	sql = "SELECT user_id from client where firstname = %s and lastname = %s;"
	args = fn, ln
	cursor.execute(sql, args)
	for uid in cursor:
		adminid = uid
	cursor.execute("INSERT into admin (admin_user_id) values (%s);", adminid)
	if (ext != ''):
		sql = "UPDATE client SET extension = %s WHERE user_id = %s;"
		args = ext, adminid
		cursor.execute(sql, args)
	else:
		sql = "UPDATE client SET extension = %s WHERE user_id = %s;"
		args = None, adminid
		cursor.execute(sql, args)
	print("Added", fn, " ", ln, " as admin!")

def del_admin(uid, cursor): #deletes an admin with the user_id
	first = ''
	last = ''

	sql = "DELETE from admin WHERE admin_user_id = %s;"
	args = (uid,)
	cursor.execute(sql, args)

	sql = "SELECT firstname, lastname from client where user_id = %s;"
	cursor.execute(sql, args)
	for fn, ln in cursor:
		first = fn
		last = ln
	sql = "DELETE from client WHERE user_id = %s;"
	cursor.execute(sql, args)
	print("Deleted ", first, " ", last, " from admins list.")

def print_admins(cursor): #shows the admin that has a client acct
	cursor.execute("SELECT cl.firstname, cl.lastname, cl.middlename, cl.extension, cl.email, ad.admin_id, ad.admin_user_id FROM client cl, admin ad where cl.user_id = ad.admin_user_id")
	for fn, ln, mn, ex, email, adminid, uid in cursor: # slices the results based on their columns (chronological order)
		initials = mn[0] + '.'; # gets the first letter of the middle name
		if (ex is None):
			print(fn, initials, ln, email, "Admin's ID:", adminid, "\tUser ID:", uid)
		else:
			print(fn, initials, ln, ex, email, "Admin's ID:", adminid, "\tUser ID:", uid)

# ALUM FUNCS -------------------------------

def add_alum(sn, fn, ln, mn, ext, mail, pw, bday, sex, batch, grad, num, comp, compcity, compcountry, pos, cursor): #adds an alumni
	sql = "INSERT into client (firstname, lastname, middlename, extension, email, password) values (%s, %s, %s, %s, %s, %s);"
	args = fn, ln, mn, ext, mail, pw
	cursor.execute(sql, args)
	sql = "SELECT user_id from client where firstname = %s and lastname = %s;"
	args = fn, ln
	cursor.execute(sql, args)
	for uid in cursor:
		alumid = uid
	sql = "INSERT into alumni (student_number, birthday, sex, batch, grad_year, alumni_user_id) values (%s, %s, %s, %s, %s, %s);"
	args = sn, bday, sex, batch, grad, alumid
	cursor.execute(sql, args)

	sql = "INSERT into job (alumni_student_number, company, company_loc_city, company_loc_country, company_position) values (%s, %s, %s, %s, %s);"
	args = sn, comp, compcity, compcountry, pos
	cursor.execute(sql, args)

	sql = "INSERT into contact_num (alumni_student_number, phone_number) values (%s, %s);"
	args = sn, num
	cursor.execute(sql, args)

	if (ext != ''):
		sql = "UPDATE client SET extension = %s WHERE user_id = %s;"
		args = ext, alumid
		cursor.execute(sql, args)
	else:
		sql = "UPDATE client SET extension = %s WHERE user_id = %s;"
		args = None, alumid
		cursor.execute(sql, args)
	print("Added", fn, " ", ln, " as alumni!")

def del_alum(uid, cursor):#deletes alumni from the table
	first = ''
	last = ''

	sql = "DELETE from admin WHERE admin_user_id = %s;"
	args = (uid,)
	cursor.execute(sql, args)

	sql = "SELECT firstname, lastname from client where user_id = %s;"
	cursor.execute(sql, args)
	for fn, ln in cursor:
		first = fn
		last = ln
	sql = "DELETE from client WHERE user_id = %s;"
	cursor.execute(sql, args)
	print("Deleted ", first, " ", last, " from alumni list.")

def print_alums(cursor): #prints the alumni that owns an acct
	cursor.execute("SELECT cl.firstname, cl.lastname, cl.middlename, cl.extension, cl.email, al.student_number, al.alumni_user_id FROM client cl, alumni al where cl.user_id = al.alumni_user_id")
	for fn, ln, mn, ex, email, sn, uid in cursor: # slices the results based on their columns (chronological order)
		initials = mn[0] + '.'; # gets the first letter of the middle name
		if (ex is None):
			print(fn, initials, ln, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid)
		else:
			print(fn, initials, ln, ex, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid)

def find_alum_per_batch(batch, cursor): #shows the alumni that entered the university in the given year 
	print("ALUMNI IN BATCH", batch)
	batchtuple = (batch,)
	cursor.execute("SELECT cl.firstname, cl.lastname, cl.middlename, cl.extension, cl.email, al.student_number, al.batch, al.grad_year, al.alumni_user_id FROM client cl natural join alumni al where cl.user_id = al.alumni_user_id and batch = %s order by cl.lastname desc", batchtuple)
	for fn, ln, mn, ex, email, sn, btch, gdyr, uid in cursor:
		initials = mn[0] + '.';
		if (ex is None):
			print(fn, initials, ln, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid, "Batch:", btch, "Class:", gdyr)
		else:
			print(fn, initials, ln, ex, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid, "Batch:", btch, "Class:", gdyr)

def find_alum_per_class(classnum, cursor): #shows the alumni that graduated in the given year
	print("ALUMNI IN CLASS", classnum)
	classtuple = (classnum,)
	cursor.execute("SELECT cl.firstname, cl.lastname, cl.middlename, cl.extension, cl.email, al.student_number, al.batch, al.grad_year, al.alumni_user_id FROM client cl natural join alumni al where cl.user_id = al.alumni_user_id and grad_year = %s order by cl.lastname desc", classtuple)
	for fn, ln, mn, ex, email, sn, btch, gdyr, uid in cursor:
		initials = mn[0] + '.';
		if (ex is None):
			print(fn, initials, ln, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid, "Batch:", btch, "Class:", gdyr)
		else:
			print(fn, initials, ln, ex, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid, "Batch:", btch, "Class:", gdyr)

def find_alum_batches5(cursor): #shows the alumni that graduated 5, 10, 15, 20 ..., 65 years ago
	yeararr = [] # initialize an array for the years to be counted.
	counter = 5 # this is not exactly a counter, but a decrementing value.
	curryear = timenow.year # this gets the current year based on your system clock.
	for i in range(int(65/5)):
		curryear -= 5; # subtract 5 from the current year.
		yeararr.append(curryear) # add the year to the array above.

	choose = isNum(input("Ascending(1) or descending(0)?:")) # sorts the array.
	if (choose == 1):
		yeararr.reverse() # reverses the array if toggled.

	for year in yeararr:
		print("ALUMNI OF CLASS", year)
		yeartuple = (year,)
		cursor.execute("SELECT cl.firstname, cl.lastname, cl.middlename, cl.extension, cl.email, al.student_number, al.batch, al.grad_year, al.alumni_user_id FROM client cl natural join alumni al where cl.user_id = al.alumni_user_id and grad_year = %s", yeartuple)
		for fn, ln, mn, ex, email, sn, btch, gdyr, uid in cursor:
			initials = mn[0] + '.'; # gets the first letter of the middle name
			if (ex is None):
				print(fn, initials, ln, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid, "Batch:", btch, "Class:", gdyr)
			else:
				print(fn, initials, ln, ex, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid, "Batch:", btch, "Class:", gdyr)
	

# ACTIVITY FUNCS -------------------------------

def add_act(name, partner, cursor): #adds an activity 
	sql = "INSERT into activity (partnerships, event_name) values (%s, %s);"
	args = partner, name
	cursor.execute(sql, args)
	print("Added", name, "as an activity!")

def del_act(name, cursor):#deletes an activity
	act = ''

	sql = "DELETE from activity WHERE event_name = %s;"
	args = (name,)
	cursor.execute(sql, args)

	print("Deleted", name, "from activity list.")

def print_acts(cursor):#prints the activity 
	cursor.execute("SELECT activity_number, partnerships, event_name, YEAR(event_date) FROM activity")
	for num, partner, name, date in cursor:
		print(num, ": '", name, date, "' in partnership with:", partner)


def print_log(cursor): # prints the activity log (basically logger) -- this is a hidden menu choice, basically can be accessed only by those who have the code and read it.
	cursor.execute("SELECT log_id, log, curtime from activity_log")
	for log_id, log, time in cursor:
		print(log_id, ":", log, "\tTime:",time)

# SEACRCH FUNCS -------------------------------

def find_alum(sn, cursor): #search an alumni based on their student number
	sql = "SELECT cl.firstname, cl.lastname, cl.middlename, cl.extension, cl.email, al.student_number, al.alumni_user_id FROM client cl, alumni al where cl.user_id = al.alumni_user_id and al.student_number = %s;"
	args = (sn,)
	cursor.execute(sql, args)
	for fn, ln, mn, ex, email, sn, uid in cursor:
		initials = mn[0] + '.';
		if (ex is None):
			print(fn, initials, ln, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid)
		else:
			print(fn, initials, ln, ex, "(", email, ") Alumni's ID:", sn, "\tUser ID:", uid)

def find_admin(fn, ln, cursor): #search an admin base on the first and last name
	sql = "SELECT cl.firstname, cl.lastname, cl.middlename, cl.extension, cl.email, ad.admin_id, ad.admin_user_id FROM client cl, admin ad where cl.user_id = ad.admin_user_id and cl.firstname = %s and cl.lastname = %s;"
	args = fn, ln
	cursor.execute(sql, args)
	for fn, ln, mn, ex, email, adminid, uid in cursor:
		initials = mn[0] + '.';
		if (ex is None):
			print(fn, initials, ln, email, "Admin's ID:", adminid, "\tUser ID:", uid)
		else:
			print(fn, initials, ln, ex, email, "Admin's ID:", adminid, "\tUser ID:", uid)

def find_activity(num, cursor): #search for activity given the activity number
	print("ACTIVITY:")
	cursor.execute("SELECT activity_number, partnerships, event_name, YEAR(event_date) FROM activity where activity_number = %s", (num,))
	for num, partner, name, date in cursor:
		print(num, ": '", name, date, "' in partnership with:", partner)

#===================================#
#          Main menu proper         #
#===================================#

glblInit() # initializes GUI window.

choice = None # initialize choice to None
while (choice != 0): # Loop while user does not pick 0(exit).
	choice = print_menu()
	if (choice > 15 or choice < 0): # If choice is out of range, print invalid input (note that 15 is still valid due to the hidden menu item)
		print("INVALID INPUT")
	elif (choice == 0): # exit
		mariadb_conn.close() # close the database connection for security purposes.
		print("Thank you!")
		break # end the loop
	elif (choice == 1): # admin
		print("(1) Add admin")
		print("(2) Delete admin")
		print("(3) Return to main")
		ad_choice = isNum(input("Choice: "))
		if (ad_choice == 1): # add admin
			ad_fname = input("Enter admin's first name: ")
			ad_lname = input("Enter admin's last name: ")
			ad_mname = input("Enter admin's middle name: ")
			ad_ext = input("Enter admin's extension (if applicable): ")
			ad_email = input("Enter admin's e-mail address: ")
			ad_pass = input("Enter admin's password: ")
			add_admin(ad_fname, ad_lname, ad_mname, ad_ext, ad_email, ad_pass, cursor)
		elif (ad_choice == 2): # delete admin
			ad_id = isNum(input("Enter admin's user id: "))
			del_admin(ad_id, cursor)
		elif (ad_choice == 3): # return to main menu
			continue

	elif (choice == 2): # alum
		print("(1) Add alumni")
		print("(2) Delete alumni")
		print("(3) Return to main")
		al_choice = isNum(input("Choice: "))
		if (al_choice == 1): # add alumni
			al_sn = isNotEmpty(input("Enter alumni's student number: "))
			al_fname = input("Enter alumni's first name: ")
			al_lname = input("Enter alumni's last name: ")
			al_mname = input("Enter alumni's middle name: ")
			al_ext = input("Enter alumni's extension (if applicable): ")
			al_email = input("Enter alumni's e-mail address: ")
			al_pass = input("Enter alumni's password: ")

			print("Enter alumni's birthday:")
			al_mon = isNum(input("Month (mm):"))
			al_day = isNum(input("Day (dd):"))
			al_year = isNum(input("Year (yyyy):"))
			al_birthday = str(al_year) + "-" + str(al_mon) + "-" + str(al_day)

			al_sex = input("Enter alumni's sex: ")
			al_batch = isNum(input("Enter alumni's batch: "))
			al_gradyear = isNum(input("Enter alumni's class: "))
			al_pnum = isNum(input("Enter alumni's phone number: "))
			al_job_check = hasJob(input("Does alumni have a job? (Y/N): "))
			if (al_job_check == "Y" or al_job_check == "y"):
				al_comp = input("Enter the name of the company: ")
				al_compcity = input("Enter the city where the company is situated: ")
				al_compcountry = input("Enter the country where the company is situated: ")
				al_pos = input("Enter the alumni's position: ")
			else:
				al_comp = None
				al_compcity = None
				al_compcountry = None
				al_pos = None
			add_alum(al_sn, al_fname, al_lname, al_mname, al_ext, al_email, al_pass, al_birthday, al_sex, al_batch, al_gradyear, al_pnum, al_comp, al_compcity, al_compcountry, al_pos, cursor)
		elif (al_choice == 2): # delete alumni
			al_id = isNum(input("Enter alumni's user id: "))
			del_alum(al_id, cursor)
		elif (al_choice == 3): # return to main menu
			continue

	elif (choice == 3): # act_log
		print("(1) Add activity")
		print("(2) Delete activity")
		print("(3) Return to main")
		act_choice = isNum(input("Choice: "))
		if (act_choice == 1):
			act_name = input("Enter the activity's name: ")
			act_partnership = input("Enter the partnership: ")
			add_act(act_name, act_partnership, cursor)
		elif (act_choice == 2):
			act_name = input("Enter the activity's name: ")
			del_act(act_name, cursor)
		elif (act_choice == 3):
			continue

	elif (choice == 4): # print admin
		print("\nAdmins of the system:\n")
		print_admins(cursor)

	elif (choice == 5): # print alum
		print("\nAlumni:\n")
		print_alums(cursor)

	elif (choice == 6): #print activity
		print("\nActivities:\n")
		print_acts(cursor)

	elif (choice == 7): # save
		savepoint = input("SAVE DATABASE?(Y/N):")
		if (savepoint == "Y" or savepoint == "y"):
			mariadb_conn.commit() # saves the database
			print("SUCCESSFULLY SAVED")
		elif (savepoint == "N" or savepoint == "n"):
			print("DATABASE NOT SAVED")
		else:
			print("INVALID INPUT")
	elif (choice == 8): # Resets GUI to initial state. Reshows GUI.
		glblInit()

	elif (choice == 9): #list of alumni members per batch.
		batch = isNum(input("Enter batch you want to see: "))
		find_alum_per_batch(batch, cursor)

	elif (choice == 10): #list of alumni members per class.
		classnum = isNum(input("Enter class you want to see: "))
		find_alum_per_class(classnum, cursor)

	elif (choice == 11): #list of alumni members per 5 batches (until the 65th batch).
		find_alum_batches5(cursor)

	elif (choice == 12): #find alumni. Required: Student number.
		sn = isNum(input("Enter student number: "))
		find_alum(sn, cursor)

	elif (choice == 13): #find admin. Required: First and last name.
		fn = input("Enter first name: ")
		ln = input("Enter last name: ")
		find_admin(fn, ln, cursor)

	elif (choice == 14): #find activity. Required: Activity ID.
		act_id = isNum(input("Enter activity's ID: "))
		find_activity(act_id, cursor)

	elif (choice == 15): #print log. (Comes from the activity log table, and is only modified whenever triggers are triggered) -- hidden
		print_log(cursor)