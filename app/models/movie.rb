class Movie < ApplicationRecord
  has_one_attached :image
  validates :title,
    presence: true
  validates :genre,
    presence: true
  validates :evaluation,
    presence: true, length: { minimum: 0, maximum: 5 }
  validates :is_delete,
    inclusion: { in: [true, false] }
  belongs_to :user
end
