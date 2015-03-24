class Wiki < ActiveRecord::Base
  belongs_to :user

  def self.visible_to(user)
    where(private: true)
  end


end
