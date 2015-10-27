class JobsController < ApplicationController

def index
	respond_to do |format|
    	format.html
    	format.json { render json: JobsDatatable.new(view_context) }
		# @jobs = Job.all
	end
end

def new
	@job = Job.new
end

def create
	job = Job.create(job_params)
	if job.errors.present?
		flash[:errors] = job.errors.full_messages
	else
		flash[:success] = 'Job Created!'
	end
	redirect_to jobs_path
end

def edit
	@job = Job.find(params[:id])
end

def update
	@job = Job.find(params[:id])
	@job.update_attributes(job_params)
	redirect_to jobs_path
end

def show
	@job = Job.find(params[:id])
end

def destroy
	@job = Job.find(params[:id])
	@job.destroy
	redirect_to jobs_path
end

private

def job_params
  params.require(:job).permit(:title, :description, :location)
end

end