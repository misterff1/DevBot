-------------------------------------------------
----|			  DevBot  v0.1.2			|----
----|		A JC-MP Community project		|----
-------------------------------------------------

class 'DevBot'


function DevBot:__init()
		
		Events:Subscribe( "PlayerChat", self, self.PlayerChat )
		Events:Subscribe( "PostTick", self, self.PostTick )
		
		MessageQueue 					= 					{}
		TriggerTable					=					{}

		BotName							=					"devbot" 		-- must be lowercase!
		BotTag							=					"[DevBot]: "
		BotColor						=					Color( 255, 255, 255 )
		
		self.numtick					=					0
		self.enabled					=					true
		
end


function DevBot:PlayerChat( args )
		
		local lowertext					=					string.lower(args.text)
		
		if self.enabled then
		
		
			if lowertext == BotName or lowertext == "hey " .. BotName then
				if args.player:GetValue("BotActive")	== false or args.player:GetValue("BotActive") == nil then
					
					table.insert( MessageQueue, "Yes my lord?" )
					args.player:SetValue("BotActive", true)
					
				else
					
					table.insert( MessageQueue, "I'm already active, ask me anything!" )
					
				end
			end

			
			if lowertext == BotName .. " learn this" or lowertext == BotName .. ", learn this" or lowertext == BotName .. " learn this:" or lowertext == BotName .. ", learn this:" then
				if args.player:GetValue("BotLearningStage0") == false or args.player:GetValue("BotLearningStage0") == nil then
					
					args.player:SetValue("BotLearningStage0", true)
					
				end
			end
			
			
			if args.player:GetValue("BotLearningStage0") == true then
				if string.sub(lowertext, 1, 9) == [[trigger: ]] then
					
					local trigger = string.sub(lowertext, 11, lowertext.len(lowertext))
					args.player:SetValue("TriggerValue", trigger)
					args.player:SetValue("BotLearningStage1", true)
					
				end
			end

			
			if args.player:GetValue("BotLearningStage1") == true then
				if string.sub(lowertext, 1, 8) == [[answer: ]] then
					
					local answer = string.sub(lowertext, 9, lowertext.len(lowertext))
					args.player:SetValue("AnswerValue", answer)
					
					local triggervalue		=		args.player:GetValue("TriggerValue")
					local answervalue		=		args.player:GetValue("AnswerValue")
					
					TriggerTable[triggervalue] = answervalue
					table.insert( MessageQueue, "Noted. I'll remember that." )
					
					args.player:SetValue("TriggerValue", nil)
					args.player:SetValue("AnswerValue", nil)
					
					args.player:SetValue("BotLearningStage0", false)
					args.player:SetValue("BotLearningStage1", false)

				end
			end
			
			
			if lowertext == BotName .. " remove this" or lowertext == BotName .. ", remove this" or lowertext == BotName .. " remove this:" or lowertext == BotName .. ", remove this:" then
				if args.player:GetValue("BotRemoval") == false or args.player:GetValue("BotRemoval") == nil then
					
					args.player:SetValue("BotRemoval", true)
					
				end
			end
			
			
			if args.player:GetValue("BotRemoval") == true then
				if string.sub(lowertext, 1, 9) == [[trigger: ]] then
					
					local trigger = string.sub(lowertext, 10, lowertext.len(lowertext))
					args.player:SetValue("TriggerValue", trigger)
					
					local triggervalue		=		args.player:GetValue("TriggerValue")
					
					TriggerTable[triggervalue] = nil
					table.insert( MessageQueue, "Got it. I removed that one for you." )
					
					args.player:SetValue("TriggerValue", nil)
					args.player:SetValue("BotRemoval", false)
					
				end
			end
			
			
			if lowertext:find("thanks") and lowertext:find(BotName) then
			
				table.insert( MessageQueue, "You're welcome." )
				args.player:SetValue("BotActive", false)
				
			end

			
			if lowertext:find("never mind") and lowertext:find(BotName) then
			
				table.insert( MessageQueue, "Okay, let me know when you need me." )
				args.player:SetValue("BotActive", false)
				
			end
			
			
			if lowertext == BotName .. " go away" or lowertext == BotName .. ", go away" then
				
				table.insert( MessageQueue, "Okay, I'll disable myself for a bit" )
				self.enabled = false
				args.player:SetValue("BotActive", false)
				
			end																			  

			
			if args.player:GetValue("BotActive") == true or string.sub(lowertext, 1, 6) == [[devbot]] then
				for trigger, value in pairs(TriggerTable) do
					if lowertext:find(trigger) then
				
						DevBotMessage = value
						table.insert( MessageQueue, DevBotMessage )
						args.player:SetValue("BotActive", false)
						
					end
				end
			end
			
		end

		
		if lowertext == BotName .. " activate yourself" or lowertext == BotName .. ", activate yourself" or lowertext == BotName .. " activate" then
			if args.player:GetValue("BotActive") == false then
				
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
		
			Chat:Broadcast( BotTag .. message, BotColor) 
			table.remove(MessageQueue, k) 
			
		end

end


devbot = DevBot()