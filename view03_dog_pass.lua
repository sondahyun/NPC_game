-----------------------------------------------------------------------------------------
--
-- view03_dog.lua
--
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect(display.contentWidth/2, display.contentHeight/2,
		display.contentWidth, display.contentHeight)
	background:setFillColor(1)
	
	local ending = display.newText("", display.contentWidth/2, display.contentHeight/2)
	ending.size = 90
	ending:setFillColor(0)

	local result = composer.getVariable("complete")

	local function nextlevel(event)
		composer.gotoScene("view02_dog")
	end

	if result then 
		-- 레벨 통과 글 써주기--
		ending.text = "Level"..result.." pass!!"
		composer.removeScene("view03_dog_pass")
		composer.gotoScene("view02_dog_start") 
	else
		-- view02_dog_start로 가야 레벨 2가 시작됨--
		composer.gotoScene("view02_dog_start") 
	end
	timer.performWithDelay(1000, timeAttack, 0)
	background:addEventListener("tap",nextlevel)

	-- sceneGroup으로 묶어줌--
	sceneGroup:insert(background)
	sceneGroup:insert(ending)
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
		-- Called when the scene is now off screen
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
