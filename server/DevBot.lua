-------------------------------------------------------------------------------------------------------------------------------------
----|	   												 	 DevBot  v0.1.1											  		    |----
----|			    					 			    A JC-MP Community project											    |----
-------------------------------------------------------------------------------------------------------------------------------------

class 'DevBot'


function DevBot:__init()
		
		Events:Subscribe( "PlayerChat", self, self.PlayerChat )
		Events:Subscribe( "PostTick", self, self.PostTick )
		
		MessageQueue 					= 					{}
		TriggerTable					=					{}

		BotName							=					"[DevBot]: "
		BotColor						=					Color( 255, 255, 255 )
		
		self.numtick					=					0
		self.enabled					=					true
		
end


function DevBot:PlayerChat( args )
		
		local cmd_args 					= 					args.text:split( " " )
		local text 						=					args.text
		local lowertext					=					string.lower(text)
		
		
		if self.enabled then
		
		
			if lowertext == "devbot" or lowertext == "hey devbot" then
			
				if args.player:GetValue("DevBotActive")	== false or args.player:GetValue("DevBotActive") == nil then
				
					table.insert( MessageQueue, "Yes my lord?" )
					args.player:SetValue("DevBotActive", true)
			
				else
				
					table.insert( MessageQueue, "I'm already active, ask me anything!" )
				
				end
			
			end
		
		
		
		
			if lowertext == "devbot learn this" or lowertext == "devbot, learn this" or lowertext == "devbot, learn this:" or lowertext == "devbot learn this:" then
				
				if args.player:GetValue("DevBotLearningStage0") == false or args.player:GetValue("DevBotLearningStage0") == nil then
				
					args.player:SetValue("DevBotLearningStage0", true)
				
				end
				
			end
		
			
			if args.player:GetValue("DevBotLearningStage0") == true then
				
				if string.sub(lowertext, 1, 10) == [[trigger: "]] and string.sub(lowertext, lowertext.len(lowertext)) == [["]] then
				
					local trigger = string.sub(lowertext, 11, lowertext.len(lowertext) - 1)
					args.player:SetValue("TriggerValue", trigger)
					args.player:SetValue("DevBotLearningStage1", true)
					
				end
			
			end
			
			
			
			if args.player:GetValue("DevBotLearningStage1") == true then
				
				if string.sub(lowertext, 1, 9) == [[answer: "]] and string.sub(lowertext, lowertext.len(lowertext)) == [["]] then
					
					local answer = string.sub(lowertext, 10, lowertext.len(lowertext) - 1)
					args.player:SetValue("AnswerValue", answer)
					
					local triggervalue		=		args.player:GetValue("TriggerValue")
					local answervalue		=		args.player:GetValue("AnswerValue")
					
					TriggerTable[triggervalue] = answervalue
					table.insert( MessageQueue, "Noted. I'll remember that." )
					
					args.player:SetValue("TriggerValue", nil)
					args.player:SetValue("AnswerValue", nil)
					
					args.player:SetValue("DevBotLearningStage0", false)
					args.player:SetValue("DevBotLearningStage1", false)
					
				end
				
			end
			
			
			
			
			if lowertext:find("thanks") and lowertext:find("devbot") then
			
				table.insert( MessageQueue, "You're welcome." )
				args.player:SetValue("DevBotActive", false)
				
			end
		
		
		
		
			if lowertext == "devbot go away" or lowertext == "devbot, go away" then
				
				table.insert( MessageQueue, "Okay, I'll disable myself for a bit" )
				self.enabled = false
				args.player:SetValue("DevBotActive", false)
				
			end																			  
		
		
		
		
			if args.player:GetValue("DevBotActive") == true then
		
				for trigger, value in pairs(TriggerTable) do
			
					if lowertext:find(trigger) then
				
						DevBotMessage = value
						table.insert( MessageQueue, DevBotMessage )
						args.player:SetValue("DevBotActive", false)
						
					end
				
				end
			
			end
			
			
		end
		
		
		
		
		if lowertext == "devbot activate yourself" or lowertext == "devbot, activate yourself" or lowertext == "devbot, activate" or lowertext == "devbot activate" then
			
			if args.player:GetValue("DevBotActive") == false then
				
				table.insert( MessageQueue, "Hi! Did you miss me?" )
				self.enabled = true
			
			end
				
		end
		

end


function DevBot:PostTick()
	
		self.numtick	=	self.numtick + 1
	
		if self.numtick >= 200 then
	
			self.ProcessQueue()
			self.numtick 	=	0
		
		end
	
end


function DevBot:ProcessQueue()

		for k, message in ipairs(MessageQueue) do 
		
			Chat:Broadcast( BotName .. message, BotColor) 
			table.remove(MessageQueue, k) 
			
		end

end


devbot = DevBot()