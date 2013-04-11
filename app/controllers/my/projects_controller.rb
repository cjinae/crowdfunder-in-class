class My::ProjectsController < ApplicationController
	
	before_filter :require_project, except: [:index, :new, :create]

	def index
		@projects = current_user.projects
	end

	def new
		@project = current_user.projects.build
	end

	def require_project
		@project = current_user.projects.find params[:id]
	end

end
