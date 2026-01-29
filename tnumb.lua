SCRIPT_VERSION =  "1.8"

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
111211,
221822,
2825430,
2825392,
2823651,
121212,
990799,
2803349,
2688251,
2825243,
545555,
144441,
1315,
2826332,
2817182,
88,
2825700,
2823894,
2123800,
62,
1281997,
2811609,
2221249,
2825827,
774,
86,
888899,
898,
808909,
2671445,
2813178,
49,
654321,
770977,
2722926,
7111,
122222,
769999,
140000,
9876,
9871,
2080039,
9874,
557,
332,
888188,
899999,
555565,
6663,
31,
341,
7071,
2801665,
2551343,
4777,
196,
400,
700,
158888,
845,
2709983,
98,
2824452,
100100,
4448,
3999,
1559907,
776777,
202015,
888,
717777,
889,
555655,
222999,
344,
200,
1535,
474,
456356,
6776,
999960,
887,
308,
8881,
899,
733337,
466,
343,
888666,
9909,
2072675,
1010,
566,
91,
313133,
10,
89,
2342589,
3333,
800000,
770,
370,
4444,
45,
212,
554,
2775306,
2155888,
330330,
2232348,
9292,
2022,
667,
441,
8333,
2131790,
51,
5588,
211414,
258644,
2812838,
707,
5557,
910910,
345677,
47,
2826008,
2323,
121416,
603,
2825508,
808080,
2705882,
2817398,
9553,
404,
4141,
666666,
201369,
878,
2825188,
240444,
111151,
1444,
3233,
484444,
2824599,
1234,
2000197,
101011,
449444,
690,
444441,
440,
148888,
730000,
5453,
679,
336,
570773,
2817674,
8080,
1191,
311113,
2818248,
2769285,
6463,
3033,
2795502,
250,
2817808,
2817805,
818283,
464444,
775677,
350035,
807002,
2798554,
560,
219999,
170602,
121,
2810065,
180180,
2825144,
877,
2817220,
7272,
2812390,
322,
3737,
123,
700001,
2703280,
494,
299999,
2824550,
830000,
3321,
661453,
112,
2825301,
123452,
109,
2824639,
335,
2392995,
2817793,
3220,
937999,
234,
552,
227722,
6767,
966969,
1337,
2151777,
152200,
716,
2903,
7535,
4090,
5792,
44,
314,
2824830,
2825028,
8811,
1555,
555502,
776655,
2305964,
1910,
111911,
111011,
5115,
9877,
2802312,
992991,
1845385,
112244,
2799221,
2811479,
247,
666066,
555000,
6789,
3636,
2805430,
121215
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
	sampSendChat('/sms ' .. dopValue[znach] .. ' Приятной игры на Advance RP Blue!')
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
