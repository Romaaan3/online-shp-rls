module GetRateOfExchange
  extend ActiveSupport::Concern

  private

  def get_rate_of_exchange
    @rate ||= Setting.find(1)
  end
end
