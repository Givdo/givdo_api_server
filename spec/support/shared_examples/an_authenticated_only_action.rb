shared_examples_for 'an authenticated only action' do
  it 'does not allow unauthenticated users' do
    api_logout

    expect(subject).to be_unauthorized
  end
end
