require 'jumpstart_auth'

class MicroBlogger 
	attr_reader :client

	def initialize 
		puts "Initializing..."
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			puts "message is to long ya noob"
		end
	end

	def dm(target, message)
		screen_names = @client .followers.collect { |follower| @client.user(follower).screen_name}
		puts "Trying to send #{target} this direct message"
		puts message
		message = "d @#{target} #{message}"
		screen_names.each do |screen_name|
			if screen_name == target 
				tweet(message)
			end
		end
	end

	def run
		puts "welcome to the DJD twitter client for Spamy McSpamface"
		command = ""
		while command != "q"
			printf "Enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
				when 'q' then puts "Client Terminated"
				when 't' then tweet(parts[1..-1].join(" "))
				when 'dm' then dm(parts[1], parts[2..-1].join(" "))
				else
					puts "Error command #{command} not recognized...sorry"
			end
		end
	end
end

blogger = MicroBlogger.new
blogger.run