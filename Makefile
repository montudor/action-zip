WORKFLOW := .github/workflows/test.yml
ACT := nix develop --command act

.PHONY: test test-workdir test-compat test-noargs

test:            ## Run the full CI workflow locally via act
	$(ACT) push -W $(WORKFLOW)

test-workdir:    ## Only the working-directory job
	$(ACT) push -W $(WORKFLOW) -j zip-with-working-directory

test-compat:     ## Only the backward-compat zip/unzip job
	$(ACT) push -W $(WORKFLOW) -j zip-without-working-directory

test-noargs:     ## Only the bare-uses job
	$(ACT) push -W $(WORKFLOW) -j no-args
