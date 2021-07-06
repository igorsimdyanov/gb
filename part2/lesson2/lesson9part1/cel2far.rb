# frozen_string_literal: true

def cel2far(cel) = cel * 1.8 + 32

def far2cel(far) = (far - 32) / 1.8

puts cel2far(100)
puts far2cel(212)
