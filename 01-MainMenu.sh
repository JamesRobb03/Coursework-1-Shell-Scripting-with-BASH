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
        if ls $fileName* 1> /dev/null 2>&1; then
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
            cd logs || ( mkdir logs && cd logs )
            #creates a logfile of the file that has been edited
            logfile="$(echo $filename)_logs"
            touch $logfile
            echo $(whoami)>$logfile
            echo "File created by $(whoami) at $(date)">>$logfile
            echo "Added:">>$logfile
            cat ../$filename>>$logfile
            echo "">>$logfile
            cd ..
        fi

        backupFile

        #then use backup command to backup file
        echo "success"

    else
        echo "does not exist. please try again"
    fi
}
#Dillon
backupFile()
{
    lFileName=$filename
    now=$(date '+%F_%H:%M:%S')

    newFileName="${lFileName}"-"${now}"

     while [ ! -f "$lFileName" ]; do
        echo "Error! This file does not exist"
        echo "$lfileName"
        break
     done

     if [ -f "$lFileName" ]; then
        cp "$lFileName" "$newFileName"
        mv $newFileName Backups
        cd Backups
        
        if [ -f "$newFileName" ]; then
            echo "Backup Successful"

        elif [ ! -f "newFileName" ]; then
            echo "ERROR";
        fi 
    fi

    cd ..

}
#Andrew
restoreFile()
{
   echo "Case Sensitive!"
    echo "Backups or Archive?"
    #Gives the user a prompt, and collects their data under "File"
    read -p "Enter Here: " file
    #Checks the file exists before attempting a restore
    if [ -e $file ]; 
    then
        if [ $file=="Backups" ];
        then
            echo $file
            echo "Entering $file... " 
            #Enters the required file, and displays the files inside
            cd $file
            ls 
            echo ""
            echo "Which file would you like to restore?"
            read -p "Enter file here: " restore
            #Copies to the restore location
            if [ -e $restore ]; 
            then
                cp -r $restore $repoName
            else
                echo "$file doesn't exist."
            fi
        else
            if [ $file=="Archive" ];
            then
                echo "Entering $fileName... " 
                #Enters the required file, and displays the files inside
                cd $file
                ls 
                echo ""
                echo "Which file would you like to unzip?"
                read -p "Enter file here: " restore
                if [ -e $restore ]; 
                then
                    #unzips folder
                    unzip $restore -d $repoName
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
    cd ..
}
#Dillon
archiveFile()
{
    userChoiceArchive=0 

    echo "Please choose from the following options"
    echo "1. Archive a select number of files from the chosen repository"
    echo "2. Archive the entire selected repository"
    read userChoiceArchive
    while [[ "$userChoiceArchive" != "1" && "$userChoiceArchive" != "2" ]]; do
        echo "This is an invalid choice, please select 1 or 2 from the above choices"
        read userChoiceArchive
    done
    if [ $userChoiceArchive = "1" ]; then
        now=$(date '+%F_%H:%M:%S')
        newFolderName="${repoName}"-"${now}"
        mkdir $newFolderName

        mv $newFolderName Archive
        echo "Please enter your choice from the following file names to archive"
        echo "Or enter QUIT to exit"
        ls
        read fileToArchive
        isDone="No"
        while [[ "$isDone" == "No" ]]; do  

            while [[ "$fileToArchive" != "QUIT" ]]; do 
                if [ -f "$fileToArchive " ]; then 
                    cp $fileToArchive Archive/$newFolderName
                    echo "Select another file, or enter QUIT to exit"
                    read fileToArchive
                fi
            done 

            isDone="Yes"
            cd Archive 
            zip -r $newFolderName $newFolderName
            rm -r $newFolderName
        done

    elif [ $userChoiceArchive = "2" ]; then
        now=$(date '+%F_%H:%M:%S')
        newFolderName="${repoName}"-"${now}"
        mkdir $newFolderName
        mv $newFolderName Archive
        cp * Archive/$newFolderName
        cd Archive 
        zip -r $newFolderName $newFolderName
        rm -r $newFolderName
    fi

    cd ..
}


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
    
    echo "current directory: "
    pwd
    echo "Available files: "
    ls -p | grep -v / 
    echo " "
    echo "1. New File"
    echo "2. Edit File"
    echo "3. Archive or Restore"
    echo "4. Change directory"
    echo "5. Quit"
    read -p ":" userInput
    if [ "$userInput" == "1" ]; then
        createFile
    elif [ "$userInput" == "2" ]; then
        editFile
    elif [ "$userInput" == "3" ]; then
        echo " "
        echo "1) Restore"
        echo "2) Archive"
        echo " "
        read varname
        while [[ "$varname" !=  "1" && "$varname" != "2" ]]; do
        echo "This is an invalid choice. Please choose from select 1, or 2 as your choice, corresponding with the above options."
            read varname
        done

        if [ "$varname" == "1" ] ; then
            restoreFile
        elif [ "$varname" == "2" ]; then
            archiveFile

        fi
    elif [ "$userInput" == "4" ]; then
        cd ..
        ls -d */
        read -p "Please enter which repository you would like to view:" repoName
        cd $repoName
    elif [ "$userInput" == "5" ]; then
        break
    else
        echo "Invalid input please try again"
    fi
done