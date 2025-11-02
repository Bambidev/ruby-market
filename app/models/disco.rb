# This file creates a class that uses Active Record for interacting with our products database table.
class Disco < ApplicationRecord
  # Let's add a presence validation to the Product model to ensure that all products must have a name.
  validates :titulo, presence: true
end
