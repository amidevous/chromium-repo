#!/bin/bash -e

cd $(dirname "$0")
DIR=$(pwd)

. config

COUNTER_EXTENSION='.DOWNLOADS'

for RELEASE in $RELEASES; do
    UBUNTU=${RELEASE%%/*}
    MINT=${RELEASE#*/}

    cd "${UBUNTU}"

        cd 'pool'

        for version in *; do

            if [ ! -d "${version}" ]; then
                continue
            fi

            cd "${version}"

                (

                    for counter in *${COUNTER_EXTENSION}; do

                        [ "${counter}" == "*${COUNTER_EXTENSION}" ] && continue

                        filename=${counter%"${COUNTER_EXTENSION}"}

                        count=$(<${counter})

                        echo "AddDescription \"Downloads: ${count}\" ${filename}"

                    done

                    echo "AddDescription \" \" .."
                    echo "AddDescription \"Downloads: 0\" *"

                ) > .htaccess

            cd ..

        done

        cd ..

    cd ..

done

exit 0
