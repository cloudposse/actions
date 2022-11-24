all: branch-cleanup auto-approve auto-merge auto-assign create-pull-request slash-command-dispatch repository-dispatch create-or-update-comment

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
auto-approve: REF=v3.1.0
auto-approve: clone(auto-approve)

.PHONY : auto-merge
auto-merge: REPO=git@github.com:pascalgn/automerge-action.git
auto-merge: REF=v0.15.5
auto-merge: clone(auto-merge)

.PHONY : auto-assign
auto-assign: REPO=git@github.com:kentaro-m/auto-assign-action.git
auto-assign: REF=v1.2.4
auto-assign: clone(auto-assign)

.PHONY : create-pull-request
create-pull-request: REPO=git@github.com:peter-evans/create-pull-request.git
create-pull-request: REF=v4.2.2
create-pull-request: clone(create-pull-request)

.PHONY : slash-command-dispatch
slash-command-dispatch: REPO=git@github.com:peter-evans/slash-command-dispatch.git
slash-command-dispatch: REF=v3.0.1
slash-command-dispatch: clone(slash-command-dispatch)

.PHONY : repository-dispatch
repository-dispatch: REPO=git@github.com:peter-evans/repository-dispatch.git
repository-dispatch: REF=v2.1.0
repository-dispatch: clone(repository-dispatch)

.PHONY : create-or-update-comment
create-or-update-comment: REPO=git@github.com:peter-evans/create-or-update-comment.git
create-or-update-comment: REF=v2.1.0
create-or-update-comment: clone(create-or-update-comment)
