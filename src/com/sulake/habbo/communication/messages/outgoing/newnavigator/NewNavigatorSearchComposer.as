package com.sulake.habbo.communication.messages.outgoing.newnavigator
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class NewNavigatorSearchComposer implements IMessageComposer 
    {

        private var _SafeStr_1906:Array = [];

        public function NewNavigatorSearchComposer(_arg_1:String, _arg_2:String)
        {
            _SafeStr_1906.push(_arg_1);
            _SafeStr_1906.push(_arg_2);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_1906);
        }

        public function dispose():void
        {
            _SafeStr_1906 = null;
        }


    }
}

