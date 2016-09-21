android list sdk -u -s -a |\
    # Filter obsoleted packages
    grep '\s\+\d\+-'      |\
    sed '/\(Obsolete\)/d' |\
    sed '/\(Source\)/d' |\
    sed '/\(Documentation\)/d' |\
    sed '/\(Intel\)/d' |\
    sed 's/^[ ]*\([0-9]*\)-.*/\1/' |\
    paste -d, -s -