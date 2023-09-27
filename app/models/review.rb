class Review < ApplicationRecord
  STARS = [1,2,3,4,5]

  validates :name, presence: true
  validates :comment, length: {minimum: 4}
  validates :stars, inclussion: {
                                  in: STARS
                                  message: "Must be between 1 and 5"
                                }

  belongs_to :movie

end
