class BaseEngine
  protected
  def make_dir
    Dir.mkdir(@dir) unless File.exists?(@dir)
  end
end