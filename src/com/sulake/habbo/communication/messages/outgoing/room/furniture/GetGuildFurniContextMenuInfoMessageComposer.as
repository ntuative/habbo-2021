package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetGuildFurniContextMenuInfoMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1922:int;
        private var _SafeStr_618:int;

        public function GetGuildFurniContextMenuInfoMessageComposer(_arg_1:int, _arg_2:int)
        {
            _SafeStr_1922 = _arg_1;
            _SafeStr_618 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1922, _SafeStr_618]);
        }


    }
}

