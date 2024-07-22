BASE_HREF = '/'
GITHUB_REPO = https://github.com/kiwi-choe/motd.github.io.git
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')
CUSTOM_DOMAIN = motd.or.kr

## Deploying

deploy-web:
	@echo "clean existing repository..."
	flutter clean

	@echo "getting packages..."
	flutter pub get

	@echo "building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	@echo "creating CNAME file..."
	echo "$(CUSTOM_DOMAIN)" > build/web/CNAME

	@echo "deploying to git repository"
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)"&& \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u --force origin main

	cd ../..
	@echo "Finished Deploy"

.PHONY: deploy-web