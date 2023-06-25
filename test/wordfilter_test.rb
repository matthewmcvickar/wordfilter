$:.unshift(File.dirname(__FILE__) + '/../lib/')

require 'test/unit'
require 'wordfilter'

class WordfilterTest < Test::Unit::TestCase

	def setup
		super
		Wordfilter.init
	end

	def test_detects_bad_words_in_a_string
		assert(Wordfilter::blocklisted?("this string contains the word skank"), "Failed to mark a bad string as bad.");
		assert(Wordfilter::blocklisted?("this string contains the word SkAnK"), "Failed to mark a bad string as bad.");
		refute(Wordfilter::blocklisted?("this string was clean!"), "Failed to allow a non-bad string.");
	end

	def test_add_word_to_blocklist
		Wordfilter::add_words(['clean']);
		assert(Wordfilter::blocklisted?("this string was clean!"), "Failed to blocklist a string containing a new bad word.");
	end

	def test_added_words_checked_case_insensitively
		Wordfilter::add_words(['CLEAN']);
		assert(Wordfilter::blocklisted?("this string was clean!"), "Failed to blocklist a string containing a new bad word because of casing differences.");
	end

	def test_clear_blocklist
		Wordfilter::clear_list
		refute(Wordfilter::blocklisted?("this string contains the word skank"), "Cleared word list still blocklisting strings.");
		Wordfilter::add_words(['skank']);
		assert(Wordfilter::blocklisted?("this string contains the word skank"), "Failed to blocklist a string containing a new bad word.");
	end
end
