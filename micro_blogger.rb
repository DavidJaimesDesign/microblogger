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

	def run
		puts "welcome to the DJD twitter client for Spamy McSpamface"
		case command
			when 'q' then puts "Client Terminated"
			else
				puts "Error command #{command} not recognized...sorry"
		end
		while command != "q"
			printf "Enter command: "
			command = gets.chomp
		end
	end
end

blogger = MicroBlogger.new
blogger.run