echo "Menu Test, Please Select:"
PS3='Please enter your choice: '
options=("File Repository" "New File" "Edit File" "Backup & Restore" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "File Repository")
			echo " "
            echo "You Selected File Repository"
            echo " "
            ;;
        "New File")
			echo " "
            echo "Please insert new file name: "
            echo " "
            ;;
        "Edit File")
			echo " "
            echo "Which file would you like to edit: "
            echo " "
            ;;
        "Backup & Restore")
			echo " "
            echo "1) Backup"
            echo "2) Restore"
            echo "3) Archive"
            echo " "
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done