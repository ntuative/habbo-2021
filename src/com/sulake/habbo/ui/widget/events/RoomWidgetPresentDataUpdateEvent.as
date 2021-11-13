package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPresentDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const UPDATE_PACKAGEINFO:String = "RWPDUE_PACKAGEINFO";
        public static const _SafeStr_4033:String = "RWPDUE_CONTENTS";
        public static const _SafeStr_4042:String = "RWPDUE_CONTENTS_CLUB";
        public static const _SafeStr_4043:String = "RWPDUE_CONTENTS_FLOOR";
        public static const UPDATE_CONTENTS_LANDSCAPE:String = "RWPDUE_CONTENTS_LANDSCAPE";
        public static const UPDATE_CONTENTS_WALLPAPER:String = "RWPDUE_CONTENTS_WALLPAPER";
        public static const UPDATE_CONTENTS_IMAGE:String = "RWPDUE_CONTENTS_IMAGE";

        private var _objectId:int = -1;
        private var _classId:int = 0;
        private var _itemType:String = "";
        private var _text:String;
        private var _controller:Boolean;
        private var _iconBitmapData:BitmapData;
        private var _purchaserName:String;
        private var _purchaserFigure:String;
        private var _placedItemId:int = -1;
        private var _placedItemType:String = "";
        private var _placedInRoom:Boolean;

        public function RoomWidgetPresentDataUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:BitmapData=null, _arg_6:String=null, _arg_7:String=null, _arg_8:Boolean=false, _arg_9:Boolean=false)
        {
            super(_arg_1, _arg_8, _arg_9);
            _objectId = _arg_2;
            _text = _arg_3;
            _controller = _arg_4;
            _iconBitmapData = _arg_5;
            _purchaserName = _arg_6;
            _purchaserFigure = _arg_7;
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get classId():int
        {
            return (_classId);
        }

        public function set classId(_arg_1:int):void
        {
            _classId = _arg_1;
        }

        public function get itemType():String
        {
            return (_itemType);
        }

        public function set itemType(_arg_1:String):void
        {
            _itemType = _arg_1;
        }

        public function get text():String
        {
            return (_text);
        }

        public function get controller():Boolean
        {
            return (_controller);
        }

        public function get iconBitmapData():BitmapData
        {
            return (_iconBitmapData);
        }

        public function get purchaserName():String
        {
            return (_purchaserName);
        }

        public function get purchaserFigure():String
        {
            return (_purchaserFigure);
        }

        public function get placedItemId():int
        {
            return (_placedItemId);
        }

        public function set placedItemId(_arg_1:int):void
        {
            _placedItemId = _arg_1;
        }

        public function get placedInRoom():Boolean
        {
            return (_placedInRoom);
        }

        public function set placedInRoom(_arg_1:Boolean):void
        {
            _placedInRoom = _arg_1;
        }

        public function get placedItemType():String
        {
            return (_placedItemType);
        }

        public function set placedItemType(_arg_1:String):void
        {
            _placedItemType = _arg_1;
        }


    }
}

