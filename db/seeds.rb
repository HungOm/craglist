
categories = [ "automotive services","beauty services","cell phone/mobil services","jobs","computer services"]

categories.each do |category|
    category = Category.create(category_title:category)
end