cd /Volumes/Work/Hybrid/Concrete/AppSource/Coatings\ Estimator
ionic build android --release
jarsigner -storepass Coatings -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore coatings.keystore platforms/android/build/outputs/apk/android-release-unsigned.apk Coatings
zipalign -f -v 4 platforms/android/build/outputs/apk/android-release-unsigned.apk coatings.apk
adb install -r coatings.apk
adb shell am start -n com.ionicframework.coatings642386/.MainActivity