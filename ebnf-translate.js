var bnf = require("ebnf-parser/ebnf-parser"),
    ebnf = require("ebnf-parser/ebnf-transform");

function parseEbnf(top, strings) {
    return function() {
        var expected = {
            "bnf": ebnf.transform({"top": [top]})
        };
        var grammar = "%ebnf\n%%\ntop : "+top+";";
    };
}

// var tests = {
//     "test idempotent transform": function() {
//         var first = {
//             "nodelist": [["", "$$ = [];"], ["nodelist node", "$1.push($2);"]]
//         };
//         var second = ebnf.transform(JSON.parse(JSON.stringify(first)));
//         assert.deepEqual(second, first);
//     },
//     "test repeat (*) on empty string": parseEbnf("word* EOF", ""),
//     "test repeat (*) on single word": parseEbnf("word* EOF", "oneword"),
//     "test repeat (*) on multiple words": parseEbnf("word* EOF", "multiple words"),
//     "test repeat (+) on single word": parseEbnf("word+ EOF", "oneword"),
//     "test repeat (+) on multiple words": parseEbnf("word+ EOF", "multiple words"),
//     "test option (?) on empty string": parseEbnf("word? EOF", ""),
//     "test option (?) on single word": parseEbnf("word? EOF", "oneword"),
//     "test group () on simple phrase": parseEbnf("(word word) EOF", "two words"),
//     "test group () with multiple options on first option": parseEbnf("((word word) | word) EOF", "hi there"),
//     "test group () with multiple options on second option": parseEbnf("((word word) | word) EOF", "hi"),
//     "test complex expression ( *, ?, () )": parseEbnf("(word (',' word)*)? EOF", ["", "hi", "hi, there"])
// };
//
// for (var test in tests) {
//     exports[test] = tests[test];
// }
