VERSION=$(shell git describe --tags 2>/dev/null)
GOOS=$(shell go env GOOS)
GOARCH=$(shell go env GOARCH)
BINARY_NAME := github-actions-test$(SUFFIX)
DISTDIR=dist

build:
	go build

test:
	go test -v

PHONY: pkg
pkg:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(DISTDIR)/github-actions-test_$(VERSION)_$(GOOS)_$(GOARCH)/$(BINARY_NAME)

windows_pkg:
	@$(MAKE) pkg GOOS=windows GOARCH=amd64 SUFFIX=.exe

linux_pkg:
	@$(MAKE) pkg GOOS=linux GOARCH=amd64

darwin_pkg:
	@$(MAKE) pkg GOOS=darwin GOARCH=amd64

DIST_DIRS := find * -type d -exec
.PHONY: dist
dist: pkg
	cd $(DISTDIR) && \
	$(DIST_DIRS) cp ../LICENSE {} \; && \
	$(DIST_DIRS) cp ../README.md {} \; && \
	$(DIST_DIRS) zip -r {}.zip {} \; && \
	cd ..
