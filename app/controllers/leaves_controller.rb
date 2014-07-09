class LeavesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @leaves = current_user.get_leaves_by_user
  end
end
