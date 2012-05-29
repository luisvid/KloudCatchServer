class Droplet < ActiveRecord::Base
  belongs_to :user
  belongs_to :status
  has_many :droplet_histories
    
  after_save :update_history
  
  def download
    dir = File.join(Configuration::DOWNLOAD_PATH, user.email)
	FileUtils.makedirs(dir)
    update_status("downloading")
    self.name, self.file = EngineFactory.get(url).download(url, dir)
	update_status("downloaded")
  rescue
    update_status("pending")
  end
  
  def upload(name, data)
	dir = File.join(Configuration::DOWNLOAD_PATH, user.email)
	FileUtils.makedirs(dir)
	self.name = name
	self.file = File.join(dir, name)
	File.open(self.file, 'wb' ) do |file|
	  file.write(data.read)
    end
  end
  
  def update_status(name)
    self.status_id = Status.find_by_name(name).id
	save
  end
  
  private
  def update_history
    DropletHistory.create!(:droplet => self, :status => status, :user => user)
  end
  
end
