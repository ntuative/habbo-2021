package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class WiredFurniTriggerMessageParser implements IMessageParser 
    {

        private var _def:TriggerDefinition;


        public function flush():Boolean
        {
            _def = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _def = new TriggerDefinition(_arg_1);
            return (true);
        }

        public function get def():TriggerDefinition
        {
            return (_def);
        }


    }
}