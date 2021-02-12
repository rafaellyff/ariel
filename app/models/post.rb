class Post < ApplicationRecord
    validates_presence_of :title, :text
    validates :text, length: { minimum: 150 }
end
