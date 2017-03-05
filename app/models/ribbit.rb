class Ribbit < ApplicationRecord

  default_scope order: 'createat DESC'
  belongs_to :user

  validates :content, length: {maximum: 140}

end
