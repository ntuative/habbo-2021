package com.sulake.habbo.communication.messages.parser.mysterybox
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GotMysteryBoxPrizeMessageParser implements IMessageParser 
    {

        private var _contentType:String;
        private var _classId:int;


        public function flush():Boolean
        {
            _contentType = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _contentType = _arg_1.readString();
            _classId = _arg_1.readInteger();
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


    }
}