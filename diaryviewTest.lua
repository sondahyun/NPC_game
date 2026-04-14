-----------------------------------------------------------------------------------------
--
-- diaryviewTest.lua
-- 일지(다이어리) 뷰어 - 좌우 화살표로 페이지 넘기기
--
-----------------------------------------------------------------------------------------

local json = require("json")
local composer = require("composer")
local scene = composer.newScene()

local Data, pos, msg
local bgMusic

local function parse()
	local filename = system.pathForFile("Content/JSON/diaryStory.json")
	Data, pos, msg = json.decodeFile(filename)

	if Data then
		print(Data[1].type)
	else
		print("JSON parse error: " .. tostring(pos))
		print("Message: " .. tostring(msg))
	end
end
parse()

function scene:create(event)
	local sceneGroup = self.view

	bgMusic = audio.loadSound("Content/PNG/script/정혁준_즐거운 추억.mp3")
	audio.play(bgMusic)

	local background = display.newImageRect("Content/PNG/diary/일지_배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth / 2, display.contentHeight / 2

	local speakerImg = display.newRect(display.contentCenterX, display.contentHeight * 0.73046875, 1100, 940)
	local speaker = display.newRect(display.contentCenterX, display.contentHeight * 0.2, 700, 700)
	local index = 1

	local button2 = display.newImage("Content/PNG/diary/닫기.png")
	button2.x, button2.y = display.contentWidth * 0.95, display.contentHeight * 0.05

	local arrowleft = display.newImageRect("Content/PNG/diary/arrow.png", 80, 80)
	arrowleft.xScale = arrowleft.xScale * -1
	arrowleft.x, arrowleft.y = speaker.x - 320, speaker.y - 65
	arrowleft.alpha = 0

	local arrowright = display.newImageRect("Content/PNG/diary/arrow.png", 80, 80)
	arrowright.x, arrowright.y = speaker.x + 320, speaker.y - 65

	local function updateDisplay()
		if not Data or index < 1 or index > #Data then return end

		arrowleft.alpha = 1
		arrowright.alpha = 1

		if Data[index].type == "background" then
			speakerImg.alpha = 1
			speakerImg.fill = {
				type = "image",
				filename = Data[index].img
			}
			speaker.alpha = 1
			speaker.fill = {
				type = "image",
				filename = Data[index].img2
			}
		end

		-- 첫 페이지면 왼쪽 화살표 숨김
		if index <= 1 then
			arrowleft.alpha = 0
		end
		-- 마지막 페이지면 오른쪽 화살표 숨김
		if index >= #Data then
			arrowright.alpha = 0
		end
	end

	updateDisplay()

	local function tap_next()
		if index < #Data then
			index = index + 1
			updateDisplay()
		end
	end

	local function tap_before()
		if index > 1 then
			index = index - 1
			updateDisplay()
		end
	end

	arrowleft:addEventListener("tap", tap_before)
	arrowright:addEventListener("tap", tap_next)

	local function tap()
		if bgMusic then
			audio.pause(bgMusic)
		end
		composer.removeScene("diaryviewTest")
		composer.gotoScene("View01_main")
	end

	button2:addEventListener("tap", tap)

	sceneGroup:insert(background)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(speaker)
	sceneGroup:insert(arrowleft)
	sceneGroup:insert(arrowright)
	sceneGroup:insert(button2)
end

function scene:show(event)
	local phase = event.phase
	if phase == "will" then
	elseif phase == "did" then
	end
end

function scene:hide(event)
	local phase = event.phase
	if phase == "will" then
	elseif phase == "did" then
		if bgMusic then
			audio.dispose(bgMusic)
			bgMusic = nil
		end
	end
end

function scene:destroy(event)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
