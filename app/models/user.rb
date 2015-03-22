class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

#This was created by calling 'rails g devise User' - we used that to create a USer calss that was devise aware and would tie into all of the devise create user authentication views