-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("Content/PNG/cat/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local pond = display.newImageRect("Content/PNG/cat/스테이지2물고기.png",150*8,200*7)
	pond.x,pond.y=display.contentWidth*0.4,display.contentHeight*0.6

	local fish = { }
	local fishGroup=display.newGroup()

	for i=1,12 do
		if i%2==0 then
			fish[i] = display.newImage(fishGroup,"Content/PNG/cat/물고기2.png")
		else
			fish[i] = display.newImage(fishGroup,"Content/PNG/cat/물고기1.png")
		end
		fish[i].x,fish[i].y=pond.x+math.random(-200,200),pond.y+math.random(-200,200)
	end

	sceneGroup:insert(fishGroup)

	--고양이 소환--
	local cat = display.newImageRect("Content/PNG/cat/스테이지1고양이.png",150*1.3,200*1.3)
	cat.x,cat.y=display.contentWidth*0.7,display.contentHeight*0.4

	--스코어 출력--
	local score=0
	local showScore = display.newText(score,display.contentWidth*0.1,display.contentHeight*0.1)
	showScore:setFillColor(0)
	showScore.size=99

	--레이어 정리--
	sceneGroup:insert(background)
	sceneGroup:insert(fishGroup)
	sceneGroup:insert(pond)
	
	sceneGroup:insert(cat)
	sceneGroup:insert(showScore)

	fishGroup:toFront()

	--탭 이벤트--
	local function catch(event)
		display.remove(event.target)
		score=score+1
		showScore.text=score

		if score==12 then
			composer.setVariable("complete",true)
			composer.gotoScene("View02_cat")
		end
	end

	for i=1,12 do
		fish[i]:addEventListener("tap",catch)
	end
	
	-- 시간 제한 --

	local limit=15
	local showLimit = display.newText(limit,display.contentWidth*0.9,display.contentHeight*0.1)
	showLimit:setFillColor(0)
	showLimit.size = 80
	sceneGroup:insert(showLimit)

	local function timeAttack(event)
		limit = limit - 1
		showLimit.text=limit

		if limit == 0 then
			composer.setVariable("complete",false)
			composer.gotoScene("View02_cat")
		end
	end

	timer.performWithDelay(1000,timeAttack,0)
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
		composer.removeScene("view1")
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