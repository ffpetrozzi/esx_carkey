fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'ffpetrozzi | https://github.com/ffpetrozzi'

version '0.0.1'

shared_scripts { 
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua'
}
