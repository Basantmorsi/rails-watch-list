class Movie < ApplicationRecord
  has_many :bookmarks
  validates :title, presence: true ,uniqueness: true
  validates :overview, presence: true
  # before_destroy :check_for_bookmarks

  # private

  # def check_for_bookmarks
  #   if !bookmarks.empty?
  #     errors.add_to_base("cannot delete movie while it is referenced in at least one bookmark")
  #     return false
  #   end
  # end
end
