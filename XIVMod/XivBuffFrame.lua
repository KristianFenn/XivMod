function XivBuffFrameAuras_RenderAuras(auraFrame)
	if (not auraFrame:IsShown()) then return end;

	for aura_index = 1,40 do
		local aura = auraFrame:GetAttribute("child" .. aura_index);

		if (not aura or not aura:IsShown()) then return end;

		XivAura_Render(aura);
	end
end

function XivBuffFrame_Create(unit, filter)
	local newBuffFrame = CreateFrame("Frame", "XivBuffFrame", UIParent, "XivBuffFrame");
	local dragFrame, auraFrame = newBuffFrame:GetChildren();
	newBuffFrame.dragFrame = dragFrame;
	newBuffFrame.auraFrame = auraFrame;

	auraFrame:SetAttribute("unit", unit);
	auraFrame:SetAttribute("filter", filter);

	if (filter == "HARMFUL") then
		auraFrame:SetPoint("BOTTOMRIGHT");
		auraFrame:SetAttribute("point", "RIGHT");
		auraFrame:SetAttribute("xOffset", "-21");
	end

	auraFrame:HookScript("OnEvent", function()
		XivBuffFrameAuras_RenderAuras(auraFrame);
	end);

	auraFrame:Show();
	newBuffFrame:Show();
	XivBuffFrameAuras_RenderAuras(auraFrame);

	return newBuffFrame;
end

function XivBuffFrame_Lock(frame)
	frame:SetMovable(false);
	frame.dragFrame:Hide();
end

function XivBuffFrame_Unlock(frame)
	frame:SetMovable(true);
	frame.dragFrame:Show();
end

function XivBuffFrame_OnDragStart(frame)
	if (not frame:IsMovable()) then
		return;
	end
	
	frame:StartMoving();
end

function XivBuffFrame_OnDragStop(frame)
	frame:StopMovingOrSizing();
end