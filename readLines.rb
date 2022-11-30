hash = Hash.new(0)

# normalize probabilities of all words that follow one specific word
def normalize(hashOfWords) 
	tot = 0.0 # force to float
	hashOfWords.each{|k, v| tot += v}
	hashOfWords.each{|k, v| hashOfWords[k] /= tot}
end

def weighted_choice(value, individualWordHash)
	lower_limit = 0
	individualWordHash.each do |k, v|
		return k if value.between?(lower_limit, lower_limit + v)
		lower_limit += v
	end
end

# Go through every file in the input directory word by word
# For each word, create a hash of every word that comes after it
# If a word already exists in this sub-hash, then increment the number of times we've seen it
def build_chain(inp_dir, hash)
	Dir.each_child(inp_dir) do |inp|
		File.readlines("#{inp_dir}/#{inp}").each do |line|
			words = line.split
			words.each_with_index do |word, idx|
				if(idx < words.length - 1) 
					hash[word] = Hash.new(0) if hash[word] == 0
					hash[word][words[idx + 1]] += 1
				end
			end
		end
	end
end

def generate_text(hash)
	# pick a random first word
	current_word = hash.keys[rand(hash.keys.length - 1)]
	puts(hash[95])
	while(1) 
		puts current_word	
		current_word = weighted_choice(rand(), hash[current_word])
	end
end

build_chain("./inputs", hash)

hash.each{|k, v| normalize v}

generate_text(hash)

