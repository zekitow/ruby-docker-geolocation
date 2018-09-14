class HomeController < ApplicationController

  get '/' do
    raise UnauthorizedError.new('401')
  end
end
