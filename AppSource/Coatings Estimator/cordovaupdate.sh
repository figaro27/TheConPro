echo 'removing plugins'
cordova plugin rm com.ionic.keyboard
#cordova plugin rm org.apache.cordova.console
cordova plugin rm cordova-plugin-console
cordova plugin rm cc.fovea.cordova.purchase
#cordova plugin rm org.apache.cordova.camera
cordova plugin rm cordova-plugin-camera
#cordova plugin rm org.apache.cordova.device
cordova plugin rm cordova-plugin-device
#cordova plugin rm org.apache.cordova.dialogs
cordova plugin rm cordova-plugin-dialogs
#cordova plugin rm org.apache.cordova.splashscreen 
cordova plugin rm cordova-plugin-splashscreen

echo 'updating platform'
cordova platform update ios --save
cordova platform update android --save

echo 'adding plugins'
cordova plugin add com.ionic.keyboard
#cordova plugin add org.apache.cordova.console
cordova plugin add cordova-plugin-console
cordova plugin add cc.fovea.cordova.purchase --variable BILLING_KEY="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtAFMGUI/43Oat66jn5vUQ6B14WF7P4WNkvZCCl3l7yPnHBPS1Ae786WIIl1yqSoLMh/tvpuvP1CppDtb5gRBLoYWZq04gLB9kFD95++ntH09/96v4kG38g2o423lRF60ir/VsLYjwVdGlJLoJuNyM11GdQVr0Z1tfbnwTceSEuR5j4uzcA+yS3E16saNolqZaev50mbag60k8AXDLnUhxebplFZLvzAMFlD0Hwj2ckzytlSs2bRTZ+b2W/UfoiF26BmCnkl5bVtGfCq1AoaRIlWO6y3+jTaf9geJQ7KqyuCZaYLfe889XIrzQM2OEi/iwD6rGCfOJwqz0zN0lPLhRwIDAQAB"
#cordova plugin add org.apache.cordova.camera
cordova plugin add cordova-plugin-camera
#cordova plugin add org.apache.cordova.device
cordova plugin add cordova-plugin-device
#cordova plugin add org.apache.cordova.dialogs
cordova plugin add cordova-plugin-dialogs
#cordova plugin add org.apache.cordova.splashscreen 
cordova plugin add cordova-plugin-splashscreen