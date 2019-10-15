userName=$(whoami)

#Andrew
createFile()
{
	#CALL CREATEFILE BASH SCRIPT 
    echo ""
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
    clear
    echo "-EDITING FILE-"
    echo "Files in this directory: "
    ls
    echo " "
    echo "Which file would you like to edit: "
    read filename
    #checks to see if file exists
    if [ -f "$filename" ]; then
        # code which creates folder and moves file into it when user is editing
        mkdir $userName && mv $filename $userName && cd $userName && nano $fileName 
        #while a process of nano is open do nothing
        while [ -n "`pgrep nano`" ]; do :; done
        #moves file out of user folder then deletes users folder
        mv $filename .. && cd .. && rmdir $userName
        #check for backup file. if backup file exists then output diff comand to logfile in log directory

        #then use backup command to backup file
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
	#CALL RESTORE FILE BASH SCRIPT
    echo""
}
#Dillon
archiveFile()
{
	#CALL ARCHIVE FILE BASH SCRIPT
    echo ""
}


notFound=true

clear
echo "Hello "$userName
ls -d */
read -p "Please enter which repository you would like to view:" repoName

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

echo "Menu Test, Please Select:"
PS3='Please enter your choice(1,2,3,4): '
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
