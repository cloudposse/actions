<!-- markdownlint-disable MD033 MD041 -->
<!-- Generated by .automation/build.py, please do not update manually -->
# lintr

## lintr documentation

- Version in Mega-Linter: **2.0.1.9000**
- Visit [Official Web Site](https://github.com/jimhester/lintr#readme){target=_blank}
- See [How to configure lintr rules](https://github.com/jimhester/lintr#project-configuration){target=_blank}
  - If custom `.lintr` config file is not found, [.lintr](https://github.com/nvuillam/mega-linter/tree/master/TEMPLATES/.lintr){target=_blank} will be used
- See [Index of problems detected by lintr](https://github.com/jimhester/lintr#available-linters){target=_blank}

[![lintr - GitHub](https://gh-card.dev/repos/jimhester/lintr.svg?fullname=)](https://github.com/jimhester/lintr){target=_blank}

## Configuration in Mega-Linter

- Enable lintr by adding `R_LINTR` in [ENABLE_LINTERS variable](https://nvuillam.github.io/mega-linter/configuration/#activation-and-deactivation)
- Disable lintr by adding `R_LINTR` in [DISABLE_LINTERS variable](https://nvuillam.github.io/mega-linter/configuration/#activation-and-deactivation)

| Variable                     | Description                                                                                                                                                                                  | Default value                                    |
|------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| R_LINTR_ARGUMENTS            | User custom arguments to add in linter CLI call<br/>Ex: `-s --foo "bar"`                                                                                                                     |                                                  |
| R_LINTR_FILTER_REGEX_INCLUDE | Custom regex including filter<br/>Ex: `(src|lib)`                                                                                                                                            | Include every file                               |
| R_LINTR_FILTER_REGEX_EXCLUDE | Custom regex excluding filter<br/>Ex: `(test|examples)`                                                                                                                                      | Exclude no file                                  |
| R_LINTR_FILE_EXTENSIONS      | Allowed file extensions. `"*"` matches any extension, `""` matches empty extension. Empty list excludes all files<br/>Ex: `[".py", ""]`                                                      | `[".r", ".R", ".Rmd", ".RMD"]`                   |
| R_LINTR_FILE_NAMES_REGEX     | File name regex filters. Regular expression list for filtering files by their base names using regex full match. Empty list includes all files<br/>Ex: `["Dockerfile(-.+)?", "Jenkinsfile"]` | Include every file                               |
| R_LINTR_CONFIG_FILE          | lintr configuration file name</br>Use `LINTER_DEFAULT` to let the linter find it                                                                                                             | `.lintr`                                         |
| R_LINTR_RULES_PATH           | Path where to find linter configuration file                                                                                                                                                 | Workspace folder, then Mega-Linter default rules |
| R_LINTR_DISABLE_ERRORS       | Run linter but consider errors as warnings                                                                                                                                                   | `false`                                          |

## IDE Integration

Use lintr in your favorite IDE to catch errors before Mega-Linter !

| <!-- -->                                                                                                                                      | IDE                                                  | Extension Name                                                                           | Install                                                                                                                                                                    |
|-----------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/atom.ico" alt="" height="32px" class="megalinter-icon"></a>    | [Atom](https://atom.io/)                             | [Atom lintr](https://github.com/AtomLinter/linter-lintr)                                 | [Visit Web Site](https://github.com/AtomLinter/linter-lintr){target=_blank}                                                                                                |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/emacs.ico" alt="" height="32px" class="megalinter-icon"></a>   | [Emacs](https://www.gnu.org/software/emacs/)         | [flycheck](http://www.flycheck.org/en/latest/languages.html#r)                           | [Visit Web Site](http://www.flycheck.org/en/latest/languages.html#r){target=_blank}                                                                                        |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/default.ico" alt="" height="32px" class="megalinter-icon"></a> | rstudio                                              | [Native Support](https://rstudio.com/)                                                   | [Visit Web Site](https://rstudio.com/){target=_blank}                                                                                                                      |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/sublime.ico" alt="" height="32px" class="megalinter-icon"></a> | [Sublime Text](https://www.sublimetext.com/)         | [SublimeLinter-contrib-lintr](https://github.com/jimhester/SublimeLinter-contrib-lintr)  | [Visit Web Site](https://github.com/jimhester/SublimeLinter-contrib-lintr){target=_blank}                                                                                  |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/vim.ico" alt="" height="32px" class="megalinter-icon"></a>     | [vim](https://www.vim.org/)                          | [ale](https://github.com/dense-analysis/ale)                                             | [Visit Web Site](https://github.com/dense-analysis/ale){target=_blank}                                                                                                     |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/vscode.ico" alt="" height="32px" class="megalinter-icon"></a>  | [Visual Studio Code](https://code.visualstudio.com/) | [VsCode R LSP](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r-lsp) | [![Install in VsCode](https://github.com/nvuillam/mega-linter/raw/master/docs/assets/images/btn_install_vscode.png)](vscode:extension/REditorSupport.r-lsp){target=_blank} |

## Mega-Linter Flavours

This linter is available in the following flavours

| <!-- -->                                                                                                                                                  | Flavor                                                           | Description                | Embedded linters | Info                                                                                                                                                                   |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|----------------------------|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/images/mega-linter-square.png" alt="" height="32px" class="megalinter-icon"></a> | [all](https://nvuillam.github.io/mega-linter/supported-linters/) | Default Mega-Linter Flavor | 80               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter) |

## Behind the scenes

### How are identified applicable files

- File extensions: `.r`, `.R`, `.Rmd`, `.RMD`

<!-- markdownlint-disable -->
<!-- /* cSpell:disable */ -->

### Example calls

```shell
R --slave -e "errors <- lintr::lint('myfile.r'); print(errors); quit(save = 'no', status = if (length(errors) > 0) 1 else 0) "
```


### Help content

```shell
No documentation for ‘lintr’ in specified packages and libraries:
you could try ‘??lintr’
```

### Installation on mega-linter Docker image

- Dockerfile commands :
```dockerfile
FROM ghcr.io/assignuser/lintr-lib:latest as lintr-lib
COPY --from=lintr-lib /usr/lib/R/library/ /home/r-library
RUN R -e "install.packages(list.dirs('/home/r-library',recursive = FALSE), repos = NULL, type = 'source')"
```

- APK packages (Linux):
  - [R](https://pkgs.alpinelinux.org/packages?branch=edge&name=R)
  - [R-dev](https://pkgs.alpinelinux.org/packages?branch=edge&name=R-dev)
  - [R-doc](https://pkgs.alpinelinux.org/packages?branch=edge&name=R-doc)

### Example success log

```shell
Results of lintr linter (version 2.0.1.9000)
See documentation on https://nvuillam.github.io/mega-linter/descriptors/r_lintr/
-----------------------------------------------

[SUCCESS] .automation/test/r/r_good_1.r
    Warning message:
    In readLines(filename) :
      incomplete final line found on '.automation/test/r/r_good_1.r'

```

### Example error log

```shell
Results of lintr linter (version 2.0.1.9000)
See documentation on https://nvuillam.github.io/mega-linter/descriptors/r_lintr/
-----------------------------------------------

[ERROR] .automation/test/r/r_bad_1.r
    style:.automation/test/r/r_bad_1.r:8:3::Use <-, not =, for assignment.
    style:.automation/test/r/r_bad_1.r:8:14::Remove spaces before the left parenthesis in a function call.
    style:.automation/test/r/r_bad_1.r:8:17::Commas should always have a space after.
    style:.automation/test/r/r_bad_1.r:8:22::There should be a space between right parenthesis and an opening curly brace.
    style:.automation/test/r/r_bad_1.r:8:23::Opening curly braces should never go on their own line and should always be followed by a new line.
    style:.automation/test/r/r_bad_1.r:8:24::Closing curly-braces should always be on their own line, unless it's followed by an else.
    style:.automation/test/r/r_bad_1.r:11:3::Commented code should be removed.
    style:.automation/test/r/r_bad_1.r:21:1::functions should have cyclomatic complexity of less than 15, this has 22.
    style:.automation/test/r/r_bad_1.r:21:1::Variable and function names should not be longer than 30 characters.
    style:.automation/test/r/r_bad_1.r:21:1::Variable and function name style should be snake_case.
    style:.automation/test/r/r_bad_1.r:22:1::Opening curly braces should never go on their own line and should always be followed by a new line.
    style:.automation/test/r/r_bad_1.r:24:1::Lines should not be more than 80 characters.
    style:.automation/test/r/r_bad_1.r:24:44::Put spaces around all infix operators.
    warning:.automation/test/r/r_bad_1.r:24:57::Use is.na rather than == NA.
    style:.automation/test/r/r_bad_1.r:24:64::Opening curly braces should never go on their own line and should always be followed by a new line.
    style:.automation/test/r/r_bad_1.r:24:69::Closing curly-braces should always be on their own line, unless it's followed by an else.
    style:.automation/test/r/r_bad_1.r:24:76::Opening curly braces should never go on their own line and should always be followed by a new line.
    style:.automation/test/r/r_bad_1.r:24:82::Closing curly-braces should always be on their own line, unless it's followed by an else.
    style:.automation/test/r/r_bad_1.r:31:3::Do not place spaces around code in parentheses or square brackets.
    warning:.automation/test/r/r_bad_1.r:32:1::Avoid 1:length(...) expressions, use seq_len.
    style:.automation/test/r/r_bad_1.r:32:37::Put spaces around all infix operators.
    style:.automation/test/r/r_bad_1.r:32:43::`%>%` should always have a space before it and a new line after it, unless the full pipeline fits on one line.
    style:.automation/test/r/r_bad_1.r:36:9::Only use double-quotes.
    style:.automation/test/r/r_bad_1.r:40:8::Put spaces around all infix operators.
    style:.automation/test/r/r_bad_1.r:40:9::Place a space before left parenthesis, except in a function call.
    style:.automation/test/r/r_bad_1.r:43:1::Trailing blank lines are superfluous.

```