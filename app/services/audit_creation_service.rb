class AuditCreationService 

  attr_reader :file_path

  def initialize(file)
    @file_path = file.path
  end

  def call
    process_and_save_file
    ImportCsvWorker.perform_async(new_directory)
    true
  end

  def process_and_save_file
    text = process_file
    save_file(text)
  end

  def process_file
    File.read(@file_path).gsub('\"', '').sub("object_id", "auditable_id").sub("object_type", "auditable_type").sub("object_changes", "event")
  end

  def save_file(text)
    File.open(new_directory, "w") { |line| line << text }
  end

  def new_directory
    Rails.root.join("public", "log_#{Time.now.to_i}.csv")
  end
end 
