.ONESHELL: build
.PHONY: build
build:
	@cd ./quartz/
	@npm install
	@npx quartz build --output ../public

.ONESHELL: serve
.PHONY: serve
serve: build
	@npm run dev

.PHONY: pull
pull:
	@git remote add quartz https://github.com/jackyzha0/quartz.git
	@git subtree pull --prefix quartz/ --squash quartz v4
