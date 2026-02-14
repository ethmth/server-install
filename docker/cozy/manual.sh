docker network create cozy-stack

docker run --rm -d \
    --name cozy-stack-couchdb \
    --network cozy-stack \
    -e COUCHDB_USER=admin \
    -e COUCHDB_PASSWORD=password \
    -v ./volumes/cozy-stack/couchdb:/opt/couchdb/data \
    couchdb:latest



docker run --rm \
    --name cozy-stack \
    --network cozy-stack \
    -p 8080:8080 \
    -p 6060:6060 \
    -e COUCHDB_HOST=cozy-stack-couchdb \
    -e COUCHDB_USER=admin \
    -e COUCHDB_PASSWORD=password \
    -e COZY_HOST=127.0.0.1 \
    -e COZY_ADMIN_HOST=127.0.0.1 \
    -e COZY_COUCHDB_URL=http://admin:password@cozy-stack-couchdb:5984 \
    -e COZY_FS_URL=file:///var/lib/cozy \
    -e COZY_ADMIN_PASSPHRASE=password \
    -v ./volumes/cozy-stack/data:/var/lib/cozy \
    -v ./volumes/cozy-stack/config:/etc/cozy/ \
    cozy/cozy-stack:latest
