run-docker: 
	sudo docker run --network host test-api

build-docker:
	sudo docker build -t test-api .