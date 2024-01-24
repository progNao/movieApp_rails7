users = ["test_user_1", "test_user_2"]
users.each_with_index do |user, i|
 User.create(
  username: "#{user}",
  email: "#{i + 1}@example.com",
  password: "password"
 )
end
