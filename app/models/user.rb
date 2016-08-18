# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :integer
#  slug                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

class User < ApplicationRecord

  has_many :orders, class_name: "Order", foreign_key: "client_id"
	belongs_to :role
  before_validation :set_default_role

  before_destroy :custom_delete

  default_scope { order("id ASC") }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  def root?
    self.role.name == "root"
  end
  def seller?
    self.role.name == "seller"
  end
  def client?
    self.role.name == "client"
  end
  private
	  def set_default_role
	    self.role_id ||= Role.find_by_name('client').id
	  end

    def custom_delete
      self.update_attributes(deleted: true)
      false
    end
end
