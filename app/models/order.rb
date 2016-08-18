# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  seller_id     :integer
#  client_id     :integer
#  payd          :boolean
#  from_store_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  full_cost     :float            default("0.0")
#  complete      :boolean
#  slug          :string
#  name          :string
#  mobile        :string
#  comment       :text
#  familija      :string
#  otchestvo     :string
#  email         :string
#  gorod         :string
#  ulica         :string
#  dom           :string
#  korpus        :integer
#  kv            :integer
#  postal_index  :string
#  tip_dostavki  :string
#  tip_oplaty    :string
#

class Order < ApplicationRecord

  belongs_to :seller, class_name: "User"
  belongs_to :client, class_name: "User", required: false
  belongs_to :from_store, class_name: "Store"
  default_scope { order('id DESC') }

  has_many :lineitems, class_name: "OrderLineitem", dependent: :destroy

  HUMANIZED_ATTRIBUTES = {
    :email => "E-mail",
    :mobile => "Телефон",
    :tip_oplaty => "Тип оплаты",
    :tip_dostavki => "Тип доставки"
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
