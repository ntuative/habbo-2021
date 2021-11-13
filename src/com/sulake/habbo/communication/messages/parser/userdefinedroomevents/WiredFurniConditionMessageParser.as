package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class WiredFurniConditionMessageParser implements IMessageParser 
    {

        private var _def:ConditionDefinition;


        public function flush():Boolean
        {
            _def = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _def = new ConditionDefinition(_arg_1);
            return (true);
        }

        public function get def():ConditionDefinition
        {
            return (_def);
        }


    }
}