module V1
  class BaseApi < Grape::API
    prefix 'api'
    mount V1::AuthApi
    mount V1::PostApi
    mount V1::UserApi
    mount V1::CommentsApi
  end
end