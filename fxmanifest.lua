fx_version 'cerulean'
game 'gta5'
author '!Junior'
discord 'Pour du support -> https://discord.gg/ju7S5y6RW6'



-----------------------------------------> data <-----------------------------------------

files({
	'data/**/carcols.meta',
	'data/**/carvariations.meta',
	'data/**/handling.meta',
	'data/**/vehicles.meta'
})

data_file('HANDLING_FILE')('data/**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
data_file('CARCOLS_FILE')('data/**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('vehicle/data/**/carvariations.meta')