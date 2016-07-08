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
		screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name}
		puts "Trying to send #{target} this direct message"
		puts message
		message = "d @#{target} #{message}"
		screen_names.each do |screen_name|
			if screen_name == target 
				tweet(message)
			else
				puts "they are not yer friends"
			end
		end
	end

	def followers_list
		screen_names = Array.new
		@client.followers.collect do |follower|
			screen_names << @client.user(follower).screen_name
		end
		screen_names
	end

	def spam_my_followers(message)
		puts "Trying to send all followers this direct message"
		puts message
		followers_list.each do |follower|
			message = "d @#{follower} #{message}"
			tweet(message)
		end
	end

	def everyones_last_tweet
		friends = @client.friends
		friends.each do |friend|
			puts ""
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
				when 'spam' then spam_my_followers(parts[1..-1].join(" "))
				when 'elt' then everyones_last_tweet
				else
					puts "Error command #{command} not recognized...sorry"
			end
		end
	end
end

blogger = MicroBlogger.new
blogger.run