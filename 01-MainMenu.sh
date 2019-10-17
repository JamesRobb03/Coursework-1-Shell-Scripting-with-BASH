userName=$(whoami)
#Andrew
createFile()
{
    #Asks the user what filename they'd like to give the file
	read -p "Please enter file name: " fileName
    if [ -e $fileName ]; 
    then
      echo "File $fileName already exists!"
    else
    	#prevents a file called "QUIT" being made
    	if [ $fileName=="QUIT" ]
    	then
    		echo "Quitting..."
    	else
    	#Creates new file and notifies user of success
        echo >> $fileName
        echo "$fileName added!"
        fi
    fi
}

#Notes for meeting:
#menu should give option to move into folders
#as in repo's there could be folders
#James
editFile()
{
    #Ask user which file they would like to edit
    #check if file exists
    #if file exists then ask which editor they would like to use
    #move file into users editing directory
    #open file and let user edit
    #when user has finished editing file(check processes for editor)
    #move file back into starting directory and compare file with most recent backup
    #create a log file and save it in folder called logs.
    #then create an automatic backup
	#CALL EDIT FILE BASH SCRIPT
    echo "Files in this directory: "
    ls
    echo " "
    echo "Which file would you like to edit: "
    read filename
    if [ -f "$filename" ]; then
        mkdir $userName && mv $filename $userName && cd $userName && nano $fileName 
        while [ -n "`pgrep nano`" ]; do :; done
        mv $filename .. && cd .. && rmdir $userName
        #check for backup file. if backup file exists then output diff comand to logfile in log directory
        #then use backup command to backup filegit stat
        echo "success"

    else
        echo "does not exist. please try again"
    fi
}
#Dillon
backupFile()
{
	#CALL BACKUP FILE BASH SCRIPT
    echo ""
}
#Andrew
restoreFile()
{
	#Alerts the user that it is case sensitive, and asks "Backups or Archives?"
	echo "Case Sensitive!"
    echo "Backups or Archives?"
    #Gives the user a prompt, and collects their data under "File"
    read -p "Enter Here: " file
    #Checks the file exists before attempting a restore
    if [ -e $file ]; 
    then
    	if [ $file=="Backup" ];
    	then
	        echo "Entering $fileName... " 
	        #Enters the required file, and displays the files inside
	        cd $file
	        ls $file
	        echo ""
	        echo "Which file would you like to restore?"
	        read -p "Enter file here: " restore
	        #Copies to the restore location
	        if [ -e $restore ]; 
    		then
	        	cp -r $restore /Coursework-1-Shell-Scripting-with-BASH
	    	else
	    		echo "$file doesn't exist."
	    	fi
	    else
	    	if [ $file=="Archives" ];
	    	then
	    		echo "Entering $fileName... " 
		        #Enters the required file, and displays the files inside
		        cd $file
		        ls $file
		        echo ""
		        echo "Which file would you like to unzip?"
		        read -p "Enter file here: " restore
		        if [ -e $restore ]; 
	    		then
	    			#unzips folder
	    			unzip $restore -d /Coursework-1-Shell-Scripting-with-BASH
		    	else
		    		echo "$file doesn't exist."
		    	fi
	    	else
	    		echo "$file doesn't exist."
	    	fi
	    fi
    else
    	#Error Check
        echo "$file doesn't exist."
    fi
}
#Dillon
archiveFile()
{
	#CALL ARCHIVE FILE BASH SCRIPT
    echo ""
}


notFound=true

echo "Hello "$userName
ls
read -p "Please enter which repository you would like to view: " repoName

while true; do

        if [ -d "$repoName" ] 
        then
            cd $repoName;
            ls
            break
        elif [ ! -d "$repoName" ] 
        then
            echo "Could not find please try again"
            read -p "Please enter which repository you would like to view:" repoName
        fi
done

echo "Menu Test, Please Select: "
PS3="Please enter your choice: "
options=("New File" "Edit File" "Backup & Restore" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "New File")
            echo " "
            echo "Please insert new file name: "
            echo " "
            createFile
            ;;
        "Edit File")
            
            # read fileToEditName
            editFile
            ;;
        "Backup & Restore")
            echo " "
            echo "1) Backup"
            echo "2) Restore"
            echo "3) Archive"
            echo " "
            read varname
            while [[ "$varname" !=  "1" && "$varname" != "2" && "$varname" != "3" ]]; do
                echo "This is an invalid choice. Please choose from select 1, 2, or 3 as your choice, corresponding with the above options."
                read varname
            done

            if [ "$varname" == "1" ] ; then
                backupFile
            elif [ "$varname" == "2" ]; then
                restoreFile
            
            elif [ "$varname" == "3" ]; then 
                archiveFile

            fi      
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done 
