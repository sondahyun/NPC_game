--병아리 게임 진행하는 화면

local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--require
	local physics = require ("physics")
	physics.start()

	local value1 = {}
	for i=1,10 do
		value1[i] = math.random(0,200)
	end

	local value2 = {}
	for i=1,10 do
		value2[i] = display.contentWidth*0.46875 + value1[i]*1.5 --* display.contentWidth*0.20833333 -500
	end
	
	--배경화면
	local bg = display.newImage("Content/PNG/chick/배경.png", display.contentWidth, display.contentHeight)
    bg.x = display.contentWidth/2
    bg.y = display.contentHeight/2
    sceneGroup:insert(bg)

	--객체
	local user = display.newImageRect("Content/PNG/chick/병아리.png", display.contentWidth/13, display.contentHeight/13)
	user.x = display.contentWidth/5
	user.y = display.contentHeight/1.6
	user.rotation = -40
	physics.addBody(user, "dynamic", {density=.08, friction=0.1, bounce=1.0, radius=15})
	sceneGroup:insert(user)

--그룹
	
    local walld = {}
    for i=1,10 do
        walld[i] = display.newImageRect("Content/PNG/chick/장애물.png", display.contentWidth/13, display.contentHeight/4)
        walld[i].x = display.contentWidth*i*0.5 + 400
        walld[i].y = value2[i]*1.7
        sceneGroup:insert(walld[i])
        physics.addBody(walld[i], "static")   
	end

    

	--all()
	local inv1 = display.newImage("Content/PNG/chick/투명줄.png")
	inv1.x = 0
	inv1.y = -display.contentHeight * 0.00925 -- -10
	physics.addBody(inv1, "static")
	local inv2 = display.newImage("Content/PNG/chick/투명줄.png")
	inv2.x = 0
	inv2.y = display.contentHeight * 1.00925926
	physics.addBody(inv2, "static")
	
	sceneGroup:insert(inv1)
	sceneGroup:insert(inv2)


	--function--

	function movewall(self, event) -- 장애물 움직임
		if self.x < -display.contentWidth*2.08333 then --4000
			self.x = display.contentWidth*111.04166 --2000
		else
			self.x = self.x - 5	
		end
    end
    
    for i=1, 10 do
        walld[i].enterFrame = movewall --장애물 움직임
        Runtime:addEventListener("enterFrame", walld[i])
    end

	function activeUser(self, event)
		self:applyForce(0, -1.5, self.x, self.y)
	end

	--[[function activeUser1(self, event)
		self:applyForce(0, 0.3, self.x, self.y)
	end]]

	function touchScreen(event)
		if event.phase == "began" then
			user.enterFrame = activeUser --위로 이동함
			Runtime:addEventListener("enterFrame", user)
		end
		
		if event.phase == "ended" then
			Runtime:removeEventListener("enterFrame", user)
			--user.enterFrame = activeUser1
			--Runtime:addEventListener("enterFrame", user)
		end
		--Runtime:removeEventListener("enterFrame", user)
	end
	--Runtime:removeEventListener("enterFrame", user)
	Runtime:addEventListener("touch",touchScreen)

	--timer
	local time = 0
 
	local function Timer(event)
		time = time + 1
		composer.setVariable("score", time)

		if  time == 15  then

			inv1:removeEventListener( "collision" )
			inv2:removeEventListener( "collision" )

			for i=1,10 do
    			walld[i]:removeEventListener("collision")
        		Runtime:removeEventListener("enterFrame", walld[i])
			end

			Runtime:removeEventListener("touch",touchScreen)
			Runtime:removeEventListener("enterFrame", user)

         	display.remove(user)

			composer.setVariable("score", time)
			composer.removeScene("view06_chick_game") --game
			composer.gotoScene("view07_chick_game_over") --gameover

			timer.cancel( event.source )
	 
			
		end
	end
	
	local tmr = timer.performWithDelay(1000, Timer, 15)

	local function onLocalCollision( self, event )
 
		if ( event.phase == "began" ) then

			inv1:removeEventListener( "collision" )
			inv2:removeEventListener( "collision" )

			for i=1,10 do
    			walld[i]:removeEventListener("collision")
        		Runtime:removeEventListener("enterFrame", walld[i])
			end

			composer.setVariable("score", time)
			timer.cancel(tmr)

			Runtime:removeEventListener("touch",touchScreen)
			Runtime:removeEventListener("enterFrame", user)

         	display.remove(user)
			composer.removeScene("view06_chick_game")
			composer.gotoScene("view07_chick_game_over")
	 
		
			
		end
	end
	 
	user.collision = onLocalCollision
	user:addEventListener( "collision" )
	
	inv1.collision = onLocalCollision
	inv1:addEventListener( "collision" )
	inv2.collision = onLocalCollision
	inv2:addEventListener( "collision" )

    for i=1,10 do
        walld[i].collision = onLocalCollision
        walld[i]:addEventListener( "collision" )
        --[[inv3[i].collision = onLocalCollision
        inv3[i]:addEventListener( "collision" )
        inv4[i].collision = onLocalCollision
        inv4[i]:addEventListener( "collision" )]]
	end
	
	
	-- all objects must be added to group (e.g. self.view)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		composer.removeScene("view06_chick_game")
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
