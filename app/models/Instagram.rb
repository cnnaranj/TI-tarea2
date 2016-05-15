class Instagram
  include HTTParty
  base_uri 'api.instagram.com/v1'

  def initialize(access_token="2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402")
      @auth = access_token
  end

  def auth
    @auth
  end 

  def get(tagname , count=20 )
    options = {  :verify => false}
    @response =self.class.get("/tags/#{tagname}/media/recent?access_token=#{@auth}&count=#{count}", options  )
    return @response
  end

  def metadata(tagname)
    options={ :verify => false}
    @response =self.class.get("/tags/#{tagname}?access_token=#{@auth}", options )
    return @response
  end
end