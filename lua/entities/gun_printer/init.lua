AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "LastUsed")
end

function ENT:SpawnFunction(ply, tr) -- Spawn function needed to make it appear on the spawn menu
	if (!tr.HitWorld) then return end

	local ent = ents.Create("gun_printer") -- Create the entity
	ent:SetPos(tr.HitPos + Vector(0, 0, 50)) -- Set it to spawn 50 units over the spot you aim at when spawning it
	ent:Spawn() -- Spawn it


	return ent -- You need to return the entity to make it work
end

function ENT:Initialize()

	self:SetModel( "models/props_junk/TrashBin01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetLastUsed(os.time())

    --self:SetNetworkedBool("bouncing", false, false) -- Make sure the message doesn't show on the client.

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
	if ( !activator:IsPlayer() ) then return end

    local phys = self:GetPhysicsObject()

    if(phys:IsValid() && (os.time() - self:GetLastUsed()) > 0) then
        --caller.openMenu()
		self:SetLastUsed(os.time())
		RunConsoleCommand("weaponMenu")
    end

    return
end

function ENT:Think()
    local phys = self:GetPhysicsObject()

    --if( self:GetNetworkedBool("bouncing") and phys:IsAsleep() ) then -- If the variable is set and we are on the ground
    --    self:SetNetworkedBool("bouncing", false, false) -- Tell the client to hide the message
    --end
end
