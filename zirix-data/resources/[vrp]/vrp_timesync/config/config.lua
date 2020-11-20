config = {}

config.standardWeather = 'EXTRASUNNY' --[ Clima padrão do servidor ]--
config.startHour = 6 --[ Hora inicial do servidor ]--
config.startMinutes = 20 --[ Minuto inicial do servidor. ]--

config.climate = { --[ Climas disponíveis para troca automatica ]--
    [1] = { 'EXTRASUNNY' },
	[2] = { 'CLEAR' },
	[3] = { 'CLOUDS' },
	[4] = { 'CLEARING' },
	[5] = { 'RAIN' }
}

config.climateCommand = 'clima' --[ Exemplo: /clima EXTRASUNNY | Comando para mudar o clima do servidor. ]--
config.timePermission = 'manager.permissao' --[ Permissão para mudar as horas e o clima. ]--

-- AvailableWeatherTypes: EXTRASUNNY, CLEAR, NEUTRAL, SMOG, FOGGY, OVERCAST, CLOUDS, CLEARING, RAIN, THUNDER, SNOW, BLIZZARD, SNOWLIGHT, XMAS, HALLOWEEN.