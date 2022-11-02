hash = Hash.new(0)

# this is all words following one specific word, not the entire hash
def normalize(hashOfWords) 
	tot = 0.0 # force to float
	hashOfWords.each{|k, v| tot += v}
	hashOfWords.each{|k, v| hashOfWords[k] /= tot}
	puts hashOfWords
end

def buildChain
File.readlines("test.txt").each do |line|
	words = line.split
	words.each_with_index do |word, idx|
		if(idx < words.length - 1) 
			hash[word] = Hash.new(0) if hash[word] == 0
			hash[word][words[idx + 1]] += 1
		end
	end
end

hash.each{|k, v| normalize v}
