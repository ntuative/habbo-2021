package com.sulake.habbo.communication.messages.outgoing.room.bots
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class CommandBotComposer implements IMessageComposer 
    {

        private var _SafeStr_1917:int;
        private var _SafeStr_1918:int;
        private var _SafeStr_1919:String;

        public function CommandBotComposer(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            _SafeStr_1917 = _arg_1;
            _SafeStr_1918 = _arg_2;
            _SafeStr_1919 = _arg_3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1917, _SafeStr_1918, _SafeStr_1919]);
        }


    }
}

