#!/bin/bash

: ${SYNC_DIR:?}
SECRET=${@:-`btsync --generate-secret`}

echo "Starting btsync with secret: $SECRET"

cat <<EOF > /btsync/btsync.conf
{
    "device_name": "Sync Server",
    "listening_port": 55555,
    "storage_path": "/btsync/sync",
    "pid_file": "/var/run/btsync/btsync.pid",
    "check_for_updates": false,
    "use_upnp": false,
    "download_limit": 0,
    "upload_limit": 0,
    "shared_folders": [
        {
            "secret": "$SECRET",
            "dir": "$SYNC_DIR",
            "use_relay_server": true,
            "use_tracker": true,
            "use_dht": false,
            "search_lan": true,
            "use_sync_trash": false
        }
    ]
}
EOF

exec btsync --config /btsync/btsync.conf --nodaemon
