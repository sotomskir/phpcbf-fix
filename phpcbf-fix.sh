#!/bin/bash
if [ -e "./phpcs.xml" ]; then
  PHPCS_STANDARD=./phpcs.xml
else
  PHPCS_STANDARD=PSR2
fi
GIT_COMMIT=`git --no-pager log -1 --pretty=format:"%H"`
FILES_CHANGED=`git diff --name-only --diff-filter=ACMTR ${GIT_COMMIT}^1..${GIT_COMMIT} | cat | grep -iE '*.php' | grep -vE '.blade.php$'`
echo "FIXING CODE SNIFFS"
echo "${FILES_CHANGED}" | xargs phpcbf --standard=${PHPCS_STANDARD}
echo "FIXING FINISHED"
echo "REMAINING ERRORS:"
echo "${FILES_CHANGED}" | xargs phpcs --standard=${PHPCS_STANDARD} --extensions=php -n

