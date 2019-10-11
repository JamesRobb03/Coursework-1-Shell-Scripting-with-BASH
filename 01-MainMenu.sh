userName=$(whoami)
notFound=true
echo "Hello "$userName
ls
read -p "Please enter which repository you would like to view:" repoName

while true; do

		if [ -d "$repoName" ] 
		then
			ls $repoName
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

createFile()
{
	#CALL CREATEFILE BASH SCRIPT 
}

editFile()
{
	#CALL EDIT FILE BASH SCRIPT
}

backupFile()
{
	#CALL BACKUP FILE BASH SCRIPT
}

restoreFile()
{
	#CALL RESTORE FILE BASH SCRIPT
}

archiveFile()
{
	#CALL ARCHIVE FILE BASH SCRIPT
}