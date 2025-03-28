build:
	@lessc -x ./src/assets/styles/theme.less > ./docs/assets/styles.min.css

	@mend -i "{\"checksum\":\"$(shell md5sum ./docs/assets/styles.min.css | cut -d ' ' -f1)\"}" ./src/index.html > ./docs/index.html
	@echo "Finished building"

watch:
	reflex -r 'src/' make build
