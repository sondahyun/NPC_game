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

	---local explosionSound = audio.loadSound( "Content/PNG/script/City Key.mp3" )
	--audio.play( explosionSound )

	local background = display.newImageRect("Content/PNG/dog/배경.png",display.contentWidth, display.contentHeight) ---배경
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)

	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000}) -- 배경 어둡게
	sceneGroup:insert(background1)

	local result = composer.getVariable("complete")

	--close 버튼
	local clear_close = display.newImageRect("Content/PNG/설정/닫기.png", 150, 150)
	clear_close.x, clear_close.y = 950, 400
	clear_close.alpha = 0


	local function gomap(event) -- 게임 pass 후 넘어감
		if event.phase == "began" then--view20ring
				audio.stop(1)
				composer.removeScene("view05_dog_end")
				composer.gotoScene( "story11" )
		end
	end

	if result == 1 then 
		local backtomap =display.newImageRect("Content/PNG/클리어창.png",display.contentWidth/1.1,display.contentHeight/1.5) --성공할 경우
		backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/2
		sceneGroup:insert(backtomap)
		clear_close.alpha = 1
		clear_close:addEventListener("touch",gomap)
	else
		composer.gotoScene("view03_dog_fail")
	end
	--sceneGroup:insert(background1)
	--sceneGroup:insert(backtomap)
	sceneGroup:insert(clear_close)
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
