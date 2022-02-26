-----------------------------------------------------------------------------------------
--
-- story.lua
--
-----------------------------------------------------------------------------------------
-- JSON파싱--
local json = require("json")

local Data, pos, msg

local function parse()
	local filename = system.pathForFile("Content/JSON/story02.json")
	Data, pos, msg = json.decodeFile(filename)

	--디버그
	if Data then
		print(Data[1].type)
	else
		print(pos)
		print(print)
	end
	--
end
parse()

local composer = require( "composer" )
local scene = composer.newScene()
--local explosionSound = audio.loadSound( "Content/PNG/script/다시그곳으로.mp3" )
--audio.play( explosionSound )
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view
	loadedEnding = loadsave.loadTable( "ending.json" )

	
	local background = display.newImage( "Content/PNG/script/background/개울1.png")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.8, 0.8, 0.8, 0.8)

	local speakerImg = display.newRect(section.x, section.y - 700, 900, 900)

	local speaker = display.newText("더미 텍스트", section.x-290, section.y-75)
	speaker.size = 70
	speaker.width = display.contentWidth
	speaker:setFillColor(0)

	local script = display.newText("더미 텍스트입니다.", section.x+100, section.y+30, display.contentWidth, 120)
	script.width = display.contentWidth
	script.size = 50
	script:setFillColor(0)

	local ending = display.newImage( "Content/PNG/stage/게임시작.png")
    ending.alpha=0
   ending.x, ending.y = display.contentWidth*0.5, display.contentHeight/2 - 600

	-----음악

    

    --샘플 볼륨 이미지
    local volumeButton = display.newImage("Content/PNG/설정/설정.png")
    volumeButton.x,volumeButton.y = display.contentWidth * 0.87, display.contentHeight - 1800
    sceneGroup:insert(volumeButton)

    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    local home = audio.loadStream( "Content/PNG/script/다시그곳으로.mp3" )
    audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    audio.play(home)


    -------------

	-- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

	local index = 1
		local function nextScript( ... )
		if(index <= #Data) then
			if(Data[index].type == "background") then

				--배경을 바꾸기
				background.fill = {
					type = "image",
					filename = Data[index].img
				}
				index = index + 1
				nextScript()

			elseif( Data[index].type == "Narration") then

				--(해설)
				speakerImg.alpha = 0
				speaker.alpha = 0

				script.text = Data[index].content

				index = index + 1

			elseif(Data[index].type == "Dialogue") then

				--대사
				speakerImg.alpha = 1
				speakerImg.fill = {
					type = "image",
					filename = Data[index].img
				}
				speaker.alpha = 1
				speaker.text = Data[index].speaker

				script.text = Data[index].content

				index = index + 1
			end
		else
			ending.alpha=1
		end
	end
	nextScript()

	local function tap( event )
		nextScript()
	end

	local function gametap(event)
		audio.pause( explosionSound )
		composer.removeScene("story02")
		composer.gotoScene("View01_cat_start")
	end

 
	section:addEventListener("tap",tap)
	ending:addEventListener("tap", gametap)
 
	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(section)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(speaker)
	sceneGroup:insert(script)
	sceneGroup:insert(ending)
	sceneGroup:insert(volumeButton)
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
		composer.removeScene("pig")
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