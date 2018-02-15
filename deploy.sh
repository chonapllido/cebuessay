## SET
ANT_PATH=/opt/apache-ant-1.9.6
DEPLOY_PATH=/home/ec2-user/stm-www/deploy
SVN_PATH=/home/ec2-user/stm-www/svn
CLASS_PATH=/WEB-INF/classes

echo "####################################"
echo "##                                ##"
echo "## PSD KITCHEN Deploy...          ##"
echo "##                                ##"
echo "####################################"
echo "####################################"
echo "##                                ##"
echo "##  - 1. SVN UPDATE...            ##"
echo "##                                ##"
echo "####################################"
cd "$SVN_PATH"/cebuessay/
svn update

echo "####################################"
echo "##                                ##"
echo "##  - 2. SVN EXPORT...            ##"
echo "##                                ##"
echo "####################################"
svn --force export "$SVN_PATH"/cebuessay/src/main/webapp "$DEPLOY_PATH"/cebuessay/

echo "####################################"
echo "##                                ##"
echo "##  - 3. SOURCE BUILD...          ##"
echo "##                                ##"
echo "####################################"
cd "$SVN_PATH"/cebuessay/
"$ANT_PATH"/bin/ant

echo "####################################"
echo "##                                ##"
echo "##  - 4. SETTING FILE APPLY...    ##"
echo "##                                ##"
echo "####################################"
rm "$DEPLOY_PATH"/cebuessay"$CLASS_PATH"/log4j2.xml
rm "$DEPLOY_PATH"/cebuessay"$CLASS_PATH"/egovframework/egovProps/globals.properties
mv "$DEPLOY_PATH"/cebuessay"$CLASS_PATH"/log4j2.server.xml "$DEPLOY_PATH"/cebuessay"$CLASS_PATH"/log4j2.xml
mv "$DEPLOY_PATH"/cebuessay"$CLASS_PATH"/egovframework/egovProps/globals.server.properties "$DEPLOY_PATH"/psdkitchen"$CLASS_PATH"/egovframework/egovProps/globals.properties

echo "####################################"
echo "##                                ##"
echo "## PSD KITCHEN Deploy finished.   ##"
echo "##                                ##"
echo "####################################"

