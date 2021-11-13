package com.sulake.habbo.communication.messages.outgoing.groupforums
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class UpdateForumReadMarkerMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [0];


        public function add(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            _SafeStr_875.push(_arg_1, _arg_2, _arg_3);
            _SafeStr_875[0]++;
        }

        public function getMessageArray():Array
        {
            return (this._SafeStr_875);
        }

        public function get size():int
        {
            return (_SafeStr_875[0]);
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

