userName=$(whoami)
notFound=true
echo "Hello "$userName
ls
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
PS3='Please enter your choice: '
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
			echo " "
            echo "Which file would you like to edit: "
            echo " "
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


#Andrew
createFile()
{
	#CALL CREATEFILE BASH SCRIPT 
}

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
}
#Dillon
backupFile()
{
	#CALL BACKUP FILE BASH SCRIPT
}
#Andrew
restoreFile()
{
	#CALL RESTORE FILE BASH SCRIPT
}
#Dillon
archiveFile()
{
	#CALL ARCHIVE FILE BASH SCRIPT
}