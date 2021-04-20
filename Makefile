PROJECT = "go-lambda-docker"

.PHONY: docker-build-test
docker-build-test:
		docker build --target=test -t ${PROJECT}-test .

.PHONY: docker-build-prod
docker-build-prod:
		docker build --target=prod -t ${PROJECT} .

.PHONY: docker-run-test
docker-run-test: docker-build-test
		docker run -p 9000:8080 --name docker-test -d ${PROJECT}-test /main

	
.PHONY: docker-stop-test
docker-stop-test: image-test
		docker rm -f docker-test

.PHONY: unit-test
unit-test:
		go test -run [^TestDocker] -v

.PHONY: image-test
image-test: docker-run-test
		go test -run TestDocker -v

.PHONY: docker-tests
docker-tests: docker-stop-test
		echo "Running tests against docker test image"



