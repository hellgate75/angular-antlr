require.config({
  baseUrl: '/bower_components',
  shim: {

  },
  paths: {
    'antlr4': 'antlr4',
    'ebnf-parser': 'ebnf-parser',
    'requirejs': 'requirejs/require'
  },
  packages: [
    {
      name: 'antlr4',
      main: 'index'
    }
  ]
});
var exports = function() {};
