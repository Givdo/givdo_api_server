require 'rails_helper'
require 'givdo/facebook/paginated_connections'

RSpec.describe Givdo::Facebook::PaginatedConnections, :type => :lib do
  let(:params) { {:param => 'value'} }
  let(:graph) { double }
  subject { Givdo::Facebook::PaginatedConnections.new(graph, 'my_connections', params) }

  describe '#list' do
    context 'when no page is set' do
      it 'is the requested connection with the given params' do
        expect(graph).to receive(:get_connections).with('me', 'my_connections', {:param => 'value'}).and_return('connections collection')

        expect(subject.list).to eql 'connections collection'
      end
    end

    context 'when the page is set' do
      it 'is the requested page' do
        params[:page] = 'page data'
        expect(graph).to receive(:get_page).with('page data').and_return('page')

        expect(subject.list).to eql 'page'
      end
    end
  end
end
