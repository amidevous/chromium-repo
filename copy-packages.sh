#!/bin/bash -e

cd $(dirname "$0")

. config

RELEASE="${1}"
V1="${2}"
V2="${3}"

UBUNTU=${RELEASE%%/*}
MINT=${RELEASE#*/}

./make-directories.sh

cd "${UBUNTU}"

    mkdir -p 'pool'

    cd 'pool'

        wget -c -o- --progress=dot -e dotbytes=1K  "${REMOTE}${V2}.dsc"
        wget -c -o- --progress=dot -e dotbytes=10K "${REMOTE}${V2}.tar.xz"
        wget -c -o- --progress=dot -e dotbytes=1M  "${REMOTE}${V2}_amd64.deb"

        echo "RewriteCond %{REQUEST_FILENAME} =${PWD}/${V2}_amd64.deb" | tee    .htaccess
        echo "RewriteRule ^ ${REMOTE}${V2}_amd64.deb [L,R=301]"        | tee -a .htaccess

    cd ..

cd ..

./make-repo.sh ${UBUNTU}

exit 0
