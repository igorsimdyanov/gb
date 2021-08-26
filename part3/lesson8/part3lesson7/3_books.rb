# frozen_string_literal: true

authors = {
  'Design Patterns in Ruby' => ['Russ Olsen'],
  'Eloquent Ruby' => ['Russ Olsen'],
  'The Well-Grounded Rubyist' => ['David A. Black'],
  'The Ruby Programming Language' => ['David Flanagan', 'Yukihiro Matsumoto'],
  'Metaprogramming Ruby 2' => ['Paolo Perrotta'],
  'Ruby Cookbook' => ['Lucas Carlson', 'Leonard Richardson'],
  'Ruby Under a Microscope' => ['Pat Shaughnessy'],
  'Ruby Performance Optimization' => ['Alexander Dymo'],
  'The Ruby Way' => ['Hal Fulton', 'Andre Arko']
}

books = authors.each_with_object(Hash.new { |h, k| h[k] = [] }) do |(book, athrs), list|
  athrs.each { |author| list[author] << book }
end

max = books.max_by { |_a, b| b.size }.last.count
p books.sort_by { |_a, b| max - b.size }.to_h.map { |ath, bks| [ath, bks.size] }.to_h
