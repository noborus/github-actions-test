VERSION=$(shell git describe --tags 2>/dev/null)
GOOS=$(shell go env GOOS)
GOARCH=$(shell go env GOARCH)
BINARY_NAME := github-actions-test$(SUFFIX)
DISTDIR=dist
DISTARCH=github-actions-test_$(VERSION)_$(GOOS)_$(GOARCH)
DISTOSDIR=$(DISTDIR)/$(DISTARCH)

build:
	go build

test:
	go test -v

PHONY: pkg
pkg:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(DISTOSDIR)/$(BINARY_NAME)

windows_pkg:
	@$(MAKE) pkg GOOS=windows GOARCH=amd64 SUFFIX=.exe

linux_pkg:
	@$(MAKE) pkg GOOS=linux GOARCH=amd64

darwin_pkg:
	@$(MAKE) pkg GOOS=darwin GOARCH=amd64

.PHONY: dist
dist:
	cd $(DISTDIR) && \
	cp ../LICENSE $(DISTARCH) && \
	cp ../README.md $(DISTARCH) && \
	zip -r $(DISTARCH).zip $(DISTARCH) && \
	cd ..
