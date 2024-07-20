SCK = {}
SCK.confirmActive = false

SCK.frame = CreateFrame('Frame', nil, UIParent)

function SCK.handleEvent(self, event)
	SCK.confirmActive = true
end

function SCK.loop(self, event)
	if(SCK.confirmActive == true) then
		if(_G['StaticPopup1']:IsVisible() and _G['StaticPopup1Button1']:IsVisible()) then
			SCK.confirmActive = false
			_G['StaticPopup1Button1']:Click()
		end
	end
end

SCK.frame:SetScript('OnUpdate', SCK.loop)

SCK.frame:SetScript('OnEvent', SCK.handleEvent)
SCK.frame:RegisterEvent('EQUIP_BIND_CONFIRM')
SCK.frame:RegisterEvent('AUTOEQUIP_BIND_CONFIRM')
SCK.frame:RegisterEvent('LOOT_BIND_CONFIRM')
--SCK.frame:RegisterEvent('DELETE_ITEM_CONFIRM')