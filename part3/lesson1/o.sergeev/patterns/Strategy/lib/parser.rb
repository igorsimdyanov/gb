# frozen_string_literal: true

# class Parser
class Parser
  attr_writer :new_job

  def initialize(new_job)
    @new_job = new_job
  end

  def job=(new_job)
    @new_job = new_job
  end

  def parse(data)
    @new_job.algorithm(data)
  end

  def self.number?(str)
    Float(str)
  rescue StandardError # StandardError => e # puts "Rescued: #{e.inspect}"
    # 'This is a string'
  else
    true
  end
end

# class Job
class Job
  def algorithm(_data)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# class PriceParsing
class PriceParsing < Job
  def algorithm(data)
    res = []
    arr = data.split(',').map { |str| str.split(' ') }
    arr.each do |array|
      array.each do |word|
        res.push(array.join(' ')) if Parser.number?(word)
      end
    end
    res
  end
end

# class NewsParsing
class NewsParsing < Job
  def algorithm(data)
    data.split('.').select { |word| word if word.include?('новост') }
  end
end
