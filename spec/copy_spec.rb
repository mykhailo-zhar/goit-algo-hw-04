require_relative '../lib/copy'
require 'pathname'
require 'tmpdir'

def create_source_dir
  dir_name = File.join(@tmp_dir, "source")
  Dir.mkdir(dir_name)
  dir_name
end

def create_destination_dir
  dir_name = File.join(@tmp_dir, "destination")
  Dir.mkdir(dir_name)
  dir_name
end

def create_file(dir_name, file_name, permissions=0644)
  file = File.join(dir_name, file_name)
  File.write(file, "test")
  File.chmod(permissions, file)
  file
end

def get_file_extname_dir(directory, file)
  File.join(directory, File.extname(file))  
end


def count_files(dir, extension)
  Dir[File.join(dir, extension, "*#{extension}")].count { |file| File.file?(file) }
end


describe Copy do
  around(:each) do |example|
    Dir.mktmpdir do |dir|
      @tmp_dir = dir
      example.run
    end
  end

  context 'when both source and destination are absent' do
    it 'should raise an error' do
      expect { Copy.copy() }.to raise_error(ArgumentError)
    end
  end

  context 'when source invalid' do
    context 'when source is a file' do
      it 'should raise an error' do
         temp_file = create_file(@tmp_dir, "test.txt")
        expect { Copy.copy(temp_file, './dist') }.to raise_error(ArgumentError)
      end
    end

    context 'when directory does not exist' do
      it 'should raise an error' do
        expect { Copy.copy('not_a_directory', './dist') }.to raise_error(ArgumentError)
      end
    end
  end

  context 'when destination invalid' do
    context 'when destination is a file' do
      let(:source_dir) do
        create_source_dir
      end 
      let(:destination_file) do
        create_file(@tmp_dir, "destination.txt")
      end
      it 'should raise an error' do
        expect { Copy.copy(source_dir, destination_file) }.to raise_error(ArgumentError)
      end
    end
  end

  context 'when copying' do
    let(:source_dir) do
      create_source_dir
    end
    let(:destination_dir) do
      create_destination_dir
    end

    context 'when one file' do
      let(:file_name) { "test.txt" }
      let!(:source_file) do
        create_file(source_dir, file_name)
      end

      it 'should copy the file to the destination directory under the same extension' do
        Copy.copy(source_dir, destination_dir)
        expect(Pathname.new(get_file_extname_dir(destination_dir, file_name)).directory?).to be_truthy
      end
    end

    context 'when multiple files' do
      before do
        a_dir = File.join(source_dir, "a")
        b_dir = File.join(source_dir, "b")
        Dir.mkdir(a_dir)
        Dir.mkdir(b_dir)
        create_file(a_dir, "test.txt")
        create_file(b_dir, "test_2.txt")
        create_file(a_dir, "test.js")
        create_file(b_dir, "test.js")
      end

      it 'should copy the files to the destination directory under the same extension' do
        Copy.copy(source_dir, destination_dir)
        expect(count_files(destination_dir, ".js")).to eq(2)
        expect(count_files(destination_dir, ".txt")).to eq(2)

      end
    end
  end
end