class Movie < ApplicationRecord

  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25}
  validates :total_gross, numericality: {gretater_or_equal_to: 0}
  validates :image_file_name, format: {
                                with: /\w+\.(jpg|png)\z/i,
                                message: "must be a JPG or PNG image"
  }
  RATINGS = %w(G PG PG-13 R NC-17)

  validates :rating, inclusion: { in: RATINGS}
  # validates :slug, presence: true, uniqueness: true

  scope :released, -> { where("released_on < ?", Time.now).order("released_on asc") }
  scope :upcoming, ->  { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, ->(max= 5) { released.limit(max)}


  def flop?
    total_gross.blank? || total_gross < 25_000_000
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def to_param
    self.slug
  end

private

  def set_slug
    slug = title.parameterize
  end

end
