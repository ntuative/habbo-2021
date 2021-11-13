package com.sulake.habbo.communication.messages.incoming.callforhelp
{
    import com.sulake.habbo.communication.messages.incoming.moderation.INamed;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CallForHelpTopicData implements INamed 
    {

        private var _name:String;
        private var _id:int;
        private var _consequence:String;

        public function CallForHelpTopicData(_arg_1:IMessageDataWrapper)
        {
            _name = _arg_1.readString();
            _id = _arg_1.readInteger();
            _consequence = _arg_1.readString();
        }

        public function get name():String
        {
            return (_name);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get consequence():String
        {
            return (_consequence);
        }


    }
}