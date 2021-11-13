package com.sulake.habbo.communication.messages.outgoing.hotlooks
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.util.Byte;

        public class GetHotLooksMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array = [];

        public function GetHotLooksMessageComposer(_arg_1:int)
        {
            _SafeStr_875.push(new Byte(_arg_1));
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }

        public function dispose():void
        {
            this._SafeStr_875 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}

