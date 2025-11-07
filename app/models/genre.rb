class Genre < ApplicationRecord
  #:genre ::= nombre del género musical
  validates :genre, presence: true
end
