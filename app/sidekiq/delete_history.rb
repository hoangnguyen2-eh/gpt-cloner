class DeleteHistory
  include Sidekiq::Job

  def perform
    Rails.logger.info "Delete all prompt history"
    Prompt.delete_all
  end
end
