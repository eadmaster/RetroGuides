
# RetroGuides

Lua script to show text guides in RetroArch.

Can be used to read FAQs, translation guides, tips and tricks, etc. directly in RetroArch.

Features Word Wrapping and scrolling with the d-pad (the current scrolling position is not saved on storage).


## Preview 

![demo1](https://private-user-images.githubusercontent.com/925171/512869513-7b2e4e7e-f790-4954-81fc-6083199fa0b2.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjU2MzQ2NDEsIm5iZiI6MTc2NTYzNDM0MSwicGF0aCI6Ii85MjUxNzEvNTEyODY5NTEzLTdiMmU0ZTdlLWY3OTAtNDk1NC04MWZjLTYwODMxOTlmYTBiMi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUxMjEzJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MTIxM1QxMzU5MDFaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00ZTE2OTcxMWNkYjE3MzZkMDRjY2JkNTYwOGRhOWNjYTYwYmRlOTY1ZjExY2Y3NzNkZTFjMjVmNGI2NTE1MDQzJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.6c-hCUpjR5iM19dw5ZL5kmc3lwm7IGlbcD4V5b3MEvs)


## Setup

 - Install a version of Retroarch with [Lua scripting support](https://github.com/libretro/RetroArch/issues/6454)
 - Download `RetroGuides.lua`, extract it as `$HOME/.config/retroarch/system/autostart.lua`
 - Create a txt file matching the content filename in the same path with the guide. E.g. `Bomberman (USA).nes` -> `Bomberman (USA).txt`

## FAQs

### How to make a context-sensitive guide?

See [RetroSubs](https://github.com/eadmaster/RetroSubs), or the [Lua scripting API](https://tasvideos.org/Bizhawk/LuaFunctions) it is based on.
