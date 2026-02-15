
# RetroGuides

Lua script to show text guides in RetroArch.

Can be used to read FAQs, translation guides, tips and tricks, etc. without switching core/process/app.

Features Word Wrapping and scrolling with the d-pad (the current scrolling position is not saved on storage).


## Preview 

<img alt="demo1" src="https://github.com/eadmaster/RetroGuides/blob/main/demo1.png?raw=true">


## Setup

 - Install a version of Retroarch with [Lua scripting support](https://github.com/eadmaster/RetroArch/releases)
 - Download `RetroGuides.lua`, and save it as `$HOME/.config/retroarch/system/global.lua`
 - Create a txt file matching the content filename in the same path with the guide. E.g. `Bomberman (USA).nes` -> `Bomberman (USA).txt`


## FAQs

### How to make a context-sensitive guide?

See [RetroSubs](https://github.com/eadmaster/RetroSubs), or the [Lua scripting API](https://tasvideos.org/Bizhawk/LuaFunctions) it is based on.

