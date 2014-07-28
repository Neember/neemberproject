require 'active_resource'

class Client < ActiveResource::Base
  self.site = 'http://neemberclient.herokuapp.com/'

  def self.options
    self.all.collect do |client|
      [client.company_name, client.id]
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
