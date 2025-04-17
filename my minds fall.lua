local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/stysscythe/script/main/LibTest.lua"))()
local Window = Library.Window('KR4K Library')
local player = game:GetService("Players").LocalPlayer

local MainWin = Window.CreateTab('Main')
local Main2Win = Window.CreateTab('Main2')
local setting = Window.CreateTab('Setting')
local setting2 = Window.CreateTab('Setting2')
local teleport = Window.CreateTab('Teleport')
local Extra = Window.CreateTab("Extra")

--kill aura
MainWin.CreateDivider("Kill aura")
local Ktoggle = false
local weapon_list = {"Heavy","Light","Drone"}
local weapon = weapon_list[1]
local range = 70
MainWin.CreateLabel("Default:Heavy,70") 
MainWin.CreateButton("Turn on kill aura", function()
    Ktoggle = true
    Kill_aura(weapon, range)
end)
MainWin.CreateButton("Turn off kill aura", function()
    Ktoggle = false
end)


--heal aura
MainWin.CreateDivider("heal aura(equip healing weapon)")
MainWin.CreateLabel("you and Target must in the same area(e.g.same raid)")

local heal_list = {}
local Htoggle = false
local TPH = 0
MainWin.CreateButton("Heal", function()
    heal_all(heal_list)
end)
MainWin.CreateButton("auto", function()
    Htoggle = true
    repeat
        wait(TPH)
        heal_all(heal_list)
    until Htoggle == false
end)
MainWin.CreateButton("stop auto", function()
    Htoggle = false
end)


