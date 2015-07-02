# encoding: UTF-8
class Snippet < ActiveRecord::Base

  validates :description, presence: true

  scope :without_private_snippet, -> { where(is_private: false) }

  paginates_per 20

  def self.search(q)
    where('description like ?', "%#{q}%")
  end

end
