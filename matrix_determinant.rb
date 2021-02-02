def determinant(matrix)
  return matrix.flatten.first if matrix.length == 1
  return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0] if matrix.length == 2
  sum = 0
  matrix.shift.each_with_index do |num, idx|
    num_minor = matrix.map{ |row| row.reject.with_index{ |num, i| i == idx } }
    sum += num * determinant(num_minor) if idx.even?
    sum -= num * determinant(num_minor) if idx.odd?
  end
  sum
end
