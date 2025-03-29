build:
	@echo "----------"
	@lessc ./src/assets/styles/theme.less > ./docs/assets/styles.css
	@csso ./docs/assets/styles.css > ./docs/assets/styles.min.css

	@mend -i '{"checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/index.html > ./docs/index.html
	@mend -i '{"checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": false}' ./src/login.html > ./docs/login.html
	@echo "Finished building"

watch:
	reflex -r 'src/' make build

serve:
	cd docs/; \
	python -m http.server 8080
