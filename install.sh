#!/bin/bash
# Copy@right SMARTSOFT Technology see License.txt
#############################################################################################
# HOLYSQL SCANNER Install script.
# Install tool in linux os.
# SMARTSOFT Technology 2018
#############################################################################################
# PATHs:
# Install directory => default: /usr/share/holysql/
# Bash completion => /etc/bash_completion.d/holysql
# Sym link => /usr/bin/holysql
# Readme => /usr/share/doc/holysql/README.md
# Desktop entry => /usr/share/applications/holy_sql.desktop
# Icons => /usr/share/icons/hicolor/
# License => /usr/share/doc/holysql/License.txt
#############################################################################################
##
echo "[ ]=======================================================================[ ]";
echo "[ ]                      SMARTSOFT  TECHNOLOGY                               [ ]";
echo "[ ]                  holysql Tool Install Script                           [ ]";
echo "[ ]=======================================================================[ ]";
echo "[ ] MIT License                                                           [ ]";
echo "[ ] Copyright (c) 2018 Smartsoft Technology                                  [ ]";
echo "[ ]                                                                       [ ]";
echo "[ ] Permission is hereby granted, free of charge, to any person obtaining [ ]";
echo "[ ] a copy of this software and associated documentation files (holysql),  [ ]";
echo "[ ] to dealin the Software without restriction, including without         [ ]";
echo "[ ] limitation the rights to use, copy, modify, merge, publish,           [ ]";
echo "[ ] distribute, sublicense, and/or sellcopies of the Software, end to     [ ]";
echo "[ ] permit persons to whom the Software is furnished to do so, subject    [ ]";
echo "[ ] to the following conditions:                                          [ ]";
echo "[ ]                                                                       [ ]";
echo "[ ] The above copyright notice and this permission notice shall be        [ ]";
echo "[ ] included in all copies or substantial portions of the Software.       [ ]";
echo "[ ]                                                                       [ ]";
echo "[ ] THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS [ ]";
echo "[ ] OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF            [ ]";
echo "[ ] MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT [ ]";
echo "[ ] IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY  [ ]";
echo "[ ] CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,  [ ]";
echo "[ ] TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE     [ ]";
echo "[ ] SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                [ ]";
echo "[ ]=======================================================================[ ]";

echo "";

### Check system compatibility
if [ -d "/usr/bin/" ];
then
echo "[!] By installing this software you agree to our terms! [Y/n]: ";
read baba
if [ "$baba" == "y" ] || [ "$baba" == "Y" ] || [ -z "$baba" ]; 
then
  echo " "
else
  echo "[!] Installation aborted!";
  exit
fi

### Checking previous instalation
echo "[i] Checking directories..."
if [ -e "/usr/bin/holysql" ];
then
echo "[!] A previous installation was found Do you want to replace it? [Y/n]: "
read mama
if [ "$mama" == "y" ] || [ "$mama" == "Y" ] || [ -z "$mama" ];  
then
 rm "/usr/bin/holysql"
else
 echo "[!] Installation aborted!";
 exit
fi
fi

### Setting instalation path
current=$(dirname "$0")
echo "[!] Where do you want to install HOLYSQL?";
echo "    Set path or press enter to use default [/usr/share/]: "
read refdir
if [ -z "$refdir" ];
then
  if [ ! -d "/usr/share/holysql/" ];
  then
    mkdir "/usr/share/holysql/";  
  fi
  chmod +x "/usr/share/holysql/";
  refdir="/usr/share/holysql/";
fi

if [ ! -d $refdir ];
then
  until [ -d $refdir ];
  do
   echo "[!] $refdir does not exist!";
   echo "[!] Set path or press enter to use default [/usr/share/]: "
   read refdir
  done
fi
      
## Begin instalation
echo "[!] Installing.. Plaise wait...";

