package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class CreateFlatMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function CreateFlatMessageComposer(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int)
        {
            this._SafeStr_875.push(_arg_1);
            this._SafeStr_875.push(_arg_2);
            this._SafeStr_875.push(_arg_3);
            this._SafeStr_875.push(_arg_4);
            this._SafeStr_875.push(_arg_5);
            this._SafeStr_875.push(_arg_6);
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

