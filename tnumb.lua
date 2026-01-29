SCRIPT_VERSION =  "1.2"

local sampev = require("lib.samp.events")

local requests = require("requests")

require "moonloader"
local encoding = require "encoding"
encoding.default = "CP1251"
u8 = encoding.UTF8
local function safeDecode(str)
    if str and type(str) == "string" then
        return u8:decode(str)
    else
        return ""
    end
end

title = safeDecode(title)

local bn = 0
local ln = 0
local sn = 0
local sdelay = 990

local UPDATE_URL = "https://raw.githubusercontent.com/ttacode/sampscripts/refs/heads/main/tnumb.lua"
local VERSION_URL = "https://raw.githubusercontent.com/ttacode/sampscripts/refs/heads/main/version.txt"

local findValue = {}

local dopValue = {
555655,
1315,
88,
444415,
399990,
959959,
79,
86,
2444,
898,
343,
228322,
441,
700,
654321,
570,
200202,
690000,
9876,
9871,
9874,
999905,
557,
66,
333363,
717777,
468531,
295,
5588,
9600,
9909,
733337,
196,
400,
845,
669669,
9095,
113011,
121,
424,
333000,
45,
666686,
899,
1917,
51,
700001,
1050,
707,
345677,
40,
455555,
603,
201369,
700485,
808080,
5557,
148888,
666666,
279,
311113,
240444,
366666,
930,
9996,
91,
3939,
250,
111411,
690,
31,
484444,
9499,
119,
444441,
5453,
219999,
560,
406000,
111151,
350035,
4400,
3033,
345,
111167,
1255,
2030,
2800,
234,
551,
299999,
3737,
112,
1551,
6866,
215216,
737777,
1133,
335,
552,
566,
123,
966969,
1337,
359822,
665666,
716,
152200,
679,
776655,
600700,
555502,
8555,
123333,
7535,
1910,
696969,
111911,
2903,
449444,
27,
314,
877,
101,
5115,
992991,
440,
987,
2232,
3636,
445544,
6789,
405060
}


local function checkForUpdate()
    local ok, res = pcall(function()
        return requests.get(VERSION_URL)
    end)

    if not ok or not res or res.status_code ~= 200 then
        return
    end

    local remoteVersion = res.text:gsub("%s+", "")
    if remoteVersion == SCRIPT_VERSION then
		sampAddChatMessage("[TNUMB] Обновление не найдено", 0xA9A9A9)
        return
    end

    sampAddChatMessage(
        string.format("[TNUMB] Найдена новая версия: %s (твоя %s)",
        remoteVersion, SCRIPT_VERSION),
        0x00FFCC
    )

    local file = requests.get(UPDATE_URL)
    if not file or file.status_code ~= 200 then
        sampAddChatMessage("[TNUMB] Ошибка загрузки файла", 0xA9A9A9)
        return
    end

    local f = io.open(thisScript().path, "w")
    if not f then
        sampAddChatMessage("[TNUMB] Не удалось перезаписать файл", 0xA9A9A9)
        return
    end

    f:write(u8:decode(file.text))
    f:close()

    sampAddChatMessage("[TNUMB] Скрипт обновлён, перезагрузка...", 0x00FFCC)
    thisScript():reload()
end

function main()
  repeat wait(0) until isSampAvailable()
  sampRegisterChatCommand("tnumb", cmd_tnumb)
  sampRegisterChatCommand("snumb", cmd_snumb)
  sampRegisterChatCommand("smsdelay", cmd_smsdelay)
	sampRegisterChatCommand("update", checkForUpdate)
	while not isSampAvailable() do wait(100) end
end



function sampev.onShowDialog(id, style, title, b1, b2, text)

if title:find('Сотрудники онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('.*_.*[%d+].*%d+.*{99b3ff}%d+') then
tnumber = line:match('.*_.*[%d+].*%d+.*{99b3ff}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Врачи онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Лицензеры онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Адвокаты онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end
end



function tnumb()
lua_thread.create(function()
znach = 0
	for i = 0, 1000 do
		znach = znach + 1
		if not findValue[znach] or bn == 0 then
			break
		end
	sampSendChat('/sms ' .. findValue[znach] .. ' tasks')
		wait(sdelay)
	end
end)
end

function snumb()
lua_thread.create(function()
znach = 0
	for i = 0, 1000 do
		znach = znach + 1
		if not dopValue[znach] or sn == 0 then
			break
		end
	sampSendChat('/sms ' .. dopValue[znach] .. ' tasks')
		wait(sdelay)
	end
end)
end

function cmd_tnumb(arg)
	if bn == 0 then
		bn = 1
		printStringNow('TASK NUMBERFIND ON', 1000)
	else
		bn = 0
		printStringNow('TASK NUMBERFIND OFF', 1000)
	end
end

function cmd_snumb(arg)
	if sn == 0 then
		sn = 1
		snumb()
		printStringNow('TASK FRESHNUMBER ON', 1000)
	else
		sn = 0
		printStringNow('TASK FRESHNUMBER OFF', 1000)
	end
end


function cmd_smsdelay(param)
		if tonumber(param) ~= nil then
			param = tonumber(param)
				if param < 500 or param > 5000 then
					sampAddChatMessage("Укажи корректную задержку (500-5000)", -1)
				else
					sampAddChatMessage('Delay '.. param .. ' ms', -1)
					sdelay = param
				end
		else
			sampAddChatMessage("Укажи задержку", -1)
		end
end
