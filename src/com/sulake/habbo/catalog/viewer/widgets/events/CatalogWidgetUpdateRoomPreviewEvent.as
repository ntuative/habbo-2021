package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetUpdateRoomPreviewEvent extends Event 
    {

        private var _wallType:String = "default";
        private var _floorType:String = "default";
        private var _landscapeType:String = "1.1";
        private var _tileSize:int = 64;

        public function CatalogWidgetUpdateRoomPreviewEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super("UPDATE_ROOM_PREVIEW", _arg_5, _arg_6);
            _floorType = _arg_1;
            _wallType = _arg_2;
            _landscapeType = _arg_3;
            _tileSize = _arg_4;
        }

        public function get wallType():String
        {
            return (_wallType);
        }

        public function get floorType():String
        {
            return (_floorType);
        }

        public function get landscapeType():String
        {
            return (_landscapeType);
        }

        public function get tileSize():int
        {
            return (_tileSize);
        }


    }
}