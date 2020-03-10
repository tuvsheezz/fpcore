Currency.create (
	[
		{name: "Төгрөг", currency_name: "tugrug"},
		{name: "Доллар", currency_name: "dollar"},
		{name: "Юань",  currency_name: "yuan"}
	]
)

Status.create (
	[
		{mn: "Идэвхтэй", en: "idevhtei"},
		{mn: "Идэвхгүй", en: "idevhgui"}
	]
)

Salestatus.create (
	[
		{mn: "Зээл", en: "zeel"},
		{mn: "Бэлэн", en: "belen"},
		{mn: "Карт", en: "card"},
		{mn: "Мобайл", en: "mobile"},
		{mn: "Дансаар", en: "dansaar"}
	]
)

Role.create (
	[
		{en: "admin", mn: "Админ"},
		{en: "nyarav", mn: "Нярав"},
		{en: "nyabo", mn: "Нягтлан"},
		{en: "seller", mn: "Худалдагч"},
		{en: "member", mn: "Гишүүн"},
		{en: "fired", mn: "Ажлаас гарсан"}
	]
)

User.create (
	[
		{name: "Oyun N", phone: 99257076, phone2: 99257076, address: "Delhii", email: "admin@admin.com", password: "123456", branch_id: 0, role_id: 1}
	]
)

# iiii = 0
#
# (1..100).each do
# 	iiii += 1
# 	Rateyuan.create(rate: iiii, user_id: 1)
# 	Rateyuan.create(rate: iiii, user_id: 1)
# end
#
# 1.upto(6) do |i|
# 	Category.create(name: "cat-" + i.to_s)
# 	1.upto(6) do |j|
# 		Subcategory.create(name: "subcat-" + i.to_s + "-" + j.to_s, category_id: i)
# 	end
# end
#
#
# 1.upto(5) do |i|
# 	Branch.create(name: "bra-" + i.to_s)
# end
