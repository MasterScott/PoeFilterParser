/*
PoeFilterParser
Copyright (C) 2015 smad2005

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 3 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

grammar PoeFilter;

COMMENT: '#'.*?('\n'|EOF) -> skip;
WS:    [ \t\r\n] -> skip ;
DIGITS: [0-9]+;
COMPAREOP: '='| '<'|'>'|'<='|'>=';
RARITY: 'Normal'| 'Magic'| 'Rare' | 'Unique';
Boolean: 'True'|'False';
SHOW: 'Show';
HIDE: 'Hide';
COLOR: 'Red' | 'Green' | 'Blue' | 'Brown' | 'White' | 'Yellow';
SHAPE: 'Circle' | 'Diamond' | 'Hexagon' | 'Square' | 'Star' | 'Triangle';
TEMP: 'Temp';
SOCKET: [RGBW]+ ;
QUOTESOCKET:'"' SOCKET '"';
QUOTERARITY:'"' RARITY '"';
STR: .+? | ~[\r\n\t "]+;
QUOTESTR:'"' STR '"';

strValue: QUOTESTR | STR;
socketValue: QUOTESOCKET | SOCKET;
rarityValue: QUOTERARITY | RARITY;

playEffectParams: COLOR (TEMP)?;
compareOpNullable:COMPAREOP?;
visibility: SHOW | HIDE;
params:strValue (strValue)*;
digitsParams: DIGITS (DIGITS)*;
rariryParams: rarityValue (rarityValue)*;
socketParams: socketValue (socketValue)*;
iconParams: DIGITS COLOR SHAPE;
red:DIGITS;
green:DIGITS;
blue:DIGITS;
alpha:DIGITS?;
color: red green blue alpha;
poeClass: 'Class' params;
poeBaseType: 'BaseType' params;
poeFontSize: 'SetFontSize' DIGITS;
poeTextColor: 'SetTextColor' color;
poeBackgroundColor: 'SetBackgroundColor' color;
poeBorderColor: 'SetBorderColor' color;
soundId:DIGITS|'ShAlchemy'|'ShBlessed'|'ShChaos'|'ShDivine'|'ShExalted'|'ShFusing'|'ShGeneral'|'ShMirror'|'ShRegal'|'ShVaal';
volume:DIGITS?;
poeAlertSound: 'PlayAlertSound' soundId volume;

poeRarity: 'Rarity' compareOpNullable rariryParams;
poeSocketGroup: 'SocketGroup' socketParams;
poeLinkedSockets: 'LinkedSockets' compareOpNullable digitsParams;
poeSockets: 'Sockets' compareOpNullable digitsParams;
poeItemLevel: 'ItemLevel' compareOpNullable digitsParams;
poeDropLevel: 'DropLevel' compareOpNullable digitsParams;
poeQuality: 'Quality' compareOpNullable digitsParams;
poeWidth: 'Width' compareOpNullable digitsParams;
poeHeight: 'Height' compareOpNullable digitsParams;
poeCorrupted: 'Corrupted' Boolean;
poeIdentified: 'Identified' Boolean;
poeElderItem: 'ElderItem' Boolean;
poeShaperItem: 'ShaperItem' Boolean;
poeShapedMap: 'ShapedMap' Boolean;
poeElderMap: 'ElderMap' Boolean;
poeBlightedMap: 'BlightedMap' Boolean;
poeDisableDropSound: 'DisableDropSound' Boolean?;
poeGemLevel: 'GemLevel' compareOpNullable digitsParams;
poeStackSize: 'StackSize' compareOpNullable digitsParams;
poeHasExplicitMod: 'HasExplicitMod' params;
poeMapTier: 'MapTier' compareOpNullable digitsParams;
poeCustomAlertSound: 'CustomAlertSound' params;
poeMinimapIcon: 'MinimapIcon' iconParams;
poePlayEffect: 'PlayEffect' playEffectParams;
poeProphecy: 'Prophecy' params;
poeHasEnchantment: 'HasEnchantment' params;
poeAnyEnchantment: 'AnyEnchantment' Boolean;
poeSynthesisedItem: 'SynthesisedItem' Boolean;
poeFracturedItem: 'FracturedItem' Boolean;

statement:  poeClass
         |  poeFontSize 
         |  poeBackgroundColor
         |  poeBorderColor
         |  poeAlertSound
         |  poeSocketGroup
         |  poeRarity
         |  poeSockets
         |  poeItemLevel
         |  poeDropLevel
         |  poeLinkedSockets
         |  poeQuality
         |  poeBaseType
         |  poeWidth
         |  poeHeight
         |  poeCorrupted 
         |  poeIdentified 
         |  poeTextColor
         |  poeElderItem
         |  poeShaperItem 
         |  poeShapedMap
         |  poeElderMap
         |  poeBlightedMap
         |  poeDisableDropSound
         |  poeGemLevel
         |  poeStackSize
         |  poeHasExplicitMod
	    	 |  poeMapTier
	    	 |  poeCustomAlertSound
	    	 |  poeMinimapIcon
	    	 |  poePlayEffect
	    	 |  poeProphecy
	    	 |  poeHasEnchantment
	    	 |  poeAnyEnchantment
	    	 |  poeSynthesisedItem
	    	 |  poeFracturedItem;

block: visibility statement*?;
main: block+;
