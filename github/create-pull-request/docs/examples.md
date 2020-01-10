# Examples

- [Use case: Create a pull request to update X on push](#use-case-create-a-pull-request-to-update-x-on-push)
  - [Update project authors](#update-project-authors)
- [Use case: Create a pull request to update X periodically](#use-case-create-a-pull-request-to-update-x-periodically)
  - [Update NPM dependencies](#update-npm-dependencies)
  - [Update SwaggerUI for GitHub Pages](#update-swaggerui-for-github-pages)
  - [Spider and download a website](#spider-and-download-a-website)
- [Use case: Create a pull request to update X by calling the GitHub API](#use-case-create-a-pull-request-to-update-x-by-calling-the-github-api)
  - [Call the GitHub API from an external service](#call-the-github-api-from-an-external-service)
  - [Call the GitHub API from another GitHub Actions workflow](#call-the-github-api-from-another-github-actions-workflow)
- [Use case: Create a pull request to modify/fix pull requests](#use-case-create-a-pull-request-to-modifyfix-pull-requests)
  - [autopep8](#autopep8)
- [Misc workflow tips](#misc-workflow-tips)
  - [Filtering push events](#filtering-push-events)
  - [Dynamic configuration using variables](#dynamic-configuration-using-variables)
  - [Debugging GitHub Actions](#debugging-github-actions)


## Use case: Create a pull request to update X on push

This pattern will work well for updating any kind of static content based on pushed changes. Care should be taken when using this pattern in repositories with a high frequency of commits.

### Update project authors

Raises a pull request to update a file called `AUTHORS` with the git user names and email addresses of contributors.

```yml
name: Update AUTHORS
on:
  push:
    branches:
      - master
jobs:
  updateAuthors:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Update AUTHORS
        run: |
          git log --format='%aN <%aE>%n%cN <%cE>' | sort -u > AUTHORS
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          commit-message: update authors
          title: Update AUTHORS
          body: Credit new contributors by updating AUTHORS
          branch: update-authors
```

## Use case: Create a pull request to update X periodically

This pattern will work well for updating any kind of static content from an external source. The workflow executes on a schedule and raises a pull request when there are changes.

### Update NPM dependencies

```yml
name: Update Dependencies
on:
  schedule:
    - cron:  '0 10 * * 1'
jobs:
  update-deps:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v1
        with:
          node-version: '10.x'
      - name: Update dependencies
        id: vars
        run: |
          npm install -g npm-check-updates
          ncu -u
          npm install
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          commit-message: update dependencies
          title: Automated Dependency Updates
          body: This is an auto-generated PR with dependency updates.
          branch: dep-updates
```

### Update SwaggerUI for GitHub Pages

When using [GitHub Pages to host Swagger documentation](https://github.com/peter-evans/swagger-github-pages), this workflow updates the repository with the latest distribution of [SwaggerUI](https://github.com/swagger-api/swagger-ui).

You must create a file called `swagger-ui.version` at the root of your repository before running.
```yml
name: Update Swagger UI
on:
  schedule:
    - cron:  '0 10 * * *'
jobs:
  updateSwagger:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Get Latest Swagger UI Release
        id: swagger-ui
        run: |
          echo ::set-output name=release_tag::$(curl -sL https://api.github.com/repos/swagger-api/swagger-ui/releases/latest | jq -r ".tag_name")
          echo ::set-output name=current_tag::$(<swagger-ui.version)
      - name: Update Swagger UI
        if: steps.swagger-ui.outputs.current_tag != steps.swagger-ui.outputs.release_tag
        env:
          RELEASE_TAG: ${{ steps.swagger-ui.outputs.release_tag }}
          SWAGGER_YAML: "swagger.yaml"
        run: |
          # Delete the dist directory and index.html
          rm -fr dist index.html
          # Download the release
          curl -sL -o $RELEASE_TAG https://api.github.com/repos/swagger-api/swagger-ui/tarball/$RELEASE_TAG
          # Extract the dist directory
          tar -xzf $RELEASE_TAG --strip-components=1 $(tar -tzf $RELEASE_TAG | head -1 | cut -f1 -d"/")/dist
          rm $RELEASE_TAG
          # Move index.html to the root
          mv dist/index.html .
          # Fix references in index.html
          sed -i "s|https://petstore.swagger.io/v2/swagger.json|$SWAGGER_YAML|g" index.html
          sed -i "s|href=\"./|href=\"dist/|g" index.html
          sed -i "s|src=\"./|src=\"dist/|g" index.html
          # Update current release
          echo ${{ steps.swagger-ui.outputs.release_tag }} > swagger-ui.version
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          commit-message: Update swagger-ui to ${{ steps.swagger-ui.outputs.release_tag }}
          title: Update SwaggerUI to ${{ steps.swagger-ui.outputs.release_tag }}
          body: |
            Updates [swagger-ui][1] to ${{ steps.swagger-ui.outputs.release_tag }}

            Auto-generated by [create-pull-request][2]

            [1]: https://github.com/swagger-api/swagger-ui
            [2]: https://github.com/peter-evans/create-pull-request
          labels: dependencies, automated pr
          branch: swagger-ui-updates
```

### Spider and download a website

This workflow spiders a website and downloads the content. Any changes to the website will be raised in a pull request.

```yml
name: Download Website
on:
  schedule:
    - cron:  '0 10 * * *'
jobs:
  format:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Download website
        run: |
          wget \
            --recursive \
            --level=2 \
            --wait=1 \
            --no-clobber \
            --page-requisites \
            --html-extension \
            --convert-links \
            --domains quotes.toscrape.com \
            http://quotes.toscrape.com/
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          commit-message: update local website copy
          title: Automated Updates to Local Website Copy
          body: This is an auto-generated PR with website updates.
          branch: website-updates
```

## Use case: Create a pull request to update X by calling the GitHub API

You can use the GitHub API to trigger a webhook event called [`repository_dispatch`](https://help.github.com/en/github/automating-your-workflow-with-github-actions/events-that-trigger-workflows#external-events-repository_dispatch) when you want to trigger a workflow for activity that happens outside of GitHub.
This pattern will work well for updating any kind of static content from an external source.

You can modify any of the examples in the previous section to work in this fashion.

Set the workflow to execute `on: repository_dispatch`.

```yml
on:
  repository_dispatch:
    types: [create-pull-request]
```

### Call the GitHub API from an external service

An `on: repository_dispatch` workflow can be triggered by a call to the GitHub API as follows.

- `[username]` is a GitHub username
- `[token]` is a `repo` scoped [Personal Access Token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line)
- `[repository]` is the name of the repository the workflow resides in.

```
curl -XPOST -u "[username]:[token]" \
  -H "Accept: application/vnd.github.everest-preview+json" \
  -H "Content-Type: application/json" \
  https://api.github.com/repos/[username]/[repository]/dispatches \
  --data '{"event_type": "create-pull-request"}'
```

### Call the GitHub API from another GitHub Actions workflow

An `on: repository_dispatch` workflow can be triggered from another workflow with [repository-dispatch](https://github.com/peter-evans/repository-dispatch) action.

```yml
- name: Repository Dispatch
  uses: peter-evans/repository-dispatch@v1.0.0
  with:
    token: ${{ secrets.REPO_ACCESS_TOKEN }}
    repository: username/my-repo
    event-type: create-pull-request
    client-payload: '{"ref": "${{ github.ref }}", "sha": "${{ github.sha }}"}'
```

## Use case: Create a pull request to modify/fix pull requests

**Note**: While the following approach does work, my strong recommendation would be to use a slash command style "ChatOps" solution for operations on pull requests. See [slash-command-dispatch](https://github.com/peter-evans/slash-command-dispatch) for such a solution.

This is a pattern that lends itself to automated code linting and fixing. A pull request can be created to fix or modify something during an `on: pull_request` workflow. The pull request containing the fix will be raised with the original pull request as the base. This can be then be merged to update the original pull request and pass any required tests.

Note that due to [limitations on forked repositories](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/authenticating-with-the-github_token#permissions-for-the-github_token) workflows for this use case do not work for pull requests raised from forks.

### autopep8

The following is an example workflow for a use case where [autopep8 action](https://github.com/peter-evans/autopep8) runs as both a check on pull requests and raises a further pull request to apply code fixes.

How it works:

1. When a pull request is raised the workflow executes as a check
2. If autopep8 makes any fixes a pull request will be raised for those fixes to be merged into the current pull request branch. The workflow then deliberately causes the check to fail.
3. When the pull request containing the fixes is merged the workflow runs again. This time autopep8 makes no changes and the check passes.
4. The original pull request can now be merged.

```yml
name: autopep8
on: pull_request
jobs:
  autopep8:
    # Check if the PR is not raised by this workflow and is not from a fork
    if: startsWith(github.head_ref, 'autopep8-patches') == false && github.event.pull_request.head.repo.full_name == github.repository
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          ref: ${{ github.head_ref }}
      - name: autopep8
        id: autopep8
        uses: peter-evans/autopep8@v1.1.0
        with:
          args: --exit-code --recursive --in-place --aggressive --aggressive .
      - name: Set autopep8 branch name
        id: vars
        run: echo ::set-output name=branch-name::"autopep8-patches/${{ github.head_ref }}"
      - name: Create Pull Request
        if: steps.autopep8.outputs.exit-code == 2
        uses: peter-evans/create-pull-request@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          commit-message: autopep8 action fixes
          title: Fixes by autopep8 action
          body: This is an auto-generated PR with fixes by autopep8.
          labels: autopep8, automated pr
          branch: ${{ steps.vars.outputs.branch-name }}
      - name: Fail if autopep8 made changes
        if: steps.autopep8.outputs.exit-code == 2
        run: exit 1
```

## Misc workflow tips

### Filtering push events

For workflows using `on: push` you may want to ignore push events for tags and only execute for branches. Specifying `branches` causes only events on branches to trigger the workflow. The `'**'` wildcard will match any branch name.

```yml
on:
  push:
    branches:
      - '**' 
```

If you have a workflow that contains jobs to handle push events on branches as well as tags, you can make sure that the job where you use `create-pull-request` action only executes when `github.ref` is a branch by using an `if` condition as follows.

```yml
on: push
jobs:
  createPullRequest:
    if: startsWith(github.ref, 'refs/heads/')
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      ...

  someOtherJob:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      ...
```

### Dynamic configuration using variables

The following examples show how configuration for the action can be dynamically defined in a previous workflow step.

The recommended method is to use [`set-output`](https://help.github.com/en/github/automating-your-workflow-with-github-actions/development-tools-for-github-actions#set-an-output-parameter-set-output). Note that the step where output variables are defined must have an id.

```yml
      - name: Set output variables
        id: vars
        run: |
          echo ::set-output name=pr_title::"[Test] Add report file $(date +%d-%m-%Y)"
          echo ::set-output name=pr_body::"This PR was auto-generated on $(date +%d-%m-%Y) \
            by [create-pull-request](https://github.com/peter-evans/create-pull-request)."
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          title: ${{ steps.vars.outputs.pr_title }}
          body: ${{ steps.vars.outputs.pr_body }}
```

Alternatively, [`set-env`](https://help.github.com/en/github/automating-your-workflow-with-github-actions/development-tools-for-github-actions#set-an-environment-variable-set-env) can be used to create environment variables.

```yml
      - name: Set environment variables
        run: |
          echo ::set-env name=PULL_REQUEST_TITLE::"[Test] Add report file $(date +%d-%m-%Y)"
          echo ::set-env name=PULL_REQUEST_BODY::"This PR was auto-generated on $(date +%d-%m-%Y) \
            by [create-pull-request](https://github.com/peter-evans/create-pull-request)."
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          title: ${{ env.PULL_REQUEST_TITLE }}
          body: ${{ env.PULL_REQUEST_BODY }}
```

### Debugging GitHub Actions

#### Runner Diagnostic Logging

[Runner diagnostic logging](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/managing-a-workflow-run#enabling-runner-diagnostic-logging) provides additional log files that contain information about how a runner is executing an action.
To enable runner diagnostic logging, set the secret `ACTIONS_RUNNER_DEBUG` to `true` in the repository that contains the workflow.

#### Step Debug Logging

[Step debug logging](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/managing-a-workflow-run#enabling-step-debug-logging) increases the verbosity of a job's logs during and after a job's execution.
To enable step debug logging set the secret `ACTIONS_STEP_DEBUG` to `true` in the repository that contains the workflow.

#### Output Various Contexts

```yml
    steps:
      - name: Dump GitHub context
        env:
          GITHUB_CONTEXT: ${{ toJson(github) }}
        run: echo "$GITHUB_CONTEXT"
      - name: Dump job context
        env:
          JOB_CONTEXT: ${{ toJson(job) }}
        run: echo "$JOB_CONTEXT"
      - name: Dump steps context
        env:
          STEPS_CONTEXT: ${{ toJson(steps) }}
        run: echo "$STEPS_CONTEXT"
      - name: Dump runner context
        env:
          RUNNER_CONTEXT: ${{ toJson(runner) }}
        run: echo "$RUNNER_CONTEXT"
      - name: Dump strategy context
        env:
          STRATEGY_CONTEXT: ${{ toJson(strategy) }}
        run: echo "$STRATEGY_CONTEXT"
      - name: Dump matrix context
        env:
          MATRIX_CONTEXT: ${{ toJson(matrix) }}
        run: echo "$MATRIX_CONTEXT"
```
