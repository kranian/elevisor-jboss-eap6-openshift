# Spring Boot - Maven 3 - CentOS Docker image

## Usage
minishift start --vm-driver virtualbox --insecure-registry 192.168.0.153:5000 --insecure-registry 172.30.0.0/16
 
eval $(minishift docker-env)
private registry build 
    docker build -t 192.168.0.153:5000/elevisor/jboss-eap6-opnshift-elevisor .
private registry push    
    docker push 192.168.0.153:5000/elevisor/jboss-eap6-opnshift-elevisor    

import yaml/json add


**Accessing the application:**

```
$ curl 127.0.0.1:8080  
```

## Repository organization

* **`s2i/bin/`**

  This folder contains scripts that are run by [S2I](https://github.com/openshift/source-to-image):

  *   **assemble**

      Is used to restore the build artifacts from the previous built (in case of
      'incremental build'), to install the sources into location from where the
      application will be run and prepare the application for deployment (eg.
      using maven to build the application etc..)

  *   **run**

      This script is responsible for running a Spring Boot fat jar using `java -jar`.
      The image exposes port 8080, so it expects application to listen on port
      8080 for incoming request.

  *   **save-artifacts**

      In order to do an *incremental build* (iow. re-use the build artifacts
      from an already built image in a new image), this script is responsible for
      archiving those. In this image, this script will archive the
      `/opt/java/.m2` directory.

## Environment variables

*  **APP_ROOT** (default: '.')

    This variable specifies a relative location to your application inside the
    application GIT repository. In case your application is located in a
    sub-folder, you can set this variable to a *./myapplication*.

*  **APP_TARGET** (default: '')

    This variable specifies a relative location to your application binary inside the
    container.

*  **MVN_ARGS** (default: '')

    This variable specifies the arguments for Maven inside the container.


## Contributing

In order to test your changes to this STI image or to the STI scripts, you can use the `test/run` script. Before that, you have to build the 'candidate' image:

```
$ docker build -t codecentric/springboot-maven3-centos-candidate .
```

After that you can execute `./test/run`. You can also use `make test` to automate this.

## Copyright

