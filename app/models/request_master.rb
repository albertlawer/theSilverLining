class RequestMaster < ActiveRecord::Base

	CLIENT_ID = 15
	CALLBACK_URL = "http://184.173.139.74:4000/amfp_callback"

	STR_CLIENT_KEY = "9AnjqCgdmM9Rl9wrwAY3ZHThZGSq7dQ/7WTOJZwbulRrJAyX4jGNlSKKeBP+MsjRv83zZX4KGYrmkWms447btw=="
	STR_SECRET_KEY = "alF+ll694Igeo7fNvirkpN21LUxFJA/nUVLR3kFs3WMduygiqt1QSKkXjkIIJKwHuHzEuXFz5b+9mBmAGU6umQ=="
	STR_SMS_API_KEY= "eIjIoAB5uTgnNOb1tWzuIVkfUCaAxgJV5QNuWsXVvSid9prPVIV7Xt/fJUSo1vFpM2lHLN58J6LBnLiP5vwNUw=="
  	SENDER_ID = "SILVER-LINE"
	 
	STROPENTIMEOUT = "180"
	new_url     =   "https://orchard-api.anmgw.com"
	new_HEADERS = {'Content-Type'=> 'application/json','timeout'=>STROPENTIMEOUT, 'open_timeout'=>STROPENTIMEOUT}


	NEW_CONN = 	Faraday.new(:url => new_url, :headers => new_HEADERS, :ssl => {:verify => false}) do |faraday|   
					faraday.request  :url_encoded             # form-encode POST params
					faraday.response :logger                  # log requests to STDOUT
					faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
			   	end

	belongs_to :a_user, class_name: "User", foreign_key: :user_id

	validates :customer_number, presence: true
	validates :network, presence: true
	validates :trans_id, presence: true
	validates :amount, presence: true
	validates :total_amount, presence: true
	validate :the_voucher
	validate :the_debit
	validate :the_credit

	def the_voucher
		if self.network == "VOD"
			if self.trans_type == "DR"
				if !self.voucher_code.present?
					self.errors.add(:voucher_code,"Voucher Code must be included for vodafone")
				end
			end
		end
	end

	def the_debit
		if self.trans_type == "DR"
			#check the amount he is requesting for against 100gh
			if self.amount.to_f < 10.00
				self.errors.add(:amount,"Amount should be greater than or equal to GHS 10")
			end
		end
	end


	def the_credit
		if self.trans_type == "CR"
			#check the amount he is requesting for against 30gh
			if self.amount.to_f < 30.00
				self.errors.add(:amount,"Amount should be greater than GHS 30")
			else
				#now check against his avaliable balance
				user_balance = AccountMaster.where(user_id: self.user_id).pluck(:avaliable_balance)[0]
				if self.amount.to_f > user_balance.to_f
					self.errors.add(:amount,"Amount should be less than availiable balance of GHS #{user_balance}")
				end
			end
		end
	end

	

	def self.genUniqueCode
	    time=Time.new
	    randval_two=rand(999).to_s.center(3, rand(9).to_s)
	    strtm=time.strftime("%y%m%d%H%M%L")
	    
	    api_code = randval_two+strtm
	    return api_code
	end


	def self.computeSignature(secret, data) 
		digest=OpenSSL::Digest.new('sha256')
		signature = OpenSSL::HMAC.hexdigest(digest, secret.to_s, data)
		return signature
    end


	def self.sendRequest(data)
		endpoint = "/sendRequest"
		ts=Time.now.strftime("%Y-%m-%d %H:%M:%S")
	    payload={
	      		:customer_number=> data.customer_number,
	      		:reference=>"TheSilverLining",
    				:amount=> data.total_amount,
    				:trans_type=> data.trans_type,
    				:nw=> data.network,
    				:client_id=> CLIENT_ID,
    				:ts=> ts,
	      		:voucher_code=>data.voucher_code,
    				:exttrid=> data.trans_id,
    				:callback_url=> CALLBACK_URL
	        	}
    
    	json_payload=JSON.generate(payload)

	    
    	signature=computeSignature(STR_SECRET_KEY, json_payload)
    
    
	    begin
	    res=NEW_CONN.post do |req|
		      req.url endpoint
		      req.options.timeout = 30           # open/read timeout in seconds
		      req.options.open_timeout = 30      # connection open timeout in seconds
		      req["Authorization"]="#{STR_CLIENT_KEY}:#{signature}"
		      req.body = json_payload
		    end
	

	    rescue Faraday::SSLError
	      puts
	      puts "There was a problem sending the https request..."
	      puts
	    rescue Faraday::TimeoutError
	      puts "Connection timeout error"
	    end

	end


	def self.checkBal
		endpoint = "/check_wallet_bal"
		ts=Time.now.strftime("%Y-%m-%d %H:%M:%S")
	    payload={
				:client_id=> CLIENT_ID,
				:ts=> ts
	        	}
    
    	json_payload=JSON.generate(payload)
    	signature=computeSignature(STR_SECRET_KEY, json_payload)
    
	    begin
	    res=NEW_CONN.post do |req|
		      req.url endpoint
		      req.options.timeout = 30           # open/read timeout in seconds
		      req.options.open_timeout = 30      # connection open timeout in seconds
		      req["Authorization"]="#{STR_CLIENT_KEY}:#{signature}"
		      req.body = json_payload
		    end
	

	    rescue Faraday::SSLError
	      puts
	      puts "There was a problem sending the https request..."
	      puts
	    rescue Faraday::TimeoutError
	      puts "Connection timeout error"
	    end

	    bal = JSON.parse(res.body)
	    balance = bal['balance']
	    return balance
	end





  def self.sendsms(user_number,sms_msg,unique_code)
    endpoint = "/sendSms"
    payload={ 
      :client_id=>CLIENT_ID,
      :sender_id=> SENDER_ID,
      :recipient_number=> user_number,
      :message_body=> sms_msg,
      :unique_id=> unique_code,
      :src=> "API",
      :api_key=>STR_SMS_API_KEY
      }
    
    json_payload=JSON.generate(payload)
    signature=computeSignature(STR_SECRET_KEY, json_payload)
    
    
    begin
      res=NEW_CONN.post do |req|
        req.url endpoint
        req.options.timeout = 180           # open/read timeout in seconds
        req.options.open_timeout = 180      # connection open timeout in seconds
        req["Authorization"]="#{STR_CLIENT_KEY}:#{signature}"
        req.body = json_payload
      end
    rescue Faraday::SSLError
      puts
      puts "There was a problem sending the https request..."
      puts
    rescue Faraday::TimeoutError
      puts "Connection timeout error"
    end
    

  end









	def self.callback_function(resp_status, resp_desc, exttrid, trans_id)
		@request = RequestMaster.where(trans_id: exttrid)[0]
		the_resp_status_new =  resp_status.split("/")
		
		if !@request.resp_code.present?
		  RequestMaster.update(@request.id, callback_status: true, resp_code: resp_status, resp_desc: resp_desc)
		  @user = User.where(id: @request.user_id)[0]
      @user_account = AccountMaster.where(user_id: @request.user_id)[0]
      @user_account_id = @user_account["id"]
      @user_account_balance = @user_account["avaliable_balance"]
  
      if the_resp_status_new[0] == "000" #successful
        if @request["trans_type"] == "DR" #deposit
          @new_bal = @user_balance.to_f + @request.amount.to_f
          AccountMaster.update(@user_account_id, avaliable_balance: @new_bal)
          #send sms notifying user of sucessful deposit
          @sms_msg = "Hello. Your deposit of GHS #{@request.amount} is successful. Your current balance is GHS #{@new_bal}. Thank you."
          Thread.new{ self.sendsms(@user["contact_number"],@sms_msg,self.genUniqueCode) }
  
        elsif @request["trans_type"] == "CR" #withdrawal
          @new_bal = @user_balance.to_f - @request.amount.to_f
          AccountMaster.update(@user_account_id, avaliable_balance: @new_bal)
          #send sms notifying user of sucessful withdrawal
          @sms_msg = "Hello. Your withdrawal of GHS #{@request.amount} is successful. Your current balance is GHS #{@new_bal}. Thank you."
          Thread.new{ self.sendsms(@user["contact_number"],@sms_msg,self.genUniqueCode) }
        end
      else #client should know there was a failure 
        if @request["trans_type"] == "DR" #deposit
          #send sms notifying user of a failed deposit
          @sms_msg = "Hello. Your deposit of GHS #{@request.amount} failed. Thank you."
          Thread.new{ self.sendsms(@user["contact_number"],@sms_msg,self.genUniqueCode) }
        elsif @request["trans_type"] == "CR" #withdrawal
          #send sms notifying user of a failed withdrawal
          @sms_msg = "Hello. Your withdrawal of GHS #{@request.amount} failed. Thank you."
          Thread.new{ self.sendsms(@user["contact_number"],@sms_msg,self.genUniqueCode) }
        end 
      end
		end
	end

end
