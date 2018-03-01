shared_examples_for "a success response" do
  it { expect(response).to have_http_status(:ok) }
  it { expect(response.content_type).to eq("application/json") }
end
