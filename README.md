# Android SDK Installer

Installer script for the Android SDK. Designed to simplify automated setup of CI environments.


## Sponsored by

[Journey][1] - Build enterprise mobile apps for iOS and Android. Work in the cloud, code in JavaScript and forget about back-end development.

## Update - 2014/06/27 - Android SDK r23

With the release of Android SDK version 23, there are some backwards-incompatible changes:

1. System image names changed. For example, instead of `sysimg-17`, use `sys-img-armeabi-v7a-android-17`.

2. The Android license was updated, and now has the id `android-sdk-license-5be876d5`. If you did not
   explicitly specify any license, you shouldn't need any change.

## Usage

    curl -3L https://raw.github.com/embarkmobile/android-sdk-installer/version-2/android-sdk-installer | bash /dev/stdin --install=build-tools-18.1.0,android-17,sys-img-armeabi-v7a-android-17 && source ~/.android-sdk-installer/env

The above command will download and install the SDK in `$HOME/.android-sdk-installer`. You can override it with `--dir=custom_path`.

You can specify components to install directly with `--install=component1,component2,...`. The is the same as installing it with:

    android update sdk --no-ui -a --filter component1,component2,...

`platform-tools` is automatically installed. Some typical filters:

    build-tools-18.1.0,android-17,sys-img-armeabi-v7a-android-17,extra-android-support,extra-google-google_play_services,extra-google-m2repository,extra-android-m2repository

To get a full list of available SDK components, run:

    android list sdk --extended -a

Currently the script is optimized to be run in a clean environment, and does not efficiently update an
existing environment (it may download and install existing components again).

You may also include the script directly in your project, but then it will not be updated to handle newer Android SDK releases.

## Accepting licenses

By default, only the `android-sdk-license-5be876d5` license is accepted. This has the side-effect of preventing
the install of MIPS emulator images, as well as some other components which are usually not required.

If you do need to install these components, you can override the accepted licenses by using the `--accept` option, 
separated by a pipe character:

    set COMPONENTS="build-tools-18.1.0,android-17,sysimg-17"
    set LICENSES="android-sdk-license-5be876d5|mips-android-sysimage-license-15de68cc|intel-android-sysimage-license-1ea702d1"
    curl -3L https://raw.github.com/embarkmobile/android-sdk-installer/version-2/android-sdk-installer | bash /dev/stdin --install=$COMPONENTS --accept=$LICENSES && source ~/.android-sdk-installer/env

You can also use the accept-license script to install components afterwards:

    accept-licenses "android update sdk --no-ui --all --filter build-tools" "android-sdk-license-5be876d5|mips-android-sysimage-license-15de68cc"

## Backwards compatibility

As far as possible, the script will be kept backwards compatible. Whenever a backwards-incompatible change is
required, the version number will be increased.

Note that the URL above uses a version-x branch, instead of master. The master branch may be used to always get
the latest version, but this may contain backwards-incompatible changes, and is therefore not recommended for
automated scripts.

### Emulator

The script also downloads and installs the wait_for_emulator script, which can be used to wait until the emulator has started.

Typical usage:

    echo no | android create avd --force -n test -t android-17 --abi armeabi-v7a
    emulator -avd test -no-skin -no-audio -no-window &
    wait_for_emulator
    
## Operating System Notes

### Ubuntu

You may need to install the following first:

    sudo apt-get install -qq libstdc++6:i386 lib32z1 expect

### Mac

Supported, thanks to a contribution by [sebv](https://github.com/sebv).

### Windows

Will probably not be supported.

## Backwards Compatibility

For CI environments it is important that the same setup script continue working over time. Therefore an effort will be made to:

1. Keep the script always stable and working as documented below.
2. Keep the script working as far as possible with newer Android SDK versions, without breaking existing builds.

We assume for example that newer versions of for example platform-tools will remain backwards compatible, but that a specific version of build-tools and specific Android versions may be required.

If the API / usage pattern of this script is ever changed, it will be released under a new URL (new branch), and the old version will conitnue running as before. You should always use a version from a specific version branch, and not directly from master.

## Sample Travis CI Configuration

This assumes that the new Gradle-based Android build system is used, with the Gradle wrapper.

    language: java
    jdk: oraclejdk7
    before_install:
        # Install base Android SDK and components
        - sudo apt-get install -qq libstdc++6:i386 lib32z1
        - export COMPONENTS=build-tools-18.1.0,android-17,sysimg-17,extra-android-support,extra-google-google_play_services,extra-google-gcm,build-tools-18.1.0,extra-google-m2repository,extra-android-m2repository
        - curl -L https://raw.github.com/embarkmobile/android-sdk-installer/version-1/android-sdk-installer | bash /dev/stdin --install=$COMPONENTS
        - source ~/.android-sdk-installer/env

        # Create and start emulator
        - echo no | android create avd --force -n test -t android-17 --abi armeabi-v7a
        - emulator -avd test -no-skin -no-audio -no-window &

    install:
        # Without TERM=dumb, we get mangled output in the Travis console
        - TERM=dumb ./gradlew assemble

    before_script:
        # Make sure the emulator has started before running tests
        - wait_for_emulator

    script:
        - TERM=dumb ./gradlew test connectedCheck


### More Travis CI examples

* [Robospice](https://github.com/octo-online/robospice/blob/master/.travis.yml) - Testing on multiple emulators in parallel, using Maven
* [ZXing Android Minimal](https://github.com/embarkmobile/zxing-android-minimal/blob/master/.travis.yml) - Building both an apklib with Maven, and aar with Gradle (no tests)

## License

Unless indicated otherwise, files in this project are under the MIT license.

When using / adapting these scripts in your own projects, you only need to keep the copyright headers, including the link back to this project.

[1]: http://journeyapps.com
