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
  
  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
