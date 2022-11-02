#!/bin/bash

# 2021 - Bruno Adelé

# Get doc files
DOCS=$(ls  *-*-*.md)

LASTCAT1=""
LASTCAT2=""
FILENAME="README.md"

# Header
echo "# Mydocs" > ${FILENAME}

# Generate the main readme
for doc in $DOCS; do

    # Split
    CAT=(${doc//\-/ })

    # Level 1
    if [ "$LASTCAT1" != "${CAT[0]}" ]; then
        LASTCAT1="${CAT[0]}"
        echo "* ${CAT[0]}" >> ${FILENAME}
    fi

    # Level 2
    if [ "$LASTCAT2" != "${CAT[1]}" ]; then
        LASTCAT2="${CAT[1]}"
        echo "  * ${CAT[1]}" >> ${FILENAME}
    fi

    # Generate doc link
    CATS="${CAT[0]}-${CAT[1]}"
    title=$(echo "$doc" | sed "s/$CATS-\(.*\).md/\1/")

    echo "    * [$title]($doc)" >> ${FILENAME}
done
