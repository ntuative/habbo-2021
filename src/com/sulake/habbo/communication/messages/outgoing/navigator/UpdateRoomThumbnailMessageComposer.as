package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class UpdateRoomThumbnailMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function UpdateRoomThumbnailMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            this._SafeStr_875.push(_arg_1);
            this._SafeStr_875.push(_arg_2);
            this._SafeStr_875.push(_arg_3);
            this._SafeStr_875.push(_arg_4);
        }

        public function addObj(_arg_1:int, _arg_2:int):void
        {
            this._SafeStr_875.push(_arg_1);
            this._SafeStr_875.push(_arg_2);
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

