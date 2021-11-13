package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ChatlineData 
    {

        private var _timeStamp:String;
        private var _chatterId:int;
        private var _chatterName:String;
        private var _msg:String;
        private var _hasHighlighting:Boolean;

        public function ChatlineData(_arg_1:IMessageDataWrapper)
        {
            _timeStamp = _arg_1.readString();
            _chatterId = _arg_1.readInteger();
            _chatterName = _arg_1.readString();
            _msg = _arg_1.readString();
            _hasHighlighting = _arg_1.readBoolean();
        }

        public function get timeStamp():String
        {
            return (_timeStamp);
        }

        public function get chatterId():int
        {
            return (_chatterId);
        }

        public function get chatterName():String
        {
            return (_chatterName);
        }

        public function get msg():String
        {
            return (_msg);
        }

        public function get hasHighlighting():Boolean
        {
            return (_hasHighlighting);
        }


    }
}