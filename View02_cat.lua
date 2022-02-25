-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local result2 = composer.getVariable("complete")

	if result2 == true then
		local sceneGroup = self.view
		local background = display.newImageRect("Content/PNG/cat/배경.png",display.contentWidth, display.contentHeight) ---배경
		background.x,background.y = display.contentWidth/2,display.contentHeight/2
		sceneGroup:insert(background)

		local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
		background1:setFillColor(0)
		transition.to(background1,{alpha=0.5,time=1000}) -- 배경 어둡게
		sceneGroup:insert(background1)

		local function gomap(event) -- 게임 pass 후 넘어감
			composer.removeScene("View02_cat")
			composer.gotoScene( "story03" )
		end

		local backtomap =display.newImageRect("Content/PNG/클리어창.png",display.contentWidth/1.1,display.contentHeight/1.5) --성공할 경우
		backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/2
		sceneGroup:insert(backtomap)

		backtomap:addEventListener("touch",gomap)
	else
		composer.removeScene("View02_cat")
		composer.gotoScene("View03_cat")
	end
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
