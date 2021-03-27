#!/bin/sh -l

#set -e at the top of your script will make the script exit with an error whenever an error occurs (and is not explicitly handled)
set -eu

echo -e "${INPUT_KEY}" >TMP_PRIVATE_KEY_FILE

# avoid Permissions too open
chmod 600 TMP_PRIVATE_KEY_FILE

echo 'deploy start'

if [ ${INPUT_FILES} = 'null' ]
then
    scp -o StrictHostKeyChecking=no -P "${INPUT_PORT}" -v -i TMP_PRIVATE_KEY_FILE -r "${INPUT_LOCALDIR}" "${INPUT_USER}"@"${INPUT_HOST}":"${INPUT_REMOTEDIR}"
else
    for file in ${INPUT_FILES}; 
    do
        echo "deploy file : $file"

        PATH="${INPUT_REMOTEDIR}/$file"

        ssh -o StrictHostKeyChecking=no -p "${INPUT_PORT}" -v -i TMP_PRIVATE_KEY_FILE "${INPUT_USER}"@"${INPUT_HOST}"  "mkdir -p dirname \"$PATH\" && touch \"$PATH\" "

        scp -o StrictHostKeyChecking=no -P "${INPUT_PORT}" -v -i TMP_PRIVATE_KEY_FILE -r $file "${INPUT_USER}"@"${INPUT_HOST}":"${INPUT_REMOTEDIR}/$file"
    done
fi


echo 'deploy success'

exit 0
