# angular-antlr
Sample Grunt Bower Angular Antlr4 application

It is a sample test ember application. It realize a simple angular ANTLR v.4 lexical and parser grammar service.
An init and build script are provided with the source.

This project is generated with [yo angular generator](https://github.com/yeoman/generator-angular)
version 0.15.1.

## Pre-Requisites

This project requires `Ruby` and `compass` for building and `grunt serve` the preview.
You can find `Ruby 2.3.0` at [Ruby Installation Page] (http://www.ruby-lang.org/en/documentation/installation)

After you have installed `Ruby 2.3.0` you can install on the system shell compass with this two commands:

`ruby update` : > gem update --system

`compass install` : > gem install compass

Please run the `NODE and NPM` maven install (`install-platform`) and the `pre-build` process to setup environment or simply install npm and bower (`npm install` & `bower install`)

After that please run once the maven link service to export antlr in the bower directory before build as follow :
`mvn clean install -P link-antlr4`

## Build & Export

Run `grunt` or `grunt build` for building and `grunt serve` for preview.
Tests and jshint are required before to compile and distribute the app in the folder `build` in a folder that matches with the application name. A junit and a cobertura reports are provided in the same folder inside the container folder `tests`.


## Build & Deployment

A maven POM procedure runs new features :

build:
`mvn clean install -P build,package`

(NOTE: In the target directory will be created during the package a war file. To be completed: The executable running external services.)

install NODE and NPM:
`mvn clean install -P install-platform`

(NOTE: In the build/bin directory will be installed the executables, then compiles the EBNF, JISON and ANTRL files.)

run NPM and bower install of dependency packages:
`mvn clean install -P pre-build`

(NOTE: This profile installs all the dependencies for NPM and bower configuration files, then compiles the EBNF, JISON and ANTRL files.)

run once the antlr4 linking command after the npm/bower install phase :
`mvn clean install -P link-antlr4`

(NOTE: This profile installs the antlr4 mandatory bowel dependency before build.)

we provide an antlr4 unlinking command to reverse the previous operation :
`mvn clean install -P unlink-antlr4`

(NOTE: This profile uninstalls the antlr4 mandatory bowel dependency before build.)

 `mvn -U exec:exec -P compile-project-parsers`

 (NOTE: This profile clean and create ANTLR, JISON and EBNF project JavaScript parsers.)

## Testing

Running `grunt test` will run the unit tests with karma. Test cases are running before the build as pre-requisites.
Running the tests a junit and a cobertura reports have been created  in the `dist` folder inside the container folder `tests`.
Testing frameworks : `karma, jasmine, mocha, chai, sinon`
