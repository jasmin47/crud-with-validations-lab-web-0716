class Song < ActiveRecord::Base
#define error messages here
validates :title, presence: true
validates :artist_name, presence: true
#validate :current_year_released

validates :title, uniqueness: {
    scope: [:release_year, :artist_name],
    message: "Song cannot be repeated by artist in same year."
  }
validates :released, inclusion: { in: [true, false] }

with_options if: :should_confirm? do |song|
  song.validates :release_year, presence: true
  song.validates :release_year, numericality: {
    less_than_or_equal_to: Date.today.year
  }
end

def should_confirm?
  self.released == true
end

# def current_year_released
#   current_year = Date.today.year
#   input = self.release_year
#     if self.released == true && input.nil?
#       errors.add(:release_year, "Must contain year.")
#     elsif input > current_year
#     errors.add(:release_year, "Must be current year.")
#   end
# end

end
