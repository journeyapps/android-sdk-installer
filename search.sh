  android list sdk -u -s -a |\
    # Filter obsoleted packages
    grep '\s\+\d\+-'      |\
    sed '/\(Source\)/d' |\
    sed '/\(Documentation\)/d' |\
    sed '/\(MIPS\)/d' |\
    sed '/\(Obsolete\)/d' |\
    sed '/\(Intel\)/d' |\
    sed '/\(Android Wear\)/d' |\
    sed '/\(Android TV\)/d' |\
    sed '/\(ARM 64\)/d'