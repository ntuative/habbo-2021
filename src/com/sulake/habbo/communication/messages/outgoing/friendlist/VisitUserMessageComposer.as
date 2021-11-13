package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class VisitUserMessageComposer implements IMessageComposer 
    {

        private var _username:String;

        public function VisitUserMessageComposer(_arg_1:String)
        {
            _username = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_username]);
        }

        public function dispose():void
        {
            _username = null;
        }


    }
}