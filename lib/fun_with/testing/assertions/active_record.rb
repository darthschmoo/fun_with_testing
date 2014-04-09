module FunWith
  module Testing
    module Assertions
      module ActiveRecord
        def assert_record_save( record, message = "")
          result = record.save

          message = "Record #{record} did not save properly.  "
          message += record.errors.map{ |k,v| "#{k} : #{v}"}.join(", ")

          assert_block message do
            result
          end
        end

        # Usage:  get("index"); assert_response_success( :template => "index" )
        # 
        def assert_response_success( opts = {} )
          assert_block "@response is nil" do
            !@response.nil?
          end

          if @response.error?
            puts @response.body
          elsif @response.redirect?
            raise Minitest::Unit::AssertionFailedError.new( "Expected success, was redirect to #{@response.redirected_to} with flash #{flash}" )
          end

          assert_response :success
          assert_template opts[:template] if opts[:template]
        end

        def assert_response_redirect( opts = {} )
          assert_block "@response is nil" do
            !@response.nil?
          end

          if @response.error? || @response.client_error?
            puts @response.body
            puts "Flash:" + @response.flash.map{|k,v| "#{k} : #{v}"}.join(', ')
            debugger
            nil
          elsif @response.success?
            puts "OOPS: should have redirected. Instead went to #{@response.template.action_name}, flash: #{@response.flash.inspect}"
          end

          assert_response :redirect
          assert_redirected_to opts[:to] if opts[:to]
        end

        def assert_no_errors_on( record, message = "" )
          record.valid?
          message = build_message( message,
                                   "#{record.class.name} record should have no errors.  Errors: ?",
                                   record.errors.map{ |k,v| "[#{k} : #{v}]"}.join(", ")
                                   )

          assert_block message do
            record.valid?
          end
        end

        # TODO: Should be able to say which errors should be present
        def assert_errors_on( record, message = "" )
          message = build_message( message, "#{record.class.name} record should have errors.")

          assert_block message do
            !record.valid?
          end
        end
      
        def assert_an_error_on( record, _field, error_says = nil )
          message = build_message( "", "<?> should have an error on the <?> field.", record, _field )
          assert_block message  do
            !record.errors[_field].blank?
          end
        
          unless error_says.blank?
            message = build_message( "", "<?> should have an error on the <?> field that says <?>.", record, _field, error_says )
            assert_block message do
              # puts "Inside field error block"
              #             debugger
              record.errors[_field].include?(error_says)
            end
          end
        end

        def assert_record_destroyed( record, message = "")
          not_record_message = build_message(message, "<?> is not an ActiveRecord::Base object.", record)
          new_record_message = build_message(message, "<?> should not be a new record in order to use assert_destroy().", record)
          full_message = build_message(message, "<?> should have been destroyed.", record)

          assert_block not_record_message do
            record.is_a?(ActiveRecord::Base)
          end

          assert_block new_record_message do
            record.new_record? == false
          end

          assert_block full_message do
            record.class.find_by_id(record.id) == nil
          end
        end
      end
    end
  end
end
