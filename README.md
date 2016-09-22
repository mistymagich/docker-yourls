# YOURLS Docker Image

[YOURLS\(Your Own URL Shortener\)](http://yourls.org/) Docker Image


There are two methods of use.

1. "MySQL container" and "YOURLS container"
2. "MySQL on the host" and "YOURLS container"


The two plug-ins have been shipped.

- [Random Keywords](https://github.com/YOURLS/random-keywords/)
- [Hide Referrer](https://github.com/Sire/yourls-hide-referrer)


## Requirements

- Domain name to access.(For example, example.jp)
- docker-compose(If you use internal MySQL)
- MySQL (If you use MySQL on the host.)


## Case 1: Using the internal MySQL

### Setup

- Network mode of docker container is the "bridge".
- The name of the "bridge" is "docker0".

It remains basically the default setting.

### Usage

```
$ cp docker-compose-internal.yml docker-compose.yml

To edit a variable of *docker-compose.yml* if necessary.

$ docker-compose up

Access YOURLS_SITE.(For example, http://example.jp)
```

## Case 2: Using MySQL on the host

### Setup

- Edit my.cnf
    ```
    bind-address=0.0.0.0
    ```

- Create Database
    ```
    CREATE DATABASE `yourls`
    ```

### Usage

```
vi start.sh
To edit a variable of *docker-compose.yml* if necessary.

- build container
$ ./build.sh

- start container
$ ./start.sh

- stop container
$ ./stop.sh

```
