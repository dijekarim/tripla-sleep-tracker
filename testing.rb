def find_missing_array(arr)
  arr.sort!
  arr.each_with_index do |num, index|
    if num != index + 1
      return index + 1
    end
  end
  return arr[arr.length - 1] + 1
end

def check_anagram(str1, str2)
  return false if str1.length != str2.length
  str1.chars.sort == str2.chars.sort
end

def check_isomorphic(str1, str2)
  return false if str1.length != str2.length
  map_str1 = {}
  map_str2 = {}
  print "str1, str2: #{str1}, #{str2} => "
  str1.chars.zip(str2.chars).each do |char1, char2|
    if map_str1[char1] && map_str1[char1] != char2
      return false
    end

    if map_str2[char2] && map_str2[char2] != char1
      return false
    end

    map_str1[char1] = char2
    map_str2[char2] = char1
  end
  return true
end

# MISSING NUMBER
p find_missing_array([2])

# ANAGRAM
p "ANAGRAM"
p check_anagram("geeks", "kseeg")
p check_anagram("allergy", "allergic")
p check_anagram("g", "g")
p check_anagram("geeks", "ksee")

# ISOMORPHIC
p "ISOMORPHIC"
p check_isomorphic("aab", "xxy")
p check_isomorphic("aab", "xyz")
p check_isomorphic("aac", "xyz")
p check_isomorphic("aab", "xyx")