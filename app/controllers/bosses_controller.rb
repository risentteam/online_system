class BossesController < ApplicationController
	def new
		@boss = Boss.new
	end

	def create

	end

	def edit
		
	end

	def update

	end

	def index
		@bosses = Boss.all
	end
end
