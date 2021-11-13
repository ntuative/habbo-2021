package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.data.MapStuffData;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureRoomBrandingLogic extends FurnitureLogic 
    {

        public static const STUFF_DATA_KEY_STATE:String = "state";
        public static const STUFF_DATA_KEY_IMAGEURL:String = "imageUrl";
        public static const STUFF_DATA_KEY_CLICKURL:String = "clickUrl";
        public static const STUFF_DATA_KEY_OFFSET_X:String = "offsetX";
        public static const STUFF_DATA_KEY_OFFSET_Y:String = "offsetY";
        public static const STUFF_DATA_KEY_OFFSET_Z:String = "offsetZ";

        protected var _disableFurnitureSelection:Boolean;
        protected var _SafeStr_3198:Boolean;

        public function FurnitureRoomBrandingLogic()
        {
            _disableFurnitureSelection = true;
            _SafeStr_3198 = false;
        }

        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if (_disableFurnitureSelection)
            {
                object.getModelController().setNumber("furniture_selection_disable", 1);
            };
        }

        override public function getEventTypes():Array
        {
            var _local_1:Array = ["RORAE_ROOM_AD_LOAD_IMAGE"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:RoomObjectRoomAdUpdateMessage;
            super.processUpdateMessage(_arg_1);
            if ((_arg_1 is RoomObjectDataUpdateMessage))
            {
                setupImageFromFurnitureData();
            };
            if ((_arg_1 is RoomObjectRoomAdUpdateMessage))
            {
                _local_2 = (_arg_1 as RoomObjectRoomAdUpdateMessage);
                switch (_local_2.type)
                {
                    case "RORUM_ROOM_BILLBOARD_IMAGE_LOADED":
                        object.getModelController().setNumber("furniture_branding_image_status", 1, false);
                        return;
                    case "RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED":
                        object.getModelController().setNumber("furniture_branding_image_status", -1);
                        Logger.log(("failed to load billboard image from url " + object.getModelController().getString("furniture_branding_image_url")));
                        return;
                    default:
                        return;
                };
            };
        }

        private function setupImageFromFurnitureData():Boolean
        {
            var _local_9:MapStuffData;
            var _local_2:Number;
            var _local_12:int;
            var _local_14:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_13:Boolean;
            if (object != null)
            {
                _local_9 = new MapStuffData();
                _local_9.initializeFromRoomObjectModel(object.getModel());
                _local_2 = 0;
                if (!isNaN(_local_2))
                {
                    _local_12 = _local_2;
                    if (object.getState(0) != _local_12)
                    {
                        object.setState(_local_12, 0);
                        _local_13 = true;
                    };
                };
                _local_14 = forceImageUrlToUseHttps(_local_9.getValue("imageUrl"));
                if (_local_14 != null)
                {
                    _local_3 = object.getModelController().getString("furniture_branding_image_url");
                    if (((_local_3 == null) || (!(forceImageUrlToUseHttps(_local_3) == _local_14))))
                    {
                        object.getModelController().setString("furniture_branding_image_url", _local_14, false);
                        object.getModelController().setNumber("furniture_branding_image_status", 0, false);
                        _local_13 = true;
                    };
                };
                _local_4 = _local_9.getValue("clickUrl");
                if (_local_4 != null)
                {
                    _local_5 = object.getModelController().getString("furniture_branding_url");
                    if (((_local_5 == null) || (!(_local_5 == _local_4))))
                    {
                        object.getModelController().setString("furniture_branding_url", _local_4);
                        _local_13 = true;
                    };
                };
                if (!isNaN(parseInt(_local_9.getValue("offsetX"))))
                {
                    _local_13 = updateOffset("furniture_branding_offset_x", object.getModelController().getNumber("furniture_branding_offset_x"), parseInt(_local_9.getValue("offsetX")));
                };
                if (!isNaN(parseInt(_local_9.getValue("offsetY"))))
                {
                    _local_13 = updateOffset("furniture_branding_offset_y", object.getModelController().getNumber("furniture_branding_offset_y"), parseInt(_local_9.getValue("offsetY")));
                };
                if (!isNaN(parseInt(_local_9.getValue("offsetZ"))))
                {
                    _local_13 = updateOffset("furniture_branding_offset_z", object.getModelController().getNumber("furniture_branding_offset_z"), parseInt(_local_9.getValue("offsetZ")));
                };
            };
            var _local_10:String = object.getModelController().getString("furniture_branding_image_url");
            var _local_1:String = object.getModelController().getString("furniture_branding_url");
            var _local_6:int = object.getModelController().getNumber("furniture_branding_offset_x");
            var _local_8:int = object.getModelController().getNumber("furniture_branding_offset_y");
            var _local_7:int = object.getModelController().getNumber("furniture_branding_offset_z");
            if (_local_10 != null)
            {
                eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_LOAD_IMAGE", object, _local_10, _local_1));
            };
            var _local_11:String = (("imageUrl=" + ((_local_10 != null) ? _local_10 : "")) + "\t");
            if (_SafeStr_3198)
            {
                _local_11 = (_local_11 + (("clickUrl=" + ((_local_1 != null) ? _local_1 : "")) + "\t"));
            };
            _local_11 = (_local_11 + (("offsetX=" + _local_6) + "\t"));
            _local_11 = (_local_11 + (("offsetY=" + _local_8) + "\t"));
            _local_11 = (_local_11 + (("offsetZ=" + _local_7) + "\t"));
            object.getModelController().setString("RWEIEP_INFOSTAND_EXTRA_PARAM", ("RWEIEP_BRANDING_OPTIONS" + _local_11));
            return (_local_13);
        }

        private function forceImageUrlToUseHttps(_arg_1:String):String
        {
            return ((_arg_1 != null) ? _arg_1.replace("http:", "https:") : null);
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            if (_arg_1.type == "mouseMove")
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "doubleClick":
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
            };
        }

        private function updateOffset(_arg_1:String, _arg_2:int, _arg_3:int):Boolean
        {
            if (((!(isNaN(_arg_3))) && (!(_arg_2 == _arg_3))))
            {
                object.getModelController().setNumber(_arg_1, _arg_3);
                return (true);
            };
            return (false);
        }


    }
}

