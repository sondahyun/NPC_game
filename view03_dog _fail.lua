-----------------------------------------------------------------------------------------
--
-- view03_dog_fail.lua
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

	local failtext = display.newText("", display.contentWidth/2, display.contentHeight/2)
	failtext.size = 90
	failtext:setFillColor(0)

	local function timeAttack(event)
		failtext.text = "FAIL!! 클릭해서 다시 시작"
	end

	local function retrybtntap(event)
		composer.gotoScene("view02_dog")
	end
	timer.performWithDelay(0, timeAttack, 0)
	background:addEventListener("tap",retrybtntap)
	

	sceneGroup:insert(background)
	sceneGroup:insert(failtext)
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
