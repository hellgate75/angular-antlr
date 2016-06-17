// Bower Libs refs serves files under /bower_components, which is the basePath from bower's config file
// require.config({
//   // Bower Libs refs serves files under /bower_components, which is the basePath from bower's config file
//   baseUrl: '/bower_components',
//   paths: {
//     'antlr4' : './antlr4',
//     'ebnf-parser': './ebnf-parser'
//   }
// });

require.config({
    //Use node's special variable __dirname to
    //get the directory containing this file.
    //Useful if building a library that will
    //be used in node but does not require the
    //use of node outside
    baseUrl: '/bower_components',
    // map: {
    //   '*' : {
    //     'antlr4' : 'antlr4',
    //     'ebnf-parser' : 'ebnf-parser',
    //   },
    packages: [
      {
          name: 'antlr4',
          main: 'index'
      },
      {
          name: 'ebnf-parser',
          main: 'ebnf-parser'
      }
    ]
      // 'antlr4': {
      //   deps: ['antlr4/index'],
      //   exports: 'antlr4/index'
      // },
      // 'ebnf-parser': {
      //   deps: ['ebnf-parser/ebnf-parser'],
      //   exports: 'ebnf-parser/ebnf-parser'
      // }
    // },
});

// requirejs.config({
//     //Use node's special variable __dirname to
//     //get the directory containing this file.
//     //Useful if building a library that will
//     //be used in node but does not require the
//     //use of node outside
//     baseUrl: '/bower_components',
//     map: {
//       '*' : {
//         'antlr4' : 'antlr4',
//         'ebnf-parser' : 'ebnf-parser',
//       },
//     },
//     'antlr4': {
//       deps: ['antlr4/index'],
//       exports: 'antlr4/index'
//     },
//     'ebnf-parser': {
//       deps: ['ebnf-parser/ebnf-parser'],
//       exports: 'ebnf-parser/ebnf-parser'
//     },
//     //Pass the top-level main.js/index.js require
//     //function to requirejs so that node modules
//     //are loaded relative to the top-level JS file.
//     nodeRequire: require
// });
