class GuardianSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :first_name, :last_name
end
