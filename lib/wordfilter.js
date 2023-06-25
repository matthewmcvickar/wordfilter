/*
 * wordfilter
 * https://github.com/dariusk/wordfilter
 *
 * Copyright (c) 2013 Darius Kazemi
 * Licensed under the MIT license.
 */

'use strict';

var blocklist, regex;

function rebuild() {
  regex = new RegExp(blocklist.join('|'), 'i');
}

blocklist = require('./badwords.json');
rebuild();

module.exports = {
  blocklisted: function(string) {
    return !!blocklist.length && regex.test(string);
  },
  blacklisted: function(string) {
    console.warn('The name of this function has changed to `blocklisted`. Please update your code accordingly.');
    return this.blocklisted(string);
  },
  addWords: function(array) {
    blocklist = blocklist.concat(array);
    rebuild();
  },
  removeWord: function(word) {
    var index = blocklist.indexOf(word);
    if (index > -1) {
      blocklist.splice(index, 1);
      rebuild();
    }
  },
  clearList: function() {
    blocklist = [];
    rebuild();
  },
};
