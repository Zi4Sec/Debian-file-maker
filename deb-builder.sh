######################################################
#		[Your Company Name]		     #
#Instruction for building deb files from [your app] #
#		Creator: zia nazari		     #
#		Data: 2019/9/3                       #
######################################################

# Set variables
module_name="your app or service name"
module_section="just set a string here"
module_descryption="some descryption about your app or service"
module_dependency="list of dependencies separated by comma. for example: sshfs,libpq-dev"
version="1.0.0"
email= "zianazari@ce.sharif.edu"
# Create debian file structure
dh_make --native --single --packagename ${module_name}_${version} --email ${email}

# Change control file which is in debian directory
echo "Source: ${module_name}" > debian/control
echo "Section: ${module_section}" >>  debian/control
echo "Priority: optional" >>  debian/control
echo "Maintainer: root <${email}>" >>  debian/control
echo "Build-Depends: debhelper (>= 9)" >>  debian/control
echo "Standards-Version: 3.9.5" >>  debian/control
echo "Homepage: http://yourwebsite" >>  debian/control
echo "" >>  debian/control
echo "Package: ${module_name}" >>  debian/control
echo "Architecture: any" >>  debian/control
echo "Depends: ${shlibs:Depends}, ${misc:Depends}${module_dependency}" >>  debian/control
echo "Description: ${module_descryption}" >>  debian/control

# Create install file in debian directory and specify where (in linux file system) files are located.
# Lets' suppose our app is located in /usr/bin directory. You can change it to an anarbitrary directory if you want
# Based on this part, all contents in the files/usr/ directory will be copied to /usr of the target machine
touch debian/install
echo "files/usr/* usr" > debian/install

# Rename  debian/preinst.ex to debian/preinst and change it so that to specify what happened before installation of your deb file.
mv debian/preinst.ex debian/preinst
echo '#!/bin/bash' > debian/preinst
echo "set -e" >> debian/preinst
echo "rm /usr/bin/my_old_app.sh" >> debian/preinst

#Rename  debian/postinst.ex to debian/postinst and change it change it so that to specify what happened after installation of your deb file.
mv debian/postinst.ex debian/postinst
echo '#!/bin/bash' > debian/postinst
echo "set -e" >> debian/postinst
echo "chmod 755 /usr/bin/my_new_app.sh" >> debian/postinst
echo "bash /usr/bin/my_new_app.sh" >> debian/postinst

#you change debian changelog file by 'dch -im' command
dpkg-buildpackage -rfakeroot -us -uc -b
