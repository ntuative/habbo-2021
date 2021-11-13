package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PollOfferParser implements IMessageParser 
    {

        private var _id:int = -1;
        private var _type:String = "";
        private var _headline:String = "";
        private var _summary:String = "";


        public function get id():int
        {
            return (_id);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get headline():String
        {
            return (_headline);
        }

        public function get summary():String
        {
            return (_summary);
        }

        public function flush():Boolean
        {
            _id = -1;
            _type = "";
            _summary = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _id = _arg_1.readInteger();
            _type = _arg_1.readString();
            _headline = _arg_1.readString();
            _summary = _arg_1.readString();
            return (true);
        }


    }
}