name=$USER
echo "Hello $name"
echo "Which repository would you like to access:"
ls
read repo
cd $repo