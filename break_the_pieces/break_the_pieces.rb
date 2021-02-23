def break_pieces(shape)
  distinct_shapes = []
  extraction_lines = {}
  puts shape#ddddddddddddddddddddd
  shape_lines = shape.split("\n")
  shape_lines.each_with_index do |line, idx|
    extraction_points = find_extraction_points(line)
    extraction_lines[idx] = extraction_points if extraction_points 
  end
  pieces = cut_in_pieces(shape_lines, distinct_pieces(shape_lines, extraction_lines))
  return pieces unless pieces.empty?
  shape 
end

def find_extraction_points(line) 
  return unless line.strip[0] == '+' && line.strip[-1] == '+' # don't bother calculating extraction points if there aren't any
  extraction_indexes, extraction_points = [], []
  line.chars.each_with_index { |sign, idx| extraction_indexes << idx if sign == '+' } # get indexes for each "+" sign
  extraction_indexes.each_with_index do |element, idx| 
     extraction_points += [element].product(extraction_indexes[idx+1..-1]) # create pairs of extractions points ex. [[0,7], [0,13]] from [0,7,13] ary
  end
  extraction_points
end

def distinct_pieces(shape_lines, extraction_lines) # returns hash that has line range for its keys and extraction points for its values
  pairs = Hash.new([])
  extraction_lines.each do |hash_key, hash_val|
    hash_val.each do |value| 
      next if value == [] # value == [] when it has been deleted before
      pair_key = find_pair(hash_key, value, extraction_lines)
      next if pair_key == [] # if there is no pair, go to the next iteration
      pairs[[hash_key, pair_key]] += [value]
      alter_array = ->(ary_element) { ary_element == value ? [] : ary_element } # this is lambda
      extraction_lines[hash_key].map!{ |el| alter_array.call(el) } # we can't just delete the value from array because it would alter the array and thus each loop wouldn't work correctly
      extraction_lines[pair_key].map!{ |el| alter_array.call(el) } 
    end
  end
  pairs
end

def find_pair(single_value_key, single_value, hash)
  pair = []
  hash.each{ |hash_key, hash_val| pair << hash_key unless hash_val.select{ |value| value == single_value && hash_key != single_value_key }.empty? } # select key from hash if found second value that isn't SINGLE VALUE and is inside of the current key's values 
  pair.first || [] # if there is no pair, return [] 
end

def cut_in_pieces(shape_lines, points_pairs)
  temp = []
  points_pairs.each do |line_idxs, ext_points|
    ext_points.each { |points| temp << get_extracted_lines(line_idxs, points, shape_lines) }
  end
  temp
end

def get_extracted_lines(line_idxs, points, lines)
  piece = ""
  lines[line_idxs[0]..line_idxs[-1]].each_with_index do |line, idx| 
    new_line = line[points[0]..points[-1]] 
    piece += "#{new_line[0]}#{new_line[1..-2].gsub("+", "-")}#{new_line[-1]}" # this is really ugly and i should probably use regex to delete the + inside the string except first and last element
    piece += "\n" if idx != lines[line_idxs[0]..line_idxs[-1]].length - 1
  end
  piece
end