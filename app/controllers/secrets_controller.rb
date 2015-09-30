class SecretsController < ApplicationController
  respond_to :html, :json

  # https://gist.github.com/dhoelzgen/cd7126b8652229d32eb4
  # https://github.com/cyu/rack-cors <- maybe better
  skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Accepts, Origin, Language, Encoding, Content-Type, Accept, Authorization, Token, X-Requested-With, Key'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      # headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Allow-Headers'] = 'Accepts, Origin, Language, Encoding, Content-Type, Accept, Authorization, Token, X-Requested-With, Key'

      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end


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

  def ajax_2
    render :nothing => true, :status => 503, :content_type => 'text/html'
  end

  def ajax_1
    if request.xhr?
      render :text => 'Beware, the second request might fail!', :status => 200, :content_type => 'text/html'
    else
      render :text => 'Phu, this is not ajax request', :status => 200, :content_type => 'text/html'
    end
  end

end

__END__
curl -i \
    -H "Accept: application/json" \
    http://localhost:3000/secrets/header