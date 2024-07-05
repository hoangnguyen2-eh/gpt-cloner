require 'grape'

class Prompt::PromptInteraction < Grape::API
    version 'v1', using: :path
    format :json

    resource :prompt do
        desc 'Send a prompt to OpenAI'
        params do
            requires :text, type: String, desc: 'Prompt text'
        end
        post do
            Rails.logger.info "Prompting OpenAI with text: #{params[:text]}"
            prompt_text = params[:text]
            headers = {
                "Authorization": "Bearer #{ENV['OPENAI_API_KEY']}",
                "Content-Type": "application/json"
            }

            body = {
                "model": "davinci-002",
                "messages": [
                    {
                        "role": "user",
                        "content": prompt_text
                    }
                ]
            }

            response = RestClient.call_api('https://api.openai.com/v1/chat/completions', 'post', headers, body)
            
            # get token
            token = cookies[:token]

            userValidator = UserValidator.new(token)
            # Save to prompt table
            if !token.present? || !userValidator.valid?
                response
                return
            end

            Rails.logger.info "Save prompt to database with user: #{userValidator.getUserName}"

            Prompt.create(value: prompt_text, user_id: User.find_by(username: userValidator.getUserName).id)
            return response
        end

        desc 'Delete all prompt'
        delete do
            DeleteHistory.perform_in(1.seconds)
            { message: 'OK' }
        end
    end
end