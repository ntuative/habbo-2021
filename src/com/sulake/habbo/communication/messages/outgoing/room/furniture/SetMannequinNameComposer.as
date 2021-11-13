package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetMannequinNameComposer implements IMessageComposer 
    {

        private var _SafeStr_1936:int;
        private var _name:String;

        public function SetMannequinNameComposer(_arg_1:int, _arg_2:String)
        {
            _SafeStr_1936 = _arg_1;
            _name = _arg_2;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1936, _name]);
        }

        public function dispose():void
        {
        }


    }
}

