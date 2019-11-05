.PHONY : branch-cleanup
branch-cleanup:
	rm -rf $@
	git clone git@github.com:jessfraz/branch-cleanup-action.git $@
	git -c advice.detachedHead=false -C $@ checkout 150e4a88d2d9838299a348c631cfc3ad2ea8560b
	rm -rf $@/.git
