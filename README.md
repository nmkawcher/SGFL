
# How to configure and make android release build for production
Release build can be made using `flutter build <options> apk` command.
Before that create a **key.properties** file in the **android** folder. Add folloiwng lines to that file:
```
keyAlias=<your keystore alias>
password=<your keystore password>
storeFile=<path to the keystore file>
```
Then run `flutter build appbundle -t lib/main_prod.dart --flavor prod` to generate app bundle (.aab) file.
To generate .apk file, run `flutter build apk -t lib/main_prod.dart --flavor prod`.
