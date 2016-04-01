class Cycle::CreateScores
  def self.call(cycle)
    return unless cycle.stoped?

    organizations = Organization.scores_between(cycle.created_at, cycle.ended_at)

    organizations.find_each do |org|
      cycle.scores << Cycle::Score.create(organization: org, score: org.total_score)
    end
  end
end
