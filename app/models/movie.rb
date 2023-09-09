class Movie < ApplicationRecord

  def self.released
    where("released_on < ?", Time.now).
      order("released_on asc")
  end


  def flop?
    total_gross.blank? || total_gross < 25_000_000
  end
end
