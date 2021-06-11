class CallbacksController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token
  skip_before_action :verify_authenticity_token
  

  STR_SUCCESS_CALLBACK={:resp_code=> '00', :resp_desc=> 'Successful'}
  STR_FAILURE_CALLBACK={:resp_code=> '01', :resp_desc=> 'Failure'}
  

  def amfp_callback
    authorize! :amfp_callback, :amfp_callback
    resp_status = params[:trans_status]
    resp_desc = params[:message]
    refID = params[:trans_ref]
    am_ref_id = params[:trans_id]  
    
    check = RequestMaster.where(trans_id: refID)[0] #check if trnx_id exists in the system
    
    respond_to do |format|
      if !check.nil?
        RequestMaster.callback_function(resp_status, resp_desc, refID, am_ref_id)
        format.json  { render :json => STR_SUCCESS_CALLBACK }
      else
        format.json  { render :json => STR_FAILURE_CALLBACK }
      end
    end
  end
  
end
