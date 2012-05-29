["pending", "downloading", "downloaded", "synched", "removed"].each do |s|  
  Status.find_or_create_by_name s  
end  
