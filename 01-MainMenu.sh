userName=$(whoami)

#Andrew
createFile()
{
	#CALL CREATEFILE BASH SCRIPT 
    echo ""
}

#James
#Ask user which file they would like to edit
#check if file exists
#if file exists then ask which editor they would like to use
#move file into users editing directory
#open file and let user edit
#when user has finished editing file(check processes for editor)
#move file back into starting directory and compare file with most recent backup
#create a log file and save it in folder called logs.
#then create an automatic backup
editFile()
{
    clear
    echo "-EDITING FILE-"
    echo "Files in this directory: "
    ls -p | grep -v / 
    echo " "
    echo "Which file would you like to edit: "
    read filename
    #checks to see if file exists
    if [ -f "$filename" ]; then
        # code which creates folder and moves file into it when user is editing
        mkdir $userName && mv $filename $userName && cd $userName && nano $filename
        #while a process of nano is open do nothing
        while [ -n "`pgrep nano`" ]; do :; done
        #moves file out of user folder then deletes users folder
        mv $filename .. && cd .. && rmdir $userName
        #check for backup file. if backup file exists then output diff command to logfile in log directory
        #Create a logs folder. have a file called filename. then write name>changes>date
        cd Backups || (mkdir Backups && cd Backups)
        if [ -f "$filename"* ]; then
            compareFile=$(ls -t $filename* | head -1)
            difference=$(diff $compareFile ../$filename) 
            cd ..
            cd logs || mkdir logs && cd logs
            log=$(ls -t $filename* | head -1)
            echo "File edited by $(whoami) at $(date)">>$log
            echo "Changes:">>$log
            echo $difference>>$log
            echo "">>$log
            cd ..
        else
            #This block of code runs if no backup file is available for the edited file
            cd ..
            cd logs || mkdir logs && cd logs
            #creates a logfile of the file that has been edited
            logfile="$(echo $filename)_logs"
            touch $logfile
            echo "File created by $(whoami) at $(date)">$logfile
            echo "Added:">>$logfile
            cat ../$filename>>$logfile
            echo "">>$logfile
            cd ..
        fi

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

#main menu.
clear
echo "Currently logged in as "$userName
echo "Available repositories: "
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

while true; do
    clear
    echo "current directory: "
    pwd
    echo "Available files: "
    ls -p | grep -v / 
    echo " "
    echo "1. New File"
    echo "2. Edit File"
    echo "3. Backup or Restore"
    echo "4. Quit"
    read -p ":" userInput
    if [ "$userInput" == "1" ]; then
        createFile
    elif [ "$userInput" == "2" ]; then
        editFile
    elif [ "$userInput" == "3" ]; then
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
    elif [ "$userInput" == "4" ]; then
        break
    else
        echo "Invalid input please try again"
    fi
done