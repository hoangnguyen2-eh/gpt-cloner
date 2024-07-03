# frozen_string_literal: true

  # Documentation for GptCloner::Base class

class UserApi < Grape::API
  mount Users::UserInteraction
end
