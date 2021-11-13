package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class MoveObjectMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1922:int;
        private var _SafeStr_954:int;
        private var _SafeStr_955:int;
        private var _direction:int;

        public function MoveObjectMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            _SafeStr_1922 = _arg_1;
            _SafeStr_954 = _arg_2;
            _SafeStr_955 = _arg_3;
            _direction = _arg_4;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1922, _SafeStr_954, _SafeStr_955, _direction]);
        }


    }
}

