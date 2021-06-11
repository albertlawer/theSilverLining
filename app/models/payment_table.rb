class PaymentTable < ActiveRecord::Base
  	belongs_to :a_user, class_name: "User", foreign_key: :user_id
  	belongs_to :a_ref, class_name: "User", foreign_key: :referer_user_id
end
