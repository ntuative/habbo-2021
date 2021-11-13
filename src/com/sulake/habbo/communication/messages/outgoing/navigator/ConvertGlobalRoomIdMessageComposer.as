package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class ConvertGlobalRoomIdMessageComposer implements IMessageComposer, IDisposable 
    {

        private var flatId:String;

        public function ConvertGlobalRoomIdMessageComposer(_arg_1:String)
        {
            this.flatId = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([flatId]);
        }

        public function dispose():void
        {
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}