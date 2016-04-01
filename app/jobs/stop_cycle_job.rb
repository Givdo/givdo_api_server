class StopCycleJob < ActiveJob::Base
  queue_as :urgent

  def perform(cycle_id)
    cycle = Cycle.find(cycle_id)
    Cycle::Stop.call(cycle)
  end
end
