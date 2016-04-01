class Cycle::Start
  def self.call
    Cycle::Stop.call(Cycle.current)
    Cycle::create!
  end
end
