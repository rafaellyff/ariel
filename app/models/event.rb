class Event < ApplicationRecord
    validates_presence_of :name, :scheduled_date, :user_id
end
