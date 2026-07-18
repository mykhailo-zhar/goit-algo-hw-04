require 'pathname'

module Copy 
  def self.copy(source, destination='./dist', limit=5) 
    if source.nil? || destination.nil?
      raise ArgumentError, "source and destination are required"
    end

    if !File.directory?(source)
      raise ArgumentError, "source is not a directory"
    end

    if !File.directory?(destination)
      raise ArgumentError, "destination is not a directory"
    end

    files = collect_files(source, limit)

    return if files.empty?

    mapped_files = map_files(files, destination, source)
    mapped_directories = map_directories(files)

    create_directories(mapped_directories, destination)

    mapped_files.each do |original, mapped|
      FileUtils.cp(original, mapped)
    end
  end

  def self.map_file_to_directory(file)
    unless file.file?
      raise ArgumentError, "file is not a file"
    end
    extension = file.extname.to_s
    extension.empty? ? "other" : extension
  end

  def self.map_directories(files)
    files.map { |file| map_file_to_directory(file) }.uniq
  end

  def self.create_directories(mapped_directories, destination)
    mapped_directories.each do |directory|
      Pathname.new(destination).join(directory).mkpath
    end
  end

  def self.map_file_to_path(original, destination, source, preserve)
    file_directory = map_file_to_directory(original)
    file_name = if preserve
      original_directory = original.relative_path_from(source).dirname.to_s.gsub(File::SEPARATOR, '-')
      "#{original.basename('.*')} (from #{original_directory})#{original.extname}"
    else
      original.basename
    end
    Pathname.new(destination).join(file_directory, file_name)
  end

  def self.map_files(files, destination, source)
    mapped_files = {}
    base_names = {}
    files.each do |file|
      preserve = base_names.key?(file.basename)
      base_names[file.basename] = true
      mapped_files[file] = map_file_to_path(file, destination, source, preserve)
    end
    mapped_files
  end

  # Collects files from a directory recursively
  def self.collect_files(directory, limit = 5)
    files = []
    Pathname.new(directory).children.each do |child|
      if child.directory?
        files += collect_files(child.to_s, limit)
      else
        files << child.realpath
      end
    end
    files
  end


end
