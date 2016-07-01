class Givdo::TriviaImporter
  attr_reader :sheet

  COLUMNS_MAP = {
    question: 'Question',
    correct_option: 'Correct Answer',
    option_1: 'Distractor 1',
    option_2: 'Distractor 2',
    category: 'Tag',
  }

  def self.import!(sheet)
    new(sheet).import!
  end

  def initialize(sheet)
    @sheet = sheet
  end

  def import!
    sheet.each_with_index(COLUMNS_MAP) do |params, i|
      next if i.zero?

      Trivia.find_or_create_by(params.slice(:question)) do |trivia|
        trivia.category = Category.find_or_create_by!(name: params[:category])
        trivia.new_correct_option(text: params[:correct_option])
        trivia.new_option(text: params[:option_1]).save
        trivia.new_option(text: params[:option_2]).save
      end
    end
  end
end
