class Cycle::Stop
  def self.call(cycle)
    return if cycle.blank?
    
    ActiveRecord::Base.transaction do
      cycle.stop!
      Cycle::CreateScores.call(cycle)
    end
  end
end
