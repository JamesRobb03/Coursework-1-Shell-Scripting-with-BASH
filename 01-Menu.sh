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


