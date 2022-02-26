-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local ff=0

	local explosionSound = audio.loadSound( "Content/PNG/cat/계곡물.mp3" )
	audio.play( explosionSound )

	local function makefish()
		local background = display.newImageRect("Content/PNG/cat/배경.png", display.contentWidth, display.contentHeight)
		background.x, background.y = display.contentWidth/2, display.contentHeight/2

		local howtoplay=display.newText("제한시간안에 클릭하여 물고기를 잡으세요!",display.contentCenterX,display.contentWidth*0.2)
		howtoplay.size=50


		local pond = display.newCircle(display.contentWidth*0.5,display.contentHeight*0.7,530)

		local fish = { }
		local fishGroup=display.newGroup() 

		for i=1,12 do
			if i%2==0 then
				fish[i] = display.newImage(fishGroup,"Content/PNG/cat/물고기2.png")
			else
				fish[i] = display.newImage(fishGroup,"Content/PNG/cat/물고기1.png")
			end
			fish[i].x,fish[i].y=pond.x+math.random(-480,480),pond.y+math.random(-380,500)
		end

		--스코어 출력--
		local score=0
		local print= display.newImage("Content/PNG/스코어.png")
		print.x,print.y=display.contentWidth*0.52,display.contentHeight*0.05
		local showScore = display.newText("",display.contentWidth*0.519,display.contentHeight*0.062)
		showScore:setFillColor(0)
		showScore.size=70

		--레이어 정리--
		sceneGroup:insert(pond)
		sceneGroup:insert(background)
		sceneGroup:insert(fishGroup)
		sceneGroup:insert(print)
		sceneGroup:insert(showScore)
		sceneGroup:insert(howtoplay)

		--fishGroup:toFront()
		
		-- 시간 제한 --

		local result = composer.getVariable("flag")


		local limit=10
		local print3= display.newImage("Content/PNG/시간.png")
		print3.x,print3.y=display.contentWidth*0.15,display.contentHeight*0.05
		print3.size = 70
		local showLimit = display.newText("",display.contentWidth*0.15,display.contentHeight*0.062)
		showLimit:setFillColor(0)
		showLimit.size = 70
		sceneGroup:insert(print3)
		--showScore:toFront()
		sceneGroup:insert(showLimit)

		local function timeAttack(event)
			limit = limit - 1
			showLimit.text=limit

			if limit == 0 then
				composer.setVariable("complete",false)
				audio.pause( explosionSound )
				timer.cancel(timer1)
				--makefish()
				composer.removeScene("View01_cat2")
				composer.gotoScene("View02_cat")
			end
		end

		timer1=timer.performWithDelay(1000,timeAttack,0)

		--탭 이벤트--
		local function catch(event)
			display.remove(event.target)
			score=score+1
			showScore.text=score

			if score==12 then
				composer.setVariable("complete",true)
				audio.pause( explosionSound )
				timer.cancel( timer1 )
				ff=2
				composer.removeScene("View01_cat")
				composer.gotoScene("View02_cat")
			end
		end

		for i=1,12 do
			fish[i]:addEventListener("tap",catch)
		end
	end
	
	if ff==0 then
		makefish()
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
		composer.removeScene("View01_cat")
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