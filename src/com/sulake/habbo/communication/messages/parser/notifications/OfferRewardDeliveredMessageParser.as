package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OfferRewardDeliveredMessageParser implements IMessageParser 
    {

        private var _contentType:String;
        private var _classId:int;
        private var _name:String;
        private var _description:String;


        public function flush():Boolean
        {
            _contentType = null;
            _classId = 0;
            _name = null;
            _description = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _contentType = _arg_1.readString();
            _classId = _arg_1.readInteger();
            _name = _arg_1.readString();
            _description = _arg_1.readString();
            return (true);
        }

        public function get contentType():String
        {
            return (_contentType);
        }

        public function get classId():int
        {
            return (_classId);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get description():String
        {
            return (_description);
        }


    }
}