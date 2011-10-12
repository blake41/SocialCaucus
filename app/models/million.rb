class Million < ActiveRecord::Base
  
  def self.queue
    TempMillion.find_in_batches(:batch_size => 1000) do |array|
      array.each do |item|
        Resque.enqueue(ParseMillions, item.id)
      end
    end
  end
end
