
require 'rubygems'
require 'ruby-hl7'
require 'classifier'

require 'madeleine'
m = SnapshotMadeleine.new("bayes_data") {
    Classifier::Bayes.new 'ELR', 'SS'
}

Dir.glob('test_data/ELR*.txt') do |elr_file|
  # do work on elr files 
  	raw_input = open("#{elr_file}").readlines
    msg = HL7::Message.new( raw_input )

    message_properties = ""
	message_properties << msg[:MSH].version_id
	message_properties << " "
	message_properties << msg[:MSH].message_type
	message_properties << " "


	$i=0
	while $i < msg.length  do
		segment = msg[$i].e0
		message_properties << segment
		message_properties << " "
		if segment == "OBR"
			message_properties << msg[$i].e4
			message_properties << " "
		elsif segment == "OBX"
			message_properties << msg[$i].e3
			message_properties << " "
		end
		$i+=1

	end
	
	#message_properties << msg.to_s
	m.system.train :ELR, message_properties

	puts message_properties
    
end

Dir.glob('test_data/SS*.txt') do |ss_file|
  # do work on syndromic files 

  	raw_input = open("#{ss_file}").readlines
    msg = HL7::Message.new( raw_input )

    message_properties = ""
	message_properties << msg[:MSH].version_id
	message_properties << " "
	message_properties << msg[:MSH].message_type
	message_properties << " "


	$i=0
	while $i < msg.length  do
		segment = msg[$i].e0
		message_properties << segment
		message_properties << " "
		if segment == "OBR"
			message_properties << msg[$i].e4
			message_properties << " "
		elsif segment == "OBX"
			message_properties << msg[$i].e3
			message_properties << " "
		end
		
		$i+=1

	end
	#message_properties << msg.to_s
	m.system.train :SS, message_properties

	puts message_properties
    
end

Dir.glob('test_data/UNK*.txt') do |unk_file|
  # do work on syndromic files 

    raw_input = open("#{unk_file}").readlines
    msg = HL7::Message.new( raw_input )

    message_properties = ""
	message_properties << msg[:MSH].version_id
	message_properties << " "
	message_properties << msg[:MSH].message_type
	message_properties << " "


	$i=0
	while $i < msg.length  do
		segment = msg[$i].e0
		message_properties << segment
		message_properties << " "
		if segment == "OBR"
			message_properties << msg[$i].e4
			message_properties << " "
		elsif segment == "OBX"
			message_properties << msg[$i].e3
			message_properties << " "
		end
		$i+=1

	end

	#message_properties << msg.to_s
	classification = m.system.classify message_properties
	class_certainty = m.system.classifications message_properties
	puts "#{unk_file} is #{classification}, with a certainty of #{class_certainty}"
	puts message_properties
    
end



