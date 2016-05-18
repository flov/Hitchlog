class FixGenderData < ActiveRecord::Migration
  def change
    User.where(gender: 'masculino').each { |user| user.gender = 'male'; user.save! }
    User.where(gender: 'weiblich').each { |user| user.gender = 'female'; user.save! }
    User.where(gender: 'feminino').each { |user| user.gender = 'female'; user.save! }
    User.where(gender: 'männlich').each { |user| user.gender = 'male'; user.save! }
    User.where(gender: 'homme').each { |user| user.gender = 'male'; user.save! }
    User.where(gender: 'hombre').each { |user| user.gender = 'male'; user.save! }
    User.where(gender: 'mujer').each { |user| user.gender = 'female'; user.save! }
  end
end
