SCRIPT_VERSION =  "1.5"

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
144441,
2811609,
555655,
2825409,
1315,
88,
927838,
2825430,
444415,
399990,
2825392,
2344571,
2652076,
468531,
2237318,
990799,
121,
79,
86,
898,
9999,
2671445,
343,
441,
654321,
570,
690000,
9876,
9871,
333000,
9909,
9874,
557,
66,
2816525,
717777,
31,
7799,
13,
733337,
196,
400,
669669,
9095,
113011,
888666,
2825473,
2709983,
211771,
7007,
899,
3999,
2775306,
580022,
424,
780,
212,
868888,
4434,
700001,
344,
468531,
7977,
7474,
771100,
707,
345677,
700485,
2825068,
455555,
603,
2824946,
201369,
808080,
5557,
2820033,
747,
468531,
666666,
240444,
2822237,
1200682,
3939,
250,
679,
9996,
690,
690096,
2000197,
828888,
366666,
336,
1255,
9499,
119,
2175957,
2030,
444441,
406000,
5453,
1000050,
560,
877,
2807878,
345,
111162,
127,
111167,
2816655,
9112,
4040,
2800,
4400,
279,
468531,
91,
2801207,
3033,
881488,
138138,
661453,
234,
7272,
299999,
551,
3737,
112,
1551,
737777,
1133,
335,
552,
100002,
51,
566,
123,
2817722,
6866,
468531,
966969,
2825686,
1337,
359822,
716,
665666,
152200,
111911,
600700,
2818267,
2305964,
7535,
9100,
1910,
696969,
2903,
449444,
866666,
27,
444448,
101,
314,
468531,
555502,
2695240,
1911,
5115,
992991,
440,
2646,
2815205,
2802312,
1845385,
468531,
333111,
2232,
3636,
445544,
6789,
468531
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
