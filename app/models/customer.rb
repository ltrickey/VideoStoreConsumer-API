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
    # can I just change this to add the attribute title to rentals?
    return self.rentals.where(returned: false), self.movies
  end
end
