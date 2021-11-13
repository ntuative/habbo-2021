package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class DanceMessageComposer implements IMessageComposer 
    {

        private var _style:int;

        public function DanceMessageComposer(_arg_1:int)
        {
            _style = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_style]);
        }


    }
}