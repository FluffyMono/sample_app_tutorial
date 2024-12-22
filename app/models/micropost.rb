class Micropost < ApplicationRecord
  belongs_to :user
  #表示用のリサイズ済み画像を追加する
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  #rails active_storage:install db:migrate でファイルアップロードを実装
  has_one_attached :image
  default_scope -> { order(created_at: :desc) } # SQLの降順（descending）
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  #画像バリデーションを追加 with active storage validation gem
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
  message: "must be a valid image format" }, size:         { less_than: 5.megabytes,
  message:   "should be less than 5MB" }
end
