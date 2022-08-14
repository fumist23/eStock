.PHONY: lint

lint:
	goimports -l ./ 2>&1 | tee /dev/stderr | (! read)