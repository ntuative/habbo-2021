package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class UpdateActionMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function UpdateActionMessageComposer(_arg_1:int, _arg_2:Array, _arg_3:String, _arg_4:Array, _arg_5:int, _arg_6:int)
        {
            _SafeStr_875.push(_arg_1);
            _SafeStr_875.push(_arg_2.length);
            for each (var _local_8:int in _arg_2)
            {
                _SafeStr_875.push(_local_8);
            };
            _SafeStr_875.push(_arg_3);
            _SafeStr_875.push(_arg_4.length);
            for each (var _local_7:int in _arg_4)
            {
                _SafeStr_875.push(_local_7);
            };
            _SafeStr_875.push(_arg_5);
            _SafeStr_875.push(_arg_6);
        }

        public function getMessageArray():Array
        {
            return (this._SafeStr_875);
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

