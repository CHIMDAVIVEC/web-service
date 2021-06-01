DOCKER = docker run --rm -it  -v $$(pwd):/home/app -w /home/app
NODE = $(DOCKER) project
NPM = $(NODE) npm

build: ## Build the docker container and install nodejs dependencies
	docker build -t project .
	$(NPM) install

install: ## Install dependencies
	$(NPM) install

serve-html: ## Serve the html ui using nginx
	docker run  --rm -v $$(pwd)/www:/usr/share/nginx/html:ro -p 8088:80 nginx:latest

package: ## Build a distruable binary
	$(DOCKER) project ./node_modules/.bin/cordova build
	$(DOCKER) project mv platforms/android/app/build/outputs/apk/debug/app-debug.apk dist/android.apk

android: ## Add a cordova android platform
	$(DOCKER) project ./node_modules/.bin/cordova platform add android
