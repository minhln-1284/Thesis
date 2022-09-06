module RatingsHelper
  def build_rating
    @review = current_user.ratings.build
  end
end
