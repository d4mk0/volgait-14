SimpleRoles.configure do |config|
  config.valid_roles = [:user, :admin, :editor]
  config.strategy = :many
end
