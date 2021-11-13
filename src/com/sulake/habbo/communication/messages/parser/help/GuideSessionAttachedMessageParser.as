package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideSessionAttachedMessageParser implements IMessageParser 
    {

        private var _asGuide:Boolean;
        private var _helpRequestType:int;
        private var _helpRequestDescription:String;
        private var _roleSpecificWaitTime:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _asGuide = _arg_1.readBoolean();
            _helpRequestType = _arg_1.readInteger();
            _helpRequestDescription = _arg_1.readString();
            _roleSpecificWaitTime = _arg_1.readInteger();
            return (true);
        }

        public function get asGuide():Boolean
        {
            return (_asGuide);
        }

        public function get helpRequestType():int
        {
            return (_helpRequestType);
        }

        public function get helpRequestDescription():String
        {
            return (_helpRequestDescription);
        }

        public function get roleSpecificWaitTime():int
        {
            return (_roleSpecificWaitTime);
        }


    }
}