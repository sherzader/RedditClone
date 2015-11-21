# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validate :ensure_sub_tags

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id

  has_many :post_subs,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id

  has_many :subs,
    through: :post_subs,
    source: :sub

  def ensure_sub_tags
    if self.sub_ids.empty? || self.sub_ids == [""]
      errors[:sub_ids] = ["No Sub-Reddit Tags"]
    end
  end
end
