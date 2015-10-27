class JobsDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Job.count,
      #iTotalDisplayRecords: Job.total_entries,
      aaData: data
    }
  end

private

  def data
    jobs.map do |job|
      [
        link_to(job.title, job),
        @view.send(:h, job.description),
        @view.send(:h, job.location)
      ]
    end
  end

  def jobs
    @jobs ||= fetch_jobs
  end

  def fetch_jobs
    jobs = Job.order("#{sort_column} #{sort_direction}")
    jobs = jobs.page(page).per_page(per_page)
    if params[:sSearch].present?
      jobs = jobs.where("title like :search or description like :search or location like :search", search: "%#{params[:sSearch]}%")
    end
    jobs
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[title description location]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end