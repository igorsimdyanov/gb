# frozen_string_literal: true

class Integer
  TO_BYTES = 2**10
  def kilobytes
    self * TO_BYTES
  end

  def megabytes
    kilobytes * TO_BYTES
  end

  def gigabytes
    megabytes * TO_BYTES
  end

  def terabytes
    gigabytes * TO_BYTES
  end
end
