build:
	@echo "----------"
	@lessc ./src/assets/styles/theme.less > ./docs/assets/styles.css
	@csso ./docs/assets/styles.css > ./docs/assets/styles.min.css

	@mend -i '{"main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/index.html > ./docs/index.html
	@mend -i '{"main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": false}' ./src/login.html > ./docs/login.html
	@mend -i '{"main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": false}' ./src/register.html > ./docs/register.html
	@mend -i '{"main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/settings.html > ./docs/settings.html
	@mend -i '{"main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/profile.html > ./docs/profile.html
	@mend -i '{"main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/profile_about.html > ./docs/profile_about.html
	@mend -i '{"main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/profile_analytics.html > ./docs/profile_analytics.html
	@mend -i '{"main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/pack.html > ./docs/pack.html
	@echo "Finished building"

watch:
	reflex -r 'src/' make build

serve:
	cd docs/; \
	python -m http.server 8080
