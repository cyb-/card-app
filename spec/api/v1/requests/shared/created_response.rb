shared_examples_for "a created response" do
  it { expect(response).to have_http_status(:created) }
  it { expect(response.content_type).to eq("application/json") }
end
