# How to create a deb file
By Running the deb-builder.sh script you can create a debain file from your files.

#Example
If you want to build a debian file, founding in "/usr/bin" after installation, you just need put it in "files/usr/bin" and run the deb-builder.sh file.
Moreover, for your case, you can decide what happens before and after installation by making some changes in deb-builder.sh file and in the debian/preinst.ex and debian/postinst.ex parts, respectively.
