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