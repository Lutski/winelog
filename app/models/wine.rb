class Wine < ActiveRecord::Base
  has_attached_file :image, styles: { large: "1000x1000>", medium: "600x600>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :user
end
