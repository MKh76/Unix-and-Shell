#! /bin/bash
# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# functions
cd_alt() {
  echo "changing directory was unsuccessful"
  exit 1
}


# [TASK 1]
targetDirectory=${1}
destinationDirectory=${2}

# [TASK 2]
echo "$1"
echo "$2"

# [TASK 3]
currentTS=$(date +%s)

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)


# [TASK 6]
cd "$destinationDirectory" || cd_alt  
destDirAbsPath=$(pwd)

# [TASK 7]
cd "$origAbsPath" || cd_alt  
cd "$targetDirectory" || cd_alt

# [TASK 8]
yesterdayTS=$(( "$currentTS" - 86400 ))

declare -a toBackup

for file in $(ls -a) # [TASK 9] # when I coded this, the instruction said all files and directories
do
  # [TASK 10]
  if (($(date -r "$file" +%s) > "$yesterdayTS"))
  then
    # [TASK 11]
    toBackup+=("$file")
  fi
done

# [TASK 12]
tar -cvzf "$backupFileName" "${toBackup[*]}"

# [TASK 13]
mv "./$backupFileName" "$destDirAbsPath"

