package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FaqTextMessageParser implements IMessageParser 
    {

        private var _questionId:int;
        private var _answerText:String;


        public function get questionId():int
        {
            return (_questionId);
        }

        public function get answerText():String
        {
            return (_answerText);
        }

        public function flush():Boolean
        {
            _questionId = -1;
            _answerText = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _questionId = _arg_1.readInteger();
            _answerText = _arg_1.readString();
            return (true);
        }


    }
}