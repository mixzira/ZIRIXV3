vRP.prepare("vRP/get_user_identity","SELECT * FROM vrp_user_identities WHERE user_id = @user_id")
vRP.prepare("vRP/init_user_identity","INSERT IGNORE INTO vrp_user_identities(user_id,registration,phone,firstname,name,age) VALUES(@user_id,@registration,@phone,@firstname,@name,@age)")
vRP.prepare("vRP/update_user_identity","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age, registration = @registration, phone = @phone WHERE user_id = @user_id")
vRP.prepare("vRP/get_userbyreg","SELECT user_id FROM vrp_user_identities WHERE registration = @registration")
vRP.prepare("vRP/get_userbyphone","SELECT user_id FROM vrp_user_identities WHERE phone = @phone")

vRP.prepare("vRP/update_user_first_spawn","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")

function vRP.getUserIdentity(user_id,cbr)
	local rows = vRP.query("vRP/get_user_identity",{ user_id = user_id })
	return rows[1]
end

function vRP.getUserByRegistration(registration, cbr)
	local rows = vRP.query("vRP/get_userbyreg",{ registration = registration or "" })
	if #rows > 0 then
		return rows[1].user_id
	end
end

function vRP.getUserByPhone(phone, cbr)
	local rows = vRP.query("vRP/get_userbyphone",{ phone = phone or "" })
	if #rows > 0 then
		return rows[1].user_id
	end
end

function vRP.generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
	for i=1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
	return number
end

function vRP.generateRegistrationNumber(cbr)
	local user_id = nil
	local registration = ""
	repeat
		registration = vRP.generateStringNumber("DDLLLDDD")
		user_id = vRP.getUserByRegistration(registration)
	until not user_id

	return registration
end

function vRP.generatePhoneNumber(cbr)
	local user_id = nil
	local phone = ""

	repeat
		phone = vRP.generateStringNumber("DDD-DDD")
		user_id = vRP.getUserByPhone(phone)
	until not user_id

	return phone
end

function vRP.checkCrimeRecord(user_id)
    local identity = vRP.getUserIdentity(user_id)
    return identity.crimerecord
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name)
	if not vRP.getUserIdentity(user_id) then
		local registration = vRP.generateRegistrationNumber()
		local phone = vRP.generatePhoneNumber()
		vRP.execute("vRP/init_user_identity",{
			user_id = user_id,
			registration = registration,
			phone = phone,
			firstname = "Indigente",
			name = "Individuo",
			age = 21
		})
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		vRPclient._setRegistrationNumber(source,identity.registration or "AA000AAA")
	end
end)