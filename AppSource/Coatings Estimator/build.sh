echo 'building app'
grunt build --gruntfile ../../WebSource/Gruntfile.js > /dev/null

echo 'removing source'
rm -rf www/* > /dev/null

echo 'copying source'
cp -r ../../WebSource/dist/* www/  > /dev/null

echo 'preparing'
cordova prepare > /dev/null

echo 'building'
cordova build > /dev/null

echo 'complete'