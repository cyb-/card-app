module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def mash
      Hashie::Mash.new(json)
    end
  end
end
