package com.sulake.habbo.session.furniture
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.utils.Map;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.Core;
    import flash.events.Event;
    import com.sulake.habbo.utils.HabboWebTools;

    public class FurnitureDataParser extends EventDispatcherWrapper 
    {

        public static const READY:String = "FDP_furniture_data_ready";

        private var _floorItems:Map;
        private var _wallItems:Map;
        private var _SafeStr_3696:Map;
        private var _localization:ICoreLocalizationManager;
        private var _SafeStr_3697:AssetLibrary;

        public function FurnitureDataParser(_arg_1:Map, _arg_2:Map, _arg_3:Map, _arg_4:ICoreLocalizationManager)
        {
            _floorItems = _arg_1;
            _wallItems = _arg_2;
            _SafeStr_3696 = _arg_3;
            _localization = _arg_4;
            _SafeStr_3697 = new AssetLibrary("FurniDataParserAssetLib");
        }

        override public function dispose():void
        {
            super.dispose();
            if (_SafeStr_3697)
            {
                _SafeStr_3697.dispose();
                _SafeStr_3697 = null;
            };
            _localization = null;
            _floorItems = null;
            _wallItems = null;
            _SafeStr_3696 = null;
        }

        public function loadData(_arg_1:String, _arg_2:String=null, _arg_3:String=null):void
        {
            var _local_4:AssetLoaderStruct;
            if (((_arg_2) && (_arg_3)))
            {
                _local_4 = _SafeStr_3697.loadAssetFromFile("furnidata", new URLRequest(_arg_1), "text/plain", ("furnidata_" + _arg_3.toLowerCase()), _arg_2);
            }
            else
            {
                _local_4 = _SafeStr_3697.loadAssetFromFile("furnidata", new URLRequest(_arg_1), "text/plain");
            };
            _local_4.addEventListener("AssetLoaderEventComplete", parseFurnitureData);
            _local_4.addEventListener("AssetLoaderEventError", furnitureDataError);
        }

        private function parseFurnitureData(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:String;
            var _local_3:ByteArray;
            var _local_4:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_4 == null)
            {
                return;
            };
            if (((_local_4.assetLoader == null) || (_local_4.assetLoader.content == null)))
            {
                return;
            };
            if ((_local_4.assetLoader.content is ByteArray))
            {
                _local_3 = (_local_4.assetLoader.content as ByteArray);
                _local_3.position = 0;
                _local_2 = _local_3.readUTFBytes(_local_3.length);
            }
            else
            {
                _local_2 = (_local_4.assetLoader.content as String);
            };
            if (_local_2.charAt(0) == "<")
            {
                parseXmlFormat(_local_2);
            }
            else
            {
                parseLingoFormat(_local_2);
            };
        }

        private function parseXmlFormat(_arg_1:String):void
        {
            var _local_5:XML;
            var _local_2:XMLList;
            var _local_3:XML;
            var _local_4:FurnitureData;
            try
            {
                _local_5 = new XML(_arg_1);
            }
            catch(e:Error)
            {
                Core.error(("XML furni data was malformed: " + _arg_1), true, 12);
            };
            if (_local_5 == null)
            {
                return;
            };
            _local_2 = _local_5.roomitemtypes;
            for each (_local_3 in _local_2.furnitype)
            {
                _local_4 = parseFloorItem(_local_3);
                storeItem(_local_4);
                registerFurnitureLocalization(_local_4);
            };
            _local_2 = _local_5.wallitemtypes;
            for each (_local_3 in _local_2.furnitype)
            {
                _local_4 = parseWallItem(_local_3);
                storeItem(_local_4);
                registerFurnitureLocalization(_local_4);
            };
            dispatchEvent(new Event("FDP_furniture_data_ready"));
        }

        private function parseFloorItem(_arg_1:XML):FurnitureData
        {
            var _local_5:String;
            var _local_8:int = parseInt(_arg_1.@id);
            var _local_11:Array = [];
            for each (var _local_2:XML in _arg_1.partcolors.color)
            {
                _local_5 = _local_2;
                if (_local_5.charAt(0) == "#")
                {
                    _local_5 = _local_5.replace("#", "");
                    _local_11.push(parseInt(_local_5, 16));
                }
                else
                {
                    _local_11.push(-(parseInt(_local_5)));
                };
            };
            var _local_4:String = _arg_1.@classname;
            var _local_9:Array = _local_4.split("*");
            var _local_7:String = _local_9[0];
            var _local_3:int = ((_local_9.length > 1) ? parseInt(_local_9[1]) : 0);
            var _local_10:Boolean = (_local_9.length > 1);
            var _local_6:FurnitureData = new FurnitureData("s", _local_8, _local_4, _local_7, _arg_1.name, "", _arg_1.revision, _arg_1.xdim, _arg_1.ydim, 0, _local_11, _local_10, _local_3, _arg_1.adurl, _arg_1.offerid, (_arg_1.buyout == "1"), _arg_1.rentofferid, (_arg_1.rentbuyout == "1"), (_arg_1.bc == "1"), _arg_1.customparams, _arg_1.specialtype, (_arg_1.canstandon == "1"), (_arg_1.cansiton == "1"), (_arg_1.canlayon == "1"), (_arg_1.excludeddynamic == "1"), _arg_1.furniline);
            return (_local_6);
        }

        private function parseWallItem(_arg_1:XML):FurnitureData
        {
            var _local_3:int = parseInt(_arg_1.@id);
            return (new FurnitureData("i", _local_3, _arg_1.@classname, _arg_1.@classname, _arg_1.name, "", _arg_1.revision, 0, 0, 0, null, false, 0, _arg_1.adurl, _arg_1.offerid, (_arg_1.buyout == "1"), _arg_1.rentofferid, (_arg_1.rentbuyout == "1"), (_arg_1.bc == "1"), null, _arg_1.specialtype, false, false, false, (_arg_1.excludeddynamic == "1"), _arg_1.furniline));
        }

        private function parseLingoFormat(_arg_1:String):void
        {
            var _local_5:Array;
            var _local_29:Array;
            var _local_9:String;
            var _local_19:int;
            var _local_3:String;
            var _local_37:Array;
            var _local_8:String;
            var _local_23:int;
            var _local_38:Boolean;
            var _local_30:int;
            var _local_22:int;
            var _local_16:int;
            var _local_17:int;
            var _local_41:Array;
            var _local_32:Array;
            var _local_39:int;
            var _local_26:String;
            var _local_10:String;
            var _local_6:String;
            var _local_7:String;
            var _local_33:int;
            var _local_20:Boolean;
            var _local_34:int;
            var _local_2:Boolean;
            var _local_24:String;
            var _local_40:int;
            var _local_31:Boolean;
            var _local_13:Boolean;
            var _local_25:Boolean;
            var _local_11:Boolean;
            var _local_36:Boolean;
            var _local_4:Boolean;
            var _local_14:FurnitureData;
            var _local_15:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/gm;
            var _local_12:RegExp = /^\s+|\s+$/g;
            var _local_35:RegExp = /\[+?((.)*?)\]/g;
            var _local_28:Array = _arg_1.split(_local_15);
            var _local_21:int;
            for each (var _local_18:String in _local_28)
            {
                _local_5 = _local_18.match(_local_35);
                for each (var _local_27:String in _local_5)
                {
                    _local_27 = _local_27.replace(/\[{1,}/gm, "");
                    _local_27 = _local_27.replace(/\]{1,}/gm, "");
                    _local_29 = _local_27.split('"');
                    removePatternFrom(_local_29, ", ");
                    removePatternFrom(_local_29, ",");
                    _local_29.splice(0, 1);
                    _local_29.splice((_local_29.length - 1), 1);
                    if (_local_29.length < 18)
                    {
                        Core.error(("Lingo furni data was malformed: " + _arg_1), true, 12);
                        return;
                    };
                    _local_9 = _local_29[0];
                    _local_19 = parseInt(_local_29[1]);
                    _local_3 = String(_local_29[2]);
                    _local_37 = _local_3.split("*");
                    _local_8 = _local_37[0];
                    _local_23 = ((_local_37.length > 1) ? parseInt(_local_37[1]) : 0);
                    _local_38 = (_local_37.length > 1);
                    _local_30 = parseInt(_local_29[3]);
                    _local_22 = parseInt(_local_29[4]);
                    _local_16 = parseInt(_local_29[5]);
                    _local_17 = parseInt(_local_29[6]);
                    _local_41 = [];
                    _local_32 = _local_29[7].split(",");
                    _local_39 = 0;
                    while (_local_39 < _local_32.length)
                    {
                        _local_26 = _local_32[_local_39];
                        if (_local_26.charAt(0) == "#")
                        {
                            _local_26 = _local_26.replace("#", "");
                            _local_41.push(parseInt(_local_26, 16));
                        }
                        else
                        {
                            _local_41.push(-(parseInt(_local_26)));
                        };
                        _local_39++;
                    };
                    _local_10 = _local_29[8];
                    _local_6 = _local_29[9];
                    _local_7 = _local_29[10];
                    _local_33 = parseInt(_local_29[11]);
                    _local_20 = (_local_29[12] == "true");
                    _local_34 = parseInt(_local_29[13]);
                    _local_2 = (_local_29[14] == "true");
                    _local_24 = _local_29[15];
                    _local_40 = parseInt(_local_29[16]);
                    _local_31 = (_local_29[17] == "true");
                    _local_36 = false;
                    _local_4 = (_local_9 == "i");
                    if (_local_4)
                    {
                        _local_13 = false;
                        _local_25 = false;
                        _local_11 = false;
                        if (_local_29.length >= 19)
                        {
                            _local_36 = (_local_29[18] == "1");
                        };
                    }
                    else
                    {
                        _local_13 = (_local_29[18] == "1");
                        _local_25 = (_local_29[19] == "1");
                        _local_11 = (_local_29[20] == "1");
                        if (_local_29.length >= 22)
                        {
                            _local_36 = (_local_29[21] == "1");
                        };
                    };
                    _local_14 = new FurnitureData(_local_9, _local_19, _local_3, _local_8, _local_10, "", _local_30, _local_22, _local_16, _local_17, _local_41, _local_38, _local_23, _local_7, _local_33, _local_20, _local_34, _local_2, _local_31, _local_24, _local_40, _local_13, _local_25, _local_11, _local_36, "");
                    storeItem(_local_14);
                    registerFurnitureLocalization(_local_14);
                };
                _local_21++;
            };
            dispatchEvent(new Event("FDP_furniture_data_ready"));
        }

        private function storeItem(_arg_1:FurnitureData):void
        {
            if (_arg_1.type == "s")
            {
                _floorItems.add(_arg_1.id, _arg_1);
            }
            else
            {
                if (_arg_1.type == "i")
                {
                    _wallItems.add(_arg_1.id, _arg_1);
                };
            };
            var _local_2:Array = _SafeStr_3696[_arg_1.className];
            if (_local_2 == null)
            {
                _local_2 = [];
                _SafeStr_3696.add(_arg_1.className, _local_2);
            };
            _local_2[_arg_1.colourIndex] = _arg_1.id;
        }

        private function furnitureDataError(_arg_1:AssetLoaderEvent):void
        {
            HabboWebTools.logEventLog(("furnituredata download error " + _arg_1.status));
            Core.error("Could not download furnidata definition", true, 12);
        }

        private function registerFurnitureLocalization(_arg_1:FurnitureData):void
        {
            if (_localization != null)
            {
                if (_arg_1.type == "s")
                {
                    _localization.updateLocalization(("roomItem.name." + _arg_1.id), _arg_1.localizedName);
                    _localization.updateLocalization(("roomItem.desc." + _arg_1.id), _arg_1.description);
                }
                else
                {
                    if (_arg_1.type == "i")
                    {
                        _localization.updateLocalization(("wallItem.name." + _arg_1.id), _arg_1.localizedName);
                        _localization.updateLocalization(("wallItem.desc." + _arg_1.id), _arg_1.description);
                    };
                };
            };
        }

        private function removePatternFrom(_arg_1:Array, _arg_2:Object):void
        {
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                if (_arg_1[_local_3] == _arg_2)
                {
                    _arg_1.splice(_local_3, 1);
                    _local_3--;
                };
                _local_3++;
            };
        }


    }
}

