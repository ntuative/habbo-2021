package com.sulake.habbo.communication.messages.incoming.room.furniture
{
        public class RoomDimmerPresetsMessageData 
    {

        private var _id:int = 0;
        private var _type:int = 0;
        private var _color:uint = 0;
        private var _light:uint = 0;
        private var _SafeStr_1818:Boolean = false;

        public function RoomDimmerPresetsMessageData(_arg_1:int)
        {
            _id = _arg_1;
        }

        public function setReadOnly():void
        {
            _SafeStr_1818 = true;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get type():int
        {
            return (_type);
        }

        public function set type(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _type = _arg_1;
            };
        }

        public function get color():uint
        {
            return (_color);
        }

        public function set color(_arg_1:uint):void
        {
            if (!_SafeStr_1818)
            {
                _color = _arg_1;
            };
        }

        public function get light():int
        {
            return (_light);
        }

        public function set light(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _light = _arg_1;
            };
        }


    }
}

