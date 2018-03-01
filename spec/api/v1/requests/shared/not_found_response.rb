shared_examples_for "a not found response" do
  it { expect(response).to have_http_status(:not_found) }
  it { expect(response.content_type).to eq("application/json") }
end
