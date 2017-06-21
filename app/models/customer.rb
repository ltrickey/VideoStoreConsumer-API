class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  def movies_checked_out_count
    self.rentals.where(returned: false).length
  end

  # def current_movies
  #   return self.movies
  # end

  def current_rentals
    return self.rentals, self.movies
  end
end
