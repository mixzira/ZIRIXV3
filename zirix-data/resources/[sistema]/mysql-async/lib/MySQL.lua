MySQL = {
	Async = {},
	Sync = {},
	Threaded = {}
}

local function safeParameters(params)
	if nil == params then
		return { [''] = '' }
	end
	assert(type(params) == "table","A table is expected")
	assert(params[1] == nil,"Parameters should not be an array, but a map (key / value pair) instead")
	if next(params) == nil then
		return { [''] = '' }
	end
	return params
end

local function safeCallback(callback)
	if nil == callback then
		return function() end
	end
	assert(type(callback) == "function","A callback is expected")
	return callback
end

function MySQL.Sync.execute(query,params)
	assert(type(query) == "string","The SQL Query must be a string")
	return exports['mysql-async']:mysql_sync_execute(query,safeParameters(params))
end

function MySQL.Sync.fetchAll(query,params)
	assert(type(query) == "string","The SQL Query must be a string")
	return exports['mysql-async']:mysql_sync_fetch_all(query,safeParameters(params))
end

function MySQL.Sync.fetchScalar(query,params)
	assert(type(query) == "string","The SQL Query must be a string")
	return exports['mysql-async']:mysql_sync_fetch_scalar(query,safeParameters(params))
end

function MySQL.Sync.insert(query,params)
	assert(type(query) == "string","The SQL Query must be a string")
	return exports['mysql-async']:mysql_sync_insert(query,safeParameters(params))
end

function MySQL.Sync.transaction(querys,params)
	assert(type(querys) == "table","The SQL Query must be a table of strings")
	return exports['mysql-async']:mysql_sync_transaction(querys,safeParameters(params))
end

function MySQL.Async.execute(query,params,func)
	assert(type(query) == "string","The SQL Query must be a string")
	exports['mysql-async']:mysql_execute(query,safeParameters(params),safeCallback(func))
end

function MySQL.Async.fetchAll(query,params,func)
	assert(type(query) == "string","The SQL Query must be a string")
	exports['mysql-async']:mysql_fetch_all(query,safeParameters(params),safeCallback(func))
end

function MySQL.Async.fetchScalar(query,params,func)
	assert(type(query) == "string","The SQL Query must be a string")
	exports['mysql-async']:mysql_fetch_scalar(query,safeParameters(params),safeCallback(func))
end

function MySQL.Async.insert(query,params,func)
	assert(type(query) == "string","The SQL Query must be a string")
	exports['mysql-async']:mysql_insert(query,safeParameters(params),safeCallback(func))
end

function MySQL.Async.transaction(querys,params,func)
	assert(type(querys) == "table","The SQL Query must be a table of strings")
	return exports['mysql-async']:mysql_transaction(querys,safeParameters(params), safeCallback(func))
end

function MySQL.Threaded.execute(query,params)
	assert(type(query) == "string","The SQL Query must be a string")
	return exports['mysql-async']:mysql_threaded_execute(query,safeParameters(params))
end

function MySQL.Threaded.fetchAll(query,params)
	assert(type(query) == "string","The SQL Query must be a string")
	return exports['mysql-async']:mysql_threaded_fetch_all(query,safeParameters(params))
end

function MySQL.Threaded.fetchScalar(query,params)
	assert(type(query) == "string","The SQL Query must be a string")
	return exports['mysql-async']:mysql_threaded_fetch_scalar(query,safeParameters(params))
end

function MySQL.Threaded.insert(query,params)
	assert(type(query) == "string","The SQL Query must be a string")
	return exports['mysql-async']:mysql_threaded_insert(query,safeParameters(params))
end

local isReady = false
AddEventHandler('onMySQLReady',function()
	isReady = true
end)

function MySQL.ready(callback)
	if isReady then
		callback()
		return
	end
	AddEventHandler('onMySQLReady',callback)
end