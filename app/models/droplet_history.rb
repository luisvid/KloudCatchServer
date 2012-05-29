class DropletHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :status
  belongs_to :droplet
end
