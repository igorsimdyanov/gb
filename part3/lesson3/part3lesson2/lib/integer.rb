# frozen_string_literal: true

# Open standart Integer class
class Integer
  TO_BYTES = 1024

  def kilobytes
    self * TO_BYTES
  end

  def to_kilobytes
    self / TO_BYTES
  end

  def megabytes
    kilobytes * TO_BYTES
  end

  def to_megabytes
    to_kilobytes / TO_BYTES
  end

  def gigabytes
    megabytes * TO_BYTES
  end

  def to_gigabytes
    to_megabytes / TO_BYTES
  end

  def terabytes
    gigabytes * TO_BYTES
  end

  def to_terabytes
    to_gigabytes / TO_BYTES
  end

  def human_size
    if self < 1.kilobytes then format('%d', self)
    elsif self < 1.megabytes then format('%d K', to_kilobytes)
    elsif self < 1.gigabytes then format('%d M', to_megabytes)
    elsif self < 1.terabytes then format('%d G', to_gigabytes)
    else
      format('%d T', to_terabytes)
    end
  end
end
