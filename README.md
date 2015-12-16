# Symfony Monitor

A docker solution to monitor Symfony and Apache or Nginx with ELK.

## How to start

To start building your monitoring dashboards thanks to [Kibana], follow these steps:

* Clone this repository or create your own [docker-compose.yml](docker-compose.yml) file.

```yaml
elk:
  image: ypereirareis/elk
  ports:
    - 8200:9200
    - 4601:5601

forwarder:
  image: ypereirareis/logstash-forwarder
  links:
    - elk
```

Change the ports mapping if needed.
The `links` configuration of the `forwarder` is very important !

* Add volumes matching your Apache/Nginx and Symfony logs directories to the `forwarder` container:

```yaml
forwarder:
  ...
  volumes:
    - APACHE_ACCESS_ERROR_LOG_DIR/:/var/log/forwarder/apache
    - NGING_ACCESS_ERROR_LOG_DIR/:/var/log/forwarder/nginx
    - SYMFONY_PROD_DEV_LOG_DIR/:/var/log/forwarder/symfony
```

* Start the containers with `make start` or `docker-compose up -d elk forwarder`
    * ELK and logstah-forwarder startup can take a few seconds.
    * You can use `make logs` to see startup logs.

* Check elastic(search) status [http://127.0.0.1:8200](http://127.0.0.1:8200)

* Access the Kibana home page [http://127.0.0.1:4601](http://127.0.0.1:4601)

## Data/indexes persistence

If you want to persist all your work and configuration even if your remove your containers,
just map a volume to the `elk` container:

```yaml
elk:
  image: ypereirareis/elk
  ...
  volumes:
    HOST_PATH_TO_STORE_ELASTICSEARCH_CONF/:/var/lib/elasticsearch
```

## Docker images

This monitoring project is built thanks to two docker images:

* [docker-elk](https://github.com/ypereirareis/docker-elk)
* [docker-logstash-forwarder](https://github.com/ypereirareis/docker-logstash-forwarder)
