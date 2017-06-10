# rpi-docker-images:shairport-sync

Containerized version of Shairport-sync (wiht multistage build). 

***Important remark*** DockerHub does not support multistage autobuilds yet --- this is coming within days :)

#### Download/Update:
```rpi-docker-images:shairport-sync```

#### Configuration

Download the example configuration [from the Shairport-sync repository](https://github.com/mikebrady/shairport-sync/blob/master/scripts/shairport-sync.conf), edit it to your needs and place in /in/a/folder/of/your/choice on the host. 


#### Run the container 

```docker run --net="host" -d   -v /dev/snd:/dev/snd --privileged -v /var/run/dbus:/var/run/dbus -v /in/a/folder/of/your/choice:/config shairport-sync:latest```
