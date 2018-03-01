shared_examples_for "an unprocessable entity response" do
  it { expect(response).to have_http_status(:unprocessable_entity) }
  it { expect(response.content_type).to eq("application/json") }
end
