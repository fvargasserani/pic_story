class Story < ApplicationRecord
    belongs_to :user, :foreign_key => 'name'
    validates :title, :picture, :content, presence: true
end
