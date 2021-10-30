#!/bin/sh

# Apple Documentation Reference: https://apple.co/3Gfe95W
# 
# To make this script executable, run in terminal:
# chmod +x build_docs.sh

PROJECT_NAME="RadioBrowserKit"
DOC_DIR="Documentation/API/"
ROOT_URL="http://de1.api.radio-browser.info/json/"

# Create the output directory
mkdir -p "${DOC_DIR}"

# Build the documentation
jazzy \
	--clean \
	--author "Woodbytes" \
	--author_url "https://woodbytes.me" \
	--github_url "https://github.com/phranck/${PROJECT_NAME}" \
	--output "${DOC_DIR}" \
	--swift-build-tool spm \
	--build-tool-arguments -Xswiftc,-swift-version,-Xswiftc,5 \
	--theme fullwidth \
	--module ${PROJECT_NAME} \
	--root-url "${ROOT_URL}" \
	--documentation=Documentation/*.md
