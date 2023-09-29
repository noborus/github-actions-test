VERSION=$(shell git describe --tags 2>/dev/null)
GOOS=$(shell go env GOOS)
GOARCH=$(shell go env GOARCH)
BINARY_NAME := github-actions-test$(SUFFIX)

ifeq ($(strip $(VERSION)),)
  LDFLAGS=""
else
  LDFLAGS="-X github.com/noborus/github-actions-test.Version=$(VERSION)"
endif
BUILDFLAG=-ldflags=$(LDFLAGS)
XGOCMD=xgo -go 1.13.x $(BUILDFLAG)
DISTDIR=dist
DIST_BIN=dist/bin

build:
	go build

test:
	go test -v
	git --no-pager grep --color=always "。\s\+$$" *

clean:
	rm $(BINARY_NAME)

# Problems with xgo output?
# Copy from dist/tmp/github.com/* to dist/bin.
PHONY: pkg
pkg:
	-mkdir dist
	-mkdir $(DIST_BIN)
	$(XGOCMD) -dest dist/tmp .
	find dist/tmp -type f -exec cp {} $(DIST_BIN) \;

DIST_DIRS := find github-actions-test* -type d -exec

.PHONY: dist
dist: dist-clean pkg linux-amd64 linux-386 linux-arm-5 linux-arm-6 linux-arm-7 linux-arm64 linux-mips linux-mips64 linux-mipsle windows-386 windows-amd64 darwin-386 darwin-amd64
	cd dist && \
	$(DIST_DIRS) cp ../README.md {} \; && \
	$(DIST_DIRS) cp ../LICENSE {} \; && \
	$(DIST_DIRS) zip -r {}.zip {} \; && \
	cd ..

linux-amd64:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_amd64
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-amd64 dist/$(BINARY_NAME)_$(VERSION)_linux_amd64/$(BINARY_NAME)

linux-386:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_386
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-386 dist/$(BINARY_NAME)_$(VERSION)_linux_386/$(BINARY_NAME)

linux-arm-5:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_arm5
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-arm-5 dist/$(BINARY_NAME)_$(VERSION)_linux_arm5/$(BINARY_NAME)

linux-arm-6:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_arm6
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-arm-6 dist/$(BINARY_NAME)_$(VERSION)_linux_arm6/$(BINARY_NAME)

linux-arm-7:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_arm7
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-arm-7 dist/$(BINARY_NAME)_$(VERSION)_linux_arm7/$(BINARY_NAME)

linux-arm64:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_arm64
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-arm64 dist/$(BINARY_NAME)_$(VERSION)_linux_arm64/$(BINARY_NAME)

linux-mips:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_mips
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-mips dist/$(BINARY_NAME)_$(VERSION)_linux_mips/$(BINARY_NAME)

linux-mips64:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_mips64
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-mips64 dist/$(BINARY_NAME)_$(VERSION)_linux_mips64/$(BINARY_NAME)

linux-mipsle:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_linux_mipsle
	cp $(DIST_BIN)/$(BINARY_NAME)-linux-mipsle dist/$(BINARY_NAME)_$(VERSION)_linux_mipsle/$(BINARY_NAME)

windows-386:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_windows_386
	cp $(DIST_BIN)/$(BINARY_NAME)-windows-4.0-386.exe dist/$(BINARY_NAME)_$(VERSION)_windows_386/$(BINARY_NAME).exe

windows-amd64:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_windows_amd64
	cp $(DIST_BIN)/$(BINARY_NAME)-windows-4.0-amd64.exe dist/$(BINARY_NAME)_$(VERSION)_windows_amd64/$(BINARY_NAME).exe

darwin-386:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_darwin_386
	cp $(DIST_BIN)/$(BINARY_NAME)-darwin-10.6-386 dist/$(BINARY_NAME)_$(VERSION)_darwin_386/$(BINARY_NAME)

darwin-amd64:
	mkdir dist/$(BINARY_NAME)_$(VERSION)_darwin_amd64
	cp $(DIST_BIN)/$(BINARY_NAME)-darwin-10.6-amd64 dist/$(BINARY_NAME)_$(VERSION)_darwin_amd64/$(BINARY_NAME)

dist-clean:
	rm -Rf dist/github-actions-test*
