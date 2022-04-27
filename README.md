# mariadb

[![Build Status](https://drone.owncloud.com/api/badges/owncloud-ops/mariadb/status.svg)](https://drone.owncloud.com/owncloud-ops/mariadb/)
[![Docker Hub](https://img.shields.io/badge/docker-latest-blue.svg?logo=docker&logoColor=white)](https://hub.docker.com/r/owncloudops/mariadb)

Custom container image for [MariaDB](https://mariadb.com/kb/en/documentation/).

## Ports

- 3306

## Volumes

- /var/lib/mysql
- /var/lib/backup

## Environment Variables

```Shell
MARIADB_DATABASE=
MARIADB_USER=
MARIADB_PASSWORD=
MARIADB_ROOT_PASSWORD=

MARIADB_BACKUP_HOST=mariadb
MARIADB_BACKUP_PORT=3306

# [mysql]
MARIADB_DEFAULT_CHARACTER_SET=utf8mb4

# [mysqld]
MARIADB_CHARACTER_SET_SERVER=utf8mb4
MARIADB_COLLATION_SERVER=utf8mb4_general_ci
MARIADB_TRANSACTION_ISOLATION=
MARIADB_KEY_BUFFER_SIZE=128M
MARIADB_MAX_ALLOWED_PACKET=16M
MARIADB_TABLE_OPEN_CACHE=2000
MARIADB_SORT_BUFFER_SIZE=2M
MARIADB_NET_BUFFER_SIZE=16K
MARIADB_READ_BUFFER_SIZE=128K
MARIADB_READ_RND_BUFFER_SIZE=256K
MARIADB_MYISAM_SORT_BUFFER_SIZE=128MB
MARIADB_MAX_CONNECTIONS=151
MARIADB_LOG_BIN=0
MARIADB_BINLOG_FORMAT=MIXED
MARIADB_INNODB_DATA_FILE_PATH=ibdata1:12M:autoextend
MARIADB_INNODB_BUFFER_POOL_SIZE=128M
MARIADB_INNODB_LOG_FILE_SIZE=96M
MARIADB_INNODB_LOG_BUFFER_SIZE=16M
MARIADB_INNODB_FLUSH_LOG_AT_TRX_COMMIT=1
MARIADB_INNODB_LOCK_WAIT_TIMEOUT=50
MARIADB_INNODB_USE_NATIVE_AIO=ON
MARIADB_INNODB_FILE_PER_TABLE=ON
MARIADB_INNODB_READ_ONLY_COMPRESSED=OFF
```

## Backups

The container image can also be used for scheduling database backups. Please ensure that the backup container is assigned to the same network as the database container. The backups are stored in `/var/lib/backup` and a volume or bind mount need to be configured to store the backups permanently.

```Shell
docker run --no-healthcheck \
    --network my-network \
    --entrypoint /usr/bin/entrypoint \
    -e MARIADB_ROOT_PASSWORD=password \
    -it mariadb:devel backup
```

## Build

```Shell
docker build -f Dockerfile -t mariadb:latest .
```

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](https://github.com/owncloud-ops/mariadb/blob/main/LICENSE) file for details.
