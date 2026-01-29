SCRIPT_VERSION =  "1.9"

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
2774504,
2815984,
2825416,
2221249,
221822,
1281997,
2782212,
2825814,
2825392,
144441,
2817182,
1315,
2826332,
2823859,
88,
986898,
222223,
2825477,
62,
2790603,
774,
86,
898,
522222,
2671445,
2667340,
570,
654321,
8881,
939,
9909,
580022,
707555,
2342589,
9876,
9871,
557,
332,
899999,
555565,
122222,
31,
779,
2809858,
2115943,
7071,
1975368,
2551343,
4777,
196,
400,
9333,
700,
158888,
2709983,
98,
100100,
100,
4448,
9874,
776677,
1559907,
776777,
49,
888899,
1101,
7977,
222999,
333393,
2232348,
344,
690000,
733337,
6663,
474,
456356,
667,
75,
6776,
2072675,
887,
717777,
899,
341,
7700,
466,
8932,
343,
2775306,
308,
2636192,
99,
91,
313133,
10,
441,
3333,
370,
9997,
999960,
45,
212,
554,
2558389,
2825169,
2444,
442,
2807842,
211771,
330330,
567,
211414,
258644,
707,
5557,
910910,
345677,
47,
2826008,
121416,
603,
2823741,
2825508,
2606,
2825243,
808080,
2817398,
9553,
511111,
2825859,
666666,
570773,
878,
2045361,
2825188,
240444,
2816655,
2813178,
700001,
679,
690,
111119,
440,
2824550,
730000,
2825144,
2818248,
111001,
148888,
2175957,
9697,
336,
3233,
2817808,
111151,
2000197,
2807878,
2824599,
5453,
1191,
311113,
710,
2817805,
1600,
201369,
3033,
5050,
464444,
444441,
255552,
775677,
1444,
807002,
2798554,
560,
700770,
170602,
121,
2822011,
138877,
818283,
101011,
877,
555005,
2824639,
3737,
937999,
661453,
123,
2812390,
112,
7075,
7272,
494,
830000,
552,
2155933,
2824700,
123452,
109,
299999,
335,
2825301,
2817793,
234,
227722,
966969,
1337,
2803961,
7535,
8811,
716,
2801068,
2305964,
152200,
5792,
2289,
4090,
44,
314,
2825028,
2710491,
2824830,
27,
8000,
777222,
57,
111911,
111011,
5115,
4308,
2799221,
204700,
992991,
9877,
2802312,
2727,
2695240,
112244,
4989,
1845385,
2811479,
833383,
555000,
6789,
3636,
2155888,
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
	sampSendChat('/sms ' .. dopValue[znach] .. ' Извиняюсь за беспокойство, tasks')
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
