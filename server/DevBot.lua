-------------------------------------------------------------------------------------------------------------------------------------
----|	   												    DevBot draft  v1.0		    									    |----
----|			    					 				A JC-MP Community project											    |----
-------------------------------------------------------------------------------------------------------------------------------------

class 'DevBot'


function DevBot:__init()
		
		Events:Subscribe( "PlayerChat", self, self.PlayerChat )
		Events:Subscribe( "PostTick", self, self.PostTick )
		
		MessageQueue 					= 					{}
		BotName							=					"[DevBot]: "
		BotColor						=					Color( 255, 255, 255 )
		
		self.numtick					=					0
		
end


function DevBot:ProcessQueue()

		for k, message in ipairs(MessageQueue) do 
		
			Chat:Broadcast( BotName .. message, BotColor) 
			table.remove(MessageQueue, k) 
			
		end

end


function DevBot:PlayerChat( args )
		
		local cmd_args 					= 					args.text:split( " " )
		local text 						=					args.text
		local lowertext					=					string.lower(text)
		
		
		
		

		----------------------------------------------------------------------------------------
		---------------------------------- Items about DevBot ----------------------------------
		----------------------------------------------------------------------------------------
		--																					  --
		-- DevBot deserves some attention for himself. He can tell about his own history or   --
		-- provide information about basic gameplay when people add his name in the question. --
		--																					  --
		----------------------------------------------------------------------------------------




		
		-------------------------------[ Begin DevBot name items ]------------------------------
		--																					  --
		
		if lowertext == "devbot" then
			table.insert( MessageQueue, "Yes my lord?" )
		end
		
		if lowertext == "hey devbot" then
			table.insert( MessageQueue, "Yes my lord?" )
		end
		
		--																					  --
		--------------------------------[ End DevBot name items ]-------------------------------
		
		
		
		
		
		
		
		
		----------------------------------------------------------------------------------------
		------------------------------- Items about anything else ------------------------------
		----------------------------------------------------------------------------------------
		--																					  --
		-- DevBot should provide funny comments when certain things are said in chat.         --
		--																					  --
		----------------------------------------------------------------------------------------
		
		
		
		
		
		----------------------------------[ Begin Shrek items ]---------------------------------
		--																					  --
		
		if lowertext == "shrek" then
			table.insert( MessageQueue, "Shrek is love, Shrek is life. " )
		end
		
		if lowertext == "shrook" then
			table.insert( MessageQueue, "I believe he was called Shrek. Could be wrong though. " )
		end

		if lowertext == "shack" then
			table.insert( MessageQueue, "I believe he was called Shrek. Could be wrong though. " )
		end
		
		if lowertext:find("shrek is") and lowertext:find("love") and lowertext:find("shrek is") and lowertext:find("life") then
			table.insert( MessageQueue, "It's all ogre now. " )
		end
		
		if lowertext == "shrek is love" then
			table.insert( MessageQueue, "Shrek is life" )
		end
		
		if lowertext == "shrek is life" then
			table.insert( MessageQueue, "Shrek is love" )
		end
		
		--																					  --
		-----------------------------------[ End Shrek items ]----------------------------------
		
		
		
		
		
		
		
		
		----------------------------------[ Begin GabeN items] ---------------------------------
		--																					  --
		
		if lowertext == "gaben" then
			table.insert( MessageQueue, "All hail GabeN!" )
		end
		
		if lowertext == "gabe newell" then
			table.insert( MessageQueue, "As a friend you may call him just Gabe. He likes that." )
		end
		
		if lowertext == "gabe" then
			table.insert( MessageQueue, "Gabe rhymes with Ape... *chuckles*" )
		end
		
		if lowertext == "gaboon" then
			table.insert( MessageQueue, "gaboon...kaboon...KABOOM!" )
		end
		
		if lowertext:find("gaben") and lowertext:find("hl3") then
			table.insert( MessageQueue, "What's 3? A number?" )
		end
		
		if lowertext:find("3 is a number") then
			table.insert( MessageQueue, "3 is a number? GabeN disagrees!" )
		end
		
		--																					  --
		-----------------------------------[ End GabeN items] ----------------------------------

		
end

function DevBot:PostTick()
	
		self.numtick	=	self.numtick + 1
	
		if self.numtick >= 200 then					-- This makes devbot respond at random speeds.
	
			self.ProcessQueue()
			self.numtick 	=	0
		
		end
	
end

devbot = DevBot()