class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items

	enum delivery_status:{prepare:1,sent:2,complete:3}

	#enum日本語表示のためのクラスメソッド
	class << self
		def localed_statuses
			statuses.keys.map do |s|
				[ApplicationController.helpers.t("order.delivery_status.#{s}"),s]
			end
		end
	end

end
