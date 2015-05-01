# HL7-ML-Classifier
by @jeffcouch
Machine Learning - Public Health Data Classifier

The ruby application is a composite of HL7 data parsing, machine learling classification algorithm implementation, utlized by training and classification functions.

Required
ruby-hl7 and classifier ruby gems are required for this project with source included for build and compilation.

Application Implemenation
ruby-hl7
	ruby-hl7 can be implemented as included, or sourced from github at: https://github.com/ruby-hl7/ruby-hl7.git.  One modification required for this project includes making empty HL7 segments optional and required a modification of lib/ruby-hl7.rb as follows:
		module HL7 # :nodoc:
  		VERSION = '1.1.0'
  		def self.ParserConfig
    		@parser_cfg ||= { :empty_segment_is_error => false }
  		end
  	Which differs from the standard gem configuration where :empty_segment_is_error is set to true.  This setting can cause NIST and other corpus data sets to fail parsing into HL7 objects, and therefore requires modification.

classifier
	A general classifier module to allow Bayesian and other types of classifications.  Built from source located at:  https://rubygems.org/gems/classifier/versions/1.3.4

test_data
	Corpus data for this machine learning excercise were gathered from the National Institute of Standards and Technology for public health implementation of meaningful use data for Electronic Laboratory Report and Syndromic Surveillance.  Data gathered are available at:
	http://hl7v2-elr-testing.nist.gov/mu-elr/
	http://hl7v2-ss-testing.nist.gov/mu-syndromic/


hl7_classifier.rb
	Project source that requires ruby-hl7, classifier, and test_data for execution.  


