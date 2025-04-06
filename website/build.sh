#!/usr/bin/env bash

echo -e "# Requires https://github.com/bbfh-dev/mend v0.1.2 to be installed\n"

lessc ./src/styles/_styles.less > ../docs/assets/styles.css
lessc ./src/styles/_fonts.less > ../docs/assets/fonts.css
### probably doesn't matter for testing
# csso ../docs/assets/styles.css > ../docs/assets/styles.min.css

checksum=$(md5sum ../docs/assets/styles.css | cut -d ' ' -f1)
sed -i "s/?checksum=\(\w*\)/?checksum=$checksum/g" ./root.html
echo "==> Finished processing styles"

function compile {
    basename=$(basename $1)
    mend -i '{}' $1 > ../docs/$basename
    echo "==> Built $basename"
}

for file in ./src/*.html; do
    compile $file &
done

wait
