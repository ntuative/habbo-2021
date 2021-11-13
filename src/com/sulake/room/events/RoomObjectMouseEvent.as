package com.sulake.room.events
{
    import com.sulake.room.object.IRoomObject;

    public class RoomObjectMouseEvent extends RoomObjectEvent 
    {

        public static const ROOM_OBJECT_MOUSE_CLICK:String = "ROE_MOUSE_CLICK";
        public static const ROOM_OBJECT_MOUSE_ENTER:String = "ROE_MOUSE_ENTER";
        public static const ROOM_OBJECT_MOUSE_MOVE:String = "ROE_MOUSE_MOVE";
        public static const ROOM_OBJECT_MOUSE_LEAVE:String = "ROE_MOUSE_LEAVE";
        public static const ROOM_OBJECT_MOUSE_DOUBLE_CLICK:String = "ROE_MOUSE_DOUBLE_CLICK";
        public static const ROOM_OBJECT_MOUSE_DOWN:String = "ROE_MOUSE_DOWN";

        private var _eventId:String = "";
        private var _altKey:Boolean;
        private var _ctrlKey:Boolean;
        private var _shiftKey:Boolean;
        private var _buttonDown:Boolean;
        private var _localX:int;
        private var _localY:int;
        private var _spriteOffsetX:int;
        private var _spriteOffsetY:int;

        public function RoomObjectMouseEvent(_arg_1:String, _arg_2:IRoomObject, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_8, _arg_9);
            _eventId = _arg_3;
            _altKey = _arg_4;
            _ctrlKey = _arg_5;
            _shiftKey = _arg_6;
            _buttonDown = _arg_7;
        }

        public function get eventId():String
        {
            return (_eventId);
        }

        public function get altKey():Boolean
        {
            return (_altKey);
        }

        public function get ctrlKey():Boolean
        {
            return (_ctrlKey);
        }

        public function get shiftKey():Boolean
        {
            return (_shiftKey);
        }

        public function get buttonDown():Boolean
        {
            return (_buttonDown);
        }

        public function get localX():int
        {
            return (_localX);
        }

        public function get localY():int
        {
            return (_localY);
        }

        public function get spriteOffsetX():int
        {
            return (_spriteOffsetX);
        }

        public function get spriteOffsetY():int
        {
            return (_spriteOffsetY);
        }

        public function set localX(_arg_1:int):void
        {
            _localX = _arg_1;
        }

        public function set localY(_arg_1:int):void
        {
            _localY = _arg_1;
        }

        public function set spriteOffsetX(_arg_1:int):void
        {
            _spriteOffsetX = _arg_1;
        }

        public function set spriteOffsetY(_arg_1:int):void
        {
            _spriteOffsetY = _arg_1;
        }


    }
}