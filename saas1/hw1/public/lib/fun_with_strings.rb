module FunWithStrings
  def palindrome?
    s = self.gsub(/\W/,'').downcase
    s == s.reverse
  end

  def count_words
     s = self.downcase.split
     count = Hash.new
     s.each { |word|
        word.gsub!(/\W/,'')
        if word.length > 0
          wcnt = count[word]
          count[word] = wcnt == nil ? 1 : wcnt+1
        end
     }

    return count
  end

  def anagram_groups
    sp = self.split
    groups = Hash.new
    sp.each { |word|
    hkey = word.downcase.split(//).sort.join
    group = groups[hkey]
    groups[hkey] = group == nil ? [word] : group << word
    }

    grp_array = []
    groups.each { |gkey, group| grp_array << group }
    return grp_array
  end

end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end