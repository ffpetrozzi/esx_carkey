# esx_carkey
## This script allows you to create an item with a custom metadata to lock and unlock cars.

###### REQUIREMENTS:
>[es_extended](https://github.com/esx-framework/esx-legacy)

>[ox_inventory](https://github.com/overextended/ox_inventory)

>[ox_lib](https://github.com/overextended/ox_lib)

Go to ox_inventory/data/items.lua and add this:

```lua
  ['carkey'] = {
    label = 'Car Key',
    weight = 3000,
    stack = false,
    consume = 0,
    client = {
      usetime = 1000
    }
  },
```
  
Go to ox_inventory/modules/items/client.lua and add this:

```lua
  Item('carkey', function(data, slot)
    ox_inventory:useItem(data, function(data)
      if data then
        TriggerEvent('ff_carkey:info', data)
      end
    end)
  end)
```
###### WARNING! The code of the client.lua file was not written by me, I changed it slightly.
###### If you want to make some changes and want to make it public make a Pull Request
