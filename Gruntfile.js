// Generated on 2016-05-28 using generator-angular 0.15.1
'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  // Automatically load required Grunt tasks
  require('jit-grunt')(grunt, {
    useminPrepare: 'grunt-usemin',
    ngtemplates: 'grunt-angular-templates',
    cdnify: 'grunt-google-cdn'
  });

  // Configurable paths for the application
  var appConfig = {
    app: require('./bower.json').appPath || 'app',
    dist: 'dist'
  };
  grunt.loadNpmTasks('grunt-antlr4');
  grunt.loadNpmTasks('grunt-text-replace');
  grunt.loadNpmTasks('grunt-import-js');
  grunt.loadNpmTasks('grunt-jison-processor');

  // Define the configuration for all the tasks
  grunt.initConfig({

    // Project settings
    antrConfig: appConfig,

    // Watches files for changes and runs tasks based on the changed files
    watch: {
      bower: {
        files: ['bower.json'],
        tasks: ['wiredep']
      },
      js: {
        files: ['<%= antrConfig.app %>/scripts/{,*/}*.js'],
        tasks: ['newer:jshint:all', 'newer:jscs:all'],
        options: {
          livereload: '<%= connect.options.livereload %>'
        }
      },
      jsTest: {
        files: ['test/spec/{,*/}*.js'],
        tasks: ['newer:jshint:test', 'newer:jscs:test', 'karma']
      },
      compass: {
        files: ['<%= antrConfig.app %>/styles/{,*/}*.{scss,sass}'],
        tasks: ['compass:server', 'postcss:server']
      },
      antlr4: {
        files: ['<%= antrConfig.app %>/g4/{,*/}*.g4']
      },
      gruntfile: {
        files: ['Gruntfile.js']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '<%= antrConfig.app %>/{,*/}*.html',
          '.tmp/styles/{,*/}*.css',
          '<%= antrConfig.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
        ]
      }
    },

    // The actual grunt server settings
    connect: {
      options: {
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        livereload: 35729
      },
      livereload: {
        options: {
          open: true,
          middleware: function (connect) {
            return [
              connect.static('.tmp'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect().use(
                '/app/styles',
                connect.static('./app/styles')
              ),
              connect.static(appConfig.app)
            ];
          }
        }
      },
      test: {
        options: {
          port: 9001,
          middleware: function (connect) {
            return [
              connect.static('.tmp'),
              connect.static('test'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect.static(appConfig.app)
            ];
          }
        }
      },
      dist: {
        options: {
          open: true,
          base: '<%= antrConfig.dist %>'
        }
      }
    },

    // Make sure there are no obvious mistakes
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: {
        src: [
          'Gruntfile.js',
          '<%= antrConfig.app %>/scripts/{,*/}*.js'
        ]
      },
      test: {
        options: {
          jshintrc: 'test/.jshintrc'
        },
        src: ['test/spec/{,*/}*.js']
      }
    },

    // Make sure code styles are up to par
    jscs: {
      options: {
        config: '.jscsrc',
        verbose: true
      },
      all: {
        src: [
          'Gruntfile.js',
          '<%= antrConfig.app %>/scripts/{,*/}*.js'
        ]
      },
      test: {
        src: ['test/spec/{,*/}*.js']
      }
    },

    // Empties folders to start fresh
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%= antrConfig.dist %>/{,*/}*',
            '!<%= antrConfig.dist %>/.git{,*/}*'
          ]
        }]
      },
      server: '.tmp'
    },

    // Add vendor prefixed styles
    postcss: {
      options: {
        processors: [
          require('autoprefixer-core')({browsers: ['last 1 version']})
        ]
      },
      server: {
        options: {
          map: true
        },
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '{,*/}*.css',
          dest: '.tmp/styles/'
        }]
      },
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '{,*/}*.css',
          dest: '.tmp/styles/'
        }]
      }
    },

    // Automatically inject Bower components into the app
    wiredep: {
      app: {
        src: ['<%= antrConfig.app %>/index.html'],
        ignorePath:  /\.\.\//
      },
      test: {
        devDependencies: true,
        src: '<%= karma.unit.configFile %>',
        ignorePath:  /\.\.\//,
        fileTypes:{
          js: {
            block: /(([\s\t]*)\/{2}\s*?bower:\s*?(\S*))(\n|\r|.)*?(\/{2}\s*endbower)/gi,
              detect: {
                js: /'(.*\.js)'/gi
              },
              replace: {
                js: '\'{{filePath}}\','
              }
            }
          }
      },
      sass: {
        src: ['<%= antrConfig.app %>/styles/{,*/}*.{scss,sass}'],
        ignorePath: /(\.\.\/){1,2}bower_components\//
      }
    },

    // Compiles Sass to CSS and generates necessary files if requested
    compass: {
      options: {
        sassDir: '<%= antrConfig.app %>/styles',
        cssDir: '.tmp/styles',
        generatedImagesDir: '.tmp/images/generated',
        imagesDir: '<%= antrConfig.app %>/images',
        javascriptsDir: '<%= antrConfig.app %>/scripts',
        fontsDir: '<%= antrConfig.app %>/styles/fonts',
        importPath: './bower_components',
        httpImagesPath: '/images',
        httpGeneratedImagesPath: '/images/generated',
        httpFontsPath: '/styles/fonts',
        relativeAssets: false,
        assetCacheBuster: false,
        raw: 'Sass::Script::Number.precision = 10\n'
      },
      dist: {
        options: {
          generatedImagesDir: '<%= antrConfig.dist %>/images/generated'
        }
      },
      server: {
        options: {
          sourcemap: true
        }
      }
    },

    // Renames files for browser caching purposes
    filerev: {
      dist: {
        src: [
          '<%= antrConfig.dist %>/scripts/{,*/}*.js',
          '<%= antrConfig.dist %>/styles/{,*/}*.css',
          '<%= antrConfig.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}',
          '<%= antrConfig.dist %>/styles/fonts/*'
        ]
      }
    },

    // Reads HTML for usemin blocks to enable smart builds that automatically
    // concat, minify and revision files. Creates configurations in memory so
    // additional tasks can operate on them
    useminPrepare: {
      html: '<%= antrConfig.app %>/index.html',
      options: {
        dest: '<%= antrConfig.dist %>',
        flow: {
          html: {
            steps: {
              js: ['concat', 'uglifyjs'],
              css: ['cssmin']
            },
            post: {}
          }
        }
      }
    },

    // Performs rewrites based on filerev and the useminPrepare configuration
    usemin: {
      html: ['<%= antrConfig.dist %>/{,*/}*.html'],
      css: ['<%= antrConfig.dist %>/styles/{,*/}*.css'],
      js: ['<%= antrConfig.dist %>/scripts/{,*/}*.js'],
      options: {
        assetsDirs: [
          '<%= antrConfig.dist %>',
          '<%= antrConfig.dist %>/images',
          '<%= antrConfig.dist %>/styles'
        ],
        patterns: {
          js: [[/(images\/[^''""]*\.(png|jpg|jpeg|gif|webp|svg))/g, 'Replacing references to images']]
        }
      }
    },

    // The following *-min tasks will produce minified files in the dist folder
    // By default, your `index.html`'s <!-- Usemin block --> will take care of
    // minification. These next options are pre-configured if you do not wish
    // to use the Usemin blocks.
    cssmin: {
      dist: {
        files: {
          '<%= antrConfig.dist %>/styles/main.css': [
            '.tmp/styles/{,*/}*.css'
          ]
        }
      }
    },
    uglify: {
      dist: {
        files: {
          '<%= antrConfig.dist %>/scripts/scripts.js': [
            '<%= antrConfig.dist %>/scripts/scripts.js'
          ]
        }
      }
    },
    concat: {
      dist: {}
    },

    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= antrConfig.app %>/images',
          src: '{,*/}*.{png,jpg,jpeg,gif}',
          dest: '<%= antrConfig.dist %>/images'
        }]
      }
    },

    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= antrConfig.app %>/images',
          src: '{,*/}*.svg',
          dest: '<%= antrConfig.dist %>/images'
        }]
      }
    },

    htmlmin: {
      dist: {
        options: {
          collapseWhitespace: true,
          conservativeCollapse: true,
          collapseBooleanAttributes: true,
          removeCommentsFromCDATA: true
        },
        files: [{
          expand: true,
          cwd: '<%= antrConfig.dist %>',
          src: ['*.html'],
          dest: '<%= antrConfig.dist %>'
        }]
      }
    },

    ngtemplates: {
      dist: {
        options: {
          module: 'angularAntlrApp',
          htmlmin: '<%= htmlmin.dist.options %>',
          usemin: 'scripts/scripts.js'
        },
        cwd: '<%= antrConfig.app %>',
        src: 'views/{,*/}*.html',
        dest: '.tmp/templateCache.js'
      }
    },

    // ng-annotate tries to make the code safe for minification automatically
    // by using the Angular long form for dependency injection.
    ngAnnotate: {
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/concat/scripts',
          src: '*.js',
          dest: '.tmp/concat/scripts'
        }]
      }
    },

    // Replace Google CDN references
    cdnify: {
      dist: {
        html: ['<%= antrConfig.dist %>/*.html']
      }
    },

    // Copies remaining files to places other tasks can use
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= antrConfig.app %>',
          dest: '<%= antrConfig.dist %>',
          src: [
            '*.{ico,png,txt}',
            '*.html',
            'images/{,*/}*.{webp}',
            'styles/fonts/{,*/}*.*',
            'antlr/{,*/}*.*'
          ]
        },
         {
          expand: true,
          cwd: '.tmp/images',
          dest: '<%= antrConfig.dist %>/images',
          src: ['generated/*']
        }, {
          expand: true,
          cwd: '.',
          src: 'bower_components/bootstrap-sass-official/assets/fonts/bootstrap/*',
          dest: '<%= antrConfig.dist %>'
        }]
      },
      antlr4: {
        expand: true,
        cwd: 'node_modules/antlr4',
        dest: '<%= antrConfig.dist %>/bower_components/antlr4',
        src: '{,*/}*.*'
      },
      styles: {
        expand: true,
        cwd: '<%= antrConfig.app %>/styles',
        dest: '.tmp/styles/',
        src: '{,*/}*.css'
      }
    },

    // Run some tasks in parallel to speed up the build process
    concurrent: {
      server: [
        'compass:server'
      ],
      test: [
        'compass'
      ],
      dist: [
        'compass:dist',
        'imagemin',
        'svgmin'
      ]
    },

    // Test settings
    karma: {
      unit: {
        configFile: 'test/karma.conf.js',
        singleRun: true
      }
    },

    import_js: {
        files: {
          expand: true,
          cwd: 'node_modules/ebnf-parser',
          src: ['**/*.js'],
          dest: 'dist/exec/ebnf-parser/',
          ext: '.js'
        }
    },

    antlr4: {
      lexer: {
            grammar: '<%= antrConfig.app %>/g4/CommandLexer.g4', //path to your grammar definition
            options: {
                o: '<%= antrConfig.app %>/antlr', //output directory
                grammarLevel: {
                  language: 'JavaScript' //generated code language
                },
                flags: [
                    'visitor' //enable visitor generation

                ]
            }
        },
        parser: {
              grammar: '<%= antrConfig.app %>/g4/CommandParser.g4', //path to your grammar definition
              options: {
                  o: '<%= antrConfig.app %>/antlr', //output directory
                  lib: '<%= antrConfig.app %>/antlr',
                  grammarLevel: {
                    language: 'JavaScript' //generated code language
                  },
                  flags: [
                      'visitor' //enable visitor generation
                  ]
            }
        }
      },
      replace: {
        antl4syntax: {
          src: ['<%= antrConfig.app %>/antlr/CommandLexer.js'],             // source files array (supports minimatch)
          dest: '<%= antrConfig.app %>/antlr/',             // destination directory or file
          replacements: [{
            from: ' boolean ',                   // string replacement
            to: ' var '
          }]
        }
      },
      'jison-processor': {
        jison: {
            options: {
                output: 'app/ebnf/calculator.js',
                //grammar: 'app/ebnf/test-parser.json'
                grammar: 'app/ebnf/calculator.jison'
                // grammar: require('./test/calculator.js')
            },
            files: {
                'app/ebnf': 'app/ebnf/*.jison'
            }
        },
        // ebnf: {
        //     options: {
        //         output: 'app/ebnf/test/example.js',
        //         //grammar: 'app/ebnf/test-parser.json'
        //         grammar: 'app/ebnf/test/example.ebnf'
        //         // grammar: require('./test/calculator.js')
        //     },
        //     files: {
        //         'app/ebnf/test': 'app/ebnf/test/*.ebnf'
        //     }
        // }
    }
  });


  grunt.registerTask('serve', 'Compile then start a connect web server', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    grunt.task.run([
      'clean:server',
      'antl4dist',
      'wiredep',
      'concurrent:server',
      'postcss:server',
      'connect:livereload',
      'watch'
    ]);
  });

  // grunt.registerTask('ebnf-compile', '', function() {
  //   var ebnfParser = require('ebnf-parser/ebnf-parser');
  //
  //   var files = grunt.file.expand(['app/ebnf/example/**/*.ebnf']);
  //   if (files) {
  //     files.forEach(function(file) {
  //       grunt.log.writeln('source file : ' + file);
  //       if ( grunt.file.isFile(file) ) {
  //         var ebnfFile = grunt.file.read(file);
  //         if (ebnfFile) {
  //           var parsed = ebnfParser.parse(ebnfFile);
  //           //var parsed = ebnfParser.transform(ebnfFile);
  //           grunt.log.writeln('parsed file : ' + parsed);
  //         }
  //       }
  //     });
  //   }
  // });

  grunt.registerTask('ebnfier', ['jison-processor:ebnf']);

  grunt.registerTask('server', 'DEPRECATED TASK. Use the "serve" task instead', function (target) {
    grunt.log.warn('The `server` task has been deprecated. Use `grunt serve` to start a server.');
    grunt.task.run(['serve:' + target]);
  });

  grunt.registerTask('test', [
    'clean:server',
    'antl4dist',
    'jison-processor:jison',
    'wiredep',
    'concurrent:test',
    'postcss',
    'connect:test',
    'karma'
  ]);
  grunt.registerTask('antl4dist', [
    'antlr4:lexer',
    'replace:antl4syntax',
    'antlr4:parser'
  ]);
  grunt.registerTask('build', [
    'clean:dist',
    'antl4dist',
    'jison-processor:jison',
    'wiredep',
    'useminPrepare',
    'concurrent:dist',
    'postcss',
    'ngtemplates',
    'concat',
    'ngAnnotate',
    'copy:dist',
    'copy:antlr4',
    'cdnify',
    'cssmin',
    'uglify',
    'filerev',
    'usemin',
    'htmlmin'
  ]);

  grunt.registerTask('default', [
    'newer:jshint',
    'newer:jscs',
    'test',
    'build'
  ]);
};
