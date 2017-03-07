 /Users/rasharab/.android-sdk-installer/android-sdk-macosx/tools/bin/sdkmanager --update
 /Users/rasharab/.android-sdk-installer/android-sdk-macosx/tools/bin/sdkmanager --list --verbose |\
    # Filter obsoleted packages
    egrep '^\S+'      |\
    sed '/\(---\)/d'   |\
    sed '/\(intel\)/d'   |\
    sed '/\(Info\)/d' |\
    sed '/\(Installed\)/d' |\
    sed '/\(Available\)/d' |\
    sed '/\(sources\)/d' |\
    sed '/\(docs\)/d' |\
    sed '/\(mips\)/d' |\
    sed '/\(android-wear\)/d' |\
    sed '/\(x86\)/d' |\
    sed '/\(arm64\)/d' |\
    sed '/\(^tools\)/d' |\
    sed '/\(done\)/d' > test.txt
