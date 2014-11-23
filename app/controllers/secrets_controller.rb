class SecretsController < ApplicationController
  respond_to :html, :json

  def header
    respond_to do |format|
      format.html {
        response.headers['secret_header'] = 'In http 2.0 it would be harder.'
      }
      format.json {
        response.headers['secret_header'] = 'Just joking..'
        render json: {}
      }
    end
  end
end

__END__
curl -i \
    -H "Accept: application/json" \
    http://localhost:3000/secrets/header