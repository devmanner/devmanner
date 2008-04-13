#!/usr/local/bin/perl
#########################################################################
# Script name: VeriCoolVareables.pl 0.1.1				#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released:						#
# Comments: This script is just to set up the vareables for the		#
# different VeriCool cgi-scripts. It is easier to just set up the vars.	#
# once. All the cgi-scripts "does" this file with the command do.	#
#########################################################################
# Define vareables							#

# The name of the file containing the menubar printed at the top of	#
# the window. (Full path)						#
$menubarfile = "/home/pr-traco/public_html/VeriCool/MenuBar.shtml";

# The path to the VeriCool ini file. In that file the responsibilety	#
# for the different parts of the project is defined.			#
$vc_ini = "/vobs/AXD30/ASIC/TRACO_ROP1011611/vericool/ini/TRACO.ini";
# Dryswim!
#$vc_ini = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR/TRACO.ini";

# The dir where the VeriCool Website is located.			#
$webdir = "/home/pr-traco/public_html/VeriCool";

# The index site of the VeriCool Website. Not index.html		#
$website = "http://avweb.etxb.ericsson.se/~pr-traco/VeriCool/index2.html";

# The url to the VeriCool Website.					#
$baseurl = "http://avweb.etxb.ericsson.se/~pr-traco/VeriCool/";

# Path to graphics directory.						#
$picdir = "pics";

# The name of the main frame in the VeriCool Website			#
$mainframe = "Main";

#########################################################################
# VeriCool vareables          					        #
# The url to the cgi scripts for VeriCool.				#
$cgi_url = "http://avweb.etxb.ericsson.se/cgi-bin/Mustang/VeriCool";

# The file where the information about the releases is stored.		#
$release_dir = "/home/pr-traco/releases/prevReleases";

# The file where the PrintFile.pl script is allowed to look. This dir	#
# or the directorys below shall not contain any "secret" information	#
# such as crypted passwords etc.					#
$alloweddir = '/home/pr-traco/releases/releaseDir';

# The dir where the releases are stored.				#
$basedir = "/home/pr-traco/releases/releaseDir";

# The name of the info file for each release				#
$rel_info_filename = "release.info";

# The name of the release configuration file.				#
$release_conf_file = "release.conf";

# Ending of the file containing the changed files.			#
$ch_file = ".files.changed";

# Ending of the file containing the comments.				#
$comments_file = ".comments";

# The javascript file created by the VeriCool.pl perlscript.		#
$mymenufile = "myMenu.js";

#########################################################################
# TR system vareables.                                                  #
# The script used to view the TR tree                                   #
$treeviewscript = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR/ViewTRTree.pl";

# The url to the script used to view the TR tree                        #
$treeviewscript_url = "http://avweb.etxb.ericsson.se/cgi-bin/Mustang/VeriCool/TR/ViewTRTree.pl";

# The directory where the TR's are stored. When they change status to	#
# finished they are moved to $arch_dir.	(Full paths)			#
$issue_dir = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR/Issue";
$arch_dir = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR/Archive";

# The TR data file containing the current idnumber. (Full path)		#
$data = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR/data.txt";

# The url where the tr cgi-scripts are stored.				#
$tr_cgi_url = "http://avweb.etxb.ericsson.se/cgi-bin/Mustang/VeriCool/TR";

# The directory where the tr cgi-scripts are stored.			#
$tr_cgi_dir = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR";

# The flag for sending e-mails to the responsible person when an error	#
# is reported.								#
$sendmail = 1;

# Set up this option to handle to whom an e-mail is sent if an error is	#
# reported on block "Unknown". This can be either "all" (send to all	#
# users listed in $vc_ini) or an e-mail adress				#
# ex.qtxtman@etxb.ericsson.se						#
$mail_to_unknown = "all";

# The domain to where the e-mails are sent. Example: @etxb.ericsson.se	#
$email_domain = "\@etxb.ericsson.se";

# A mail will always be sent to $always_email. (without                 #
# @my.mail.domain.com) May be NULL                                      #
$always_email = "";

# The title of the TR status page.					#
$stat_title = "TRACO TR status";

# The title of the TR status page.					#
$chart_title = "Status (ea.)";

# The statuses available in the TR-system. Firat shall always be "Issue"#
@stat_avail = ("Issue", "Follow up", "Finish");

# The colours for the different statuses in the TR-system.		#
$STAT_COLOR{'Issue'} = "red";
$STAT_COLOR{'Follow up'} = "orange";
$STAT_COLOR{'Finish'} = "green";

# The labels in the TR statistics chart                 		#
$CHART_STAT_LABEL{'Issue'} = "Issued";
$CHART_STAT_LABEL{'Follow up'} = "Followed up";
$CHART_STAT_LABEL{'Finish'} = "Finished";

# The available prioritys in the TR system.				#
@prio_avail = ("Low", "Normal", "Critical");

# The images used to represent the different prioritys in the TR tree.  #
# Set all to trans.gif if you don't whant different images for          #
# different prios.                                                      #
$PRIO_COLOR{'Low'} = "#00CC00";
$PRIO_COLOR{'Normal'} = "#FF9900";
$PRIO_COLOR{'Critical'} = "#FF0000";

# Font used to print the TR's in a fixed font. Tip: use a fontlist for  #
# exsample: "Verdana, Courier, fixed-font".                             #
$fixed_font = "Verdana, Courier, fixed-font";

# The .class file for the status chart.					#
#$chartfile = "Chart.class";                     # Staple
$chartfile = "PieChart.class";                 # Pie

# The url to the .class file for the status chart.			#
$charturl = "http://avweb.etxb.ericsson.se/~pr-traco/VeriCool/";

#########################################################################
# Release tree variables.					        #
# Text for the menu root in the VeriCool Website.			#
$menu_root_name = "VeriCool View Tree";

# The version of the menu. Make this unique for each tree menu.		#
$tree_menu_name = "myMenu_4.0";

# Number of days to keep the cookie for the tree menu.			#
$tree_menu_days = "0";

# Name of the menu frame in the VeriCool Website.			#
$tree_menu_frame = "Mainframe";

# Background image for menu frame in the VeriCool Website.		#
$menubg = "VertLinesBig.gif";

# Color for menu frame background in the VeriCool Website.		#
$tree_menu_bg_color = "#000000";

# Color for menu item text in the menutree in the VeriCool Website.	#
$tree_menu_fg_color = "#efefef";

# Color for selected item in the menutree in the VeriCool Website.	#
$tree_menu_hi_bg_color = "#008080";

# Color for selected item text in the menutree in the VeriCool Website.	#
$tree_menu_hi_fg_color = "#FFFFFF";

# Text font face in the menutree in the VeriCool Website.		#
$tree_menu_font = "MS Sans Serif,Arial,Helvetica";

# Text font size in the menutree in the VeriCool Website.		#
#$tree_menu_font_size = "1";
$tree_menu_font_size = "2";

# Sets display of '+' and '-' icons in the menutree in the VeriCool	#
# Website.								#
$tree_menu_folders = "1";

# Use menu item text for icon image ALT text in the menutree in the	#
# VeriCool Website. (true/false)					#
$tree_menu_alt_txt = "true";

# Done									#
#########################################################################
