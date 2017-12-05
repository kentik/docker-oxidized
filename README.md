# docker-librenms
Docker image for oxidized

## About

This a docker container that runs all needed services for using oxidized.

The container runs on debian stretch.

## Basic commands to run the container


	docker run \
        -d \
        -p 3600:8888 \
        -v /data/service/oxidized/conf:/home/oxidized/.config/oxidized \
        -v /data/service/oxidized/workspace:/tmp/oxidized \
        -v /data/service/oxidized/repo:/home/oxidized/repo \
        -v /data/service/oxidized/ssh:/home/oxidized/.ssh \
        --name oxidized \
        oxidized:latest

## License

This project is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).

oxidized has its own license, this license only covers the Docker part.
