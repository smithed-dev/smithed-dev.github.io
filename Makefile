build:
	@echo "----------"
	@lessc ./src/assets/styles/theme.less > ./docs/assets/styles.css
	@csso ./docs/assets/styles.css > ./docs/assets/styles.min.css

	@mend -i '{"is_browse": true, "main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/browse.html > ./docs/browse.html
	@mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/inbox.html > ./docs/inbox.html
	@# @mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/cookies.html > ./docs/cookies.html
	@# @mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/privacy_policy.html > ./docs/privacy_policy.html
	@# @mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/terms_of_use.html > ./docs/terms_of_use.html
	@# @mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/guidelines.html > ./docs/guidelines.html
	@# @mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/how_to_contribute.html > ./docs/how_to_contribute.html
	@mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/index.html > ./docs/index.html
	@mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": false}' ./src/login.html > ./docs/login.html
	@mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": false}' ./src/register.html > ./docs/register.html
	@mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/settings.html > ./docs/settings.html
	@mend -i '{"is_browse": false, "main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/profile.html > ./docs/profile.html
	@mend -i '{"is_browse": false, "main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/profile_about.html > ./docs/profile_about.html
	@mend -i '{"is_browse": false, "main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/profile_analytics.html > ./docs/profile_analytics.html
	@mend -i '{"is_browse": false, "main": "wide", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/pack.html > ./docs/pack.html
	@mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/articles.html > ./docs/articles.html
	@mend -i '{"is_browse": false, "main": "", "checksum":"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)", "logged_in": true}' ./src/about.html > ./docs/about.html
	@echo "Finished building"

watch:
	reflex -r 'src/' make build

serve:
	cd docs/; \
	python -m http.server 8080
