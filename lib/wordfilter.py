import os
import json
from warnings import warn

class Wordfilter:
    def __init__(self):
        # json is in same directory as this class, given by __location__.
        __location__ = os.path.realpath(
            os.path.join(os.getcwd(), os.path.dirname(__file__)))
        with open(os.path.join(__location__, 'badwords.json')) as f:
            self.blocklist = json.loads(f.read())

    def blocklisted(self, string):
        test_string = string.lower()
        return any(badword in test_string for badword in self.blocklist)

    def blacklisted(self, string):
        warn('The name of this function has changed to `blocklisted`. Please update your code accordingly.', DeprecationWarning, stacklevel=2)
        return self.blocklisted(self, string)

    def addWords(self, words):
        self.blocklist.extend([word.lower() for word in words])

    def removeWord(self, word):
        self.blocklist = [x for x in self.blocklist if x != word]

    def clearList(self):
        self.blocklist = []
