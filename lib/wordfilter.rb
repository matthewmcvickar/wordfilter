require 'json'

module Wordfilter
	BadWordsFileName = File.dirname(__FILE__) + "/badwords.json";
	@@blocklist = nil

	def self.init_first_time
		return if(!@@blocklist.nil?)
		self.init
	end

	def self.init
		badwords_file = File.read(BadWordsFileName);
		@@blocklist = JSON.parse(badwords_file);
	end

	def self.blocklisted? string
		self.init_first_time

		string_to_test = string.downcase
		@@blocklist.map!{|badword| badword.downcase}

		@@blocklist.each{|word|
			return true if string_to_test.include? word
		}

		return false
	end

  def self.blacklisted? string
    warn "The name of this function has changed to `blocklisted`. Please update your code accordingly."
    blacklisted(string)
  end

	def self.add_words words
		self.init_first_time
		@@blocklist += words
	end

	def self.clear_list
		@@blocklist = []
	end
end
