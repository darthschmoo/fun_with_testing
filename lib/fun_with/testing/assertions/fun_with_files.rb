module FunWith
  module Testing
    module Assertions
      module FunWithFiles
        def assert_fwf_filepath( file, message = "" )
          message = build_message( message, "File <#{file}> should be a FunWith::Files::FilePath")
          
          assert_block message do
            file.is_a?( FunWith::Files::FilePath )
          end
        end

        def assert_file( file, message = "" )
          assert_fwf_filepath( file, message )
          
          message = build_message( message, "File should exist at <#{file}>." )

          assert_block message do
            file.exist?
          end
        end

        def assert_no_file( file, message = "" )
          assert_fwf_filepath( file, message )
          
          message = build_message( message, "No file/directory should exist at <#{file}>." )

          assert_block message do
            ! file.exist?
          end
        end
        
        def assert_directory( file, message = "" )
          assert_fwf_filepath( file, message )
          
          message = build_message( message, "<#{file}> should be a directory." )

          
          assert_block message do
            file.directory?
          end
        end

        def assert_not_directory( file, message = "" )
          assert_fwf_filepath( file, message )
          
          message = build_message( message, "<#{file}> shouldn't be a directory." )

          
          assert_block message do
            ! file.directory?
          end
        end
        
        def assert_empty_file( file, message = "" )
          assert_fwf_filepath( file, message )
          
          message = build_message( message, "Empty file should exist at <#{file}>." )

          assert_block message do
            file.exist? && file.empty?
          end
        end

        def assert_empty_directory( file, message = "" )
          assert_fwf_filepath( file, message )
          
          message = build_message( message, "Empty directory should exist at <#{file}>." )

          assert_block message do
            file.directory? && file.empty?
          end
        end
        
        def assert_file_has_content( file, message = "" )
          assert_fwf_filepath( file, message )
          
          message = build_message( message, "File should exist at <#{file}>, and have content." )

          assert_block message do
            file.exist? && !file.empty?
          end
        end

        def assert_file_contents( file, content, message = "" )
          assert_file( file )
          
          case content
          when String
            # message = build_message( message, "File <#{file}> contents should be #{content[0..99].inspect}#{'...(truncated)' if content.length > 100}" )
            assert_equal( content, file.read, message )
          when Regexp
            assert_match( content, file.read, message)
          end
        end
        
        # Actually, because  FilePath responds to =~, assert_match may work for this
        # def assert_file_content_matches( file, regex_or_string, times = nil, message = "" )
        #   if 
        #   if times.nil?
        #     
        #   end
        # end
      end
    end
  end
end