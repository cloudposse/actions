<!-- markdownlint-disable MD033 MD041 -->
<!-- Generated by .automation/build.py, please do not update manually -->
# xmllint

## xmllint documentation

- Version in Mega-Linter: **20910**
- Visit [Official Web Site](http://xmlsoft.org/xmllint.html){target=_blank}
- See [Index of problems detected by xmllint](http://xmlsoft.org/xmllint.html#diagnostics){target=_blank}

## Configuration in Mega-Linter

- Enable xmllint by adding `XML_XMLLINT` in [ENABLE_LINTERS variable](https://nvuillam.github.io/mega-linter/configuration/#activation-and-deactivation)
- Disable xmllint by adding `XML_XMLLINT` in [DISABLE_LINTERS variable](https://nvuillam.github.io/mega-linter/configuration/#activation-and-deactivation)

| Variable                         | Description                                                                                                                                                                                  | Default value      |
|----------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------|
| XML_XMLLINT_ARGUMENTS            | User custom arguments to add in linter CLI call<br/>Ex: `-s --foo "bar"`                                                                                                                     |                    |
| XML_XMLLINT_FILTER_REGEX_INCLUDE | Custom regex including filter<br/>Ex: `(src|lib)`                                                                                                                                            | Include every file |
| XML_XMLLINT_FILTER_REGEX_EXCLUDE | Custom regex excluding filter<br/>Ex: `(test|examples)`                                                                                                                                      | Exclude no file    |
| XML_XMLLINT_FILE_EXTENSIONS      | Allowed file extensions. `"*"` matches any extension, `""` matches empty extension. Empty list excludes all files<br/>Ex: `[".py", ""]`                                                      | `[".xml"]`         |
| XML_XMLLINT_FILE_NAMES_REGEX     | File name regex filters. Regular expression list for filtering files by their base names using regex full match. Empty list includes all files<br/>Ex: `["Dockerfile(-.+)?", "Jenkinsfile"]` | Include every file |
| XML_XMLLINT_DISABLE_ERRORS       | Run linter but consider errors as warnings                                                                                                                                                   | `false`            |

## Mega-Linter Flavours

This linter is available in the following flavours

| <!-- -->                                                                                                                                                  | Flavor                                                                         | Description                                                            | Embedded linters | Info                                                                                                                                                                                               |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|------------------------------------------------------------------------|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/images/mega-linter-square.png" alt="" height="32px" class="megalinter-icon"></a> | [all](https://nvuillam.github.io/mega-linter/supported-linters/)               | Default Mega-Linter Flavor                                             | 80               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter)                             |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/ci_light.ico" alt="" height="32px" class="megalinter-icon"></a>            | [ci_light](https://nvuillam.github.io/mega-linter/flavors/ci_light/)           | Optimized for CI items (Dockerfile, Jenkinsfile, JSON/YAML schemas,XML | 11               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-ci_light/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-ci_light)           |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/dart.ico" alt="" height="32px" class="megalinter-icon"></a>                | [dart](https://nvuillam.github.io/mega-linter/flavors/dart/)                   | Optimized for DART based projects                                      | 36               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-dart/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-dart)                   |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/documentation.ico" alt="" height="32px" class="megalinter-icon"></a>       | [documentation](https://nvuillam.github.io/mega-linter/flavors/documentation/) | Mega-Linter for documentation projects                                 | 35               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-documentation/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-documentation) |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/dotnet.ico" alt="" height="32px" class="megalinter-icon"></a>              | [dotnet](https://nvuillam.github.io/mega-linter/flavors/dotnet/)               | Optimized for C, C++, C# or VB based projects                          | 41               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-dotnet/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-dotnet)               |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/go.ico" alt="" height="32px" class="megalinter-icon"></a>                  | [go](https://nvuillam.github.io/mega-linter/flavors/go/)                       | Optimized for GO based projects                                        | 36               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-go/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-go)                       |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/java.ico" alt="" height="32px" class="megalinter-icon"></a>                | [java](https://nvuillam.github.io/mega-linter/flavors/java/)                   | Optimized for JAVA based projects                                      | 36               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-java/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-java)                   |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/javascript.ico" alt="" height="32px" class="megalinter-icon"></a>          | [javascript](https://nvuillam.github.io/mega-linter/flavors/javascript/)       | Optimized for JAVASCRIPT or TYPESCRIPT based projects                  | 44               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-javascript/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-javascript)       |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/php.ico" alt="" height="32px" class="megalinter-icon"></a>                 | [php](https://nvuillam.github.io/mega-linter/flavors/php/)                     | Optimized for PHP based projects                                       | 39               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-php/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-php)                     |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/python.ico" alt="" height="32px" class="megalinter-icon"></a>              | [python](https://nvuillam.github.io/mega-linter/flavors/python/)               | Optimized for PYTHON based projects                                    | 42               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-python/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-python)               |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/ruby.ico" alt="" height="32px" class="megalinter-icon"></a>                | [ruby](https://nvuillam.github.io/mega-linter/flavors/ruby/)                   | Optimized for RUBY based projects                                      | 36               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-ruby/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-ruby)                   |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/rust.ico" alt="" height="32px" class="megalinter-icon"></a>                | [rust](https://nvuillam.github.io/mega-linter/flavors/rust/)                   | Optimized for RUST based projects                                      | 36               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-rust/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-rust)                   |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/salesforce.ico" alt="" height="32px" class="megalinter-icon"></a>          | [salesforce](https://nvuillam.github.io/mega-linter/flavors/salesforce/)       | Optimized for Salesforce based projects                                | 36               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-salesforce/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-salesforce)       |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/scala.ico" alt="" height="32px" class="megalinter-icon"></a>               | [scala](https://nvuillam.github.io/mega-linter/flavors/scala/)                 | Optimized for SCALA based projects                                     | 36               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-scala/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-scala)                 |
| <img src="https://github.com/nvuillam/mega-linter/raw/master/docs/assets/icons/terraform.ico" alt="" height="32px" class="megalinter-icon"></a>           | [terraform](https://nvuillam.github.io/mega-linter/flavors/terraform/)         | Optimized for TERRAFORM based projects                                 | 38               | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/nvuillam/mega-linter-terraform/v4) ![Docker Pulls](https://img.shields.io/docker/pulls/nvuillam/mega-linter-terraform)         |

## Behind the scenes

### How are identified applicable files

- File extensions: `.xml`

<!-- markdownlint-disable -->
<!-- /* cSpell:disable */ -->

### Example calls

```shell
xmllint myfile.xml
```


### Help content

```shell
Unknown option --help
Usage : xmllint [options] XMLfiles ...
  Parse the XML files and output the result of the parsing
  --version : display the version of the XML library used
  --debug : dump a debug tree of the in-memory document
  --shell : run a navigating shell
  --debugent : debug the entities defined in the document
  --copy : used to test the internal copy implementation
  --recover : output what was parsable on broken XML documents
  --huge : remove any internal arbitrary parser limits
  --noent : substitute entity references by their value
  --noenc : ignore any encoding specified inside the document
  --noout : don't output the result tree
  --path 'paths': provide a set of paths for resources
  --load-trace : print trace of all external entities loaded
  --nonet : refuse to fetch DTDs or entities over network
  --nocompact : do not generate compact text nodes
  --htmlout : output results as HTML
  --nowrap : do not put HTML doc wrapper
  --valid : validate the document in addition to std well-formed check
  --postvalid : do a posteriori validation, i.e after parsing
  --dtdvalid URL : do a posteriori validation against a given DTD
  --dtdvalidfpi FPI : same but name the DTD with a Public Identifier
  --timing : print some timings
  --output file or -o file: save to a given file
  --repeat : repeat 100 times, for timing or profiling
  --insert : ad-hoc test for valid insertions
  --compress : turn on gzip compression of output
  --html : use the HTML parser
  --xmlout : force to use the XML serializer when using --html
  --nodefdtd : do not default HTML doctype
  --push : use the push mode of the parser
  --pushsmall : use the push mode of the parser using tiny increments
  --memory : parse from memory
  --maxmem nbbytes : limits memory allocation to nbbytes bytes
  --nowarning : do not emit warnings from parser/validator
  --noblanks : drop (ignorable?) blanks spaces
  --nocdata : replace cdata section with text nodes
  --format : reformat/reindent the output
  --encode encoding : output in the given encoding
  --dropdtd : remove the DOCTYPE of the input docs
  --pretty STYLE : pretty-print in a particular style
                   0 Do not pretty print
                   1 Format the XML content, as --format
                   2 Add whitespace inside tags, preserving content
  --c14n : save in W3C canonical format v1.0 (with comments)
  --c14n11 : save in W3C canonical format v1.1 (with comments)
  --exc-c14n : save in W3C exclusive canonical format (with comments)
  --nsclean : remove redundant namespace declarations
  --testIO : test user I/O support
  --catalogs : use SGML catalogs from $SGML_CATALOG_FILES
               otherwise XML Catalogs starting from
           file:///etc/xml/catalog are activated by default
  --nocatalogs: deactivate all catalogs
  --auto : generate a small doc on the fly
  --xinclude : do XInclude processing
  --noxincludenode : same but do not generate XInclude nodes
  --nofixup-base-uris : do not fixup xml:base uris
  --loaddtd : fetch external DTD
  --dtdattr : loaddtd + populate the tree with inherited attributes
  --stream : use the streaming interface to process very large files
  --walker : create a reader and walk though the resulting doc
  --pattern pattern_value : test the pattern support
  --chkregister : verify the node registration code
  --relaxng schema : do RelaxNG validation against the schema
  --schema schema : do validation against the WXS schema
  --schematron schema : do validation against a schematron
  --sax1: use the old SAX1 interfaces for processing
  --sax: do not build a tree but work just at the SAX level
  --oldxml10: use XML-1.0 parsing rules before the 5th edition
  --xpath expr: evaluate the XPath expression, imply --noout

Libxml project home page: http://xmlsoft.org/
To report bugs or get some help check: http://xmlsoft.org/bugs.html
```

### Installation on mega-linter Docker image

- APK packages (Linux):
  - [libc-dev](https://pkgs.alpinelinux.org/packages?branch=edge&name=libc-dev)
  - [libxml2-dev](https://pkgs.alpinelinux.org/packages?branch=edge&name=libxml2-dev)
  - [libxml2-utils](https://pkgs.alpinelinux.org/packages?branch=edge&name=libxml2-utils)
  - [libgcc](https://pkgs.alpinelinux.org/packages?branch=edge&name=libgcc)

### Example success log

```shell
Results of xmllint linter (version 20910)
See documentation on https://nvuillam.github.io/mega-linter/descriptors/xml_xmllint/
-----------------------------------------------

[SUCCESS] .automation/test/xml/xml_good_1.xml
    <?xml version="1.0"?>
    <note>
      <to>Tove</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don't forget me this weekend!</body>
    </note>

```

### Example error log

```shell
Results of xmllint linter (version 20910)
See documentation on https://nvuillam.github.io/mega-linter/descriptors/xml_xmllint/
-----------------------------------------------

[ERROR] .automation/test/xml/xml_bad_1.xml
    .automation/test/xml/xml_bad_1.xml:7: parser error : EndTag: '</' not found
    
    ^

```