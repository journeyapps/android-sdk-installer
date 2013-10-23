# Android SDK Installer

## Usage

    curl -L https://raw.github.com/embarkmobile/android-sdk-installer/master/android-sdk-installer | bash /dev/stdin --install=build-tools-18.1.0,android-17,sysimg-17 && source ~/.android-sdk-installer/env

The above command will download and install the SDK in `$HOME/.android-sdk-installer`. You can override it with `--dir=custom_path`.

You can specify components to install directly with `--install=component1,component2,...`. The is the same as installing it with:

    android update sdk --no-ui -a --filter component1,component2,...

`platform-tools` is automatically installed. Some typical filters:

    build-tools-18.1.0,android-17,sysimg-17,extra-android-support,extra-google-google_play_services,extra-google-m2repository,extra-android-m2repository

To get a full list of available SDK components, run:

    android list sdk --extended -a


Currently the script is optimized to be run in a clean environment, and does not efficiently update an existing environment (it may download and install 
existing components again).

You may also include the script directly in your project, but then it will not be updated to handle newer Android SDK releases.

## Operating System Notes

### Ubuntu

You may need to install the following first:

    sudo apt-get install -qq libstdc++6:i386 lib32z1

### Mac

Not supported currently, but may be supported in the future (pull requests welcome).

### Windows

Will probably not be supported.

## License

All files in this project are under the MIT license.
