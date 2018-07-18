class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items

	#ラジオボタンで選択するのでenumでない方が良さそう。
	# enum payment_method:{cash:1,bank:2}
	enum delivery_time:{am:1,pm:2,night:3}
	enum delivery_status:{prepare:1,sent:2,complete:3}
	# enum delivery_address:{default:1,second:2,third:3}

	#enum日本語表示のためのクラスメソッド
	class << self
		def localed_statuses
			statuses.keys.map do |s|
				[ApplicationController.helpers.t("order.delivery_status.#{s}"),s]
			end
		end
	end

	# class << self
	# 	def localed_delivery_times
	# 		delivery_times.keys.map do |s|
	# 			[ApplicationController.helpers.t("order.delivery_status.#{s}"),s]
	# 		end
	# 	end
	# end

end
