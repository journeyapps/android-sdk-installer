 /Users/rasharab/.android-sdk-installer/android-sdk-macosx/tools/bin/sdkmanager --update
 /Users/rasharab/.android-sdk-installer/android-sdk-macosx/tools/bin/sdkmanager --list --verbose |\
    # Filter obsoleted packages
    egrep '^\S+'      |\
    sed -E '/(---)/d'  |\
    sed -E '/(Info)/d' |\
    sed -E '/(Installed)/d' |\
    sed -E '/(Available)/d' |\
    sed -E '/(sources)/d' |\
    sed -E '/(docs)/d' |\
    sed -E '/(mips)/d' |\
    sed -E '/(intel)/d' |\
    sed -E '/(android-tv)/d' |\
    sed -E '/(android-wear)/d' |\
    sed -E '/(usb)/d' |\
    sed -E '/(x86)/d' |\
    sed -E '/(arm64)/d' |\
    sed -E '/(platforms;android-(7|8|9))/d' |\
    sed -E '/(add-ons;addon-google_apis-google-(15|16|17|18|19))/d' |\
    sed -E '/(system-images;android-(10|14|15|16|17|18|19|21|22);)/d' |\
    # avoid installing emulator/tools due to forcing to 25.2.5
    sed -E '/(^emulator)/d' |\
    sed -E '/(^tools)/d' |\
    sed '/\(done\)/d' > sdklist.txt
