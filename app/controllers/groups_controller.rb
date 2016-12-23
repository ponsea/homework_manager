class GroupsController < ApplicationController
  before_action :check_logined

  def new
    @new_group = Group.new
  end
end