if [ $current != $refdir ];
then
 sleep 1 && echo "[i] Moving files to $refdir ...                         [ 5%]";
 cp -r $current/* $refdir;
fi 

 sleep 1 && echo "[i] Creating symbolic link...                                      [12%]";
 echo "#!/bin/bash 
 perl $refdir/holysql_scanner.pl" '${1+"$@"}' > holysql;
 chmod +x holysql;
 sudo cp holysql /usr/bin/;
 rm holysql;
 sleep 1 && echo "[i] Creating Completion link...                                    [18%]";
 if [ -d "/etc/bash_completion.d" ] ;
 then
   chmod +x $refdir/inc/conf/holysql;
   sudo cp $refdir/inc/conf/holysql /etc/bash_completion.d/;
 fi
 
 sleep 1 && echo "[i] Setting update files...                                        [30%]";
 echo `date +%Y%j` >> $refdir/inc/conf/uplog.log;
 echo -en "\n" >> $refdir/inc/conf/version.log;

 sleep 1 && echo "[i] Creating shirt links...                                        [38%]";
 if [ ! -d "/usr/share/applications" ]; 
 then
   mkdir "/usr/share/applications";  
 fi
 chmod +x "/usr/share/applications";

 sudo cp $refdir/inc/conf/desktop/holysql.desktop /usr/share/applications/;
 if [ ! -e "/usr/share/applications/holysql.desktop" ]; 
 then
   echo "Warning! Failed to add direct access to the applications menu!";  
 fi

 sleep 1 && echo "[i] Copying icons...                                               [47%]";
 if [ ! -d "/usr/share/icons" ]; 
 then
   mkdir "/usr/share/icons";  
 fi
 chmod +x "/usr/share/icons";
 
 if [ ! -d "/usr/share/icons/hicolor" ]; 
 then
   mkdir "/usr/share/icons/hicolor";  
 fi
 chmod +x "/usr/share/icons/hicolor";
 
 
 if [ ! -d "/usr/share/icons/hicolor/16x16" ]; 
 then
   mkdir "/usr/share/icons/hicolor/16x16";  
 fi
 chmod +x "/usr/share/icons/hicolor/16x16";
 if [ ! -d "/usr/share/icons/hicolor/16x16/apps" ]; 
 then
   mkdir "/usr/share/icons/hicolor/16x16/apps";  
 fi
 chmod +x "/usr/share/icons/hicolor/16x16/apps";
 sudo cp $refdir/inc/conf/desktop/16x16/holysql-menu.png /usr/share/icons/hicolor/16x16/apps/;
 
 if [ ! -d "/usr/share/icons/hicolor/22x22" ]; 
 then
   mkdir "/usr/share/icons/hicolor/22x22";  
 fi
 chmod +x "/usr/share/icons/hicolor/22x22";
 if [ ! -d "/usr/share/icons/hicolor/22x22/apps" ]; 
 then
   mkdir "/usr/share/icons/hicolor/22x22/apps";  
 fi
 chmod +x "/usr/share/icons/hicolor/22x22/apps";
 sudo cp $refdir/inc/conf/desktop/22x22/holysql-menu.png /usr/share/icons/hicolor/22x22/apps/;
 
 if [ ! -d "/usr/share/icons/hicolor/24x24" ]; 
 then
   mkdir "/usr/share/icons/hicolor/24x24";  
 fi
 chmod +x "/usr/share/icons/hicolor/24x24";
 if [ ! -d "/usr/share/icons/hicolor/24x24/apps" ]; 
 then
   mkdir "/usr/share/icons/hicolor/24x24/apps";  
 fi
 chmod +x "/usr/share/icons/hicolor/24x24/apps";
 sudo cp $refdir/inc/conf/desktop/24x24/holysql-menu.png /usr/share/icons/hicolor/24x24/apps/;
 
 if [ ! -d "/usr/share/icons/hicolor/48x48" ]; 
 then
   mkdir "/usr/share/icons/hicolor/48x48";  
 fi
 chmod +x "/usr/share/icons/hicolor/48x48";
 if [ ! -d "/usr/share/icons/hicolor/48x48/apps" ]; 
 then
   mkdir "/usr/share/icons/hicolor/48x48/apps";  
 fi
 chmod +x "/usr/share/icons/hicolor/48x48/apps";
 sudo cp $refdir/inc/conf/desktop/48x48/holysql-menu.png /usr/share/icons/hicolor/48x48/apps/;
 
 if [ ! -d "/usr/share/icons/hicolor/256x256/" ]; 
 then
   mkdir "/usr/share/icons/hicolor/256x256/";  
 fi
 chmod +x "/usr/share/icons/hicolor/256x256/";
 if [ ! -d "/usr/share/icons/hicolor/256x256//apps" ]; 
 then
   mkdir "/usr/share/icons/hicolor/256x256//apps";  
 fi
 chmod +x "/usr/share/icons/hicolor/256x256//apps";
 sudo cp $refdir/inc/conf/desktop/256x256//holysql-menu.png /usr/share/icons/hicolor/256x256//apps/;
 
 ########################################################################################################################

 if [ ! -d "/usr/share/doc/holysql" ]; then
   mkdir "/usr/share/doc/holysql";
 fi
 ########################################################################################################################
 
 sleep 1 && echo "[i] Copying README.md to /usr/share/doc/holysql...                  [75%]";
 chmod +x "/usr/share/doc/holysql/";
 chmod +x $refdir/README.md;
 sudo cp $refdir/README.md /usr/share/doc/holysql/;
 sleep 1 && echo "[i] Copying License.txt to /usr/share/doc/holysql...                [83%]";
 chmod +x $refdir/License.txt;
 sudo cp $refdir/License.txt /usr/share/doc/holysql/;
 sleep 1 && echo "[i] Removing install files...                                      [92%]";
 rm $refdir/inc/conf/holysql;
 rm $refdir/install.sh; 
 if [ -d "$refdir/holysql_install" ];
 then
   rm -r $refdir/holysql_install;
 fi
 rm $refdir/README.md;
 rm $refdir/License.txt;
 if [ -d "$refdir/inc/conf/desktop" ]; 
 then
   rm -r $refdir/inc/conf/desktop;
 fi
 if [ -e "$refdir/holysql" ] || [ -e "$refdir/holysql.pl" ];
 then     
     
 echo "";
 echo "+======================================================================+";
 echo "| 1 INTERACTIVE: You will use holysql by simple interactive options.    |";
 echo "| 2 ADVANCED:    You will use advanced holysql by command line.         |";
 echo "+======================================================================+";
 echo "|   NOTE: This setting can be changed in user configation!             |";
 echo "+======================================================================+";
 echo "";
 echo "[!] How do you like to boot the tool? [Default 2]: ";

 read modeChoice
 if [ "$modeChoice" == "1" ]; 
 then
  sudo sed -i 's/holysql;/holysql --interactive;/g' /usr/share/applications/holysql.desktop;
  echo "interactive on" >> $refdir/inc/conf/userSetting;
 fi
 sleep 1 && echo "[i] Tool successfully installed and will start in 3s!..           [100%]";
 sleep 3;
 holysql --update;
else
 echo "[!] Installation faid!! ";
 exit
fi
else
 echo "[!] Tool cannot be installed on your system! Use it as portable!";
fi