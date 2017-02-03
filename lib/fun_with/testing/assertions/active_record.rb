module FunWith
  module Testing
    module Assertions
      module ActiveRecord
        def assert_record_save( record, msg = nil)
          result = record.save

          msg = message(msg){
            "Record #{record} did not save properly.  " + record.errors.map{ |k,v| "#{k} : #{v}"}.join(", ")
          }

          assert result, msg
        end

        # Usage:  get("index"); assert_response_success( :template => "index" )
        # 
        def assert_response_success( opts = {} )
          message = "@response is nil"
          
          refute @response.nil?, message

          if @response.error?
            puts @response.body
          elsif @response.redirect?
            raise Minitest::Unit::AssertionFailedError.new( "Expected success, was redirect to #{@response.redirected_to} with flash #{flash}" )
          end

          assert_response :success
          assert_template opts[:template] if opts[:template]
        end

        def assert_response_redirect( opts = {} )
          message = "@response is nil"
          refute @response.nil?, message

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

        def assert_no_errors_on( record, msg = nil )
          record.valid?
          msg = message(msg){
            "#{record.class.name} record should have no errors.  Errors: ?" + 
              record.errors.map{ |k,v| "[#{k} : #{v}]"}.join(", ")
          }
          
          assert record.valid?, msg
        end

        # TODO: Should be able to say which errors should be present
        def assert_errors_on( record, msg = nil )
          msg = message(msg){"#{record.class.name} record should have errors."}
          refute record.valid?, msg
        end
      
        def assert_an_error_on( record, _field, matches = nil, msg = nil )
          msg = message(msg){ "<#{mu_pp(record)}> should have an error on the <#{mu_pp(_field)}> field." }
          
          refute record.errors[_field].blank?, msg
          
          field_error_message = record.errors[_field]
          case matches
          when String
            msg = "Error on field #{mu_pp(field)} says #{field_error_message.inspect}, should say #{matches.inspect}."
            assert field_error_message == matches, msg
          when Regexp
            msg = "Error on field #{mu_pp(field)} says #{field_error_message.inspect}, doesn't match #{matches.inspect}."
            assert field_error_message =~ matches, msg 
          end
        end

        def assert_record_destroyed( record, msg = nil)
          msg = message(msg) { "<#{mu_pp(record)}> should have been destroyed." }

          assert_kind_of ActiveRecord::Base, record, "<#{mu_pp(record)}> is not an ActiveRecord::Base object."
          refute record.new_record?, "<#{mu_pp(record)}> should not be a new record in order to use assert_destroy()."

          assert record.class.find_by_id(record.id).nil?, msg
        end
        
        # check that the given variables were assigned non-nil values
        # by the controller

        # If successful, returns an array of assigned objects.
        # You can do:
        # account, phone_number = assert_assigns(:account, :phone_number)
        # or
        # order = assert_assigns(:order)
        # TODO:  HAVEN'T USED THIS ANYWHERE
        def assert_assigns(*args)
          symbols_assigned = []
          symbols_not_assigned = []

          for sym in args
            ((assigns(sym) != nil)? symbols_assigned : symbols_not_assigned) << sym
          end

          msg = "The following variables should have been assigned values by the controller: <#{mu_pp(symbols_not_assigned)}>"

          assert_length 0, symbols_not_assigned, msg

          if symbols_assigned.length == 1
            assigns(symbols_assigned.first)
          else
            symbols_assigned.map{|s| assigns(s) }
          end
        end
      end
    end
  end
end
