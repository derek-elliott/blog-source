BUILD_DIR=public
THEME=coder

DATE=$(shell date)
MESSAGE="Updating blog on $(DATE)"

build:
	@rm -rf $(BUILD_DIR)/*
	hugo -t $(THEME)

publish: build
	@echo "\033[0;32mDeploying updates to GitHub...\033[0m"
	git -C $(BUILD_DIR) add -f --all
	git -C $(BUILD_DIR) commit -m $(MESSAGE)
	git -C $(BUILD_DIR) push origin master

dev:
	hugo server -D
