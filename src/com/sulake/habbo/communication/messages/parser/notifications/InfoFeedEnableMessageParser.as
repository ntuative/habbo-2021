package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class InfoFeedEnableMessageParser implements IMessageParser 
    {

        private var _enabled:Boolean;


        public function flush():Boolean
        {
            _enabled = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _enabled = _arg_1.readBoolean();
            return (true);
        }

        public function get enabled():Boolean
        {
            return (_enabled);
        }


    }
}