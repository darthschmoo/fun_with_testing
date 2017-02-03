module FunWith
  module Testing
    module Assertions
      module FunWithFiles
        def assert_fwf_filepath( file, msg = nil )
          msg = message(msg){ "File <#{file}> should be a FunWith::Files::FilePath" }
          assert_kind_of FunWith::Files::FilePath, file, msg  
        end

        def assert_file( file, msg = nil )
          assert_fwf_filepath( file, message )
          
          msg = message(msg){ "File should exist at <#{file}>." }
          assert file.exist?, msg
        end

        def assert_no_file( file, msg = nil )
          assert_fwf_filepath( file, message )
          msg = message(msg){ "No file/directory should exist at <#{file}>." }
          refute file.exist?, msg
        end
        
        def assert_directory( file, msg = nil )
          assert_fwf_filepath( file, msg )
          msg = message(msg){ "<#{file}> should be a directory." }
          assert file.directory?, msg
        end

        def assert_not_directory( file, msg = nil )
          assert_fwf_filepath( file, message )
          msg = message(msg){ "<#{file}> shouldn't be a directory." }
          refute file.directory?
        end
        
        def assert_empty_file( file, msg = nil )
          assert_fwf_filepath( file )
          msg = message(msg){ "Empty file should exist at <#{file}>." }
          assert file.exist? && file.empty?, msg
        end

        def assert_empty_directory( file, msg = nil )
          assert_fwf_filepath( file )
          msg = message(msg){ "Empty directory should exist at <#{file}>." }
          assert file.directory? && file.empty?
        end
        
        
        def assert_file_has_content( file, msg = nil )
          assert_fwf_filepath( file, message )
          msg = message(msg){ "File should exist at <#{file}>, and have content." }
          assert file.exist?, msg.call + "(file does not exist)"
          refute file.empty?, msg.call + "(file is not empty)"
        end
        
        alias :assert_file_not_empty :assert_file_has_content
        
        
        def assert_file_contents( file, content, msg = nil )
          assert_file( file )
          
          case content
          when String
            # message = build_message( message, "File <#{file}> contents should be #{content[0..99].inspect}#{'...(truncated)' if content.length > 100}" )
            assert_equal( content, file.read, message )
          when Regexp
            assert_match( content, file.read, message )
          end
        end
        
        # Actually, because  FilePath responds to =~, assert_match may work for this
        # def assert_file_content_matches( file, regex_or_string, times = nil, msg = nil )
        #   if 
        #   if times.nil?
        #     
        #   end
        # end
      end
    end
  end
end