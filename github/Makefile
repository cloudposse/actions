all: branch-cleanup auto-approve auto-merge auto-assign create-pull-request

clone(%):
	rm -rf $%
	git clone $(REPO) $%
	git -c advice.detachedHead=false -C $% checkout $(REF)
	rm -rf $%/.git

.PHONY : branch-cleanup
branch-cleanup: REPO=git@github.com:jessfraz/branch-cleanup-action.git
branch-cleanup: REF=150e4a88d2d9838299a348c631cfc3ad2ea8560b
branch-cleanup: clone(branch-cleanup)

.PHONY : auto-approve
auto-approve: REPO=git@github.com:hmarr/auto-approve-action.git
auto-approve: REF=52fb28e282cc215b0ce091ca1f583538d247f1b6
auto-approve: clone(auto-approve)

.PHONY : auto-merge
auto-merge: REPO=git@github.com:pascalgn/automerge-action.git
auto-merge: REF=6d8643b52af0466d0f190ebb4901f25184bdd3c5
auto-merge: clone(auto-merge)

.PHONY : auto-assign
auto-assign: REPO=git@github.com:kentaro-m/auto-assign-action.git
auto-assign: REF=5fd7cfa5a54fc1c4efee28c3e3989cf9da535c05
auto-assign: clone(auto-assign)

.PHONY : create-pull-request
create-pull-request: REPO=git@github.com:peter-evans/create-pull-request.git
create-pull-request: REF=c9e477ec051a8fb2ef523640a5ecbfe6297514d3
create-pull-request: clone(create-pull-request)

.PHONY : slash-command-dispatch
slash-command-dispatch: REPO=git@github.com:peter-evans/slash-command-dispatch.git
slash-command-dispatch: REF=302daa7302b574801d901d7301de324b22b2a670
slash-command-dispatch: clone(slash-command-dispatch)

.PHONY : repository-dispatch
repository-dispatch: REPO=git@github.com:peter-evans/repository-dispatch.git
repository-dispatch: REF=0ae1c4b014bff102f1063cd67a53fc4a91311d1b
repository-dispatch: clone(repository-dispatch)
