# ci_light Mega-Linter Flavor

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-ci_light/v4)
![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-ci_light)

## Description

Optimized for CI items (Dockerfile, Jenkinsfile, JSON/YAML schemas,XML

## Usage

- [GitHub Action](https://nvuillam.github.io/mega-linter/installation/#github-action): **nvuillam/mega-linter/flavors/ci_light@v4**
- Docker image: **nvuillam/mega-linter-ci_light:v4**
- [mega-linter-runner](https://nvuillam.github.io/mega-linter/mega-linter-runner/): `mega-linter-runner --flavor ci_light`

## Embedded linters

### Languages

| <!-- -->                                                                                                                                                          | Language                                                                 | Linter                                                                                        | Configuration key                                                                                    | Format/Fix         |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|--------------------|
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/groovy.ico" alt="" height="32px" class="megalinter-icon"></a> <!-- linter-icon --> | [**GROOVY**](https://nvuillam.github.io/mega-linter/descriptors/groovy/) | [npm-groovy-lint](https://nvuillam.github.io/mega-linter/descriptors/groovy_npm_groovy_lint/) | [GROOVY_NPM_GROOVY_LINT](https://nvuillam.github.io/mega-linter/descriptors/groovy_npm_groovy_lint/) | :heavy_check_mark: |

### Formats

| <!-- -->                                                                                                                                                        | Format                                                               | Linter                                                                                              | Configuration key                                                                                        | Format/Fix         |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|--------------------|
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/env.ico" alt="" height="32px" class="megalinter-icon"></a> <!-- linter-icon -->  | [**ENV**](https://nvuillam.github.io/mega-linter/descriptors/env/)   | [dotenv-linter](https://nvuillam.github.io/mega-linter/descriptors/env_dotenv_linter/)              | [ENV_DOTENV_LINTER](https://nvuillam.github.io/mega-linter/descriptors/env_dotenv_linter/)               | :heavy_check_mark: |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/json.ico" alt="" height="32px" class="megalinter-icon"></a> <!-- linter-icon --> | [**JSON**](https://nvuillam.github.io/mega-linter/descriptors/json/) | [jsonlint](https://nvuillam.github.io/mega-linter/descriptors/json_jsonlint/)                       | [JSON_JSONLINT](https://nvuillam.github.io/mega-linter/descriptors/json_jsonlint/)                       |                    |
| <!-- --> <!-- linter-icon -->                                                                                                                                   |                                                                      | [eslint-plugin-jsonc](https://nvuillam.github.io/mega-linter/descriptors/json_eslint_plugin_jsonc/) | [JSON_ESLINT_PLUGIN_JSONC](https://nvuillam.github.io/mega-linter/descriptors/json_eslint_plugin_jsonc/) | :heavy_check_mark: |
| <!-- --> <!-- linter-icon -->                                                                                                                                   |                                                                      | [v8r](https://nvuillam.github.io/mega-linter/descriptors/json_v8r/)                                 | [JSON_V8R](https://nvuillam.github.io/mega-linter/descriptors/json_v8r/)                                 |                    |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/xml.ico" alt="" height="32px" class="megalinter-icon"></a> <!-- linter-icon -->  | [**XML**](https://nvuillam.github.io/mega-linter/descriptors/xml/)   | [xmllint](https://nvuillam.github.io/mega-linter/descriptors/xml_xmllint/)                          | [XML_XMLLINT](https://nvuillam.github.io/mega-linter/descriptors/xml_xmllint/)                           |                    |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/yaml.ico" alt="" height="32px" class="megalinter-icon"></a> <!-- linter-icon --> | [**YAML**](https://nvuillam.github.io/mega-linter/descriptors/yaml/) | [yamllint](https://nvuillam.github.io/mega-linter/descriptors/yaml_yamllint/)                       | [YAML_YAMLLINT](https://nvuillam.github.io/mega-linter/descriptors/yaml_yamllint/)                       |                    |
| <!-- --> <!-- linter-icon -->                                                                                                                                   |                                                                      | [v8r](https://nvuillam.github.io/mega-linter/descriptors/yaml_v8r/)                                 | [YAML_V8R](https://nvuillam.github.io/mega-linter/descriptors/yaml_v8r/)                                 |                    |

### Tooling formats

| <!-- -->                                                                                                                                                              | Tooling format                                                                   | Linter                                                                                          | Configuration key                                                                                          | Format/Fix |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|------------|
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/dockerfile.ico" alt="" height="32px" class="megalinter-icon"></a> <!-- linter-icon --> | [**DOCKERFILE**](https://nvuillam.github.io/mega-linter/descriptors/dockerfile/) | [dockerfilelint](https://nvuillam.github.io/mega-linter/descriptors/dockerfile_dockerfilelint/) | [DOCKERFILE_DOCKERFILELINT](https://nvuillam.github.io/mega-linter/descriptors/dockerfile_dockerfilelint/) |            |
| <!-- --> <!-- linter-icon -->                                                                                                                                         |                                                                                  | [hadolint](https://nvuillam.github.io/mega-linter/descriptors/dockerfile_hadolint/)             | [DOCKERFILE_HADOLINT](https://nvuillam.github.io/mega-linter/descriptors/dockerfile_hadolint/)             |            |

### Other

| <!-- -->                                                                                                                                                       | Code quality checker                                               | Linter                                                                       | Configuration key                                                                | Format/Fix |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|------------------------------------------------------------------------------|----------------------------------------------------------------------------------|------------|
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/git.ico" alt="" height="32px" class="megalinter-icon"></a> <!-- linter-icon --> | [**GIT**](https://nvuillam.github.io/mega-linter/descriptors/git/) | [git_diff](https://nvuillam.github.io/mega-linter/descriptors/git_git_diff/) | [GIT_GIT_DIFF](https://nvuillam.github.io/mega-linter/descriptors/git_git_diff/) |            |

