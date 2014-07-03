class PageSweeper < ActionController::Caching::Sweeper
  observe Page
  
  def sweep(page)
    expire_fragment page_path(page)
    expire_fragment 'root_pages'
  end

  alias_method :after_commit, :sweep
  # alias_method :after_create, :sweep
  # alias_method :after_update, :sweep
  # alias_method :after_destroy, :sweep
end