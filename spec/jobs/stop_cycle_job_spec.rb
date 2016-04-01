require 'rails_helper'

RSpec.describe StopCycleJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.new.perform(cycle.id) }

  let(:cycle) { create(:cycle, ended_at: nil) }
end
