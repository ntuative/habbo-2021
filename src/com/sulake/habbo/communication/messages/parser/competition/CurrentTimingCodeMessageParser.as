package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CurrentTimingCodeMessageParser implements IMessageParser 
    {

        private var _schedulingStr:String;
        private var _code:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _schedulingStr = _arg_1.readString();
            _code = _arg_1.readString();
            return (true);
        }

        public function get schedulingStr():String
        {
            return (_schedulingStr);
        }

        public function get code():String
        {
            return (_code);
        }


    }
}