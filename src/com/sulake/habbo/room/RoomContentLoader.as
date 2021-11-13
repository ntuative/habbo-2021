package com.sulake.habbo.room
{
    import com.sulake.room.IRoomContentLoader;
    import com.sulake.habbo.session.furniture.IFurniDataListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.Core;
    import com.sulake.core.utils.IFileProxy;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.habbo.utils.StringUtil;
    import flash.events.Event;
    import com.sulake.habbo.room.object.RoomObjectUserTypes;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.utils.getTimer;

        public class RoomContentLoader implements IRoomContentLoader, IFurniDataListener, IDisposable
    {

        public static const CONTENT_LOADER_READY:String = "RCL_LOADER_READY";
        private static const ASSET_LIBRARY_NAME_PREFIX:String = "RoomContentLoader ";
        private static const STATE_CREATED:int = 0;
        private static const STATE_INITIALIZING:int = 1;
        private static const STATE_READY:int = 2;
        private static const PLACE_HOLDER_FURNITURE:String = "place_holder";
        private static const PLACE_HOLDER_WALL_ITEM:String = "wall_place_holder";
        private static const PLACE_HOLDER_PET:String = "pet_place_holder";
        private static const PLACE_HOLDER_DEFAULT:String = "place_holder";
        private static const ROOM_CONTENT:String = "room";
        private static const _SafeStr_3584:String = "tile_cursor";
        private static const _SafeStr_3617:String = "selection_arrow";
        private static const PLACE_HOLDER_TYPES:Array = ["place_holder", "wall_place_holder", "pet_place_holder", "room", "tile_cursor", "selection_arrow"];
        private static const PLACE_HOLDER_TYPES_GPU:Array = ["place_holder", "wall_place_holder", "pet_place_holder", "room", "selection_arrow"];
        private static const CONTENT_DROP_DELAY:int = 20000;
        private static const COMPRESSION_INTERVAL:int = 30000;
        private static const CACHE_KEY_PREFIX:String = "furniture/";

        private var _SafeStr_3305:String;
        private var _SafeStr_1361:Map = null;
        private var _SafeStr_913:Map = null;
        private var _SafeStr_3618:Map = null;
        private var _SafeStr_3619:Map = null;
        private var _visualizationFactory:IRoomObjectVisualizationFactory = null;
        private var _SafeStr_448:int = 0;
        private var _stateEvents:IEventDispatcher = null;
        private var _disposed:Boolean = false;
        private var _SafeStr_3620:Boolean = false;
        private var _SafeStr_3621:Map = null;
        private var _SafeStr_3622:Dictionary = new Dictionary();
        private var _SafeStr_3623:Map = null;
        private var _SafeStr_3624:Map = null;
        private var _wallItems:Dictionary = new Dictionary();
        private var _SafeStr_3625:Map = null;
        private var _SafeStr_3626:Map = null;
        private var _SafeStr_3627:Dictionary = new Dictionary();
        private var _petColors:Map = null;
        private var _petLayers:Map = null;
        private var _SafeStr_3628:Map = null;
        private var _SafeStr_3629:Map = null;
        private var _SafeStr_3630:Map = null;
        private var _SafeStr_3631:Map = null;
        private var _SafeStr_3632:String;
        private var _SafeStr_3633:String;
        private var _SafeStr_3634:String;
        private var _SafeStr_3635:String;
        private var _SafeStr_3636:String;
        private var _SafeStr_3637:Boolean = false;
        private var _lastAssetCompressionTime:uint;
        private var _sessionDataManager:ISessionDataManager;
        private var _SafeStr_3638:IAssetLibrary;
        private var _SafeStr_3639:IRoomContentListener;
        private var _configuration:ICoreConfiguration;
        private var _SafeStr_3640:Array;

        public function RoomContentLoader(_arg_1:String)
        {
            _SafeStr_3305 = _arg_1;
            _SafeStr_1361 = new Map();
            _SafeStr_913 = new Map();
            _SafeStr_3621 = new Map();
            _SafeStr_3623 = new Map();
            _SafeStr_3624 = new Map();
            _SafeStr_3625 = new Map();
            _SafeStr_3626 = new Map();
            _SafeStr_3631 = new Map();
            _SafeStr_3628 = new Map();
            _SafeStr_3629 = new Map();
            _SafeStr_3630 = new Map();
            _SafeStr_3619 = new Map();
            _SafeStr_3618 = new Map();
        }

        private function get fileProxy():IFileProxy
        {
            return (Core.instance.fileProxy);
        }

        public function set sessionDataManager(_arg_1:ISessionDataManager):void
        {
            _sessionDataManager = _arg_1;
            if (_SafeStr_3637)
            {
                _SafeStr_3637 = false;
                initFurnitureData();
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set visualizationFactory(_arg_1:IRoomObjectVisualizationFactory):void
        {
            _visualizationFactory = _arg_1;
        }

        public function initialize(_arg_1:IEventDispatcher, _arg_2:ICoreConfiguration):void
        {
            _stateEvents = _arg_1;
            _SafeStr_3632 = _arg_2.getProperty("flash.dynamic.download.url");
            _SafeStr_3633 = _arg_2.getProperty("flash.dynamic.download.name.template");
            _SafeStr_3634 = _arg_2.getProperty("flash.dynamic.icon.download.name.template");
            _SafeStr_3635 = _arg_2.getProperty("pet.dynamic.download.url");
            _SafeStr_3636 = _arg_2.getProperty("pet.dynamic.download.name.template");
            _configuration = _arg_2;
            _SafeStr_448 = 1;
            initFurnitureData();
            initPetData(_arg_2);
        }

        private function initPetData(_arg_1:ICoreConfiguration):void
        {
            var _local_2:Array = _arg_1.getProperty("pet.configuration").split(",");
            var _local_3:int;
            for each (var _local_4:String in _local_2)
            {
                _SafeStr_3627[_local_4] = _local_3;
                _SafeStr_3626.add(_local_3, _local_4);
                _local_3++;
            };
            _petColors = new Map();
            _petLayers = new Map();
        }

        private function initFurnitureData():void
        {
            if (_sessionDataManager == null)
            {
                _SafeStr_3637 = true;
                return;
            };
            var _local_1:Vector.<IFurnitureData> = _sessionDataManager.getFurniData(this);
            if (_local_1 == null)
            {
                return;
            };
            _sessionDataManager.removeFurniDataListener(this);
            populateFurniData(_local_1);
            _SafeStr_3620 = true;
            parseIgnoredFurniTypes();
            continueInitilization();
        }

        public function dispose():void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_1:AssetLibrary;
            var _local_4:IGraphicAssetCollection;
            var _local_5:String;
            if (_SafeStr_1361 != null)
            {
                _local_2 = _SafeStr_1361.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_1 = (_SafeStr_1361.getWithIndex(_local_3) as AssetLibrary);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_3++;
                };
                _SafeStr_1361.dispose();
                _SafeStr_1361 = null;
            };
            if (_SafeStr_913 != null)
            {
                _SafeStr_913.dispose();
                _SafeStr_913 = null;
            };
            if (_SafeStr_3621 != null)
            {
                _SafeStr_3621.dispose();
                _SafeStr_3621 = null;
            };
            if (_SafeStr_3623)
            {
                _SafeStr_3623.dispose();
                _SafeStr_3623 = null;
            };
            if (_SafeStr_3624 != null)
            {
                _SafeStr_3624.dispose();
                _SafeStr_3624 = null;
            };
            if (_SafeStr_3625)
            {
                _SafeStr_3625.dispose();
                _SafeStr_3625 = null;
            };
            if (_SafeStr_3626 != null)
            {
                _SafeStr_3626.dispose();
                _SafeStr_3626 = null;
            };
            if (_petColors != null)
            {
                _petColors.dispose();
                _petColors = null;
            };
            if (_petLayers != null)
            {
                _petLayers.dispose();
                _petLayers = null;
            };
            if (_SafeStr_3628 != null)
            {
                _SafeStr_3628.dispose();
                _SafeStr_3628 = null;
            };
            if (_SafeStr_3629 != null)
            {
                _SafeStr_3629.dispose();
                _SafeStr_3629 = null;
            };
            if (_SafeStr_3630 != null)
            {
                _SafeStr_3630.dispose();
                _SafeStr_3630 = null;
            };
            if (_SafeStr_3631 != null)
            {
                _SafeStr_3631.dispose();
                _SafeStr_3631 = null;
            };
            if (_SafeStr_3619 != null)
            {
                _local_2 = _SafeStr_3619.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = (_SafeStr_3619.getWithIndex(_local_3) as IGraphicAssetCollection);
                    if (_local_4 != null)
                    {
                        _local_4.dispose();
                    };
                    _local_3++;
                };
                _SafeStr_3619.dispose();
                _SafeStr_3619 = null;
            };
            if (_SafeStr_3618 != null)
            {
                _SafeStr_3618.dispose();
                _SafeStr_3618 = null;
            };
            if (_SafeStr_3622 != null)
            {
                for (_local_5 in _SafeStr_3622)
                {
                    delete _SafeStr_3622[_local_5];
                };
                _SafeStr_3622 = null;
            };
            if (_wallItems != null)
            {
                for (_local_5 in _wallItems)
                {
                    delete _wallItems[_local_5];
                };
                _wallItems = null;
            };
            if (_SafeStr_3627 != null)
            {
                for (_local_5 in _SafeStr_3627)
                {
                    delete _SafeStr_3627[_local_5];
                };
                _SafeStr_3627 = null;
            };
            _stateEvents = null;
            _sessionDataManager = null;
            _configuration = null;
            _disposed = true;
        }

        private function parseIgnoredFurniTypes():void
        {
            var _local_3:int;
            var _local_1:String = _configuration.getProperty("gpu.ignored_furni");
            if (!_local_1)
            {
                return;
            };
            _SafeStr_3640 = _local_1.split(",");
            var _local_2:int = _SafeStr_3640.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _SafeStr_3640[_local_3] = StringUtil.trim(_SafeStr_3640[_local_3]);
                _local_3++;
            };
        }

        private function isIgnoredFurniType(_arg_1:String):Boolean
        {
            return ((_SafeStr_3640) ? (!(_SafeStr_3640.indexOf(_arg_1) == -1)) : false);
        }

        private function populateFurniData(_arg_1:Vector.<IFurnitureData>):void
        {
            var _local_3:IFurnitureData;
            var _local_4:int;
            var _local_6:String;
            var _local_8:int;
            var _local_2:String;
            var _local_7:String;
            var _local_5:int;
            for each (_local_3 in _arg_1)
            {
                _local_4 = _local_3.id;
                _local_6 = _local_3.className;
                if (_local_3.hasIndexedColor)
                {
                    _local_6 = ((_local_6 + "*") + _local_3.colourIndex);
                };
                _local_8 = _local_3.revision;
                _local_2 = _local_3.adUrl;
                if (((!(_local_2 == null)) && (_local_2.length > 0)))
                {
                    _SafeStr_3631.add(_local_6, _local_2);
                };
                _local_7 = _local_3.className;
                if (_local_3.type == "s")
                {
                    _SafeStr_3621.add(_local_4, _local_6);
                    _SafeStr_3623.add(_local_6, _local_4);
                    if (_SafeStr_3622[_local_7] == null)
                    {
                        _SafeStr_3622[_local_7] = 1;
                    };
                }
                else
                {
                    if (_local_3.type == "i")
                    {
                        if (_local_6 == "post.it")
                        {
                            _local_6 = "post_it";
                            _local_7 = "post_it";
                        };
                        if (_local_6 == "post.it.vd")
                        {
                            _local_6 = "post_it_vd";
                            _local_7 = "post_it_vd";
                        };
                        _SafeStr_3624.add(_local_4, _local_6);
                        _SafeStr_3625.add(_local_6, _local_4);
                        if (_wallItems[_local_7] == null)
                        {
                            _wallItems[_local_7] = 1;
                        };
                    };
                };
                _local_5 = _SafeStr_3628.getValue(_local_7);
                if (_local_8 > _local_5)
                {
                    _SafeStr_3628.remove(_local_7);
                    _SafeStr_3628.add(_local_7, _local_8);
                };
            };
        }

        private function continueInitilization():void
        {
            if (_SafeStr_3620)
            {
                _SafeStr_448 = 2;
                if (_stateEvents != null)
                {
                    _stateEvents.dispatchEvent(new Event("RCL_LOADER_READY"));
                };
            };
        }

        public function setRoomObjectAlias(_arg_1:String, _arg_2:String):void
        {
            if (_SafeStr_3629 != null)
            {
                _SafeStr_3629.remove(_arg_1);
                _SafeStr_3629.add(_arg_1, _arg_2);
            };
            if (_SafeStr_3630 != null)
            {
                _SafeStr_3630.remove(_arg_2);
                _SafeStr_3630.add(_arg_2, _arg_1);
            };
        }

        private function getRoomObjectAlias(_arg_1:String):String
        {
            var _local_2:String;
            if (_SafeStr_3629 != null)
            {
                _local_2 = (_SafeStr_3629.getValue(_arg_1) as String);
            };
            if (_local_2 == null)
            {
                _local_2 = _arg_1;
            };
            return (_local_2);
        }

        private function getRoomObjectOriginalName(_arg_1:String):String
        {
            var _local_2:String;
            if (_SafeStr_3630 != null)
            {
                _local_2 = (_SafeStr_3630.getValue(_arg_1) as String);
            };
            if (_local_2 == null)
            {
                _local_2 = _arg_1;
            };
            return (_local_2);
        }

        public function getObjectCategory(_arg_1:String):int
        {
            if (_arg_1 == null)
            {
                return (-2);
            };
            if (_SafeStr_3622[_arg_1] != null)
            {
                return (10);
            };
            if (_wallItems[_arg_1] != null)
            {
                return (20);
            };
            if (_SafeStr_3627[_arg_1] != null)
            {
                return (100);
            };
            if (_arg_1.indexOf("poster") == 0)
            {
                return (20);
            };
            if (_arg_1 == "room")
            {
                return (0);
            };
            if (_arg_1 == "user")
            {
                return (100);
            };
            if (_arg_1 == "pet")
            {
                return (100);
            };
            if (_arg_1 == "bot")
            {
                return (100);
            };
            if (_arg_1 == "rentable_bot")
            {
                return (100);
            };
            if (((_arg_1 == "tile_cursor") || (_arg_1 == "selection_arrow")))
            {
                return (200);
            };
            return (-2);
        }

        public function getPlaceHolderType(_arg_1:String):String
        {
            if (_SafeStr_3622[_arg_1] != null)
            {
                return ("place_holder");
            };
            if (_wallItems[_arg_1] != null)
            {
                return ("wall_place_holder");
            };
            if (_SafeStr_3627[_arg_1] != null)
            {
                return ("pet_place_holder");
            };
            return ("place_holder");
        }

        public function getPlaceHolderTypes():Array
        {
            return (PLACE_HOLDER_TYPES);
        }

        public function getActiveObjectType(_arg_1:int):String
        {
            var _local_2:String = (_SafeStr_3621.getValue(_arg_1) as String);
            if (_local_2 == null)
            {
                Logger.log(("[RoomContentLoader] Could not find type for id: " + _arg_1));
            };
            return (getObjectType(_local_2));
        }

        public function getActiveObjectTypeId(_arg_1:String):int
        {
            return (_SafeStr_3623.getValue(_arg_1));
        }

        public function getWallItemType(_arg_1:int, _arg_2:String=null):String
        {
            var _local_3:String = (_SafeStr_3624.getValue(_arg_1) as String);
            if (((_local_3 == "poster") && (!(_arg_2 == null))))
            {
                _local_3 = (_local_3 + _arg_2);
            };
            return (getObjectType(_local_3));
        }

        public function getWallItemTypeId(_arg_1:String):int
        {
            return (_SafeStr_3625.getValue(_arg_1));
        }

        public function getPetType(_arg_1:int):String
        {
            return (_SafeStr_3626.getValue(_arg_1) as String);
        }

        public function getPetTypeId(_arg_1:String):int
        {
            return (_SafeStr_3627[_arg_1]);
        }

        public function getPetColor(_arg_1:int, _arg_2:int):PetColorResult
        {
            var _local_3:Map = _petColors[_arg_1];
            if (_local_3 != null)
            {
                return (_local_3[_arg_2] as PetColorResult);
            };
            return (null);
        }

        public function getPetColorsByTag(_arg_1:int, _arg_2:String):Array
        {
            var _local_5:Map = _petColors[_arg_1];
            var _local_3:Array = [];
            if (_local_5 != null)
            {
                for each (var _local_4:PetColorResult in _local_5.getValues())
                {
                    if (_local_4.tag == _arg_2)
                    {
                        _local_3.push(_local_4);
                    };
                };
            };
            return (_local_3);
        }

        public function getPetLayerIdForTag(_arg_1:int, _arg_2:String, _arg_3:int=64):int
        {
            var _local_5:Dictionary;
            var _local_4:Map = _petLayers[_arg_1];
            if (_local_4)
            {
                _local_5 = _local_4[_arg_3.toString()];
                if (_local_5)
                {
                    return ((_local_5[_arg_2] != null) ? _local_5[_arg_2] : -1);
                };
            };
            return (-1);
        }

        public function getPetDefaultPalette(_arg_1:int, _arg_2:String):PetColorResult
        {
            var _local_4:Map = _petColors[_arg_1];
            if (_local_4 != null)
            {
                for each (var _local_3:PetColorResult in _local_4.getValues())
                {
                    if (((_local_3.layerTags.indexOf(_arg_2) > -1) && (_local_3.isMaster)))
                    {
                        return (_local_3);
                    };
                };
            };
            return (null);
        }

        public function getActiveObjectColorIndex(_arg_1:int):int
        {
            var _local_2:String = (_SafeStr_3621.getValue(_arg_1) as String);
            return (getObjectColorIndex(_local_2));
        }

        public function getWallItemColorIndex(_arg_1:int):int
        {
            var _local_2:String = (_SafeStr_3624.getValue(_arg_1) as String);
            return (getObjectColorIndex(_local_2));
        }

        public function getRoomObjectAdURL(_arg_1:String):String
        {
            if (_SafeStr_3631.getValue(_arg_1) != null)
            {
                return (_SafeStr_3631.getValue(_arg_1));
            };
            return ("");
        }

        private function getObjectType(_arg_1:String):String
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_2:int = _arg_1.indexOf("*");
            if (_local_2 >= 0)
            {
                _arg_1 = _arg_1.substr(0, _local_2);
            };
            return (_arg_1);
        }

        private function getObjectColorIndex(_arg_1:String):int
        {
            if (_arg_1 == null)
            {
                return (-1);
            };
            var _local_3:int;
            var _local_2:int = _arg_1.indexOf("*");
            if (_local_2 >= 0)
            {
                _local_3 = int(_arg_1.substr((_local_2 + 1)));
            };
            return (_local_3);
        }

        public function getContentType(_arg_1:String):String
        {
            return (_arg_1);
        }

        public function hasInternalContent(_arg_1:String):Boolean
        {
            _arg_1 = RoomObjectUserTypes.getVisualizationType(_arg_1);
            if ((((_arg_1 == "user") || (_arg_1 == "game_snowball")) || (_arg_1 == "game_snowsplash")))
            {
                return (true);
            };
            return (false);
        }

        private function getObjectRevision(_arg_1:String):int
        {
            var _local_3:int;
            var _local_2:int = getObjectCategory(_arg_1);
            if (((_local_2 == 10) || (_local_2 == 20)))
            {
                if (_arg_1.indexOf("poster") == 0)
                {
                    _arg_1 = "poster";
                };
                return (_SafeStr_3628.getValue(_arg_1));
            };
            return (0);
        }

        private function getObjectContentURLs(_arg_1:String, _arg_2:String=null, _arg_3:Boolean=false):Array
        {
            var _local_6:int;
            var _local_4:String;
            var _local_8:String;
            var _local_10:int;
            var _local_5:Boolean;
            var _local_9:String;
            var _local_7:String = getContentType(_arg_1);
            switch (_local_7)
            {
                case "place_holder":
                    return ([new RoomContentLoaderURL(resolveLocalOrAssetBaseUrl("PlaceHolderFurniture.swf"))]);
                case "wall_place_holder":
                    return ([new RoomContentLoaderURL(resolveLocalOrAssetBaseUrl("PlaceHolderWallItem.swf"))]);
                case "pet_place_holder":
                    return ([new RoomContentLoaderURL(resolveLocalOrAssetBaseUrl("PlaceHolderPet.swf"))]);
                case "room":
                    return ([new RoomContentLoaderURL(resolveLocalOrAssetBaseUrl("HabboRoomContent.swf"))]);
                case "tile_cursor":
                    return ([new RoomContentLoaderURL(resolveLocalOrAssetBaseUrl("TileCursor.swf"))]);
                case "selection_arrow":
                    return ([new RoomContentLoaderURL(resolveLocalOrAssetBaseUrl("SelectionArrow.swf"))]);
                default:
                    _local_6 = getObjectCategory(_local_7);
                    if (((_local_6 == 10) || (_local_6 == 20)))
                    {
                        _local_4 = getRoomObjectAlias(_local_7);
                        _local_8 = ((_arg_3) ? _SafeStr_3634 : _SafeStr_3633);
                        _local_8 = _local_8.replace(/%typeid%/, _local_4);
                        _local_10 = getObjectRevision(_local_7);
                        _local_8 = _local_8.replace(/%revision%/, _local_10);
                        if (_arg_3)
                        {
                            _local_5 = (((!(_arg_2 == null)) && (!(_arg_2 == ""))) && (_SafeStr_3623.hasKey(((_arg_1 + "*") + _arg_2))));
                            _local_8 = _local_8.replace(/%param%/, ((_local_5) ? ("_" + _arg_2) : ""));
                        };
                        return ([new RoomContentLoaderURL((_SafeStr_3632 + _local_8), _arg_1, String(_local_10), _arg_3, [_arg_1, _arg_2].join("_"))]);
                    };
                    if (_local_6 == 100)
                    {
                        _local_9 = (_SafeStr_3635 + _SafeStr_3636);
                        _local_9 = _local_9.replace(/%type%/, _local_7);
                        return ([new RoomContentLoaderURL(_local_9)]);
                    };
            };
            return ([]);
        }

        private function resolveLocalOrAssetBaseUrl(_arg_1:String):String
        {
            var _local_2:String;
            if (((fileProxy) && (fileProxy.localFileExists(_arg_1))))
            {
                return (fileProxy.localFilePath(_arg_1));
            };
            return (_SafeStr_3635 + _arg_1);
        }

        public function insertObjectContent(_arg_1:int, _arg_2:int, _arg_3:IAssetLibrary):Boolean
        {
            var _local_6:Event;
            var _local_7:IEventDispatcher;
            var _local_5:String = getAssetLibraryType(_arg_3);
            switch (_arg_2)
            {
                case 10:
                    _SafeStr_3621[_arg_1] = _local_5;
                    _SafeStr_3623.add(_local_5, _arg_1);
                    break;
                case 20:
                    _SafeStr_3624[_arg_1] = _local_5;
                    break;
                default:
                    throw (new Error((("Registering content library for unsupported category " + _arg_2) + "!")));
            };
            var _local_4:AssetLibraryCollection = (addAssetLibraryCollection(_local_5, null) as AssetLibraryCollection);
            if (_local_4)
            {
                _local_4.addAssetLibrary(_arg_3);
                if (initializeGraphicAssetCollection(_local_5, _arg_3))
                {
                    switch (_arg_2)
                    {
                        case 10:
                            if (_SafeStr_3622[_local_5] == null)
                            {
                                _SafeStr_3622[_local_5] = 1;
                            };
                            break;
                        case 20:
                            if (_wallItems[_local_5] == null)
                            {
                                _wallItems[_local_5] = 1;
                            };
                            break;
                        default:
                            throw (new Error((("Registering content library for unsupported category " + _arg_2) + "!")));
                    };
                    _local_6 = new RoomContentLoadedEvent("RCLE_SUCCESS", _local_5);
                    _local_7 = getAssetLibraryEventDispatcher(_local_5, true);
                    if (_local_7)
                    {
                        _local_7.dispatchEvent(_local_6);
                    };
                    return (true);
                };
            };
            return (false);
        }

        public function getObjectUrl(_arg_1:String, _arg_2:String):String
        {
            var _local_3:Array;
            var _local_4:String;
            if (((_arg_1) && (_arg_1.indexOf(",") >= 0)))
            {
                _local_4 = _arg_1;
                _arg_1 = _local_4.split(",")[0];
            };
            if (_local_4 != null)
            {
                _local_3 = getObjectContentURLs(_local_4, _arg_2, true);
            }
            else
            {
                _local_3 = getObjectContentURLs(_arg_1, _arg_2, true);
            };
            if (_local_3.length > 0)
            {
                return ((_local_3[0] as RoomContentLoaderURL).url);
            };
            return (null);
        }

        public function loadThumbnailContent(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:IEventDispatcher):Boolean
        {
            var _local_7:Array;
            var _local_9:int;
            var _local_6:RoomContentLoaderURL;
            var _local_5:String;
            var _local_8:AssetLoaderStruct;
            var _local_10:String;
            if (((_arg_2) && (_arg_2.indexOf(",") >= 0)))
            {
                _local_10 = _arg_2;
                _arg_2 = _local_10.split(",")[0];
            };
            if (_local_10 != null)
            {
                _local_7 = getObjectContentURLs(_local_10, _arg_3, true);
            }
            else
            {
                _local_7 = getObjectContentURLs(_arg_2, _arg_3, true);
            };
            if (((!(_local_7 == null)) && (_local_7.length > 0)))
            {
                _local_9 = 0;
                while (_local_9 < _local_7.length)
                {
                    _local_6 = _local_7[_local_9];
                    _local_5 = _local_6.url;
                    _local_8 = _SafeStr_3638.loadAssetFromFile([_arg_2, _arg_3].join("_"), new URLRequest(_local_5), "image/png", null, null, _arg_1);
                    _local_8.addEventListener("AssetLoaderEventComplete", onContentLoaded);
                    _local_9++;
                };
                return (true);
            };
            return (false);
        }

        public function loadObjectContent(_arg_1:String, _arg_2:IEventDispatcher):Boolean
        {
            var _local_5:Array;
            var _local_7:int;
            var _local_6:LibraryLoader;
            var _local_4:RoomContentLoaderURL;
            var _local_3:String;
            if (((_arg_1 == null) || (_arg_1 == "")))
            {
                Logger.log("[RoomContentLoader] Can not load content, object type unknown!");
                return (false);
            };
            var _local_9:String;
            if (((_arg_1) && (_arg_1.indexOf(",") >= 0)))
            {
                _local_9 = _arg_1;
                _arg_1 = _local_9.split(",")[0];
            };
            if (((!(getAssetLibrary(_arg_1) == null)) || (!(getAssetLibraryEventDispatcher(_arg_1) == null))))
            {
                return (false);
            };
            var _local_8:AssetLibraryCollection = (addAssetLibraryCollection(_arg_1, _arg_2) as AssetLibraryCollection);
            if (_local_8 == null)
            {
                return (false);
            };
            if (isIgnoredFurniType(_arg_1))
            {
                Logger.log(("Ignored object type found from configuration. Not downloading assets for: " + _arg_1));
                return (false);
            };
            if (_local_9 != null)
            {
                _local_5 = getObjectContentURLs(_local_9);
            }
            else
            {
                _local_5 = getObjectContentURLs(_arg_1);
            };
            if (((!(_local_5 == null)) && (_local_5.length > 0)))
            {
                _local_8.addEventListener("AssetLibraryLoaded", onContentLoaded);
                _local_7 = 0;
                while (_local_7 < _local_5.length)
                {
                    _local_6 = new LibraryLoader();
                    _local_4 = _local_5[_local_7];
                    _local_3 = _local_4.url;
                    _local_8.loadFromFile(_local_6, true);
                    _local_6.addEventListener("LIBRARY_LOADER_EVENT_ERROR", onContentLoadError);
                    _local_6.load(new URLRequest(_local_3), ("furniture/" + _local_4.cacheKey), _local_4.cacheRevision);
                    _local_7++;
                };
                return (true);
            };
            return (false);
        }

        private function onContentLoadError(_arg_1:Event):void
        {
            var _local_3:Array;
            var _local_4:LibraryLoader = LibraryLoader(_arg_1.target);
            var _local_5:Array = getPlaceHolderTypes();
            for each (var _local_2:String in _local_5)
            {
                _local_3 = getObjectContentURLs(_local_2);
                if ((((_local_3.length > 0) && (!(_local_4.url == null))) && (_local_4.url.indexOf((_local_3[0] as RoomContentLoaderURL).url) == 0)))
                {
                    Core.crash(("Failed to load asset: " + _local_4.url), 3);
                    return;
                };
            };
        }

        private function onContentLoaded(_arg_1:Event):void
        {
            var _local_2:AssetLoaderStruct;
            var _local_3:IAssetLibrary;
            if (disposed)
            {
                return;
            };
            if ((_arg_1.target is AssetLoaderStruct))
            {
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                _SafeStr_3639.iconLoaded(_local_2.assetLoader.id, _local_2.assetName, true);
            }
            else
            {
                _local_3 = (_arg_1.target as IAssetLibrary);
                if (_local_3 == null)
                {
                    return;
                };
                processLoadedLibrary(_local_3);
            };
        }

        private function processLoadedLibrary(_arg_1:IAssetLibrary):void
        {
            var _local_3:RoomContentLoadedEvent;
            var _local_2:Boolean;
            var _local_4:String = getAssetLibraryType(_arg_1);
            _local_4 = getRoomObjectOriginalName(_local_4);
            if (_local_4 != null)
            {
                _local_2 = initializeGraphicAssetCollection(_local_4, _arg_1);
            };
            if (_local_2)
            {
                if (_SafeStr_3627[_local_4] != null)
                {
                    extractPetDataFromLoadedContent(_local_4);
                };
                _local_3 = new RoomContentLoadedEvent("RCLE_SUCCESS", _local_4);
            }
            else
            {
                _local_3 = new RoomContentLoadedEvent("RCLE_FAILURE", _local_4);
            };
            var _local_5:IEventDispatcher = getAssetLibraryEventDispatcher(_local_4, true);
            if (((!(_local_5 == null)) && (!(_local_3 == null))))
            {
                _local_5.dispatchEvent(_local_3);
            };
        }

        private function extractPetDataFromLoadedContent(_arg_1:String):void
        {
            var _local_7:Map;
            var _local_5:Array;
            var _local_9:Array;
            var _local_13:XML;
            var _local_8:int;
            var _local_16:int;
            var _local_2:Array;
            var _local_14:Boolean;
            var _local_11:Map;
            var _local_17:Dictionary;
            var _local_10:String;
            var _local_15:String;
            var _local_19:int = _SafeStr_3627[_arg_1];
            var _local_6:IGraphicAssetCollection = getGraphicAssetCollection(_arg_1);
            if (_local_6 != null)
            {
                _local_7 = new Map();
                _local_5 = _local_6.getPaletteNames();
                for each (var _local_12:String in _local_5)
                {
                    _local_9 = _local_6.getPaletteColors(_local_12);
                    if (((!(_local_9 == null)) && (_local_9.length >= 2)))
                    {
                        _local_13 = _local_6.getPaletteXML(_local_12);
                        _local_8 = int(_local_13.@breed);
                        _local_16 = ((_local_13.hasOwnProperty("@colortag")) ? _local_13.@colortag : -1);
                        _local_2 = ((_local_13.hasOwnProperty("@tags")) ? String(_local_13.@tags).split(",") : []);
                        _local_14 = ((_local_13.hasOwnProperty("@master")) ? (String(_local_13.@master) == "true") : false);
                        _local_7.add(_local_12, new PetColorResult(_local_9[0], _local_9[1], _local_8, _local_16, _local_12, _local_14, _local_2));
                    };
                };
                _petColors.add(_local_19, _local_7);
            };
            var _local_4:XML = getVisualizationXML(_arg_1);
            if (_local_4 != null)
            {
                _local_11 = new Map();
                for each (var _local_3:XML in _local_4.visualization)
                {
                    _local_17 = new Dictionary();
                    for each (var _local_18:XML in _local_3.layers.layer)
                    {
                        if (_local_18.hasOwnProperty("@tag"))
                        {
                            _local_10 = _local_18.@tag;
                            _local_17[_local_10] = parseInt(String(_local_18.@id));
                        };
                    };
                    _local_15 = _local_3.@size;
                    _local_11.add(_local_15, _local_17);
                };
                _petLayers.add(_local_19, _local_11);
            };
        }

        private function initializeGraphicAssetCollection(_arg_1:String, _arg_2:IAssetLibrary):Boolean
        {
            var _local_4:XML;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (false);
            };
            var _local_3:Boolean;
            var _local_5:IGraphicAssetCollection = createGraphicAssetCollection(_arg_1, _arg_2);
            if (_local_5 != null)
            {
                _local_4 = getAssetXML(_arg_1);
                if (_local_5.define(_local_4))
                {
                    _local_3 = true;
                }
                else
                {
                    disposeGraphicAssetCollection(_arg_1);
                };
            };
            return (_local_3);
        }

        public function extractObjectContent(_arg_1:String, _arg_2:String):Boolean
        {
            var _local_3:IAssetLibrary = getAssetLibrary(_arg_1);
            _SafeStr_3618.add(_arg_2, _arg_1);
            if (initializeGraphicAssetCollection(_arg_2, _local_3))
            {
                return (true);
            };
            _SafeStr_3618.remove(_arg_2);
            return (false);
        }

        private function getAssetLibraryName(_arg_1:String):String
        {
            return ("RoomContentLoader " + _arg_1);
        }

        private function getAssetLibrary(_arg_1:String):IAssetLibrary
        {
            var _local_3:String;
            var _local_4:String = getContentType(_arg_1);
            _local_4 = getRoomObjectOriginalName(_local_4);
            var _local_2:IAssetLibrary = (_SafeStr_1361.getValue(getAssetLibraryName(_local_4)) as IAssetLibrary);
            if (_local_2 == null)
            {
                _local_3 = _SafeStr_3618.getValue(_local_4);
                if (_local_3 != null)
                {
                    _local_4 = getContentType(_local_3);
                    _local_2 = (_SafeStr_1361.getValue(getAssetLibraryName(_local_4)) as IAssetLibrary);
                };
            };
            return (_local_2);
        }

        private function addAssetLibraryCollection(_arg_1:String, _arg_2:IEventDispatcher):IAssetLibrary
        {
            var _local_5:String = getContentType(_arg_1);
            var _local_3:IAssetLibrary = getAssetLibrary(_arg_1);
            if (_local_3 != null)
            {
                return (_local_3);
            };
            var _local_4:String = getAssetLibraryName(_local_5);
            _local_3 = new AssetLibraryCollection(_local_4);
            _SafeStr_1361.add(_local_4, _local_3);
            if (((!(_arg_2 == null)) && (getAssetLibraryEventDispatcher(_arg_1) == null)))
            {
                _SafeStr_913.add(_local_5, _arg_2);
            };
            return (_local_3);
        }

        private function getAssetLibraryEventDispatcher(_arg_1:String, _arg_2:Boolean=false):IEventDispatcher
        {
            var _local_3:String = getContentType(_arg_1);
            if (!_arg_2)
            {
                return (_SafeStr_913.getValue(_local_3));
            };
            return (_SafeStr_913.remove(_local_3));
        }

        private function getIconAssetType(_arg_1:AssetLoaderStruct):String
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_4:String = _arg_1.assetName;
            var _local_2:Array = _local_4.split("_");
            var _local_5:int = parseInt(_local_2.pop());
            var _local_3:String = _local_2.join("_");
            return ((_local_5 > 0) ? ((_local_3 + "*") + _local_5) : _local_3);
        }

        private function getAssetLibraryType(_arg_1:IAssetLibrary):String
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:IAsset = _arg_1.getAssetByName("index");
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_2:XML = (_local_3.content as XML);
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_4:String = _local_2.@type;
            return (_local_4);
        }

        public function getVisualizationType(_arg_1:String):String
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_2:IAssetLibrary = getAssetLibrary(_arg_1);
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_4:IAsset = _local_2.getAssetByName((_arg_1 + "_index"));
            if (_local_4 == null)
            {
                _local_4 = _local_2.getAssetByName("index");
            };
            if (_local_4 == null)
            {
                return (null);
            };
            var _local_3:XML = (_local_4.content as XML);
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_5:String = _local_3.@visualization;
            return (_local_5);
        }

        public function getLogicType(_arg_1:String):String
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_2:IAssetLibrary = getAssetLibrary(_arg_1);
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_4:IAsset = _local_2.getAssetByName((_arg_1 + "_index"));
            if (_local_4 == null)
            {
                _local_4 = _local_2.getAssetByName("index");
            };
            if (_local_4 == null)
            {
                return (null);
            };
            var _local_3:XML = (_local_4.content as XML);
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_5:String = _local_3.@logic;
            return (_local_5);
        }

        public function hasVisualizationXML(_arg_1:String):Boolean
        {
            return (hasXML(_arg_1, "_visualization"));
        }

        public function getVisualizationXML(_arg_1:String):XML
        {
            return (getXML(_arg_1, "_visualization"));
        }

        public function hasAssetXML(_arg_1:String):Boolean
        {
            return (hasXML(_arg_1, "_assets"));
        }

        public function getAssetXML(_arg_1:String):XML
        {
            return (getXML(_arg_1, "_assets"));
        }

        public function hasLogicXML(_arg_1:String):Boolean
        {
            return (hasXML(_arg_1, "_logic"));
        }

        public function getLogicXML(_arg_1:String):XML
        {
            return (getXML(_arg_1, "_logic"));
        }

        private function getXML(_arg_1:String, _arg_2:String):XML
        {
            var _local_3:IAssetLibrary = getAssetLibrary(_arg_1);
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_7:String = getContentType(_arg_1);
            var _local_5:String = getRoomObjectAlias(_local_7);
            var _local_6:IAsset = _local_3.getAssetByName((_local_5 + _arg_2));
            if (_local_6 == null)
            {
                return (null);
            };
            var _local_4:XML = (_local_6.content as XML);
            if (_local_4 == null)
            {
                return (null);
            };
            return (_local_4);
        }

        private function hasXML(_arg_1:String, _arg_2:String):Boolean
        {
            var _local_3:IAssetLibrary = getAssetLibrary(_arg_1);
            if (_local_3 == null)
            {
                return (false);
            };
            var _local_5:String = getContentType(_arg_1);
            var _local_4:String = getRoomObjectAlias(_local_5);
            return (_local_3.hasAsset((_local_4 + _arg_2)));
        }

        public function addGraphicAsset(_arg_1:String, _arg_2:String, _arg_3:BitmapData, _arg_4:Boolean, _arg_5:Boolean=true):Boolean
        {
            var _local_6:IGraphicAssetCollection = getGraphicAssetCollection(_arg_1);
            if (_local_6 != null)
            {
                return (_local_6.addAsset(_arg_2, _arg_3, _arg_4, 0, 0, false, false));
            };
            return (false);
        }

        private function createGraphicAssetCollection(_arg_1:String, _arg_2:IAssetLibrary):IGraphicAssetCollection
        {
            var _local_3:IGraphicAssetCollection = getGraphicAssetCollection(_arg_1);
            if (_local_3 != null)
            {
                return (_local_3);
            };
            if (_arg_2 == null)
            {
                return (null);
            };
            _local_3 = _visualizationFactory.createGraphicAssetCollection();
            if (_local_3 != null)
            {
                _local_3.assetLibrary = _arg_2;
                _SafeStr_3619.add(_arg_1, _local_3);
            };
            return (_local_3);
        }

        public function getGraphicAssetCollection(_arg_1:String):IGraphicAssetCollection
        {
            var _local_2:String = getContentType(_arg_1);
            return (_SafeStr_3619.getValue(_local_2) as IGraphicAssetCollection);
        }

        public function roomObjectCreated(_arg_1:IRoomObject, _arg_2:String):void
        {
            var _local_3:IRoomObjectController = (_arg_1 as IRoomObjectController);
            if (((_local_3) && (_local_3.getModelController())))
            {
                _local_3.getModelController().setString("object_room_id", _arg_2, true);
            };
        }

        private function disposeGraphicAssetCollection(_arg_1:String):Boolean
        {
            var _local_3:IGraphicAssetCollection;
            var _local_2:String = getContentType(_arg_1);
            if (_SafeStr_3619[_local_2] != null)
            {
                _local_3 = _SafeStr_3619.remove(_local_2);
                if (_local_3 != null)
                {
                    _local_3.dispose();
                };
                return (true);
            };
            return (false);
        }

        public function furniDataReady():void
        {
            initFurnitureData();
        }

        public function setActiveObjectType(_arg_1:int, _arg_2:String):void
        {
            _SafeStr_3621.remove(_arg_1);
            _SafeStr_3621.add(_arg_1, _arg_2);
        }

        public function compressAssets():void
        {
            var _local_5:IGraphicAssetCollection;
            var _local_10:String;
            var _local_7:int;
            var _local_2:String;
            var _local_3:IAssetLibrary;
            var _local_4:int;
            var _local_8:int;
            var _local_9:BitmapDataAsset;
            var _local_1:int = _SafeStr_3619.length;
            var _local_6:Array = getPlaceHolderTypes();
            _local_7 = (_local_1 - 1);
            while (_local_7 > -1)
            {
                _local_10 = _SafeStr_3619.getKey(_local_7);
                if (_local_6.indexOf(_local_10) == -1)
                {
                    _local_5 = _SafeStr_3619.getValue(_local_10);
                    _local_2 = getAssetLibraryName(_local_10);
                    _local_3 = (_SafeStr_1361.getValue(_local_2) as IAssetLibrary);
                    if (_local_3)
                    {
                        _local_4 = _local_3.numAssets;
                        _local_8 = 0;
                        while (_local_8 < _local_4)
                        {
                            _local_9 = (_local_3.getAssetByIndex(_local_8) as BitmapDataAsset);
                            if (_local_9)
                            {
                            };
                            _local_8++;
                        };
                    };
                };
                _local_7--;
            };
            _lastAssetCompressionTime = getTimer();
        }

        public function purge():void
        {
            var _local_4:IGraphicAssetCollection;
            var _local_7:String;
            var _local_5:int;
            var _local_2:String;
            var _local_3:IAssetLibrary;
            var _local_1:int = _SafeStr_3619.length;
            var _local_6:int = getTimer();
            _local_5 = (_local_1 - 1);
            while (_local_5 > -1)
            {
                _local_7 = _SafeStr_3619.getKey(_local_5);
                if (PLACE_HOLDER_TYPES.indexOf(_local_7) < 0)
                {
                    _local_4 = _SafeStr_3619.getValue(_local_7);
                    if (((_local_4.getReferenceCount() < 1) && ((_local_6 - _local_4.getLastReferenceTimeStamp()) >= 20000)))
                    {
                        _SafeStr_3619.remove(_local_7);
                        _local_4.dispose();
                        _local_2 = getAssetLibraryName(_local_7);
                        _local_3 = (_SafeStr_1361.getValue(_local_2) as IAssetLibrary);
                        if (_local_3)
                        {
                            _SafeStr_1361.remove(_local_2);
                            _local_3.dispose();
                        };
                    };
                };
                _local_5--;
            };
        }

        public function getCachePath(_arg_1:String):String
        {
            var _local_3:String = getContentType(_arg_1);
            if (((((((_local_3 == "place_holder") || (_local_3 == "wall_place_holder")) || (_local_3 == "pet_place_holder")) || (_local_3 == "room")) || (_local_3 == "tile_cursor")) || (_local_3 == "selection_arrow")))
            {
                return (null);
            };
            var _local_2:int = getObjectCategory(_local_3);
            if (((!(_local_2 == 10)) && (!(_local_2 == 20))))
            {
                return (null);
            };
            var _local_4:int = getObjectRevision(_local_3);
            return (((((("room_content/" + _arg_1) + "/") + _local_4) + "/") + _arg_1) + ".swf");
        }

        public function set iconAssets(_arg_1:IAssetLibrary):void
        {
            _SafeStr_3638 = _arg_1;
        }

        public function set iconListener(_arg_1:IRoomContentListener):void
        {
            _SafeStr_3639 = _arg_1;
        }


    }
}