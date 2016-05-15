require 'json'
require 'Instagram'
class ApiController < ApplicationController
	def search
		if !params.key?('tag') || !params.key?('access_token')
			render :nothing => true, :status => 400
		else

			@instagram= Instagram.new(params['access_token'])
			@metadata= @instagram.metadata(params['tag'])
			@response= @instagram.get(params['tag'], 20)
			@post={}
			@posts=[]
			@version="2.1.1"

			@response['data'].each do |data|
				if data['type']=="image"
					if data['images']['standard_resolution']
						@post= {:tags=> data['tags'], :username => data['user']['username'], :likes => data['likes']['count'], :url => data['images']['standard_resolution']['url'], :caption => data['caption']['text']}
						
					elsif  data['images']['low_resolution']
						@post= {:tags=> data['tags'], :username => data ['user']['username'], :likes => data ['likes']['count'], :url => data['images']['low_resolution']['url'] , :caption => data['caption']['text']}
					else
						@post= {:tags=> data['tags'], :username => data ['user']['username'], :likes => data ['likes']['count'], :url => data['images']['thumbnail']['url'] , :caption => data['caption']['text']}
					end	
				else

					if data['videos']['standard_resolution']
						@post= {:tags=> data['tags'], :username => data ['user']['username'], :likes => data ['likes']['count'], :url => data['videos']['standard_resolution']['url'] , :caption => data['caption']['text']
					else
						@post= {:tags=> data['tags'], :username => data ['user']['username'], :likes => data ['likes']['count'], :url => data['videos']['low_resolution'][, :version => @version}
					end
				end
				@posts.push(@post)
							
			end

			render :status =>200, json: { metadata: { total: @metadata['data']['media_count']}, posts: @posts, version: @version }
		end

	end
end
