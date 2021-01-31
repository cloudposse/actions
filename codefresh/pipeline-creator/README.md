# Codefresh Pipeline Creator GitHub Action

Automatically creates Codefresh pipelines from pipeline specs.


## Usage

In your application repo, create a workflow file (e.g. `.github/workflows/codefresh.yml`) similar to this:

```yaml
name: codefresh
on:
  push:
    branches:
      - main
    paths:
      # When this file is merged to the default branch, then perform codefresh CRUD
      - '.github/workflows/codefresh.yml'
  # Synchronize pipelines with Codefresh nightly
  schedule:
    - cron:  '0 0 * * *'

jobs:
  pipeline-creator:
    runs-on: ubuntu-latest
    steps:
      - uses: cloudposse/actions/codefresh/pipeline-creator@0.25.0
        with:
          # GitHub owner and repository name of the application repository
          repo: "${{ github.repository }}"
          # Codefresh project name to host the pipelines
          cf_project: "${{ github.event.repository.name }}"
          # URL of the repository that contains Codefresh pipelines and pipeline specs
          cf_repo_url: "https://github.com/cloudposse/codefresh.git"
          # Version of the repository that contains Codefresh pipelines and pipeline specs
          cf_repo_version: "0.1.0"
          # Pipeline spec type (microservice, spa, serverless)
          cf_spec_type: "microservice"
          # A comma separated list of pipeline specs to create the pipelines from
          cf_specs: "preview,build,deploy,release,destroy"
        env:
          GITHUB_USER: "xxxxxxxxx-bot"
          # Global organization secrets
          GITHUB_TOKEN: "${{ secrets.CF_GITHUB_TOKEN }}"
          CF_API_KEY: "${{ secrets.CF_API_KEY }}"
```


## Why?

  - Every application that uses Codefresh as a CI/CD platform, needs to define a set of Codefresh pipelines 
    (e.g. `build`, `deploy`, `release`, `destroy`),
    which are usually different for different types of applications (`microservice`, `SPA`, `severless`, etc.).
  

  - Instead of copying the same Codefresh pipeline definitions into every application (which would require maintaining them in many places), 
    and creating the pipelines manually in the Codefresh UI,
    define the pipeline steps and pipeline specs in your company's centralized catalog of Codefresh pipelines 
    (e.g. in `https://github.com/my-company/codefresh` repo), and just copy one 
    file with the GitHub Actions workflow described above into your application.
    

  - The workflow calls the `pipeline-creator` action, which combines the pipeline steps with pipeline spec templates 
    into the final specs, and provisions the pipelines in Codefresh automatically.
