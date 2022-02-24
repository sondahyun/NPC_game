-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
    local flag=1
	
	local ending = display.newText(" ",display.contentCenterX,display.contentCenterY)
	ending.size = 180

    ending.text="FAIL! 다시 하고싶다면 아래 버튼을 눌러주세요"
    composer.setVariable("flag",true)
    local button = display.newImageRect("Content/PNG/cat/미니게임옵션_다시하기.png",150*8.5,200*1.7)
	button.x,button.y=display.contentWidth*0.5,display.contentHeight*0.8


    sceneGroup:insert(ending)
    sceneGroup:insert(button)

    local function tapp(event)
		display.remove(event.target)
		flag=0

		if flag==0 then
            composer.removeScene("View03_cat")
			composer.gotoScene("View01_cat2")
		end
	end

	button:addEventListener("tap",tapp)
	
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
