
# RetroGuides

Lua script to show text guides in RetroArch.

Can be used to read FAQs, translation guides, tips and tricks, etc. without switching core/process/app.

Features Word Wrapping and scrolling with the d-pad (the current scrolling position is not saved on storage).


## Preview 

![demo1](https://private-user-images.githubusercontent.com/925171/512869513-7b2e4e7e-f790-4954-81fc-6083199fa0b2.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzAxMzk1NDksIm5iZiI6MTc3MDEzOTI0OSwicGF0aCI6Ii85MjUxNzEvNTEyODY5NTEzLTdiMmU0ZTdlLWY3OTAtNDk1NC04MWZjLTYwODMxOTlmYTBiMi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAzJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwM1QxNzIwNDlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04YzM2OWU3YjQ0ODMyZDJmZWIyMjFjNWI4OTBlZDAzMmNhM2JhNzVhYmRhYTJkZTcyM2E1MDJlOWU0NWMwNTk2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.-OR5WzpVPwkQUkxQs3YplCBjC_QoHodFqGB9Tg-T1WQ)


## Setup

 - Install a version of Retroarch with [Lua scripting support](https://github.com/eadmaster/RetroArch/releases)
 - Download `RetroGuides.lua`, and save it as `$HOME/.config/retroarch/system/autostart.lua`
 - Create a txt file matching the content filename in the same path with the guide. E.g. `Bomberman (USA).nes` -> `Bomberman (USA).txt`


## FAQs

### How to make a context-sensitive guide?

See [RetroSubs](https://github.com/eadmaster/RetroSubs), or the [Lua scripting API](https://tasvideos.org/Bizhawk/LuaFunctions) it is based on.

