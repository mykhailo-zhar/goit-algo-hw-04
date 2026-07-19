# frozen_string_literal: true

# This module is used to copy files from a source directory to a destination directory.
module Copy
  def self.copy(source, destination = './dist', limit = 5)
    raise ArgumentError, 'source and destination are required' if source.nil? || destination.nil?

    raise ArgumentError, 'source is not a directory' unless File.directory?(source)

    raise ArgumentError, 'destination is not a directory' if File.exist?(destination) && !File.directory?(destination)

    files = collect_files(source, limit)
    return if files.empty?

    mapped_files = map_files(files, destination, source)
    create_directories(mapped_files.values)

    mapped_files.each do |original, mapped|
      FileUtils.cp(original, mapped)
    end
  end

  def self.map_file_to_directory(file)
    raise ArgumentError, 'file is not a file' unless file.file?

    extension = file.extname.to_s
    extension.empty? ? 'other' : extension
  end

  def self.map_directories(files)
    files.map { |file| map_file_to_directory(file) }.uniq
  end

  def self.create_directories(directories)
    parents = directories.map(&:parent).uniq
    parents.each(&:mkpath)
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
