class Book < ApplicationRecord
	 belongs_to :user

	 has_many :favorites, dependent: :destroy
	 has_many :book_comments, dependent: :destroy

	 def favorited_by?(user)
	 	favorites.where(user_id: user.id).exists?
	 end

	 # 下記追加（favoritesテーブルを通って、userモデルのデータを持ってくるって意味？？）
	 has_many :favorited_users, through: :favorites, source: :user

  # ================ 検索機能 ================
  def self.search(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_march"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
  # ================ 検索機能 ================



	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	validates :rate, presence: true

end
