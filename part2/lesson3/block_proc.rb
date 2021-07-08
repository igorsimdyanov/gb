def greeting(&proc)
  proc.call 'Ruby'
end

greeting { |name| puts "Hello, #{name}!" }
