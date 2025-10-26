ScootsConfirmationSkip = {
    ['version'] = '2.0.0',
    ['frame'] = CreateFrame('Frame', 'ScootsConfirmationSkip-EventsFrame', UIParent),
    ['activeEvents'] = {},
    ['eventMap'] = {
        ['EQUIP_BIND_CONFIRM'] = {
            ['popupWhich'] = 'EQUIP_BIND',
            ['functionName'] = 'EquipPendingItem',
        },
        ['AUTOEQUIP_BIND_CONFIRM'] = {
            ['popupWhich'] = 'AUTOEQUIP_BIND',
            ['functionName'] = 'EquipPendingItem',
        },
        ['LOOT_BIND_CONFIRM'] = {
            ['popupWhich'] = 'LOOT_BIND',
            ['functionName'] = 'ConfirmLootSlot',
        },
        ['DELETE_ITEM_CONFIRM'] = {
            ['popupWhich'] = 'DELETE_ITEM',
            ['functionName'] = 'DeleteCursorItem',
        },
    },
}

ScootsConfirmationSkip.handleEvent = function(self, event)
    local suppress = false

    if(_G['AuctionFrame'] ~= nil and _G['AuctionFrame']:IsVisible()) then
        suppress = true
    elseif(_G['BHunterFrame'] ~= nil and _G['BHunterFrame']:IsVisible()) then
        suppress = true
    end
    
    if(suppress == true) then
        ScootsConfirmationSkip.activeEvents = {}
    elseif(ScootsConfirmationSkip.eventMap[event] ~= nil) then
        table.insert(ScootsConfirmationSkip.activeEvents, event)
    end
end

ScootsConfirmationSkip.loop = function()
    if(#ScootsConfirmationSkip.activeEvents > 0) then
        local doLoop = true
    
        for eventIndex = 1, #ScootsConfirmationSkip.activeEvents do
            if(doLoop == true) then
                local event = ScootsConfirmationSkip.activeEvents[eventIndex]
                
                for popupIndex = 1, 10 do
                    if(doLoop == true) then
                        local popup = _G['StaticPopup' .. popupIndex]
                        
                        if(popup and popup:IsVisible() and popup.which == ScootsConfirmationSkip.eventMap[event].popupWhich) then
                            _G[ScootsConfirmationSkip.eventMap[event].functionName](popup.data)
                            StaticPopup_Hide(popup.which)
                            doLoop = false
                            
                            for removeIndex = #ScootsConfirmationSkip.activeEvents, 1, -1 do
                                if(ScootsConfirmationSkip.activeEvents[removeIndex] == event) then
                                    table.remove(ScootsConfirmationSkip.activeEvents, removeIndex)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

ScootsConfirmationSkip.frame:SetScript('OnEvent', ScootsConfirmationSkip.handleEvent)
ScootsConfirmationSkip.frame:SetScript('OnUpdate', ScootsConfirmationSkip.loop)

ScootsConfirmationSkip.frame:RegisterEvent('EQUIP_BIND_CONFIRM')
ScootsConfirmationSkip.frame:RegisterEvent('AUTOEQUIP_BIND_CONFIRM')
ScootsConfirmationSkip.frame:RegisterEvent('LOOT_BIND_CONFIRM')
--ScootsConfirmationSkip.frame:RegisterEvent('DELETE_ITEM_CONFIRM')