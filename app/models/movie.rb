class Movie < ApplicationRecord
  has_one_attached :image
  validates :title,
    presence: true, length: { maximum: 50 }
  validates :genre,
    presence: true, length: { maximum: 30 }
  validates :evaluation,
    presence: true, length: { minimum: 1, maximum: 5 }
  validates :is_delete,
    inclusion: { in: [true, false] }
  belongs_to :user
  
  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
