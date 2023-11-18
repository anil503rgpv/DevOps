TARGET=target
RESULTS=build-results.properties
BUILDRESULTS=$(TARGET)/$(RESULTS)


MAKE_BUILD_ID := $(shell date "+%Y%m%d-%H%M%S")

## download usage:
# $(call download, <download url>, <name of the local file downloaded to target/, default to original name of file>)
download = cd $(TARGET) && curl --anyauth --netrc-file .netrc -netrc-optional --create-dirs -L -J -g $(and $2, -o $2) -O --fail $(1)

$(TARGET) :
		@set -e
		@mkdir -p $(TARGET)

.PHONY: common.clean
common.clean :
		@set -e
		@rm -rf $(TARGET)

.PHONY: clean
clean : common.clean


.PHONY: common.prepare
common.prepare : $(TARGET)
		@set -e
		@rm -rf $(BUILDRESULTS)
		@rm -rf $(RESULTS)


.PHONY: prepare
prepare : common.prepare