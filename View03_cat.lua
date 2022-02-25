--링 통과하는 게임 종료된 화면

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("Content/PNG/cat/배경.png",display.contentWidth, display.contentHeight) ---배경
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)
	
	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000}) -- 배경 어둡게
	sceneGroup:insert(background1)

	local backgame =display.newImageRect("Content/PNG/fail.png",display.contentWidth/1.1,display.contentHeight/2.5) --실패할 경우
	backgame.x, backgame.y = display.contentWidth/2, display.contentHeight/2
	backgame.alpha = 1
	sceneGroup:insert(backgame)

	local function retrybtntap(event)
		composer.removeScene("View03_cat")
		composer.gotoScene("View01_cat2")
	end
	
	backgame:addEventListener("tap",retrybtntap)
	--sceneGroup:insert(backgame)

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
