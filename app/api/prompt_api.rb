# frozen_string_literal: true

  # Documentation for GptCloner::Base class

class PromptApi < Grape::API
    mount Prompt::PromptInteraction
end
  