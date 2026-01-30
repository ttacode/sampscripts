SCRIPT_VERSION =  "2.7"

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
9222,
153153,
45,
700001,
800000,
555565,
7111,
733337,
1010,
6900,
9292,
2816881,
700,
474,
2807842,
2775306,
9874,
555050,
666777,
717777,
158888,
2709983,
9876,
7071,
344,
4777,
665,
9871,
400,
332,
774,
3883,
121,
7007,
888188,
898,
456356,
2558389,
2444,
606606,
4944,
2825169,
330330,
2826325,
9200,
666999,
933333,
777977,
769999,
939,
2714287,
343,
196,
8881,
1980347,
9999,
228322,
1300258,
2826616,
580022,
2667340,
448,
225588,
282828,
49,
350035,
5568,
776677,
9997,
15,
13,
464444,
120,
91,
2673586,
7474,
845,
557,
31,
79,
8800,
308,
1101,
888,
2725087,
555655,
2115943,
779,
202021,
75,
1559907,
370,
999960,
2215177,
707555,
4080,
603,
808080,
47,
2825392,
211,
661453,
40,
2817382,
2817398,
2705882,
910910,
2823863,
1515,
5557,
166665,
2817862,
111911,
2612264,
666666,
7300,
170602,
818283,
440,
111167,
2810671,
111001,
507777,
444441,
690,
144,
2807878,
3033,
1911,
333002,
2826008,
106,
1444,
119,
138138,
101011,
2798554,
484444,
371,
111151,
2816655,
2779963,
180180,
431,
878,
2800,
234,
9095,
830000,
3737,
232,
551,
1133,
2155933,
494,
769,
123,
661,
566,
335,
148867,
1551,
6767,
7272,
2787544,
3636,
2546775,
100001,
552,
1500,
112,
2822407,
555005,
299999,
937999,
2703280,
2233,
966969,
2000197,
8811,
2818248,
27,
2305964,
111011,
866666,
1337,
555888,
114433,
878888,
152200,
776655,
80,
1555,
7331,
2803961,
201369,
716,
7535,
2818267,
555502,
333300,
5792,
2551343,
1664116,
4090,
1910,
5115,
122222,
3100,
247,
333111,
2824639,
2825188,
1202,
2816833,
2802312,
228,
152,
2155888,
775677,
6789,
1281997,
2232,
808707,
313133,
833383,
2825700,
2823859,
2803349,
2825083,
133338,
815,
2825376,
404040,
2825430,
633,
2525,
1315,
2811609,
959959,
6166,
88,
655556,
2825746
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

    sampAddChatMessage("[TNUMB] Найдена свежая версия", 0x00FFCC)

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
	sampSendChat('/sms ' .. dopValue[znach] .. ' Привет, хорошего вечера!')
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
