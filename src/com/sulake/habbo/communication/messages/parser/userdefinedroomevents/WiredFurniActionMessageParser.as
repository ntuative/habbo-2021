package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class WiredFurniActionMessageParser implements IMessageParser 
    {

        private var _def:ActionDefinition;


        public function flush():Boolean
        {
            _def = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _def = new ActionDefinition(_arg_1);
            return (true);
        }

        public function get def():ActionDefinition
        {
            return (_def);
        }


    }
}