--auto dungeon
MainWin.CreateDivider("auto sewer to 100")
MainWin.CreateButton("Start", function()
        local args = {
        [1] = {
            ["T"] = "InfExplore";
        };
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remote", 9e9):WaitForChild("ExploreRE", 9e9):FireServer(unpack(args))
    wait(2)
    
    auto_dungeon()
end)
MainWin.CreateButton("auto", function()
    local Dtoggle = true
    repeat
        local args = {
        [1] = {
            ["T"] = "InfExplore";
        };
    }
    
        game:GetService("ReplicatedStorage"):WaitForChild("Remote", 9e9):WaitForChild("ExploreRE", 9e9):FireServer(unpack(args))
        wait(2)
        print(Dtoggle)
        auto_dungeon()
    until Dtoggle == false
end)
MainWin.CreateButton("stop auto", function()
    Dtoggle = false
end)


--Main 2    
Main2Win.CreateButton("auto collect supplies", function()
    for i,v in pairs(game.workspace.Drop:GetChildren()) do
        local args = {
        [1] = v.Name;
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remote", 9e9):WaitForChild("DropObjRE", 9e9):FireServer(unpack(args))
    end
end)




--setting
setting.CreateDivider("Aura(reactive to change)")

setting.CreateTextbox("weapon", function(txt)
	if txt == "1" or txt == "2" or txt =="3" then 
	    weapon = weapon_list[tonumber(txt)]
	end
end)

setting.CreateLabel("1=Heavy,2=Light,3=Drone")
setting.CreateTextbox("Range", function(txt)
    if tonumber(txt) > 0 then
        range = tonumber(txt)
    end
end)

setting.CreateDivider("Heal aura target")
setting.CreateLabel("Type Player's username(name in the server's ranking)")
setting.CreateTextbox("Add player:",function(txt)
    for i,v in pairs(game.Players:GetChildren()) do
        if txt == v.Name then
            table.insert(heal_list,v:GetAttribute("UnitID"))
        end
    end
end)
setting.CreateTextbox("Remove player:",function(txt)
    for i,v in pairs(game.Players:GetChildren()) do
        if txt == v.Name then
            table.remove(heal_list, i)
        end
    end
end)
setting.CreateButton("Add all players", function()
	local count = #heal_list
	for i=0, count do heal_list[i]=nil end
	for i,v in pairs(game.Players:GetChildren()) do
	    table.insert(heal_list, v:GetAttribute("UnitID"))
	end
	count = nil
end) 
setting.CreateButton("Remove all players", function()
	local count = #heal_list
	for i=0, count do heal_list[i]=nil end
    count = nil
end) 
setting2.CreateTextbox("time per heal:",function(txt)
    TPH = tonumber(txt)
end)




--teleport
teleport.CreateButton("Camp", function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(1982.021484375, -193.3939666748047, 49.082054138183594)
end)
teleport.CreateButton("L Shape House", function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(1593.796630859375, -193.69776916503906, -67.92874145507812)
end)
teleport.CreateButton("Police Station", function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(1665.3504638671875, -193.93240356445312, -271.9259033203125)
end)
teleport.CreateButton("SuperMarket", function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(2244.5400390625, -193.9221954345703, 53.43947982788086)
end)
teleport.CreateButton("Pharmacie", function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(2166.7431640625, -192.66485595703125, 189.23446655273438)
end)
teleport.CreateButton("Ruins", function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(1970.83203125, -194.0018768310547, -688.6741333007812)
end)
teleport.CreateButton("Port", function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(2474.518798828125, -194.42173767089844, 259.9259033203125)
end)
teleport.CreateButton("Action/Story tag", function()
    player.Character.HumanoidRootPart.CFrame = game.workspace.StoryPromptREMOTE.CFrame
end)


-- Credit
Extra.CreateDivider("UI lib producer(DC: kr4k#4503)")



--functions
function Kill_aura(Selec_weapon, Selec_range)
    repeat
        for i,v in pairs(workspace.Units:GetChildren()) do
            if player:DistanceFromCharacter(v.CFrame.Position) <= Selec_range  and v:GetAttribute("HP") > 0  then 
                local args = {
                [1] = {
                    ["Type"] = "Hit";
                    ["Slot"] = Selec_weapon;
                    ["From"] = Vector3.new(player.Character.HumanoidRootPart.CFrame.Position);
                    ["UID"] = v.Name;
                };
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remote", 9e9):WaitForChild("CharacterRE", 9e9):FireServer(unpack(args))
            end
        end
        wait()
    until Ktoggle == false
end


function heal_all(Healing_list)
    local count = #Healing_list
    for i =0,count do
        local args = {
        [1] = {
            ["Type"] = "BeHeal";
            ["From"] = Vector3.new(player.Character.HumanoidRootPart.CFrame.Position);
            ["Slot"] = "Heavy";
            ["UID"] = Healing_list[i];
        };
    }
    
        game:GetService("ReplicatedStorage"):WaitForChild("Remote", 9e9):WaitForChild("CharacterRE", 9e9):FireServer(unpack(args))
    end
end

function auto_dungeon()
    local dungeonid = player:GetAttribute("Field")
    local num = 1
    local dungeon_level = "S1"
    local dungeon = game.workspace.Fields:WaitForChild(dungeonid):WaitForChild(dungeon_level)
    repeat
        player.Character.HumanoidRootPart.CFrame = dungeon:WaitForChild("Body").CFrame
        wait(2)
        player.Character.HumanoidRootPart.CFrame = dungeon.BOXMOD.CFrame*CFrame.new(0, -10, 0)
        repeat
            wait()
        until dungeon.BOX.Model.Door.CFrame.RightVector.Z>0
        wait()
        local args = {}
        
        
        workspace:WaitForChild("Fields", 9e9):WaitForChild(dungeonid, 9e9):WaitForChild(dungeon_level, 9e9):WaitForChild("Body", 9e9):WaitForChild("NextPT", 9e9):WaitForChild("RE", 9e9):FireServer(unpack(args))
        wait(2)
        num = num + 1
        dungeon_level = "S"..tostring(num)
        dungeonid = player:GetAttribute("Field")
        dungeon = game.workspace.Fields:WaitForChild(dungeonid):FindFirstChild(dungeon_level)
    until(dungeonid == "World")
end
