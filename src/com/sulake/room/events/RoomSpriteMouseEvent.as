package com.sulake.room.events
{
    public class RoomSpriteMouseEvent 
    {

        private var _type:String = "";
        private var _eventId:String = "";
        private var _canvasId:String = "";
        private var _spriteTag:String = "";
        private var _screenX:Number = 0;
        private var _screenY:Number = 0;
        private var _localX:Number = 0;
        private var _localY:Number = 0;
        private var _ctrlKey:Boolean = false;
        private var _altKey:Boolean = false;
        private var _shiftKey:Boolean = false;
        private var _buttonDown:Boolean = false;
        private var _spriteOffsetX:int = 0;
        private var _spriteOffsetY:int = 0;

        public function RoomSpriteMouseEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Number, _arg_6:Number, _arg_7:Number=0, _arg_8:Number=0, _arg_9:Boolean=false, _arg_10:Boolean=false, _arg_11:Boolean=false, _arg_12:Boolean=false)
        {
            _type = _arg_1;
            _eventId = _arg_2;
            _canvasId = _arg_3;
            _spriteTag = _arg_4;
            _screenX = _arg_5;
            _screenY = _arg_6;
            _localX = _arg_7;
            _localY = _arg_8;
            _ctrlKey = _arg_9;
            _altKey = _arg_10;
            _shiftKey = _arg_11;
            _buttonDown = _arg_12;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get eventId():String
        {
            return (_eventId);
        }

        public function get canvasId():String
        {
            return (_canvasId);
        }

        public function get spriteTag():String
        {
            return (_spriteTag);
        }

        public function get screenX():Number
        {
            return (_screenX);
        }

        public function get screenY():Number
        {
            return (_screenY);
        }

        public function get localX():Number
        {
            return (_localX);
        }

        public function get localY():Number
        {
            return (_localY);
        }

        public function get ctrlKey():Boolean
        {
            return (_ctrlKey);
        }

        public function get altKey():Boolean
        {
            return (_altKey);
        }

        public function get shiftKey():Boolean
        {
            return (_shiftKey);
        }

        public function get buttonDown():Boolean
        {
            return (_buttonDown);
        }

        public function get spriteOffsetX():int
        {
            return (_spriteOffsetX);
        }

        public function set spriteOffsetX(_arg_1:int):void
        {
            _spriteOffsetX = _arg_1;
        }

        public function get spriteOffsetY():int
        {
            return (_spriteOffsetY);
        }

        public function set spriteOffsetY(_arg_1:int):void
        {
            _spriteOffsetY = _arg_1;
        }


    }
}