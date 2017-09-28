IMAGE_NAME = 192.168.0.153:5000/elevisor/jboss-eap6-openshift-elevisor

all : build push 

clean :
	oc delete all --all	
build:
	docker build -t $(IMAGE_NAME) .
push :
	docker push $(IMAGE_NAME)	
.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run test-app
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run test-app-mvnw
